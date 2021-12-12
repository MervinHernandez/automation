; https://xdebug.org/docs-dbgp.php

DebuggerInit() {
    DBGp_OnBegin("DebuggerConnected")
    DBGp_OnBreak("DebuggerBreak")
    DBGp_OnStream("DebuggerStream")
    DBGp_OnEnd("DebuggerDisconnected")

    g_DbgSocket := DBGp_StartListening("127.0.0.1", g_DbgPort)
}

DebuggerConnected(Session) {
    ;MsgBox % "Connected to " . Session.File

    ; Redirect OutputDebug.
    If (g_DbgCaptureStderr) {
        Session.stderr("-c 2")
    }

    ;Session.stdout("-c 2") ; ?

    g_DbgSession := Session
    g_DbgSession.property_set("-n A_LastError -- 0")

    g_DbgStatus := 1

    DefineBreakpoints()

    Dbg_UpdateGUI()

    ; Step onto the first line.
    Session.step_into()
}

; DebuggerBreak is called whenever the debugger breaks, such
; as when step_into has completed or a breakpoint has been hit.
DebuggerBreak(Session, ByRef Response) {
    Local LineNo, FileURI, FullPath, n

    If (InStr(Response, "status=""break""")) {
        ; Get the current context; i.e. file and line.
        Session.stack_get("-d 0", Response)

        ; Retrieve the line number and file URI.
        RegExMatch(Response, "lineno=""\K\d+", LineNo)
        RegExMatch(Response, "filename=""\K.*?(?="")", FileURI)

        FullPath := DBGp_DecodeFileURI(FileURI)
        g_DbgSession.CurrentFile := FullPath

        If (FullPath == "") {
            Return
        }

        n := TabEx.GetSel()
        If (Sci[n].FullName != FullPath) {
            n := IsFileOpened(FullPath)
            If (n) {
                TabEx.SetSel(n)
            } Else {
                n := OpenFileEx(FullPath)
            }
        }

        RemoveStepMarker()
        Sci[n].MarkerAdd(LineNo - 1, g_MarkerDebugStep)
        Sci[n].GoToLine(LineNo - 1)
        GoToLineEx(n, LineNo - 1)

        ; Variables
        Dbg_GetContext()
        If (g_ReloadVarListOnEveryStep && IsWindowVisible(g_hWndVarList)) {
            DisplayVariables()
        }

        ; Call Stack
        Session.stack_get("", g_DbgStack := "")
        g_DbgStack := LoadXMLData(g_DbgStack)
        UpdateCallStack()

        g_DbgStatus := 2
    }
}

DebuggerStream(Session, ByRef Packet) { ; OutputDebug was called.
    ;Global hLVStderr
    Local StdErr, Time
    If (RegExMatch(Packet, "(?<=<stream type=""stderr"">).*(?=</stream>)", StdErr)) {
        StdErr := DBGp_Base64UTF8Decode(StdErr)

        Gui Stderr: Default
        FormatTime Time, %A_Now%, HH:mm:ss
        LV_Add("", LV_GetCount() + 1, Time . "." . A_MSec, StdErr)
        SendMessage 0x115, 7, 0,, ahk_id %hLVStderr% ; WM_VSCROLL, SB_BOTTOM
    }
}

DebuggerDisconnected(Session) {
    ;MsgBox % "Disconnected from " . Session.File

    g_DbgStatus := 0
    g_AttachDebugger := False

    DBGp_StopListening(g_DbgSocket)

    Dbg_UpdateGUI()

    Loop % g_aBreakpoints.Length() {
        g_DbgSession.breakpoint_remove("-d " . g_aBreakpoints[A_Index].ID)
    }
}

M_DebugRun() {
    DebugRun()
}

; Start debugging
DebugRun(AhkPath := "") {
    Local n, AhkScript, Params, WorkingDir

    If (g_DbgStatus == 0) {
        n := TabEx.GetSel()
        If (Sci[n].Type != "AHK") {
            ErrorMsgBox("Debugging is available for AutoHotkey scripts only.", "Main")
            Return
        }

        If (Sci[n].GetModify()) {
            If (!SaveFile(n)) {
                Return
            }
        }

        AhkPath := (AhkPath == "") ? GetAhkPath() : AhkPath
        AhkScript := Sci[n].FullName
        Params := Sci[n].Parameters
        WorkingDir := GetFileDir(AhkScript)

        If (!FileExist(AhkPath) || !FileExist(AhkScript)) {
            Return
        }

        DebuggerInit()
        RemoveStepMarker()

        If (g_CaptureStdErr) {
            AhkRunGetStdErr(n, AhkPath, AhkScript, Params, WorkingDir, "/Debug=127.0.0.1:" . g_DbgPort)

        } Else {
            RunWait "%AhkPath%" /debug=127.0.0.1:%g_DbgPort% "%AhkScript%" %Params%, %WorkingDir%, UseErrorLevel
            If (ErrorLevel) {
                DebugError()
            }
        }

    } Else {
        g_DbgSession.run()
    }
}

DebugError() {
    DebugStop()
    g_DbgStatus := 0
    DBGp_StopListening(g_DbgSocket)
    Dbg_UpdateGUI()
}

DebugBreak() {
    g_DbgSession.break()
}

StepInto() {
    g_DbgSession.step_into()
}

StepOver() {
    g_DbgSession.step_over()
}

StepOut() {
    g_DbgSession.step_out()
}

DebugStop() {
    g_AttachDebugger ? g_DbgSession.detach() : g_DbgSession.stop()

    g_DbgSession.close()
}

Dbg_GetContext() {
    Local XmlLocal, oXmlLocal, oLocalNodes, XmlGlobal, oXmlGlobal, oGlobalNodes

    ; Local variables
    g_DbgSession.context_get("-c 0", XmlLocal)
    oXmlLocal := LoadXMLData(XmlLocal)
    oLocalNodes := oXmlLocal.getElementsByTagName("property")
    Dbg_GetVariables(oLocalNodes, g_DbgLocalVariables)

    ; Global variables
    g_DbgSession.context_get("-c 1", XmlGlobal)
    oXmlGlobal := LoadXMLData(XmlGlobal)
    oGlobalNodes := oXmlGlobal.getElementsByTagName("property")
    Dbg_GetVariables(oGlobalNodes, g_DbgGlobalVariables)
}

Dbg_GetVariables(oXmlNodes, ByRef Variables) {
    Local oNode, Name, Type, Value, ClassName, Facet
    Variables := []

    For oNode in oXmlNodes {
        Name := oNode.getAttribute("fullname")

        StringUpper Type, % oNode.getAttribute("type"), T

        Value := (Type == "Object") ? "" : DBGp_Base64UTF8Decode(oNode.text)

        ClassName := oNode.getAttribute("classname")
        If (ClassName != "" && ClassName != "Object") {
            Type := Type . " (" . ClassName . ")"
        }

        Facet := oNode.getAttribute("facet")

        Variables.Push({"Name": Name, "Value": Value, "Type": Type, "Facet": Facet})
    }
}

ShowVarList() { ; M
    Global
    Local Columns, IL

    Dbg_GetContext()

    If (IsWindow(g_hWndVarList)) {
        DisplayVariables()
        Gui Variables: Show
        Return
    }

    Gui Variables: New, +LabelVarListOn +hWndg_hWndVarList +Resize +AlwaysOnTop
    SetWindowIcon(g_hWndVarList, IconLib, -78)
    Gui Font, s9, Segoe UI
    Gui Color, 0xF1F5FB

    Menu VarEditMenu, Add, &Modify Variable, ModifyVariable
    Menu VarEditMenu, Add
    Menu VarEditMenu, Add, &Copy`tCtrl+C, VarListCopy
    Menu VarEditMenu, Add, Select &All`tCtrl+A, VarListSelectAll
    Menu VarEditMenu, Add
    Menu VarEditMenu, Add, E&xit`tEsc, VarListOnClose

    Menu VarReloadMenu, Add, &Reload List`tCtrl+R, VarListReload
    Menu VarReloadMenu, Add
    Menu VarReloadMenu, Add, Reload on &Every Debug Step, SetVarListReload
    CheckMenuItem("VarReloadMenu", "Reload on &Every Debug Step", g_ReloadVarListOnEveryStep)

    Menu VarShowMenu, Add, Show &Indexed Variables, SetVarListOption
    CheckMenuItem("VarShowMenu", "Show &Indexed Variables", g_ShowIndexedVariables)
    Menu VarShowMenu, Add, Show &Object Members, SetVarListOption
    CheckMenuItem("VarShowMenu", "Show &Object Members", g_ShowObjectMembers)
    Menu VarShowMenu, Add, Show &Reserved Class Members, SetVarListOption
    CheckMenuItem("VarShowMenu", "Show &Reserved Class Members", !g_HideReservedClassMembers)
    Menu VarShowMenu, Add,
    Menu VarShowMenu, Add, &Always on Top, SetVarListAlwaysOnTop
    Menu VarShowMenu, Check, &Always on Top

    Menu VarMenuBar, Add, &Edit, :VarEditMenu
    Menu VarMenuBar, Add, &Reload, :VarReloadMenu
    Menu VarMenuBar, Add, &Show, :VarShowMenu
    Gui Menu, VarMenuBar

    Columns := g_NT6orLater ? "Name|Value|Type" : "Name|Value|Type|Scope"
    Gui Add, ListView, hWndhLvVarList vLvVarList gVarListHandler x0 y0 w621 h370 +LV0x14000, %Columns%
    g_NT6orLater ? LV_ModifyColEx(200, 270, 130) : LV_ModifyColEx(200, 200, 100, 100)

    Gui Add, Edit, hWndhEdtVarSearch vEdtVarSearch gDisplayVariables x10 y380 w186 h23 +0x2000000 ; WS_CLIPCHILDREN
    DllCall("SendMessage", "Ptr", hEdtVarSearch, "UInt", 0x1501, "Ptr", 1, "WStr", "Search") ; Hint text
    Gui Add, Picture, hWndhPicVarSearch x165 y1 w16 h16 Icon-87, %IconLib% ; Search icon
    DllCall("SetParent", "Ptr", hPicVarSearch, "Ptr", hEdtVarSearch)
    WinSet Style, -0x40000000, ahk_id %hPicVarSearch% ; -WS_CHILD

    Gui Add, CheckBox, vChkVarName x208 y380 w64 h23 +Checked, &Name
    Gui Add, CheckBox, vChkVarValue x277 y380 w64 h23 +Checked, &Value
    Gui Add, CheckBox, vChkVarRegEx x346 y380 w130 h23, &Regular Expression

    Gui Show, w621 h414, Variables

    IL := IL_Create(7, 0, 0)
    ; Variable, BIV, object, object member, function object, file object, COM object
    IL_AddEx(IL, IconLib, -79, -80, -81, -82, -85, -83, -84)
    LV_SetImageList(IL, 1)

    If (g_NT6orLater) {
        LV_InsertGroup(hLvVarList, 1, "Local Variables")
        LV_InsertGroup(hLvVarList, 2, "Global Variables")
        LV_EnableGroupView(hLvVarList)
        SetExplorerTheme(hLvVarList)
    }

    DisplayVariables()

    SetFocus(hEdtVarSearch)

    Menu VarContextMenu, Add, Modify Value, ModifyVariable
    Menu VarContextMenu, Add
    Menu VarContextMenu, Add, Copy, VarListCopy
    Menu VarContextMenu, Add, Select All, VarListSelectAll
}

VarListReload() {
    Dbg_GetContext()
    DisplayVariables()
}

VarListOnSize() {
    Global
    AutoXYWH("wh", hLvVarList)
    AutoXYWH("y",  hEdtVarSearch)
    AutoXYWH("y", "ChkVarName")
    AutoXYWH("y", "ChkVarValue")
    AutoXYWH("y", "ChkVarRegEx")
}

VarListOnContextMenu() {
    If (A_GuiControl == "LvVarList" && LV_GetNext()) {
        Menu VarContextMenu, Show
    }
}

VarListOnClose() {
    VarListOnEscape:
    Gui Variables: Hide
    Return
}

DisplayVariables() {
    Local Pos, SearchFunc, Variables, i, Scope, Each, Item, Icon, Row

    Gui Variables: Default
    Gui ListView, %hLvVarList%
    Gui Submit, NoHide

    Pos := DllCall("GetScrollPos", "Ptr", hLvVarList, "Int", 1) ; SB_VERT

    SearchFunc := ChkVarRegEx ? "RegExMatch" : "InStr"

    LV_Delete()
    GuiControl -Redraw, %hLvVarList%

    Variables := [g_DbgLocalVariables, g_DbgGlobalVariables]
    Loop % Variables.Length() {
        i := A_Index
        Scope := i == 1 ? "Local" : "Global"
        For Each, Item in Variables[i] {
            If (g_HideReservedClassMembers && RegExMatch(Item.Name, "\.(base|Name|__Class|__Init)")) {
                Continue
            }

            If (!g_ShowIndexedVariables && InStr(Item.Name, "[")) {
                Continue
            }

            If (!g_ShowObjectMembers && InStr(Item.Name, ".")) {
                Continue
            }

            If ((ChkVarName && %SearchFunc%(Item.Name, EdtVarSearch))
            || (ChkVarValue && %SearchFunc%(Item.Value, EdtVarSearch))) {
                Icon := "Icon" . GetVarIconType(Item.Name, Item.Type, Item.Facet)
                Row := LV_Add(Icon, Item.Name, Item.Value, Item.Type, Scope)
                LV_SetGroup(hLvVarList, Row, i)
            }
        }
    }

    GuiControl +Redraw, %hLvVarList%
    ;DllCall("SetScrollPos", "Ptr", hLvVarList, "Int", 1, "Int", Pos, "Int", 0)
    SendMessage 0x1014, 0, %Pos%,, ahk_id %hLvVarList% ; LVM_SCROLL (XP? WM_VSCROLL?)
}

GetVarIconType(VarName, VarType, VarFacet) {
    If (InStr(VarType, "Com", 1)) { ; ComObject
        Return 7
    } Else If (InStr(VarType, "Fi", 1)) { ; FileObject
        Return 6
    } Else If (InStr(VarType, "Fu", 1)) { ; Func or BoundFunc
        Return 5
    } Else If (SubStr(VarType, 1, 1) == "O") { ; Object
        Return 3
    } Else If (VarName ~= "\.|\[") { ; Object member or indexed variable
        Return 4
    } Else If (VarFacet == "Builtin" || VarName ~= "i)^(Clipboard|ClipboardAll|ErrorLevel|\d+)$") {
        Return 2
    } Else {
        Return 1
    }
}

VarListHandler(hLV, Event, Info, Err := "") {
    If (Event == "DoubleClick") {
        ModifyVariable()
    }
}

ModifyVariable() {
    Local Row, VarName, VarValue, Context, Scope, ExStyle, NewValue, Response

    Gui Variables: Default

    Row := LV_GetNext()
    If (!Row) {
        Return
    }

    LV_GetText(VarName, Row)
    LV_GetText(VarValue, Row, 2)

    If (g_NT6orLater) {
        Context := LV_GetGroupId(hLvVarList, Row) - 1 ; 0 = local, 1 = global
    } Else {
        LV_GetText(Scope, Row, 4)
        Context := (Scope == "Local") ? 0 : 1
    }

    If (VarName = "A_LastError") {
        Gui Variables: +OwnDialogs
        MsgBox 0x40000, A_LastError: %VarValue%, % GetErrorMessage(VarValue+0)
        Return
    }

    If (IsBuiltInVar(VarName)) {
        Gui Variables: +OwnDialogs
        MsgBox 0x40010, Modify Variable, "%VarName%" is a READ-ONLY built-in variable.
        Return
    }

    WinGet ExStyle, ExStyle, ahk_id %g_hWndVarList%

    NewValue := InputBoxEx("Modify Variable", "Enter the new value for the variable """ . VarName . """:"
    , "Variables", VarValue, "", "", g_hWndVarList, "", "", IconLib, -78, ExStyle & 0x8 ? "AlwaysOnTop" : "")
    If (!ErrorLevel) {
        NewValue := DBGp_Base64UTF8Encode(NewValue)

        g_DbgSession.property_set("-c " . Context . " -n " . VarName . " -- " . NewValue, Response)
        If (RegExMatch(Response, "success=""\K\d")) {
            VarListReload()
            LV_Modify(Row, "Select")

        } Else {
            ErrorMsgBox("The value of the variable """ . VarName . """ could not be changed.", "Variables")
        }
    }
}

IsBuiltInVar(VarName) {
    Local Each, Item

    If (VarName = "Clipboard") {
        Return 0
    }

    For Each, Item in g_DbgGlobalVariables {
        If (VarName = Item.Name && Item.Facet == "Builtin") {
            Return 1
        }
    }

    Return VarName = "ClipboardAll" ? 1 : 0
}

VarListCopy() {
    Local FocusedControl, SearchText, Row, Output, Name, Value

    Gui Variables: Default
    GuiControlGet FocusedControl, Focus
    GuiControlGet SearchText,, Edit1

    If (FocusedControl == "Edit1" && SearchText != "") {
        Send ^C
    } Else {
        Row := 0, Output := ""
        While (Row := LV_GetNext(Row)) {
            LV_GetText(Name, Row)
            LV_GetText(Value, Row, 2)
            Output .= Name . "`t" . Value . "`n"
        }

        Clipboard := RTrim(Output, "`n")
    }
}

VarListSelectAll() {
    Local FocusedControl, SearchText

    Gui Variables: Default
    GuiControlGet FocusedControl, Focus
    GuiControlGet SearchText,, Edit1

    If (FocusedControl == "Edit1" && SearchText != "") {
        Send ^A
    } Else {
        GuiControl Focus, %hLvVarList%
        LV_Modify(0, "Select")
    }
}

SetVarListOption(MenuItem) {
    If (InStr(MenuItem, "Indexed")) {
        g_ShowIndexedVariables := !g_ShowIndexedVariables

    } Else If (InStr(MenuItem, "Object")) {
        g_ShowObjectMembers := !g_ShowObjectMembers

    } Else If (InStr(MenuItem, "Reserved")) {
        g_HideReservedClassMembers := !g_HideReservedClassMembers
    }

    DisplayVariables()

    ToggleMenuItem("VarShowMenu", MenuItem)
}

SetVarListAlwaysOnTop(MenuItem) {
    WinSet AlwaysOnTop, Toggle, ahk_id %g_hWndVarList%
    ToggleMenuItem("VarShowMenu", MenuItem)
}

SetVarListReload(MenuItem) {
    g_ReloadVarListOnEveryStep := !g_ReloadVarListOnEveryStep
    ToggleMenuItem("VarReloadMenu", MenuItem)
}

ShowStderr() {
    Global

    Gui Stderr: New, +LabelStderrOn +hWndhWndStderr +Resize +AlwaysOnTop
    SetWindowIcon(hWndStderr, IconLib, -89)

    Gui Font, s10, Courier New
    Gui Add, ListView, hWndhLvStderr x8 y8 w569 h280 +LV0x14000, #|Time|Debug Print
    LV_ModifyColEx(36, 112, 396)
    SetExplorerTheme(hLvStderr)

    Gui Show, w586 h298, Standard Error Viewer
}

StderrOnSize() {
    Global
    Return A_EventInfo == 1 ? 0 : AutoXYWH("wh", hLvStderr)
}

StderrOnClose() {
    StderrOnEscape:
    Gui Stderr: Destroy
    Return
}

ShowCallStack() { ; M
    Global

    Gui CallStack: New, +LabelCallStackOn +hWndhWndCallStack +Resize +AlwaysOnTop
    SetWindowIcon(hWndCallStack, IconLib, -88)

    Gui Font, s9, Segoe UI
    Gui Add, ListView, hWndhLvCallStack x7 y8 w571 h282 +LV0x14000, File|Line|Stack Entry
    LV_ModifyColEx(100, 45, "AutoHdr")
    SetExplorerTheme(hLvCallStack)

    Gui Show, w586 h298, Call Stack

    If (g_DbgStatus) {
        UpdateCallStack()
    }
}

CallStackOnSize() {
    Global
    Return A_EventInfo == 1 ? 0 : AutoXYWH("wh", hLvCallStack)
}

CallStackOnClose() {
    CallStackOnEscape:
    Gui CallStack: Destroy
    Return
}

UpdateCallStack() {
    Local oFilename, oLineNo, oWhere, i, Filename, ShortName

    oFilename := g_DbgStack.selectNodes("/response/stack/@filename")
    oLineNo   := g_DbgStack.selectNodes("/response/stack/@lineno")
    oWhere    := g_DbgStack.selectNodes("/response/stack/@where")

    Gui CallStack: Default
    LV_Delete()

    Loop % oWhere.Length() {
        i := A_Index - 1

        Filename := DBGp_DecodeFileURI(oFilename.item[i].text)
        SplitPath Filename, ShortName

        LV_Add("", ShortName, oLineNo.item[i].text, oWhere.item[i].text)
    }
    LV_ModifyCol(3, "AutoHdr")
}

ToggleBreakpoint() {
    Local n := TabEx.GetSel()
    Local Line := Sci[n].LineFromPosition(Sci[n].GetCurrentPos())

    If (Sci[n].MarkerGet(Line) & (1 << g_MarkerBreakpoint)) {
        Sci[n].MarkerDelete(Line, g_MarkerBreakpoint)
        RemoveBreakpoint(Sci[n].FullName, Line + 1)

    } Else {
        Sci[n].MarkerAdd(Line, g_MarkerBreakpoint)
        AddBreakpoint(Sci[n].FullName, Line + 1)
    }
}

DeleteBreakpoints() {
    Loop % Sci.Length() {
        Sci[A_Index].MarkerDeleteAll(g_MarkerBreakpoint)
    }

    Loop % g_aBreakpoints.Length() {
        g_DbgSession.breakpoint_remove("-d " . g_aBreakpoints[A_Index].ID)
    }
}

AddBreakpoint(File, Line) {
    Local URI, Response, ID

    If (g_DbgStatus) {
        URI := DBGp_EncodeFileURI(File)
        g_DbgSession.breakpoint_set("-t line -n " . Line . " -f " . URI, Response)

        If (RegExMatch(Response, " id=""\K\d+", ID)) {
            g_aBreakpoints.Push({"File": File, "Line": Line, "ID": ID})
        }
    }
}

RemoveBreakpoint(File, Line) {
    If (g_DbgStatus) {
        Loop % g_aBreakpoints.Length() {
            If (g_aBreakpoints[A_Index].File == File && g_aBreakpoints[A_Index].Line == Line) {
                g_DbgSession.breakpoint_remove("-d " . g_aBreakpoints[A_Index].ID)
                Break
            }
        }
    }
}

; Define breakpoint markers as real breakpoints (called from DebuggerConnected)
DefineBreakpoints() {
    Local Line := 0, i

    Loop % Sci.Length() {
        i := A_Index

        If (Sci[i].FullName == "") {
            Continue
        }

        Loop {
            Line := Sci[i].MarkerNext(Line, (1 << g_MarkerBreakpoint)) + 1
            If (Line) {
                AddBreakpoint(Sci[i].FullName, Line)
            }
        } Until (!Line)
    }
}

RemoveStepMarker() {
    Loop % Sci.Length() {
        Sci[A_Index].MarkerDeleteAll(g_MarkerDebugStep)
    }
}

ShowDebugButtons(Show := True) {
    Loop 5 {
        SendMessage 0x404, % A_Index + 2500, !Show,, ahk_id %g_hToolbar% ; TB_HIDEBUTTON
    }

    Try {
        If (Show) {
            Menu MenuDebug, Rename, Start Debugging`tF5, Continue`tF5
        } Else {
            Menu MenuDebug, Rename, Continue`tF5, Start Debugging`tF5
        }
    }
}

SetDebugPort() {
    Local Port := InputBoxEx("Debug Port", "Specify the port to be used by the debugger (default: 9001):"
        , "Debug Settings", g_DbgPort, "", "Number", g_hWndMain, "", "", IconLib, -65)

    If (!ErrorLevel) {
        g_DbgPort := Port
    }
}

ShowAttachDialog() {
    Global hWndAttachDbg, hLvAttachDbg

    Gui Attach: New, +LabelAttach +hWndhWndAttachDbg
    SetWindowIcon(hWndAttachDbg, IconLib, -70)
    Gui Color, White

    Gui Add, Pic, x-2 y-2 w622 h51, % "HBITMAP:" . CreateGradient(642, 51)
    Gui Font, s12 cWhite, Segoe UI
    Gui Add, Text, x12 y12 w259 h23 +0x200 +BackgroundTrans, Running Scripts
    Gui Font
    Gui Font, s9, Segoe UI
    Gui Add, Text, x12 y52 w604 h23 +0x200
    , Attach the debugger to a running script. The script will not be terminated when the debug session ends.

    Gui Add, ListView, hWndhLvAttachDbg x0 y80 w620 h265 -Multi +LV0x14000, Filename|Path|PID
    LV_ModifyColEx(174, 387, "AutoHdr Integer Left")
    SetExplorerTheme(hLvAttachDbg)

    Gui Add, Text, x0 y346 w620 h48 -Background
    hTbBtn := CreateButton("DbgAttachBtnHandler", IconLib, -10, "x8 y357 w24 h24", "Reload list")
    SendMessage 0x454, 0, 137,, ahk_id %hTbBtn% ; TB_SETEXTENDEDSTYLE
    Gui Add, Button, x433 y357 w84 h24 gAttachDebugger +Default, &Attach
    Gui Add, Button, x525 y357 w84 h24 gAttachClose, &Cancel

    ListRunningScripts()

    Gui Show, w620 h393, Attach Debugger
}

DbgAttachBtnHandler(hWnd, Event, Text) {
    If (Event == "Click" && Text == "Reload list") {
        ListRunningScripts()
    }
}

ListRunningScripts() {
    Global
    Local Scripts, hWnd, Title, Filename, FilePath, FileExt, PID

    Gui ListView, %hLvAttachDbg%
    LV_Delete()

    ; Get the list of running scripts (adapted from DebugVars)
    WinGet Scripts, List, ahk_class AutoHotkey
    Loop % Scripts {
        hWnd := Scripts%A_Index%
        If (hWnd == A_ScriptHwnd) {
            Continue
        }

        PostMessage 0x44, 0, 0,, ahk_id %hWnd% ; WM_COMMNOTIFY, WM_NULL
        If (ErrorLevel) { ; Likely blocked by UIPI (won't be able to attach).
            Continue
        }

        WinGetTitle Title, ahk_id %hWnd%
        Title := RegExReplace(Title, " - AutoHotkey v\S*$")
        SplitPath Title, Filename, FilePath, FileExt
        If (IsAhkFileExt(FileExt)) {
            WinGet PID, PID, ahk_id %hWnd%
            LV_Add("", Filename, FilePath, PID)
        }
    }
}

AttachClose() {
    AttachEscape:
    Gui Attach: Destroy
    Return
}

AttachDebugger() {
    Global
    Local Row, Filename, Path, PID, AttachMsg, IP, Filename, n

    Gui ListView, %hLvAttachDbg%
    Row := LV_GetNext()
    If (Row) {
        LV_GetText(Filename, Row, 1)
        LV_GetText(Path, Row, 2)
        LV_GetText(PID, Row, 3)
        AttachClose()

        If (g_DbgStatus) {
            DebugStop()
        }

        DebuggerInit()

        AttachMsg := DllCall("RegisterWindowMessage", "Str", "AHK_ATTACH_DEBUGGER")
        IP := DllCall("ws2_32\inet_addr", "AStr", "127.0.0.1")
        PostMessage %AttachMsg%, %IP%, %g_DbgPort%,, ahk_pid %PID% ahk_class AutoHotkey

        Filename := Path . "\" . Filename
        n := IsFileOpened(Filename)
        If (!n) {
            OpenFileEx(Filename)
        }

        g_AttachDebugger := True
    }
}

Dbg_UpdateGUI() {
    ShowDebugButtons(g_DbgStatus)

    If (g_DbgStatus) {
        Gui Main: Default
        SB_SetText("Debugging", g_SBP_FileType)
        SB_SetIcon(IconLib, -65, g_SBP_FileType)
    } Else {
        RemoveStepMarker()
        SB_UpdateFileDesc(TabEx.GetSel())
        SendMessage 0x40F, % g_SBP_FileType - 1, 0,, ahk_id %g_hStatusBar% ; SB_SETICON
    }
}
