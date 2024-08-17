; SLACK - Set Status
#Persistent
; a) Get the active window's process name
WinGet, activeProcessName, ProcessName, A
; b) Do something depending on whether Slack is in focus or not
if (activeProcessName = "slack.exe") {
    ; TRUE Slack is in focus
    MsgBox "Slack is in focus"
} else {
    ; FALSE Slack is not in focus
    MsgBox "Slack is NOT in focus"
    ; 1 SET Slack to be in focus
    Send, {Blind}{LWin Down}1{LWin Up}
    Sleep, 50
    ; 2 GO to the first Slack Workspace
    Send, {Blind}{Ctrl Down}1{Ctrl Up}
    Sleep, 50
}


; 1 Call the Set Status Window
;Send, {Blind}{Ctrl Down}{Shift Down}y{Shift Up}{Ctrl Up}
;Sleep, 50

ExitApp