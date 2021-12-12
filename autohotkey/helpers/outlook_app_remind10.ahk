; Outlook - Appointment - 5 minutes
WinGetTitle, Title, A
if (!!InStr(Title, "- Appointment")) {
    ; SET Reminder to 5 min
    Send, {Blind}{Lalt}{2}
    Sleep, 280
    Send, {Blind}{1}{0} ; < = = = Reminder Time
    Sleep, 280
    Send, {Blind}{Enter}
}
else {
    ExitApp
}

; Exit
ExitApp