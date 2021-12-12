; OUTLOOK Appointment - Flyout
; When creating a new Outlook appoint, this script will create a
; fly-out like window visible next to the appointment window,
; which makes available quick access to numerous shortcuts,
; like the Area of life to associate the appointment with, input fields
; for details to be part of the appointment, etc.

;Aim:
;1. When Notepad comes to front, Gui 2 should be visible & on top.
; When another app comes to front, Gui 2 should be hidden.
;2. When user drags Notepad to a new location, Gui 2 should follow it
; with the appropriate displacement.
;3. When Notepad closes, Gui 2 should disappear.

#Persistent
SetTitleMatchMode, 2
DetectHiddenWindows, On
;NOTE - This works ok with Notepad but it may need to be
;turned OFF if you can't get this macro to work with other apps
;Check with Window Spy

Gui, 2: Add, Button, vmyButton1 gOnToolbar,  #1
Gui, 2: Add, Button, vmyButton2 gOnToolbar,  #2
Gui, 2: Add, Button, vmyButton3 gOnToolbar,  #3
Gui, 2: +AlwaysOnTop +Toolwindow
Gui, 2: +LastFound
TB_hWnd := WinExist()

; http://www.autohotkey.com/forum/topic35659
HookProcAdr   := RegisterCallback( "HookProc", "F" )
hWinEventHook := SetWinEventHook( 0x3, 0x3, 0, HookProcAdr, 0, 0, 0 )

Return

~LButton::
{
    IfWinActive, Notepad
    {
        Gui, 2: Show, NoActivate, Toolbar
    }
    Loop
    {
        MouseIsPressed := GetKeyState( "LButton", "P" )
        IfWinActive, Notepad
        {
            WinGetPos, myX, myY, Width, Height, ahk_class Notepad
            Gui, 2: Show, % "x"myX + 50 . " y"myY + 100 . " NoActivate"
        }
        If( Not MouseIsPressed )
        {
            If !( WinActive( "Notepad" ) OR WinActive( "ahk_id " . hWnd ) )
            {
                Gui, 2: Hide
            }
            Break
        }
    }
}
Return

OnToolbar:
{
    Gui, Submit, NoHide
    If ( A_GuiControl = "myButton1" )
    {
        MsgBox, Button #1 clicked
    }
    Else If ( A_GuiControl = "myButton2" )
    {
        MsgBox, Button #2 clicked
    }
    Else If ( A_GuiControl = "myButton3" )
    {
        MsgBox, Button #3 clicked
    }
}
Return

HookProc( hWinEventHook, Event, hWnd, idObject, idChild, dwEventThread, dwmsEventTime )
{
    Global TB_hWnd
    WinGetClass, myClass, ahk_id %hWnd%
    WinGetTitle, myTitle, ahk_id %hWnd%
    If Event ; EVENT_SYSTEM_FOREGROUND = 0x3
    {
        If ( hWnd = TB_hWnd )
        {
            Return
        }
        If ( myClass = "Notepad" )
        {
            WinGetPos, myX, myY, Width, Height, ahk_class Notepad
            Gui, 2: Show, % "x"myX + 50 . " y"myY + 100 . " NoActivate"
        }
        Else
        {
            Gui, 2: Hide
        }
    }
}

SetWinEventHook( eventMin, eventMax, hmodWinEventProc, lpfnWinEventProc, idProcess, idThread, dwFlags )
{
   DllCall("CoInitialize", Uint, 0)
   return DllCall("SetWinEventHook"
   , Uint,eventMin
   , Uint,eventMax
   , Uint,hmodWinEventProc
   , Uint,lpfnWinEventProc
   , Uint,idProcess
   , Uint,idThread
   , Uint,dwFlags)
}