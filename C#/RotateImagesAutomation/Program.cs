using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.Windows.Forms;

namespace RotatePhotos
{
    class Program
    {
        static int IntervalBwKeys = 450;
        static int IntervalBwRestartingPaintApp = 900;

        static Process paint = new Process();

        static void Send(string Keys)
        {
            try
            {
                // Wait a while
                System.Threading.Thread.Sleep(IntervalBwKeys);
                // Make the paint app, as the active one
                Microsoft.VisualBasic.Interaction.AppActivate( paint.Id );
                // Send the keys, to paint
                SendKeys.SendWait(Keys);
            }
            catch (Exception eX) {}
        }

        static void Main(string[] args)
        {
            // We need both the Input files folder and the rotation value
            if (args.Length != 2 )
            {
                return;
            }           
            
            // Start paint app;
            ProcessStartInfo pInfo = new ProcessStartInfo("mspaint.exe");
            paint.StartInfo = pInfo;
            paint.Start();       
 
            string sPath = args[0];
            int rotation = int.Parse(args[1]) * 90;
            // Create a directory to save the transformed files
            if (!Directory.Exists(sPath + @"\RotatedByAbraham\"))
            {
                Directory.CreateDirectory(sPath + @"\RotatedByAbraham\"); 
            }
            // Get all the JPG files from the specified folder
            string[] sFiles = System.IO.Directory.GetFiles(sPath, "*.jpg");
            int tot = sFiles.Length;
            int cur = 0;
            // Process Each of the input JPG file
            foreach (string file in sFiles)
            {
                // Calculate the path to the intermediate BMP file creating
                string bmp = sPath + "\\" + Path.GetFileNameWithoutExtension(file) + ".bmp";
                //Open our current input JPG file
                Send("%(FO)"); Send("%N");
                Send(file);
                Send("~");
                // If user specified , rotation to be made
                if (rotation > 0)
                {
                    // Calculate the rotation, [90,180,270]
                    string s = string.Format("{0}", rotation).Trim().Substring(0, 1);
                    // Select the flip rotate dialog in paint
                    Send("%(IF)");
                    // Send the rotation needed
                    Send("%(R" + s + ")");
                    // Rotation completed
                    Send("~");
                }
                // Select, File/Save As menu item
                Send("%(FA)");
                // In the dialog select the bitmap, in the filter combo box and then click the save button
                Send("%T"); Send("{F4}"); Send("2"); Send("2"); Send("{TAB}"); Send("%s");
                System.Threading.Thread.Sleep(IntervalBwRestartingPaintApp);

                // Restart Paint appliction, so that we dont have errors while saving
                Send("%(FX)");  //paint.Kill(); // Close the paint app
                paint.StartInfo = pInfo;
                paint.Start();

                // Start the paint application, and open our temporary BMP file created
                Send("%(FO)"); Send("%N");
                Send("\"" + bmp + "\"");
                Send("~");
                // Select the File/Save As option
                Send("%(FA)");
                // Specify save path, and in the filter combo box, select JPG, and click the save button
                Send(sPath + @"\RotatedByAbraham\" + Path.GetFileName(file)); Send("%T"); Send("{F4}"); Send("j"); Send("{TAB}"); Send("%s");
                //Send("~");

                string fileName = Path.GetFileName(file);
                // Delete the intermediate BMP file created
                File.Delete(bmp);
                // Delete the original JPG file inputted
                File.Delete(file);
                // Write the progress to the console and percent of completion  
                Console.Clear();
                Console.WriteLine("Percent Completed: {0}%\n\nCompleted File: {1}.", (int)(100F * (float)cur++ / (float)tot), fileName);
            }
            // Close paint
            Send("%(FX)");  //paint.Kill();
            
        }
    };
};
