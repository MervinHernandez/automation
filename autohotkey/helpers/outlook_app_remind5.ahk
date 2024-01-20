; Outlook - Appointment - X minutes
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
    ; SET Reminder to 5 min
    Send, {Blind}{Lalt}{2}
    Sleep, 50
    Send, {Blind}{Backspace}
    Sleep, 50
    Send, {Blind}{5} ; < = = = Reminder Time
    Sleep, 50
    Send, {Blind}{Enter}
}
else {
    ExitApp
}

; Exit
ExitApp