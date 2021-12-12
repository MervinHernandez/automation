#define UNICODE
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commctrl.h>
#include <tchar.h>

#pragma comment(lib, "user32")
#pragma comment(lib, "comctl32")

#pragma comment(linker,"\"/manifestdependency:type='win32' \
name='Microsoft.Windows.Common-Controls' version='6.0.0.0' \
processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")

typedef int (*MESSAGEBOXTIMEOUT)(HWND, LPCTSTR, LPCTSTR, UINT, WORD, DWORD);

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
    HMODULE hMod, hLib;
    MSGBOXPARAMSW lpmbp;
    MESSAGEBOXTIMEOUT MessageBoxTimeout;
    int nButtonPressed = 0;

    // MessageBox
    MessageBox(0, L"A simple message box.", L"MessageBox", MB_OK | MB_ICONINFORMATION);

    // MessageBoxTimeout
    hMod = GetModuleHandle(L"user32.dll");
    if (hMod != NULL) {
        MessageBoxTimeout = (MESSAGEBOXTIMEOUT) GetProcAddress(hMod, "MessageBoxTimeoutW");
        if (MessageBoxTimeout != NULL) {
            MessageBoxTimeout(0
            , L"This message box will close automatically after 3 seconds."
            , L"MessageBoxTimeout"
            , MB_OK | MB_ICONWARNING, 0
            , 3000);
        }
    }

    // MessageBoxIndirect
    hLib = LoadLibraryExW(L"imageres.dll", 0, LOAD_LIBRARY_AS_DATAFILE); // Icon resource
    lpmbp.cbSize = sizeof (MSGBOXPARAMSW);
    lpmbp.hwndOwner = NULL;
    lpmbp.hInstance = hLib;
    lpmbp.lpszText = L"Custom icon...";
    lpmbp.lpszCaption = L"MessageBoxIndirect";
    lpmbp.dwStyle = MB_USERICON;
    lpmbp.lpszIcon = MAKEINTRESOURCE(114);

    MessageBoxIndirect(&lpmbp);

    FreeLibrary(hLib);

    // TaskDialog
    if (TaskDialog(GetDesktopWindow(), NULL, L"Task Dialog", L"Main Instruction", L"Content"
    , TDCBF_OK_BUTTON | TDCBF_CANCEL_BUTTON, MAKEINTRESOURCE(144), &nButtonPressed) == S_OK) {
        OutputDebugStringW(nButtonPressed == IDOK ? L"OK button pressed." : L"Cancel pressed.");        
    }

    return 0;
}
