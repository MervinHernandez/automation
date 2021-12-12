; START My Day
; -- Open all the chromes

; Chrome - Mervin (MAIN)
Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" "https://gmail.com"
Sleep, 600
; Chrome - WingMan WP
Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1" "https://gmail.com"
Sleep, 600
; Chrome - rtCamp
Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 2" "https://gmail.com"
Sleep, 600

ExitApp

; = = = = = =
; Escape to Quit anytime
~*Esc:: ExitApp