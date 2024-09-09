; START - Chrome - WingMan
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

; Run the shortcut to the specific Chrome
Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 3"
Sleep, 750

; Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%
Sleep, 120

; Move Window to Screen 1
WinMove, %this_window%,, 1522, 393, 1300, 855
Sleep, 150

; Open Cam Control
Send * cam
Sleep, 250
Send {Enter}
Sleep, 500
Loop 3 {
    Send {Blind}{Tab}
    Sleep, 50
}
; Login - start typing password, and then let 1Password login
Send ad
Sleep, 150
Send {Down}{Enter}
Sleep, 750

; Tab to Settings
Loop 3 {
    Send {Blind}{Tab}
    Sleep, 100
}
Send {Enter}
Sleep, 250

; Tab to Camera Controls
Loop 6 {
    Send {Blind}{Tab}
    Sleep, 100
}
Sleep, 150
Send {Enter}
Sleep, 100

; Select the html element with the id "gain" on the screen which is already in focus
Loop 21 {
    Send {Blind}{Tab}
    Sleep, 100
}
Sleep, 150

Msgbox Done

; Done
ExitApp