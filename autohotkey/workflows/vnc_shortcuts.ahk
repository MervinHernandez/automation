; GUI Window - Remote Desktops

; 1. CREATE GUI Elements
Gui, Destroy
Gui, Show, x1537 y562 h313 w270, Remote PC's
Gui, Add, Button, x22 y59 w220 h30 gbtn1, Merv13 PC
Gui, Add, Button, x22 y99 w220 h30 gbtn2, Tablet Laptop
Gui, Add, Button, x22 y139 w220 h30 gbtn3, PC 2303
Gui, Add, Button, x22 y259 w220 h30 gbtn4, LOCAL MacOne
Gui, Font, s14, Verdana
Gui, Add, Text, x22 y19 w220 h30 , LOCAL Computers
Gui, Add, Text, x22 y219 w220 h30 , OTHER Computers

; 2. Set the Window Icon
{
hIcon := DllCall("LoadImage", uint, 0, str, A_ScriptDir "\vnc_icon.ico"
	, uint, 1, int, 0, int, 0, uint, 0x10)  ; Type, Width, Height, Flags
Gui +LastFound  ; Set the "last found window" for use in the next lines.
SendMessage, 0x80, 0, hIcon  ; Set the window's small icon (0x80 is WM_SETICON).
SendMessage, 0x80, 1, hIcon  ; Set the window's big icon to the same one.
}

Return

; 2. CLOSE The Application on Close
GuiClose:
ExitApp

; = = Functions = =
; *****
; Button 1
; *****
btn1:
{
; Run the VNC Link to Merv13
Run, C:\Users\mervi\OneDrive - Mervin Enterprises\Documents\UTIL Shortcuts\TASKBAR Shortcuts\LOCAL Merv13.vnc
Sleep, 1000

; Select this window
; -- Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Size and Move
WinMove, %this_window%,, 544, 190, 3263, 1887

; Exit App
ExitApp
}
; *****
; Button 2
; *****
btn2:
{
; Run the VNC Link to MervTAB
Run, C:\Users\mervi\OneDrive - Mervin Enterprises\Documents\UTIL Shortcuts\TASKBAR Shortcuts\LOCAL MervTAB.vnc
Sleep, 2000

; Select this window
; -- Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Size and Move
WinMove, %this_window%,, 544, 190, 3263, 1887

; Exit App
ExitApp
}

; *****
; Button 3
; *****
btn3:
{
; Run Button 3
Run, "C:\Program Files\RustDesk\rustdesk.exe" --connect 1743355273
Sleep, 2000

; Select this window
; -- Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Size and Move
WinMove, %this_window%,, 544, 190, 3263, 1887

; Exit App
ExitApp
}
; *****
; Button 4
; *****
btn4:
{
; Run Button 4
Run, C:\Users\mervi\OneDrive - Mervin Enterprises\Documents\UTIL Shortcuts\TASKBAR Shortcuts\LOCAL MacOne.vnc
Sleep, 2000

; Select this window
; -- Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Size and Move
WinMove, %this_window%,, 544, 190, 3263, 1887

; Exit App
ExitApp
}