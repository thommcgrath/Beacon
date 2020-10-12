#tag Menu
Begin Menu MainMenuBar
   Begin MenuItem FileMenu
      SpecialMenu = 0
      Value = "&File"
      Index = -2147483648
      Text = "&File"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin MenuItem FileNew
         SpecialMenu = 0
         Value = "New Document"
         Index = -2147483648
         Text = "New Document"
         ShortcutKey = "N"
         Shortcut = "Cmd+N"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileNewPreset
         SpecialMenu = 0
         Value = "New Preset"
         Index = -2147483648
         Text = "New Preset"
         ShortcutKey = "N"
         Shortcut = "Cmd+Shift+N"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileOpen
         SpecialMenu = 0
         Value = "Open…"
         Index = -2147483648
         Text = "Open…"
         ShortcutKey = "O"
         Shortcut = "Cmd+O"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileOpenRecent
         SpecialMenu = 0
         Value = "Open Recent"
         Index = -2147483648
         Text = "Open Recent"
         AutoEnabled = True
         AutoEnable = True
         SubMenu = True
         Visible = True
      End
      Begin MenuItem FileClose
         SpecialMenu = 0
         Value = "Close"
         Index = -2147483648
         Text = "Close"
         ShortcutKey = "W"
         Shortcut = "Cmd+W"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileImport
         SpecialMenu = 0
         Value = "Import…"
         Index = -2147483648
         Text = "Import…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileSave
         SpecialMenu = 0
         Value = "Save"
         Index = -2147483648
         Text = "Save"
         ShortcutKey = "S"
         Shortcut = "Cmd+S"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileSaveAs
         SpecialMenu = 0
         Value = "Save As…"
         Index = -2147483648
         Text = "Save As…"
         ShortcutKey = "S"
         Shortcut = "Cmd+Shift+S"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator4
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileExport
         SpecialMenu = 0
         Value = "Export…"
         Index = -2147483648
         Text = "Export…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileDeploy
         SpecialMenu = 0
         Value = "Deploy…"
         Index = -2147483648
         Text = "Deploy…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator0
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin QuitMenuItem FileQuit
         SpecialMenu = 0
         Value = "#App.kFileQuit"
         Index = -2147483648
         Text = "#App.kFileQuit"
         ShortcutKey = "#App.kFileQuitShortcut"
         Shortcut = "#App.kFileQuitShortcut"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem EditMenu
      SpecialMenu = 0
      Value = "&Edit"
      Index = -2147483648
      Text = "&Edit"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin MenuItem EditUndo
         SpecialMenu = 0
         Value = "&Undo"
         Index = -2147483648
         Text = "&Undo"
         ShortcutKey = "Z"
         Shortcut = "Cmd+Z"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditSeparator1
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCut
         SpecialMenu = 0
         Value = "Cu&t"
         Index = -2147483648
         Text = "Cu&t"
         ShortcutKey = "X"
         Shortcut = "Cmd+X"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditCopy
         SpecialMenu = 0
         Value = "&Copy"
         Index = -2147483648
         Text = "&Copy"
         ShortcutKey = "C"
         Shortcut = "Cmd+C"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditPaste
         SpecialMenu = 0
         Value = "&Paste"
         Index = -2147483648
         Text = "&Paste"
         ShortcutKey = "V"
         Shortcut = "Cmd+V"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditClear
         SpecialMenu = 0
         Value = "#App.kEditClear"
         Index = -2147483648
         Text = "#App.kEditClear"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditSeparator2
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditSelectAll
         SpecialMenu = 0
         Value = "Select &All"
         Index = -2147483648
         Text = "Select &All"
         ShortcutKey = "A"
         Shortcut = "Cmd+A"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem ViewMenu
      SpecialMenu = 0
      Value = "View"
      Index = -2147483648
      Text = "View"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin MenuItem ViewDashboard
         SpecialMenu = 0
         Value = "Home"
         Index = -2147483648
         Text = "Home"
         ShortcutKey = "H"
         Shortcut = "Cmd+Shift+H"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator9
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewDocuments
         SpecialMenu = 0
         Value = "Documents"
         Index = -2147483648
         Text = "Documents"
         ShortcutKey = "1"
         Shortcut = "Cmd+1"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewPresets
         SpecialMenu = 0
         Value = "Presets"
         Index = -2147483648
         Text = "Presets"
         ShortcutKey = "2"
         Shortcut = "Cmd+2"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewEngrams
         SpecialMenu = 0
         Value = "Engrams"
         Index = -2147483648
         Text = "Engrams"
         ShortcutKey = "3"
         Shortcut = "Cmd+3"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewTools
         SpecialMenu = 0
         Value = "Tools"
         Index = -2147483648
         Text = "Tools"
         ShortcutKey = "4"
         Shortcut = "Cmd+4"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewSearch
         SpecialMenu = 0
         Value = "Search"
         Index = -2147483648
         Text = "Search"
         ShortcutKey = "5"
         Shortcut = "Cmd+5"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem EditorMenu
      SpecialMenu = 0
      Value = "Editor"
      Index = -2147483648
      Text = "Editor"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
   End
   Begin MenuItem WindowMenu
      SpecialMenu = 0
      Value = "Window"
      Index = -2147483648
      Text = "Window"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin MenuItem WindowMinimize
         SpecialMenu = 0
         Value = "Minimize"
         Index = -2147483648
         Text = "Minimize"
         ShortcutKey = "M"
         Shortcut = "Cmd+M"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem WindowZoom
         SpecialMenu = 0
         Value = "Zoom"
         Index = -2147483648
         Text = "Zoom"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator3
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem HelpMenu
      SpecialMenu = 0
      Value = "Help"
      Index = -2147483648
      Text = "Help"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin ApplicationMenuItem HelpAboutBeacon
         SpecialMenu = 0
         Value = "About Beacon"
         Index = -2147483648
         Text = "About Beacon"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem UntitledSeparator5
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem HelpCheckforUpdates
         SpecialMenu = 0
         Value = "Check for Beacon Updates…"
         Index = -2147483648
         Text = "Check for Beacon Updates…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem HelpReleaseNotes
         SpecialMenu = 0
         Value = "Release Notes…"
         Index = -2147483648
         Text = "Release Notes…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpSeparator2
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpUpdateEngrams
         SpecialMenu = 0
         Value = "Update Engrams"
         Index = -2147483648
         Text = "Update Engrams"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem HelpSyncCloudFiles
         SpecialMenu = 0
         Value = "Sync Cloud Files"
         Index = -2147483648
         Text = "Sync Cloud Files"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator6
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpAdminSpawnCodes
         SpecialMenu = 0
         Value = "Admin Spawn Codes"
         Index = -2147483648
         Text = "Admin Spawn Codes"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpArkConfigFileReference
         SpecialMenu = 0
         Value = "Ark Config File Reference"
         Index = -2147483648
         Text = "Ark Config File Reference"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator1
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpCreateSupportTicket
         SpecialMenu = 0
         Value = "Create Support Ticket…"
         Index = -2147483648
         Text = "Create Support Ticket…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpOpenDataFolder
         SpecialMenu = 0
         Value = "Open Data Folder"
         Index = -2147483648
         Text = "Open Data Folder"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpReportAProblem
         SpecialMenu = 0
         Value = "Report a Problem…"
         Index = -2147483648
         Text = "Report a Problem…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpCreateOfflineAuthorizationRequest
         SpecialMenu = 0
         Value = "Create Offline Authorization Request…"
         Index = -2147483648
         Text = "Create Offline Authorization Request…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator2
         SpecialMenu = 0
         Value = "-"
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpAPIGuide
         SpecialMenu = 0
         Value = "API Guide…"
         Index = -2147483648
         Text = "API Guide…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpAPIBuilder
         SpecialMenu = 0
         Value = "API Builder…"
         Index = -2147483648
         Text = "API Builder…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
End
#tag EndMenu
