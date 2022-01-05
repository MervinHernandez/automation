; ============================================================================
;  |\/| |__  |__) \  / | |\ |    |__| |__  |__) |\ |  /\  |\ | |  \ |__   /
;  |  | |___ |  \  \/  | | \|    |  | |___ |  \ | \| /~~\ | \| |__/ |___ /_
;           ___  __        __  ___       ___
;  /\  |  |  |  /  \ |__| /  \  |  |__/ |__  \ /
; /~~\ \__/  |  \__/ |  | \__/  |  |  \ |___  |
; ============================================================================

; #####################################################
; NOTES - Prerequisites
; #####################################################
; This script depends on the following screen resolution and scaling proportions.
; Absent these, several clicks will not work properly.
; Screen 1 - 3840 x 2160 @ 175% Windows Scaling
; Screen 2 - 1920 x 1080 @ 100% Windows Scaling
; Screen 3 - 1920 x 1080 @ 125% Windows Scaling

; INCLUDES
; Outlook flyout menu
#Include D:\payload_repos\automation\autohotkey\workflows\outlook_app_helper.ahk

; = = =
; F Keys - Mervin Edition

^!+1:: ; Ctrl + Alt + Shift + 1
{
;-- Subroutine - If Outlook Appointment
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
    WinActivate, A
    Send, {Blind}{Alt Down}{2 Down}{2 Up}{Alt Up}
    Sleep, 80
    Send, {0}
    Sleep, 80
    MouseClick, L
}
else {
}
;-- Subroutine - If Outlook Appointment
return
}

^!+2:: ; Ctrl + Alt + Shift + 2
{
;-- Subroutine - If Outlook Appointment
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
    WinActivate, A
    Send, {Blind}{Alt Down}{2 Down}{2 Up}{Alt Up}
    Sleep, 80
    Send, {N}
    Sleep, 80
    MouseClick, L
}
else {
Send, {F2}
}
;-- Subroutine - If Outlook Appointment
return
}

^!+3:: ; Ctrl + Alt + Shift + 3
{
say_it()
return
}

^!+4:: ; Ctrl + Alt + Shift + 4
{
WinActivate, A
Send, {Alt Down}{F4 Down}{F4 Up}{Alt Up}
return
}

^!+5:: ; Ctrl + Alt + Shift + 5
{
say_it()
return
}

^!+6:: ; Ctrl + Alt + Shift + 6
{
say_it()
return
}

^!+7:: ; Ctrl + Alt + Shift + 7
{
say_it()
return
}

^!+8:: ; Ctrl + Alt + Shift + 8
{
say_it()
return
}

^!+9:: ; Ctrl + Alt + Shift + 9
{
say_it()
return
}

^!+0:: ; Ctrl + Alt + Shift + 0
{
say_it()
return
}

; Function - Say it
say_it() {
MsgBox, It Works
}