; SHUT Down Sequence

; 1. CLOSE Other Desktops
;RunWait, %A_ScriptDir%\SHUTDOWN_CLOSE_Desktops.ahk

; 2. Start > Shut Down
{
Send, {Blind}{LWin Down}{LWin Up}
Sleep, 305
Send, {Blind}{Up}
Sleep, 172
Send, {Blind}{Right}
Sleep, 50
Send, {Blind}{Right}
Sleep, 50
Send, {Blind}{Enter}
Sleep, 586
Send, {Blind}{Down}
}
Sleep, 80
SoundBeep, 750, 500