;AHK2 Script

#SingleInstance Force
#UseHook True
SendMode "Input"

Pause::ExitApp


attachmentMode := "Off" ; from ["Off", "Pressure", "Toggle"]

multiClick := 0
MultiClickHandler(setTo := 0) {
    global multiClick

    multiClick := setTo
    if (multiClick != 0) {
        SetTimer MultiClickHandler, 200
    }
}

Hotkey "*XButton2", Pressed

Pressed(ThisHotkey) {
    global attachmentMode
    global multiClick

    Switch attachmentMode {
        Case "Off":
            Switch multiClick {
                Case 0:
                    attachmentMode := "Pressed"
                    MultiClickHandler(1)
                    send "{blind}{XButton2}"
                Case 1:
                    attachmentMode := "Toggle"
                    MultiClickHandler(2)
                    send "{blind}{XButton2}"
            }
        ;Case "Pressed":
        Case "Toggle":
            if (multiClick = 2) {
                send "{blind}{XButton2}"
            } else {
                attachmentMode := "Off"
                send "{blind}{XButton2}"
            }
    }
}

Hotkey "*XButton2 UP", Released

Released(ThisHotkey) {
    global attachmentMode
    global multiClick

    Switch attachmentMode {
        ;Case "Off":
        Case "Pressed":
            attachmentMode := "Off"
            send "{blind}{XButton2}"
        ;Case "Toggle":
    }
}