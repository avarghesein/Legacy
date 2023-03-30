
using System;
using System.IO; 
using System.Text.RegularExpressions;  
using System.Collections; 

namespace XCoDec
{
	class CXCoDec
	{
		[STAThread]
		static void Main(string[] args)
		{
			bool isEncode = true;
			string file = string.Empty,pass = string.Empty;
			byte code = 0;

			if(!CheckCommandLine(args,ref isEncode,ref code,ref file,ref pass)) return;

			try
			{
				Console.WriteLine("\n\nFile:{0}\n\nPass:{1}\n\nEncode:{2}\n\nByteCode:{3}\n\nType 'Quit' to abort...\n",file,pass,isEncode,code);  
				string chr = Console.ReadLine();  
				if(chr.Trim().ToUpper() == "QUIT") return;  
				if(isEncode) Encode(file,pass,code); else Decode(file,pass,code); 
				Console.WriteLine("\n\nOperation Success...Any Key to close...");
				Console.ReadLine(); 
				//Console.ReadLine();  
			}
			catch(Exception eX)
			{
				Console.Write(GetMsg(eX));
				Console.ReadLine(); 
				//Console.ReadLine();  
			}
		}

		private static string GetMsg(Exception eX)
		{
			if(eX == null) return string.Empty;
			return eX.Message + "\n" + GetMsg(eX.InnerException); 
		}

		static bool ParseCommandLine(string CmdLine,ref bool IsEncode,ref byte Code,ref string File,ref string PassWord)
		{
			string patFile = @"(-[f|F]:(?<FILE>[^\s]+))";
			string patOpt = @"(-(?<OPT>[e|E|d|D])((:(?<OPTVAL>[0-9]+))|(?<OPTVAL>[\s]*)))";
			string patPass = @"(((-[p|P]:(?<PASS>[^\s]+))|(?<PASS>[\s]*)))";

			string[] patterns = new string[] { patFile,patOpt,patPass }; 

			CPerm perm = new CPerm(3);
 
			foreach(ArrayList indexList in perm)
			{
				string patCur = @"[\s]*";
				foreach(int index in indexList) patCur += patterns[index] + @"[\s]*";  
				patCur = patCur.Substring(0,patCur.Length - 1) + "*"; 
  
				try
				{
					Regex regX = new Regex(patCur,RegexOptions.Singleline);
					Match match = regX.Match(CmdLine);
					if(!match.Success || match.Value != CmdLine) continue;
					File = match.Groups["FILE"].Value;   
					IsEncode = match.Groups["OPT"].Value.Trim().ToUpper() == "E";  
					Code = match.Groups["OPTVAL"].Value.Trim() == string.Empty ? (byte)100 : byte.Parse(match.Groups["OPTVAL"].Value); 
					PassWord = match.Groups["PASS"].Value;
					return true;
				}
				catch {}
			}

			return false;
		}

		static bool CheckCommandLine(string[] args,ref bool IsEncode,ref byte Code,ref string File,ref string Pass)
		{
			string cmdLne = string.Empty;
 
			foreach(string str in args) cmdLne += str + " ";
			cmdLne = cmdLne.Trim();
			bool res;
			if(!(res = ParseCommandLine(cmdLne,ref IsEncode,ref Code,ref File,ref Pass))) PrintUsage();
			return res;
		}

		static void PrintUsage()
		{
			Console.WriteLine("\n\nUsage: XCoDec -(e|d)[:{Encoding Byte}] -f:{File} [-p:{Password}]\n\n");    
			Console.Read();  
		}

		static unsafe void Decode(string SrcFile,string PassWord,byte DeCode)
		{
			byte[] fileData = GetFileContents(SrcFile);
			
			int passLen,fileNameLen;

			int *p = &passLen;
			for(int i = 0; i < sizeof(int); ++i) *(((byte*)p)+i) = fileData[i];
			byte[] passByts = new Byte[passLen]; 
			for(int i = 0; i < passLen; ++i) passByts[i] = (byte)(fileData[sizeof(int) + i] ^ DeCode); 
			string pass = System.Text.Encoding.ASCII.GetString(passByts);       

			if(pass != PassWord) throw new ApplicationException("Invalid Password!!!");
  
			int *q = &fileNameLen;
			for(int i = 0; i < sizeof(int); ++i) *(((byte*)q)+i) = fileData[sizeof(int)+ passLen + i];
			byte[] fileNameByts = new Byte[fileNameLen]; 
			for(int i = 0; i < fileNameLen; ++i) fileNameByts[i] = (byte)(fileData[passLen + 2 * sizeof(int) + i] ^ DeCode); 
			string fileName = System.Text.Encoding.ASCII.GetString(fileNameByts);  
     
			FileStream stream = new FileStream(GetDecodePath(SrcFile) + fileName,FileMode.Create,FileAccess.Write);
			for(int i = 2 * sizeof(int) + passLen + fileNameLen; i < fileData.Length; ++i) stream.WriteByte((byte)(fileData[i] ^ DeCode));
			stream.Close();  
		}

		static unsafe void Encode(string SrcFile,string PassWord,byte EnCode)
		{
			byte[] fileData = GetFileContents(SrcFile);
			byte[] passWord = System.Text.Encoding.ASCII.GetBytes(PassWord);
			byte[] fileName = System.Text.Encoding.ASCII.GetBytes(GetFileName(SrcFile)); 

			byte[][] arrays = new byte[][] { passWord,fileName,fileData };

			foreach(byte[] array in arrays)
				for(int i = 0; i < array.Length; ++i) array[i] = (byte)(array[i] ^ EnCode);

			FileStream stream = new FileStream(GetEncodeFile(SrcFile),FileMode.Create,FileAccess.Write);

			int passLen = passWord.Length,fileNameLen = fileName.Length;   

			int *q = &passLen; 
			{
				for(int i = 0; i < sizeof(int); ++i)
				{
					stream.WriteByte(*((byte*)(void*)q+i));  
				}
			}
			stream.Write(passWord,0,passWord.Length);

			int *p = &fileNameLen; 
			{
				for(int i = 0; i < sizeof(int); ++i)
				{
					stream.WriteByte(*((byte*)(void*)p+i));  
				}
			}
			stream.Write(fileName,0,fileName.Length);  

			stream.Write(fileData,0,fileData.Length);           
			stream.Close(); 
		}

		static string GetEncodeFile(string Path)
		{
			int index = Path.LastIndexOf(".");
			if(index <= -1) return Path + ".XCoDec";
			if(index >= (Path.Length - 1)) return Path + "XCoDec";   
			return Path.Substring(0,index) + ".XCoDec";    
		}

		static string GetDecodePath(string Path)
		{
			int index = Path.LastIndexOf("\\");  
			if(index < 0 || index >= (Path.Length - 1)) return string.Empty;
			return Path.Substring(0,index + 1);   
		}

		static string GetFileName(string Path)
		{
			int index = Path.LastIndexOf("\\");  
			if(index < 0 || index >= (Path.Length - 1)) return Path;
			return Path.Substring(index + 1);   
		}

		static byte[] GetFileContents(string FileName)
		{
			try
			{
				using(FileStream fstream = new FileStream(FileName,FileMode.Open,FileAccess.Read))
				{
					byte[] byts = new byte[fstream.Length];  
					if(fstream.Length == fstream.Read(byts,0,(int)fstream.Length)) return byts;  
				}
				throw new Exception("Entire Bytes Cannot be read"); 
			}
			catch(Exception eX)
			{
				throw new ApplicationException("Source File Read Error",eX); 
			}
		}
	};
};
