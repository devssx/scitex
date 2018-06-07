#include <astyle_main.h>
#include <list>
#include "CodeFormatter.h"

using namespace astyle;

std::list<char*> mallocRef;

CodeFormatter::CodeFormatter(std::string code, CodeType ct) : m_code("")
{
mallocRef.clear();
ASLibrary program;

auto unformated = program.convertUtf8ToUtf16(code.c_str(), MemoryAllocation);
auto formated = program.formatUtf16(unformated, (utf16_t*)L"--style=bsd --indent-namespaces", OnError, MemoryAllocation);
m_code = program.convertUtf16ToUtf8(formated);

for (auto ref : mallocRef)
{
	delete[] ref;
	ref = nullptr;
}
}


CodeFormatter::~CodeFormatter()
{
}

std::string CodeFormatter::ToString()
{
    return m_code;
}

char * CodeFormatter::MemoryAllocation(unsigned long memoryNeeded)
{
    char* buffer = new (nothrow) char[memoryNeeded];
    mallocRef.push_back(buffer);
    return buffer;
}

void CodeFormatter::OnError(int errorNumber, const char * errorMessage)
{
}
