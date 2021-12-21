; MS Outlook
; -- Automatically open calendar and resize everything
CoordMode, Mouse, Screen

;-- Progress Bar --
Progress, b w200, Working ..., Starting Outlook, Outlook
Progress, 10
;-- Progress Bar --

if WinExist("Inbox - Me@mervinhernandez.com - Outlook") {
    ; Save starting mouse position
    MouseGetPos, x_start, y_start
    BlockInput, MouseMove ;block the user from moving the mouse during this operation

    ; Focus on Outlook Window
    WinActivate ; Use the window found by WinExist.
    Progress, 15
    Sleep, 50

    ; 1. Move Inbox to the left
    Send, {Blind}{LWin Down}{Left}{LWin Up}
    Progress, 35
    Sleep, 500

    ; 2. Open calendar in new window
    MouseClick, R, 129, 1998
    Sleep, 500
    MouseClick, L, 222, 1825
    Sleep, 500
    Progress, 50

    ; 3. Put calendar window on the right
    Send, {Blind}{LWin Down}{Right}{LWin Up}
    Sleep, 1000
    Progress, 62

    ; 4. Resize two windows
    MouseClick, L, 1920, 940,,, D
    Sleep, 500
    MouseClick, L, 1404, 894,,, U
    Sleep, 600
    Progress, 72

    ; 5. Open other two calendars
    MouseClick, L, 1528, 913
    Sleep, 500
    MouseClick, L, 1540, 950
    Sleep, 500
    Progress, 80

    ; 6. Click main calendar tab
    MouseClick, L, 2026, 269
    Progress, 90

    ; Put the mouse back
    MouseMove, x_start, y_start
    BlockInput, Off ;and release the mouse from its bounds

    ; 7. PLAY Sound
    Progress, 99
    SoundPlay, %A_ScriptDir%\..\sounds\airline_ding.mp3
    Sleep 2000
}
else {
    MsgBox, Outlook is not open yet.
}

; Done
Progress, Off
ExitApp

; = = = = = =
; Escape to Quit anytime
~*Esc::
{
BlockInput, Off ;also release the mouse if I quit the app
ExitApp
}