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
WinMove, %this_window%,, 336, 207, 1920, 1080
Sleep, 500

; Done
ExitApp