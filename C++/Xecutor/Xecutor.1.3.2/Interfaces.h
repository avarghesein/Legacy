
#pragma once

#define interface struct

interface IRedirectedOutput
{
	virtual bool WriteToStream(CTString tsOutputLine) = 0;
	virtual bool StreamClosed(bool Graceful) = 0;
};

interface IDynamicCommandLineProvider
{
	virtual bool GenerateCommandLine(CTString &tsExePath,CTString &tsCommandLine) = 0;
};