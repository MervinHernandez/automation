; LISTENER Script
; Running on MervPC13
; ========

; ========
; KEY ASSIGNMENTS
; ========

; Numpad 1
Numpad1::
{
beep()
exp_down()
return
}
; Numpad 2
Numpad2::
{
beep()
exp_up()
return
}
; Numpad 3
Numpad3::
{
beep()
return
}
; Numpad 4
Numpad4::
{
beep()
win_left()
return
}
; Numpad 5
Numpad5::
{
beep()
return
}
; Numpad 6
Numpad6::
{
beep()
win_right()
return
}
; Numpad 7
Numpad7::
{
beep()
step_1_remoteshoot()
return
}
; Numpad 8
Numpad8::
{
beep()
step_2_livepreview()
return
}
; Numpad 9
Numpad9::
{
beep()
open_ndi_monitor()
return
}

; ========
; FUNCTIONS
; ========

beep() {
SoundBeep, 1760, 300
return
}

; FUNC - Windows Left
win_left() {
Send, {Blind}{Ctrl Down}{LWin Down}{Left}{LWin Up}{Ctrl Up}
return
}
; FUNC - Windows Right
win_right() {
Send, {Blind}{Ctrl Down}{LWin Down}{Right}{LWin Up}{Ctrl Up}
return
}

; FUNC - Press Remote Shooting
step_1_remoteshoot() {
DllCall("SetCursorPos", "int", 208, "int", 238)
MouseClick, L
Sleep, 250
return
}

; FUNC - Open the Live Preview window
step_2_livepreview() {
; 1. Move this window to the top left of the screen
    ; Set variable with window title
    WinGetActiveTitle, Title
    ; Move Window to Screen 1
    WinMove, %Title%,, 6, 11
    Sleep, 150

; 2. Click "Live Preview" button
    MouseMove, 77, 544
    Sleep, 150
    MouseClick, L
    Sleep, 350

; 3. Minimize the Preview window
    WinWait, Remote Live View window
    WinMinimize
return
}

; FUNC - Exposure Down
exp_down() {
    ; Click exposure bar
    CoordMode, Mouse, Screen
    MouseClick, L, 129, 277
    Sleep, 50

    ; Bump exposure
    Send, {Left}
    Sleep, 50

    ; Done
    Send, {Enter}
    return
}

; FUNC - Exposure Up
exp_up() {
    ; Click exposure bar
    CoordMode, Mouse, Screen
    MouseClick, L, 129, 277
    Sleep, 50

    ; Bump exposure
    Send, {Right}
    Sleep, 50

    ; Done
    Send, {Enter}
    return
}

; FUNC - Open NDI Monitor
open_ndi_monitor() {
Run, "C:\Program Files\NDI\NDI 5 Tools\Studio Monitor\Application.Network.StudioMonitor.x64.exe"
return
}