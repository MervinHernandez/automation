; SELECT Area of Life
; - from a list of GTD areas in nested dropdown lists

; Define the GUI for the color selection window
Gui, Add, Radio, vChoice1, Blue
Gui, Add, Radio, vChoice2, Green
Gui, Add, Radio, vChoice3, Red
Gui, Add, Button, Default gNextButton, Next
Gui, Show, w300 h150, Color Selection

return

NextButton:
Gui, Submit, NoHide
Gui, Destroy

; Determine the selected choice
if (Choice1)
    SelectedColor := "Blue"
else if (Choice2)
    SelectedColor := "Green"
else if (Choice3)
    SelectedColor := "Red"

; Create a new GUI window with the selected color title
Gui, Add, Text, vColorTitle, You selected %SelectedColor%
Gui, Show, w300 h150, %SelectedColor% Window

return
