
#define _stdcall __attribute__((stdcall))
#define _cdecl __attribute__((cdecl))
#define API __declspec(dllexport)
#define GMFUNC API double
API double initConsole(double outputs);
API double print(char*text);
API double error(char*text);
