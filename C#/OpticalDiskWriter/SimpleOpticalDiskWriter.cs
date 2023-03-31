using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO; 
using System.Threading;
using System.Collections;
using System.Text.RegularExpressions;  

namespace WindowsApplication1
{
    public class COpticalDiskManager
    {
        public enum EWriteMode
        {
            DISK_AT_ONCE = 0,
            TRACK_AT_ONCE = 1
        };

        public enum EDiskType
        {
            AUDIO =0,
            DATA =1
        };

        public class COpticalDrive
        {
            internal string sScanBusId;
            private string sDriveName;

            internal string sDriveType;
            public string DriveType
            {
                get
                {
                    return sDriveType; 
                }
            }

            internal string sDriveVersion;
            public string DriveVersion
            {
                get
                {
                    return sDriveVersion;
                }
            }

            internal string sDriveRevision;
            public string DriveRevision
            {
                get
                {
                    return sDriveVersion;
                }
            }

            internal string sDriveResponseFormat;
            public string DriveResponseFormat
            {
                get
                {
                    return sDriveResponseFormat;
                }
            }

            internal string sDriveVendor;
            public string DriveVendor
            {
                get
                {
                    return sDriveVendor;
                }
            }


            internal string sDriveIdentification;
            public string DriveIdentification
            {
                get
                {
                    return sDriveIdentification;
                }
            }

            internal string sDriveRemarks;
            public string DriveRemarks
            {
                get
                {
                    return sDriveRemarks;
                }
            }


            internal bool bTestWritable;
            public bool TestWritable
            {
                get
                {
                    return bTestWritable; 
                }
            }

            internal bool bCDMultiSessionReadable;
            public bool MultiSessionCDReadable
            {
                get
                {
                    return bCDMultiSessionReadable;
                }
            }

            internal bool bCDreadable;
            public bool CDROMReadable
            {
                get
                {
                    return bCDreadable;
                }
            }

            internal bool bCDWritable;
            public bool CDROMWritable
            {
                get
                {
                    return bCDWritable;
                }
            }

            internal bool bCDRWreadable;
            public bool CDRWReadable
            {
                get
                {
                    return bCDRWreadable;
                }
            }

            internal bool bCDRWWritable;
            public bool CDRWWritable
            {
                get
                {
                    return bCDRWWritable;
                }
            }

            internal bool bDVDROMReadable;
            public bool DVDROMReadable
            {
                get
                {
                    return bDVDROMReadable;
                }
            }

            internal bool bDVDROMWritable;
            public bool DVDROMWritable
            {
                get
                {
                    return bDVDROMWritable;
                }
            }

            internal bool bDVDRAMReadable;
            public bool DVDRWReadable
            {
                get
                {
                    return bDVDRAMReadable;
                }
            }

            internal bool bDVDRAMWritable;
            public bool DVDRWWritable
            {
                get
                {
                    return bDVDRAMWritable;
                }
            }

            internal int iCDMaxReadSpeed;
            public int CDMaxReadSpeed
            {
                get
                {
                    return iCDMaxReadSpeed;
                }
            }

            internal int iCDMaxWriteSpeed;
            public int CDMaxWriteSpeed
            {
                get
                {
                    return iCDMaxWriteSpeed;
                }
            }

            internal int iDVDMaxReadSpeed;
            public int DVDMaxReadSpeed
            {
                get
                {
                    return iDVDMaxReadSpeed;
                }
            }

            internal int iDVDMaxWriteSpeed;
            public int DVDMaxWriteSpeed
            {
                get
                {
                    return iDVDMaxWriteSpeed;
                }
            }

            internal int iBufferSizeInKB;
            public int BufferSizeInKB
            {
                get
                {
                    return iBufferSizeInKB;
                }
            }

            internal COpticalDrive(string vsScanBusId, string vsDriveName)
            {
                sScanBusId = vsScanBusId;
                sDriveName = vsDriveName;
            }       

            public string BUS_ID
            {
                get 
                {
                    return sScanBusId; 
                }
            }

            public string DriveName
            {
                get 
                {
                    return sDriveName; 
                }
            }
        };

        public delegate void StandardOut(string vsRedirectedLine);

        private string sLastError, sLastOutPut;
        private Process oOpticalProcess;
        private ProcessStartInfo oProcessInfo;
        private Thread oStdErrorThread, oStdOutputThread;

        public event StandardOut StandardOutput;
        public event StandardOut StandardError;

        public bool ProcessCompleted
        {
            get 
            {
                return oOpticalProcess == null; 
            }
        }

        public string LastError
        {
            get
            {
                return sLastError; 
            }
        }

        public string LastOutPut
        {
            get
            {
                return sLastOutPut;
            }
        }

        private void WriteError(string vsLine)
        {
            if (StandardError != null) StandardError(vsLine);            
            sLastError += vsLine; 
        }

        private void WriteOutPut(string vsLine)
        {
            if (StandardOutput != null) StandardOutput(vsLine);
            sLastOutPut += vsLine;  
        }

        private void KillThreads()
        {
            try
            {
                if (oStdErrorThread != null && oStdErrorThread.IsAlive) oStdErrorThread.Abort();
                if (oStdOutputThread != null && oStdOutputThread.IsAlive) oStdOutputThread.Abort();
            } 
            catch (Exception eX)
            {
                WriteError(eX.Message); 
            }
            oOpticalProcess = null; oProcessInfo = null; oStdOutputThread = null; oStdErrorThread = null;
        }

        private void OpticalProcessExited(object sender, EventArgs e)
        {
            if (StandardOutput != null)
            {
                StandardOutput("Process exited, Code:" + oOpticalProcess.ExitCode.ToString());
            }
            sLastOutPut += "Process exited, Code:" + oOpticalProcess.ExitCode.ToString();
            KillThreads();
        }

        private void StatusThread(object oRedirectedReader)
        {
            bool bIsError;
            char[] Buff = new char[1];
            StandardOut StandardRedirected;
            StreamReader oStdRedirectedReader = oRedirectedReader as StreamReader;

            StandardRedirected = !((bIsError = !(oOpticalProcess.StandardOutput == oStdRedirectedReader))) ? StandardOutput : StandardError;

            if (!bIsError)
                if (StandardRedirected != null)
                    while (oStdRedirectedReader == null);                          

             if (StandardRedirected != null)
                 while (oStdRedirectedReader != null && !oStdRedirectedReader.EndOfStream)
                     if (oStdRedirectedReader.Peek() != -1)
                     {
                         if (oStdRedirectedReader.ReadBlock(Buff, 0, 1) == 1)
                         {
                             StandardRedirected(Buff[0].ToString());
                             if(bIsError)
                                 sLastError += Buff[0].ToString();
                             else
                                sLastOutPut += Buff[0].ToString();
                         }
                     }
                     else Thread.Sleep(100);

             return;  
        }

        private bool ExecuteGeneric(string vsCommandLine)
        {
            try
            {
                sLastError = sLastOutPut = string.Empty;  
                KillThreads();

                oProcessInfo = new ProcessStartInfo("CMD.exe", @"/C " + vsCommandLine);
                oProcessInfo.CreateNoWindow = true;
                oProcessInfo.ErrorDialog = false;
                oProcessInfo.RedirectStandardError = true;
                oProcessInfo.RedirectStandardOutput = true;
                oProcessInfo.UseShellExecute = false;
                oProcessInfo.WorkingDirectory = Environment.CurrentDirectory;

                oOpticalProcess = new Process();
                oOpticalProcess.StartInfo = oProcessInfo;
                oOpticalProcess.EnableRaisingEvents = true;
                oOpticalProcess.Exited += new EventHandler(OpticalProcessExited);
                oOpticalProcess.Start();
                if (StandardOutput != null)
                {
                    oStdOutputThread.Start(oOpticalProcess.StandardOutput);
                    oStdOutputThread = new Thread(new ParameterizedThreadStart(StatusThread));
                }
                else
                {
                    sLastOutPut = oOpticalProcess.StandardOutput.ReadToEnd();    
                }
                if (StandardError != null)
                {
                    oStdErrorThread = new Thread(new ParameterizedThreadStart(StatusThread));
                    oStdErrorThread.Start(oOpticalProcess.StandardError);
                }
                else
                {
                    sLastError = oOpticalProcess.StandardError.ReadToEnd(); 
                }
                if (StandardOutput == null && StandardError == null)
                {
                    oOpticalProcess.WaitForExit();  
                }
            }
            catch (Exception eX)
            {
                WriteError(eX.Message);
                return false;
            }
            return true; 
        }

        public bool CreateISO(string vsSourcePath,string vsTargetISOFileName)
        {
            if (oOpticalProcess != null) 
            {
                WriteError("Previous operation not completed");
                return false;
            }
            return ExecuteGeneric("mkisofs -r -o " + vsTargetISOFileName + " " + vsSourcePath);  
        }

        public bool EjectDrive(COpticalDrive voOpticalDrive)
        {
            if (oOpticalProcess != null) 
            {
                WriteError("Previous operation not completed");
                return false;
            }
            return ExecuteGeneric("cdrecord dev=" + voOpticalDrive.BUS_ID + " -eject");  
        }

        public bool LoadDrive(COpticalDrive voOpticalDrive)
        {
            if (oOpticalProcess != null)
            {
                WriteError("Previous operation not completed");
                return false;
            }
            return ExecuteGeneric("cdrecord dev=" + voOpticalDrive.BUS_ID + " -load");
        }

        public COpticalDrive[] GetOpticalDrives()
        {
            int iIndx;
            string sOutPut;
            string[] sDrives;
            ArrayList oList;
            Regex oRegX, oRegXBus;
            Match oMatch,oMatchBus;
            COpticalDrive[] oOpticalDrives; 
            COpticalDiskManager oDiskMgr;

            if (oOpticalProcess != null) 
            {
                WriteError("Previous operation not completed");
                return null;
            }
            oDiskMgr = new COpticalDiskManager();
            sLastOutPut = sLastError = string.Empty;    
            if (oDiskMgr.ExecuteGeneric("cdrecord -scanbus"))
            {
                sOutPut = oDiskMgr.LastOutPut;
                sDrives = sOutPut.Split(new string[] { "\n\t","\r\n", "\n", "\r\f" },StringSplitOptions.RemoveEmptyEntries);
                oList = new ArrayList();
                oRegX = new Regex("CD-R*|DVD-R*}");
                foreach (string sLine in sDrives)
                {
                    oMatch = oRegX.Match(sLine);
                    if (oMatch.Success) oList.Add(sLine);     
                }
                oOpticalDrives = new COpticalDrive[oList.Count];
                oRegXBus = new Regex(@"\d+,\d+,\d+");
                for (iIndx = 0; iIndx < oList.Count; iIndx++)
                {
                    sOutPut = oList[iIndx].ToString().Trim();
                    oMatchBus = oRegXBus.Match(sOutPut);
                    if (!oMatchBus.Success) continue;
                    oMatch = oRegX.Match(sOutPut);
                    if (!oMatch.Success) continue;
                    WriteOutPut(sOutPut + "\n\t");
                    sLastOutPut += sOutPut + "\n\t"; 
                    oOpticalDrives[iIndx] = new COpticalDrive(oMatchBus.Value, sOutPut.Substring(sOutPut.IndexOf(')') + 1));   
                }
                return oOpticalDrives; 
            } 
            sLastError = oDiskMgr.LastError;
            return null;
        }

        public bool Burn(COpticalDrive voTargetOpticalDrive, int viSpeed, bool vbIsTest, string vsSourcePath, bool vbIsISOimage, EWriteMode veWriteMode, EDiskType veDiskType)
        {
            string sWriteMode = string.Empty,sDiskType= string.Empty;

            if (oOpticalProcess != null)
            {
                WriteError("Previous operation not completed");
                return false;
            }
            switch (veDiskType)
            {
                case EDiskType.AUDIO :
                    sDiskType = "-audio"; break;
                case EDiskType.DATA :
                default:
                    sDiskType = "-data"; break;
            }
            switch (veWriteMode)
            {                
                case EWriteMode.TRACK_AT_ONCE: sWriteMode = "-tao"; break;
                case EWriteMode.DISK_AT_ONCE: 
                default:
                    sWriteMode = "-dao"; break;
            }
            if (vbIsISOimage)
            {
                return ExecuteGeneric("mkisofs -r -o " + vsSourcePath + " | cdrecord dev=" + voTargetOpticalDrive.BUS_ID + " speed=" + viSpeed + " -v " + (vbIsTest ? "-dummy" : string.Empty) + " " + sWriteMode + " " + sDiskType + " -"); 
            }
            else
            {
                return ExecuteGeneric("cdrecord dev=" + voTargetOpticalDrive.BUS_ID + " speed=" + viSpeed + " -v " + (vbIsTest ? "-dummy" : string.Empty) + " " + sWriteMode + " " + sDiskType + " " + vsSourcePath); 
            }
        }


        public bool GetExtendedInformation(ref COpticalDrive roOpticalDrive)
        {
            string sOutPut = string.Empty,sTmp;
            Match oMatch;
            COpticalDiskManager oDiskMgr;

            if (oOpticalProcess != null)
            {
                WriteError("Previous operation not completed");
                return false;
            }
            oDiskMgr = new COpticalDiskManager();
            sLastOutPut = sLastError = string.Empty;
            if (oDiskMgr.ExecuteGeneric("cdrecord dev=" + roOpticalDrive.BUS_ID + " -prcap"))
            {
                sOutPut = oDiskMgr.LastOutPut;
                oMatch = new Regex("^[ ]*Does[ ]+read[ ]+CD-R[ ]+media*|Does[ ]+read[ ]+CD-ROM[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bCDreadable = oMatch.Success;
                oMatch = new Regex("^[ ]*Does[ ]+read[ ]+CD-RW[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bCDRWreadable = oMatch.Success;
                oMatch = new Regex("^[ ]*Does[ ]+write[ ]+CD-R[ ]+media*|Does[ ]+write[ ]+CD-ROM[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bCDWritable = oMatch.Success;
                oMatch = new Regex("^[ ]*Does[ ]+write[ ]+CD-RW[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bCDRWWritable = oMatch.Success;

                oMatch = new Regex("^[ ]*Does[ ]+read[ ]+DVD-ROM[ ]+media*|Does[ ]+read[ ]+DVD-R[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bDVDROMReadable = oMatch.Success;
                oMatch = new Regex("^[ ]*Does[ ]+write[ ]+DVD-ROM[ ]+media*|Does[ ]+write[ ]+DVD-R[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bDVDROMReadable = oMatch.Success;

                oMatch = new Regex("^[ ]*Does[ ]+read[ ]+DVD-RAM[ ]+media*|Does[ ]+read[ ]+DVD-RW[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bDVDRAMReadable = oMatch.Success;
                oMatch = new Regex("^[ ]*Does[ ]+write[ ]+DVD-RAM[ ]+media*|Does[ ]+write[ ]+DVD-RW[ ]+media*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bDVDRAMWritable = oMatch.Success;

                oMatch = new Regex("^[ ]*Does support test writing*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bTestWritable = oMatch.Success;

                oMatch = new Regex("^[ ]*Does read multi-session CD*", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                roOpticalDrive.bCDMultiSessionReadable = oMatch.Success;

                oMatch = new Regex(@"^[ ]*Device type[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveType = oMatch.Value.Substring(oMatch.Value.IndexOf(':')+1).Trim();
                oMatch = new Regex("^[ ]*Version[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveVersion = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();
                oMatch = new Regex("^[ ]*Response Format[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveResponseFormat = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();
                oMatch = new Regex("^[ ]*Vendor_info[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveVendor = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();
                oMatch = new Regex("^[ ]*Identifikation[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveIdentification = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();
                oMatch = new Regex("^[ ]*Revision[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveRevision = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();
                oMatch = new Regex("^[ ]*Device seems to be[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success) roOpticalDrive.sDriveRemarks = oMatch.Value.Substring(oMatch.Value.IndexOf(':') + 1).Trim();

                roOpticalDrive.iBufferSizeInKB = roOpticalDrive.iCDMaxReadSpeed = roOpticalDrive.iCDMaxWriteSpeed = roOpticalDrive.iDVDMaxReadSpeed = roOpticalDrive.iDVDMaxWriteSpeed = 0;

                oMatch = new Regex("^[ ]*Maximum[ ]+read[ ]+speed[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success)
                {
                    sTmp = oMatch.Value;
                    oMatch = new Regex(@"CD[ ]+\d+x", RegexOptions.IgnoreCase).Match(sTmp);
                    if (oMatch.Success)
                    {
                        oMatch = new Regex(@"\d+").Match(oMatch.Value);
                        if (oMatch.Success) int.TryParse(oMatch.Value, out roOpticalDrive.iCDMaxReadSpeed);       
                    }
                    oMatch = new Regex(@"DVD[ ]+\d+x", RegexOptions.IgnoreCase).Match(sTmp);
                    if (oMatch.Success)
                    {
                        oMatch = new Regex(@"\d+").Match(oMatch.Value);
                        if (oMatch.Success) int.TryParse(oMatch.Value, out roOpticalDrive.iDVDMaxReadSpeed);
                    }
                }
                oMatch = new Regex("^[ ]*Maximum[ ]+write[ ]+speed[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success)
                {
                    sTmp = oMatch.Value;
                    oMatch = new Regex(@"CD[ ]+\d+x", RegexOptions.IgnoreCase).Match(sTmp);
                    if (oMatch.Success)
                    {
                        oMatch = new Regex(@"\d+").Match(oMatch.Value);
                        if (oMatch.Success) int.TryParse(oMatch.Value, out roOpticalDrive.iCDMaxWriteSpeed);
                    }
                    oMatch = new Regex(@"DVD[ ]+\d+x", RegexOptions.IgnoreCase).Match(sTmp);
                    if (oMatch.Success)
                    {
                        oMatch = new Regex(@"\d+").Match(oMatch.Value);
                        if (oMatch.Success) int.TryParse(oMatch.Value, out roOpticalDrive.iDVDMaxWriteSpeed);
                    }
                }
                oMatch = new Regex("^[ ]*Buffer[ ]+size[ ]+in[ ]+KB[^\n]+", RegexOptions.IgnoreCase | RegexOptions.Multiline).Match(sOutPut);
                if (oMatch.Success)
                {
                    oMatch = new Regex(@"\d+", RegexOptions.IgnoreCase).Match(oMatch.Value);
                    if (oMatch.Success) int.TryParse(oMatch.Value, out roOpticalDrive.iBufferSizeInKB);
                }
                return true;
            }
            sLastError = oDiskMgr.LastError;
            return false;
        }

        public bool IsDriveEmpty(COpticalDrive voOpticalDrive)
        {
            string sOutPut = string.Empty;
            Match oMatch;
            COpticalDiskManager oDiskMgr;

            if (oOpticalProcess != null)
            {
                WriteError("Previous operation not completed");
                return false;
            }
            oDiskMgr = new COpticalDiskManager();
            sLastOutPut = sLastError = string.Empty;
            if (oDiskMgr.LoadDrive(voOpticalDrive))
            {
                sOutPut = oDiskMgr.LastError;
                oMatch = new Regex("medium not present*|No disk*|Wrong disk*", RegexOptions.Multiline | RegexOptions.IgnoreCase).Match(sOutPut);
                return oMatch.Success; 
            }
            return true;
        }
    };
};
