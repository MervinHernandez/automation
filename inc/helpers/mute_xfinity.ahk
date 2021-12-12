; MUTE - Xfinity
CoordMode, Mouse, Screen

; Method A - Win Activate
if WinExist("All Channels - Xfinity Stream") {

    mute_xfinity()

    }
else {
        if WinExist("CNN") {

        mute_xfinity()

            }
            else {
            ; MsgBox, 0, No Can Do, Xfinity is not on right now.
            mute_xfinity2()
            }
    }
; Done
ExitApp

; = = = FUNCTION
mute_xfinity() {
    ; Save starting mouse position
    MouseGetPos, x_start, y_start

    ; Focus on Xfinity Window
    WinActivate ; Use the window found by WinExist.

    ; Get the window position
    WinGetPos, X, Y,,, A

    ; Calculate where to put the mouse
    x_click := X + 125
    y_click := Y + 155

    ; Move to second screen and click
    DllCall("SetCursorPos", "int", x_click, "int", y_click)
    MouseClick, L
    Sleep, 50

    ; Press M
    Send m
    Sleep, 50
    MouseClick, L
    Sleep, 50

    ; Click Screen 1 Task Bar
    ;DllCall("SetCursorPos", "int", 1446, "int", 1129)
    ;MouseClick, L
    Sleep, 50

    ; Put the mouse back
    DllCall("SetCursorPos", "int", x_start, "int", y_start)
    ;MouseClick, L

    ;-- Move again to dismiss overlays
    ;-- -- Move to second screen and click
        DllCall("SetCursorPos", "int", x_click, "int", y_click)
        Sleep, 50
        MouseClick, L
        Sleep, 50
    ;-- -- Put the mouse back
        DllCall("SetCursorPos", "int", x_start, "int", y_start)
        Sleep, 50
        MouseClick, L
        Sleep, 100

    ; PLAY Sound
    SoundPlay, %A_ScriptDir%\..\sounds\airplane_chime.mp3
    Sleep 2000

    ; End Function
    return
}

mute_xfinity2() {
    ; Save starting mouse position
    MouseGetPos, x_start, y_start

    ; Focus on second monitor
    DllCall("SetCursorPos", "int", 8003, "int", 824)
    Sleep, 250
    MouseClick, L
    Sleep, 50

    ; Press M
    Send m
    Sleep, 50
    MouseClick, L
    Sleep, 50

    ; Click Screen 1 Task Bar
    ;DllCall("SetCursorPos", "int", 2513, "int", 2116)
    ;MouseClick, L
    ;Sleep, 50

    ; Put the mouse back
    DllCall("SetCursorPos", "int", x_start, "int", y_start)

    ;-- Move again to dismiss overlays
        ;-- -- Move to second screen and click
            DllCall("SetCursorPos", "int", x_click, "int", y_click)
            Sleep, 50
            MouseClick, L
            Sleep, 50
        ;-- -- Put the mouse back
            DllCall("SetCursorPos", "int", x_start, "int", y_start)
            Sleep, 50
            MouseClick, L
            Sleep, 100

    ; PLAY Sound
    SoundPlay, %A_ScriptDir%\..\sounds\airplane_chime.mp3
    Sleep 2000

    ; End Function
    return
}