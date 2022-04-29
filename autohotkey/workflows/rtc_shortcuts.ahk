; GUI Window - rtC Desktop Shortcuts
Msgbox, This is a WIP
; 1. CREATE GUI Elements
Gui, Destroy
Gui, Show, x1537 y562 h150 w270, rtCamp Shortcuts
Gui, Add, Button, x22 y59 w220 h30 gbtn1, Clients Folder (x-Delivery-Sales-for-Clients)
Gui, Add, Button, x22 y99 w220 h30 gbtn2, PM Folder (Clients-Projects-Data)
Gui, Font, s14, Verdana
Gui, Add, Text, x22 y19 w220 h30 , Main rtC Folders

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
; Open Sales Folder
Run, I:\Shared drives\x-Delivery-Sales-for-Clients
Sleep, 1000

; Exit App
ExitApp
}
; *****
; Button 2
; *****
btn2:
{

; Exit App
ExitApp
}
; *****
; Button 3
; *****
btn3:
{
MsgBox, Button 3
; Exit App
ExitApp
}

; *****
; Button 4
; *****
btn4:
{
MsgBox, Button 4
; Exit App
ExitApp
}