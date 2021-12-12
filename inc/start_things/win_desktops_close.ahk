;CLOSE All open Desktops

Loop, 11
{
    MouseMove, 632, 24 ;Screen 2 close button position
    Sleep, 400

    ;Look at color under mouse
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%

    ;Decide what to do
    if color = 0x1C0DB9
    {
    MouseClick, L
    Sleep, 180
    }
    else {
    MouseClick, L
    return
    }
}

Exit