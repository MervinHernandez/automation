#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <tchar.h>

#pragma comment(lib, "user32")

#pragma comment(linker,"\"/manifestdependency:type='win32' \
name='Microsoft.Windows.Common-Controls' version='6.0.0.0' \
processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")

int CDECL MessageBoxPrintf(TCHAR * szCaption, TCHAR * szFormat, ...) {
    TCHAR szBuffer[1024];
    va_list pArgList;

    va_start(pArgList, szFormat);
    _vsntprintf(szBuffer, sizeof(szBuffer) / sizeof(TCHAR), szFormat, pArgList);
    va_end(pArgList);

    return MessageBox(NULL, szBuffer, szCaption, 0);
}

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {

    MessageBoxPrintf(_T("Title"), "%d", 1);
    return 0;
}
