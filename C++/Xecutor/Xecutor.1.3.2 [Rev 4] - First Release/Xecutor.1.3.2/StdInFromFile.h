
#pragma once

class CStdInFromFile : public IRedirectedInput
{
private:
	

public:

	CStdInFromFile(CTString Path);
	virtual bool WriteToStream(CTString tsOutputLine);
	virtual bool StreamClosed(bool Graceful);
}