
#include <stdio.h>
#include <Windows.h>
#include "console.h"
#include <share.h>

#define CONFLAGS_CONSOLE	1
#define CONFLAGS_WRITEOUT	2
#define CONFLAGS_WRITEERR	4
#define CONFLAGS_WRITEFILE	8

typedef unsigned long long uint64_t;

FILE*in = NULL,
	*out = NULL,
	*err = NULL,
	*file = NULL;
GMFUNC initConsole(double _o)
{
	uint64_t outputs = _o;
	if (outputs & CONFLAGS_CONSOLE)
	{
		if (AllocConsole())
		{
			if (outputs & CONFLAGS_WRITEOUT)
				freopen_s(&out, "CONOUT$", "w", stdout);
			//if (outputs & CONFLAGS_WRITEERR)
			//	freopen_s(&err, "CONERR$", "w", stderr); // guessing // okay not the right name
		}
	}
	if (outputs & CONFLAGS_WRITEFILE)
	{
		file = _fsopen("log.log", "w", _SH_DENYNO);
	}
	return 123.30555f;
}
GMFUNC print(char*text)
{
	if (file)
	{
		fputs(text, file);
		fflush(file);
	}
	if (out)
		fputs(text, out);
	return 0;
}
GMFUNC error(char*text)
{
	return fputs(text, err);
}

/*API BOOL WINAPI DllMain(
	HINSTANCE hInstance,
	ULONG ulReason,
	LPVOID _)
{
	switch(ulReason)
	{
	case DLL_PROCESS_ATTACH:
		break;

	case DLL_PROCESS_DETACH:
		if (file)
			fclose(file);
		break;
	}

	return TRUE;
}*/

