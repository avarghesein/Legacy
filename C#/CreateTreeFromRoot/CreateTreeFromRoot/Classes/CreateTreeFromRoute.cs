using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace CreateTreeFromRoot
{
    // Tree progress notifications type
    public enum ETreeNotifications : int
    {
        ProgressMaxCount = 0, ProgressUpdate, ProgressEnd, ProgressAborted
    };

    // Tree notifications event delegate
    public delegate void TreeNotificationHandler(ETreeNotifications NotificationType, int Value, string sMessage);

    // Destination File overwrite options
    public enum EFilesOverwriteOptions : int
    {
        ShowError = 0, SkipFiles, OverwriteFiles
    };

    public class CCreateTreeFromRoot
    {
        static private EFilesOverwriteOptions m_bOverwriteFileFlags = EFilesOverwriteOptions.OverwriteFiles;

        static public event TreeNotificationHandler TreeCreationNotificationEvent;

        static private bool m_bCancelOperation = false;

        static public bool CancelOperations
        {
            get
            {
                return m_bCancelOperation;
            }
            set
            {
                m_bCancelOperation = value;
            }
        }

        static public EFilesOverwriteOptions OverWriteTargetFiles
        {
            get
            {
                return m_bOverwriteFileFlags;
            }
            set
            {
                m_bOverwriteFileFlags = value;
            }
        }

        /// <summary>
        /// Will return the common part of two strings from the begining.
        /// ie. If the two strings were "Abc" and "Abcdef", it will return "Abc"
        /// ie. If the two string were "Ax" and "Bx", it will return Empty string
        /// </summary>
        /// <param name="sSource">Source String</param>
        /// <param name="sTarget">Target String</param>
        /// <returns>Common part of both the string, if any</returns>
        static private string CommonPart(string sSource, string sTarget)
        {
            // Left part should be the minimal length string
            string sLeft = sSource.Length < sTarget.Length ? sSource : sTarget;
            // Right part shuld be the maximal length string
            string sRight = sSource.Length < sTarget.Length ? sTarget : sSource;

            int nIndex = 0;
            string sMatch = string.Empty;
            // Loop and compare both string, character by character until we found a mismatch
            // and build the common match string
            for ( nIndex = 0; nIndex < sLeft.Length; ++nIndex)
            {
                if (sLeft[nIndex].ToString().ToLower() != sRight[nIndex].ToString().ToLower())
                {
                    break;
                }
                sMatch += sLeft[nIndex];
            }
            return sMatch;
        }

        /// <summary>
        /// Will find common root path, for a list of paths. ie if the paths are
        /// C:\abc\a.exe, C:\abc\xyz, C:\abc\efg; it will retrun C:\abc , which will be
        /// the common root folder for the 3 paths
        /// </summary>
        /// <param name="PathList_i">List of paths</param>
        /// <param name="sRootCalculated_o">Common root path for all the paths in the list</param>
        /// <param name="sError_o">Error if any</param>
        /// <returns>true on successfully finding the common root, false otherwise</returns>
        static public bool CommonRootFromPaths(List<string> PathList_i, ref string sRootCalculated_o, ref string sError_o)
        {
            try
            {
                // If no list or, no paths in list, return
                if ( null == PathList_i || PathList_i.Count <= 0)
                {
                    sError_o = "No Files/Folders Selected";
                    return false;
                }

                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressMaxCount, PathList_i.Count, "Start Finding Root...");
                }

                // Make the first string as the pivotal one
                string sMatch = PathList_i[0];  
                // Now using the pivotal element, compare with each other paths in the list
                // And update the common part. ie .. Find the common part b/w 1st string and 2nd..
                // Then b/w that common part and 3rd and so on...
                for (int iIndex = 1; iIndex < PathList_i.Count; ++iIndex)
                {
                    if (m_bCancelOperation)
                    {
                        // If client registered for receiving notification, Inform the client about the progress
                        if (null != TreeCreationNotificationEvent)
                        {
                            TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0, "Operation Cancelled.");
                        }

                        sError_o = "Operation Cancelled.";
                        return false;
                    }

                    // Adjust the strings
                    string sFirst = sMatch.Trim().TrimEnd('\\');
                    string sSecond = PathList_i[iIndex].Trim().TrimEnd('\\');
                                      
                    // Find the common part b/w both the strings from begining
                    sMatch = CommonPart(sFirst,sSecond);
                    // If we have no common part, both those paths belongs to different directory heirarchies
                    // So return error, on such case
                    if (sMatch == string.Empty)
                    {
                        // If client registered for receiving notification, Inform the client about the progress
                        if (null != TreeCreationNotificationEvent)
                        {
                            TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0, "Error Finding Root.");
                        }

                        sError_o = "Files/Folders From Different Roots Selected\n" + "'" + sFirst + "', '" + sSecond + "'";
                        return false;
                    }

                    // If client registered for receiving notification, Inform the client about the progress
                    // Call back only after each 50 processed paths, since call back causes heavy GUI upadation and hence
                    // takes considerable amount of time, if called frequently
                    if (null != TreeCreationNotificationEvent && 0 == iIndex % 50)
                    {
                        TreeCreationNotificationEvent(ETreeNotifications.ProgressUpdate, iIndex, string.Format("Processed Item ...{0}", sSecond));
                    }
                }
                FileInfo fInfo = new FileInfo(sMatch);
                if (fInfo.Exists)
                {
                    sMatch = fInfo.Directory.FullName;
                }              
                // Return the common part b/w all the paths
                sRootCalculated_o = sMatch ;

                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressEnd, PathList_i.Count, "Root Found.");
                }                
            }
            catch (Exception eX)
            {
                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0, "Error Finding Root." + eX.Message);
                }

                sError_o = "Exception Occured During Root Calculation.\n" + eX.Message;
                return false;
            }
            return true;
        }

        /// <summary>
        /// Creates the files/folder tree, in the specified target folder, from the given files/folder list.
        /// </summary>
        /// <param name="PathList_i">List of paths of files/folders</param>
        /// <param name="sRoot_i">Root path based on which tree should be created. empty string for
        /// taking parent drive as root</param>
        /// <param name="sTargetDir_i">Target folder in which the tree should be created</param>
        /// <param name="sError_o">Error if any</param>
        /// <returns>true on successful creation of the tree, false otherwise</returns>
        static public bool CreateTreeFromRoot( List<string> PathList_i, string sRoot_i,
                                                string sTargetDir_i, ref string sError_o )
        {
            try
            {
                // If no list or, no paths in list, return
                if (null == PathList_i || PathList_i.Count <= 0)
                {
                    sError_o = "No Files/Folders Selected";
                    return false;
                }
                // Validate target directory
                sTargetDir_i = sTargetDir_i.Replace('/', '\\').TrimEnd('\\').Trim(' ');
                if (!Directory.Exists(sTargetDir_i))
                {
                    if (sTargetDir_i.Trim() == string.Empty) sTargetDir_i = "<EMPTY>";
                    sError_o = "specified Target Directory not exist.\n'" + sTargetDir_i + "'";
                    return false;
                }
                // Root will be the logical drive, if not explicitly given by user
                if (sRoot_i.Trim() == string.Empty)
                {
                    string sItem = PathList_i[0].Trim();
                    string[] sSubItem = sItem.Split('\\');
                    if (sSubItem.Length > 0)
                    {
                        sRoot_i = sSubItem[0];
                    }
                }
                // Validate the root for existance
                sRoot_i = sRoot_i.Replace('/', '\\').TrimEnd('\\').Trim(' ');
                if (!Directory.Exists(sRoot_i))
                {
                    sError_o = "specified Root Directory not exist.\n'" + sRoot_i + "'";
                    return false;
                }

                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressMaxCount, PathList_i.Count,"Creating List of objects to copied...");
                }

                // Below for loop, does the following things..
                // 1. Validate each path. ie. ensures it comes under the root path given as input
                // 2. Creates a new minimized list of paths from the original list, for copying to destination
                // 3. Contradictory to the Path list given as input, which contain absolute paths, 
                //    Minimized list will contain paths as relative path with respect to the root path given. This 
                //    will later help us to find the target path for each file/folder during tree creation easily.
                //
                // For ex: user selected C:\MplusV3 (a folder, means he needs to copy the entire content inside it to 
                // the target folder ), C:\MplusV3\MplusPlatform and C:\MplusV3\MplusPlatform\SearchConfig.txt.
                // In this case we can omit the latter two paths as they already include in the 
                // C:\MplusV3, hence we avoid duplicate copying
                List<string> ProcessedList = new List<string>();
                for (int nIndex = 0; nIndex < PathList_i.Count; ++nIndex )
                {
                    if (m_bCancelOperation)
                    {
                        // If client registered for receiving notification, Inform the client about the progress
                        if (null != TreeCreationNotificationEvent)
                        {
                            TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0, "Operation Cancelled.");
                        }

                        sError_o = "Operation Cancelled.";
                        return false;
                    }

                    string sPathItem = PathList_i[nIndex];
                    // Adjust the path, and check its inclusion inside the root folder given
                    string sPath = sPathItem.Replace('/', '\\').TrimEnd('\\').Trim(' ');
                    if (!sPath.StartsWith(sRoot_i, StringComparison.OrdinalIgnoreCase))
                    {
                        sError_o = "File/Folder does not belong to the root.\nPath: '" + sPath + "'\nRoot: '" + sRoot_i + "'";
                        
                        // If client registered for receiving notification, Inform the client about the progress
                        if (null != TreeCreationNotificationEvent)
                        {
                            TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0,"Create Tree Failed");
                        }

                        return false;
                    }
                    // Get the relative path, for the source file/folder with respect to the root given
                    sPath = sPath.Remove(0, sRoot_i.Length).Trim('\\');

                    bool bContainerExists = false;
                    int iIndex = 0;
                    // Iterate the processed list of paths, to determine whether or not to include the current path, into
                    // the processed list. Also to remove unwanted child paths from the processed list
                    while (iIndex < ProcessedList.Count)
                    {
                        if (m_bCancelOperation)
                        {
                            // If client registered for receiving notification, Inform the client about the progress
                            if (null != TreeCreationNotificationEvent)
                            {
                                TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0, "Operation Cancelled.");
                            }

                            sError_o = "Operation Cancelled.";
                            return false;
                        }

                        string sProItem = ProcessedList[iIndex];
                        // If we have a path, inside the processed list, for which the current path is a parent path
                        // ie. the path inside the processed list is a child path for the current path, Remove the child path
                        // from the processed list, as we have alreay a parent path at hand.
                        // So continue to the next item in the processed list, After removing the child path
                        if (sProItem.StartsWith(sPath, StringComparison.OrdinalIgnoreCase))
                        {
                            ProcessedList.RemoveAt(iIndex);
                            continue;
                        }
                        // If we have a path inside teh processed list, for which the current path is a child path
                        // ie. the path inside the processed list is a prent path for the current path, Ignore the current path
                        // as it inlude in the parent path, already present in the list
                        if (sPath.StartsWith(sProItem, StringComparison.OrdinalIgnoreCase))
                        {
                            bContainerExists = true;
                            break;
                        }
                        ++iIndex;
                    }
                    // If we have no parent path or path itself for the current file/folder path, inside the list,
                    // add it to the list.
                    if (!bContainerExists) ProcessedList.Add(sPath);
                    
                    // If client registered for receiving notification, Inform the client about the progress
                    // Call back only after each 50 processed paths, since call back causes heavy GUI upadation and hence
                    // takes considerable amount of time, if called frequently
                    if (null != TreeCreationNotificationEvent && 0 == nIndex % 50 )
                    {
                        TreeCreationNotificationEvent(ETreeNotifications.ProgressUpdate, nIndex, string.Format("Processed Item ...{0}", sPath));
                    }
                }

                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressEnd, PathList_i.Count, "Created List of objects to copied");
                }
                
                // Find the target root folder, from the root folder of the tree given.
                // If the root folder given is the logical drive itself, we have no target root folder
                // other than the target folder. Otherwise we need to find the root folder and append it
                // to the Target Directory given.
                //
                // Ex1. User given 'C:\MPlusV3\MPlusPlatform' as root folder (as he selected several source 
                // files/folders under C:\MPlusV3\MPlusPlatform)
                // and Target Folder as D:\ABC\, the resultant target root will be 'D:\ABC\MPlusPlatform'
                //
                // Ex2. User selected parent drive as root folder , ie. 'C:\' and 
                // (selected several source files/folders under C:\MPlusV3\MPlusPlatform) and Target Folder as D:\ABC\,
                // the resultant target root will be 'D:\ABC\MPlusV3'

                string sRootFolder = string.Empty;
                int nLastSlashIndx = sRoot_i.LastIndexOf('\\');
                // User selected a folder inside the logical drive, not the drive itself...
                if (nLastSlashIndx > -1 && (nLastSlashIndx + 1) < sRoot_i.Length)
                {
                    // Get the last folder name in the root. ex: if 'C:\MPlusV3\MPlusPlatform', get 'MPlusPlatform'
                    sRootFolder = sRoot_i.Substring(nLastSlashIndx + 1);
                }

                // As per the above findings, update the target directory selected by user, if needed                
                string sTargetFolder = sTargetDir_i;
                if (sRootFolder != string.Empty)
                {
                    // Correct target folder as D:\ABC\, adjust it as 'D:\ABC\MPlusPlatform' and create it if not exists
                    sTargetFolder = sTargetDir_i + "\\" + sRootFolder;
                    if (!Directory.Exists(sTargetFolder))
                    {
                        Directory.CreateDirectory(sTargetFolder);
                    }
                }

                // If client registered for receiving notification, find out the total number of files to transfer
                // and notify it to the client
                if (null != TreeCreationNotificationEvent)
                {
                    CalculateTotalFilesToCopy( ProcessedList, sRoot_i) ;
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressMaxCount, m_nTotalFilesToTransfer, "Start Copying Objects...");
                }

                string sSrcPath;
                string sTarPath;
                // Copy now each processed source folder and file into respective target path
                foreach (string sPath in ProcessedList)
                {
                    // Create full path to source file/folder
                    sSrcPath = sRoot_i + "\\" + sPath;
                    // Create full path to target file/folder
                    sTarPath = sTargetFolder + "\\" + sPath;
                    // If source path is a directory, initiate folder copying
                    if (Directory.Exists(sSrcPath))
                    {
                        DirectoryInfo dirSrcInfo = new DirectoryInfo(sSrcPath);
                        DirectoryInfo dirTarInfo = new DirectoryInfo(sTarPath);
                        CopyDirectory(dirSrcInfo, dirTarInfo);
                        
                    }
                    // If source path is a file, initiate file copying
                    else if (File.Exists(sSrcPath))
                    {
                        FileInfo fileSrcInfo = new FileInfo(sSrcPath);
                        FileInfo fileTarInfo = new FileInfo(sTarPath);
                        CopyFile(fileSrcInfo, fileTarInfo);
                    }
                    // If Source path not exists, return error
                    else
                    {
                        sError_o += "Source File/Folder not exists: '" + sSrcPath + "'.\n";
                        return false;
                    }
                }

                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressEnd, m_nTotalFilesToTransfer, "Created Tree Successfully");
                }
            }
            catch (Exception eX)
            {
                sError_o = "Exception Occured During Tree Creation.\n" + eX.Message;
                
                // If client registered for receiving notification, Inform the client about the progress
                if (null != TreeCreationNotificationEvent)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressAborted, 0,"Tree Creation Failure, Exception occured.\n" + eX.Message);
                }

                return false;
            }
            return true;
        }

        /// <summary>
        /// Copies, source directory to target directory with all the sub folders and files inside 
        /// recursively.
        /// </summary>
        /// <param name="DirectoryToCopy">Source Folder</param>
        /// <param name="TargetDirectory">Target Folder</param>
        private static void CopyDirectory(DirectoryInfo DirectoryToCopy,DirectoryInfo TargetDirectory)
        {
            if (m_bCancelOperation)
            {                
                throw new IOException( "Operation Cancelled." );
            }

            // Check the existance of the source folder
            if (!DirectoryToCopy.Exists)
            {
                throw new IOException("Folder To be Copied '" + DirectoryToCopy.FullName + "' doses'nt exists.");
            }
            // If the target folder not exits, create the target folder
            if (!TargetDirectory.Exists )
            {
                Directory.CreateDirectory( TargetDirectory.FullName );
            }
            // Now Copy each files inside the source folder into the target folder
            foreach (FileInfo fileInfo in DirectoryToCopy.GetFiles())
            {
                CopyFile(fileInfo, new FileInfo(TargetDirectory.FullName + "\\" + fileInfo.Name));
            }
            // Copy each sub folder inside the source folder into the target folder
            foreach (DirectoryInfo dirInfo in DirectoryToCopy.GetDirectories())
            {
                CopyDirectory(dirInfo, new DirectoryInfo(TargetDirectory.FullName + "\\" + dirInfo.Name));
            }            
        }

        /// <summary>
        /// Copy the source file to target file according to the overwrite options
        /// provided
        /// </summary>
        /// <param name="FileToCopy">Source File</param>
        /// <param name="TargetFile">Target File</param>
        private static void CopyFile(FileInfo FileToCopy, FileInfo TargetFile)
        {
            if (m_bCancelOperation)
            {
                throw new IOException("Operation Cancelled.");
            }

            // Validate Source file's existance
            if( !FileToCopy.Exists )
            {
                throw new IOException( "File To be Copied '" + FileToCopy.FullName + "' doses'nt exists.");
            }
            // If Target file's parent directory not created.. Create parent directory
            if (!TargetFile.Directory.Exists )
            {
                TargetFile.Directory.Create();
            }
            // If target file already exists
            if (TargetFile.Exists)
            {
                switch (m_bOverwriteFileFlags)
                {
                    // If option is to overwrite, delete the existing target file and copy the new one [by breaking the case struct]
                    case EFilesOverwriteOptions.OverwriteFiles:
                        TargetFile.Delete();
                        break;

                    // If the option is to remain the target file unchanged, return right now
                    case EFilesOverwriteOptions.SkipFiles:
                        // If client registered for receiving notification, Inform the client about the progress
                        if (null != TreeCreationNotificationEvent)
                        {
                            TreeCreationNotificationEvent(ETreeNotifications.ProgressUpdate, ++m_nFilesTransferred, "Skipped " + TargetFile.FullName );
                        }
                        return;

                    // If the option is to show error, on existance of the target file, throw error
                    case EFilesOverwriteOptions.ShowError:
                        throw new IOException( "Target File '" + TargetFile.FullName + "' already exists.");
                }
            }
            // Copy the source file to target path
            FileToCopy.CopyTo(TargetFile.FullName);
            // If client registered for receiving notification, Inform the client about the progress
            if (null != TreeCreationNotificationEvent)
            {
                TreeCreationNotificationEvent(ETreeNotifications.ProgressUpdate, ++m_nFilesTransferred, "Copied " + FileToCopy.FullName );
            }
        }

        private static int m_nTotalFilesToTransfer = 0;
        private static int m_nFilesTransferred = 0;

        /// <summary>
        /// Calculates total number of files to copy to the target path, this includes files selected by user, files inside the 
        /// folders selected by user, and subfolders inside the selected folders
        /// </summary>
        /// <param name="ProcessedList_i">list of file/folder paths</param>
        /// <param name="sRoot_i">Root directory of the tree selected by the user</param>
        private static void CalculateTotalFilesToCopy(List<string> ProcessedList_i, string sRoot_i)
        {
            m_nTotalFilesToTransfer = 0;
            m_nFilesTransferred = 0;

            if (null == ProcessedList_i || ProcessedList_i.Count <= 0) return;

            TreeCreationNotificationEvent(ETreeNotifications.ProgressMaxCount, ProcessedList_i.Count, "Finding List of files to copy...");
            string sSrcPath;
            for (int nIndex = 0; nIndex < ProcessedList_i.Count; ++nIndex )
            {
                if (m_bCancelOperation)
                {
                    throw new IOException("Operation Cancelled.");
                }

                string sPath = ProcessedList_i[nIndex];

                // Create full path to source file/folder
                sSrcPath = sRoot_i + "\\" + sPath;
                // If source path is a directory, find files inside the folder and subfolders
                if (Directory.Exists(sSrcPath))
                {
                    DirectoryInfo dirSrcInfo = new DirectoryInfo(sSrcPath);
                    CalculateTotalFilesInFolder(dirSrcInfo);

                }
                // If source path is a file, update file count
                else if (File.Exists(sSrcPath))
                {
                    ++m_nTotalFilesToTransfer;
                }
                // Call back only after each 50 processed files, since call back causes heavy GUI upadation and hence
                // takes considerable amount of time, if called frequently
                if (0 == nIndex % 50)
                {
                    TreeCreationNotificationEvent(ETreeNotifications.ProgressUpdate, nIndex + 1, "Processed " + sPath);
                }
            }
            TreeCreationNotificationEvent(ETreeNotifications.ProgressEnd, ProcessedList_i.Count, "Processed List of files to copy.");
        }

        /// <summary>
        /// This function calculates the total number files inside the given folder, including the subfolders
        /// </summary>
        /// <param name="DirectoryToCopy">Source directory to search</param>
        private static void CalculateTotalFilesInFolder(DirectoryInfo DirectoryToCopy )
        {
            // If operation cancelled, exit
            if (m_bCancelOperation)
            {
                throw new IOException("Operation Cancelled.");
            }

            // Check the existance of the source folder
            if (!DirectoryToCopy.Exists)
            {
                return;
            }
            // Iterate through each files and update count
            foreach (FileInfo fileInfo in DirectoryToCopy.GetFiles())
            {
                if (m_bCancelOperation)
                {
                    throw new IOException("Operation Cancelled.");
                }
                ++m_nTotalFilesToTransfer;
            }
            // Now iterate through each sub directory to find out the file count on each subdirectory
            foreach (DirectoryInfo dirInfo in DirectoryToCopy.GetDirectories())
            {
                CalculateTotalFilesInFolder( dirInfo );
            }
        }

    };
};