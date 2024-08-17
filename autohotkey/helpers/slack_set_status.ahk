; SLACK - Set Status
#Persistent
; a) Get the active window's process name
WinGet, activeProcessName, ProcessName, A
; b) Do something depending on whether Slack is in focus or not
if (activeProcessName = "slack.exe") {
    ; TRUE Slack is in focus
    step_1()
} else {
    ; FALSE Slack is not in focus
    ; 1 SET Slack to be in focus
    Send, {Blind}{LWin Down}1{LWin Up}
    Sleep, 50
    ; 2 GO to the first Slack Workspace
    Send, {Blind}{Ctrl Down}1{Ctrl Up}
    Sleep, 50
    ; 3 SET Status
    step_1()
}



ExitApp

/**
 * FUNCTIONS
 */

step_1()
{
    ; 1 Call the Set Status Window
    Send, {Blind}{Ctrl Down}{Shift Down}y{Shift Up}{Ctrl Up}
    Sleep, 300
    step_2()
    step_3()
    return
}
step_2()
{
    ; 2 TYPE The Status text
    Send weekend mode
    return
}
step_3()
{
    ; 3 Go to set the icon
    Send, {Blind}{Shift Down}{Tab}{Shift Up}
    Sleep, 25
    Send, {Enter}
    Sleep, 25
    Send, :double_vertical_bar
    Sleep, 25
    Send, {Enter}
    Sleep, 25
    ; Press Tab 7 times
    Loop, 7 {
    Send {Blind}{Tab}
    Sleep, 10
    }
    return
}