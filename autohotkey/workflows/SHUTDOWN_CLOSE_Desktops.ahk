; CLOSE Windows Desktops

Send, {Blind}{LWin Down}{Tab}{LWin Up}
Loop, 4 {
Sleep, 450
Send, {Blind}{Down}
}

Loop, 5 {
Send, {Blind}{Left}
Sleep, 500
Send, {Blind}{AppsKey}
Sleep, 100
Send, {Blind}{Up}
Sleep, 100
Send, {Blind}{Enter}
Sleep, 100
}

Loop, 6 {
Sleep, 200
Send, {Blind}{LWin Down}{Tab}{LWin Up}
Sleep, 200
Send, {Blind}{Alt Down}{F4}{Alt Up}
Sleep, 100
}

Sleep, 500

ExitApp