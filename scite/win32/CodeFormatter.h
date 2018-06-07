#pragma once
enum CodeType 
{
	CPP,
	CS,
	CSS,
	JAVA,
	JSON
};

class CodeFormatter
{
private:
	std::string m_code;
public:
	CodeFormatter(std::string code, CodeType ct = CodeType::CPP);
	~CodeFormatter();

	std::string ToString();
	static char* __stdcall MemoryAllocation(unsigned long memoryNeeded);
	static void __stdcall OnError(int errorNumber, const char* errorMessage);
};

