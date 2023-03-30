#pragma once

class CCommandLineProvider : public IDynamicCommandLineProvider
{
public:
	CTString Script;
	CTString DumpFolder;
	CTString DumTemplateFile;
	CTString User;
	CTString Pass;
	CTString DataBase;
	CTString Exta;
	CTString Profile;
	CTString UseExtaOnly;
	virtual bool GenerateCommandLine(CTString &tsExePath,CTString &tsCommandLine);
};

bool CCommandLineProvider::GenerateCommandLine(CTString &tsExePath,CTString &tsCommandLine)
{
	CTString sCmdLine;

	tsExePath = Script;
	if(UseExtaOnly.Trim().Cut(0,1).ToUpper() == "T")
	{
		sCmdLine = Exta;
	}
	else
	{
		CTString sFile = " -f " + DumTemplateFile + "_" + CTime::CurrentDate("MM-dd-yy") + ".dat";
		sCmdLine += Exta + sFile + " -U " + User + " " + DataBase;  		
	}
	tsCommandLine = sCmdLine;
	return true;
}