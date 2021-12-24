; START - Chrome - WingMan
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

; Run the shortcut to the specific Chrome
RunWait, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1"
Sleep, 350

; Set variable with window title
WinGetActiveTitle, Title
this_window = %Title%

; Move Window to Screen 1
WinMove, %this_window%,, 653, 250, 2567, 1617
Sleep, 500

; Done
ExitApp