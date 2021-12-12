; Outlook - Appointment - Move to - WingMan WP Calendar
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
    ; SET Reminder to 5 min
    Send, {Blind}{Lalt}{4}
    Sleep, 280
    Send, {Blind}{c}{a}
    Sleep, 280
    Send, {Blind}{Right}
    Sleep, 150
    Send, {Blind}{Right}
    Sleep, 150
    Send, {Blind}{w}{i}
    Sleep, 150
    Send, {Blind}{Enter}
}
else {
    ExitApp
}

; Exit
ExitApp