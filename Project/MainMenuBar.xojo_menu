#tag Menu
Begin Menu MainMenuBar
   Begin MenuItem FileMenu
      SpecialMenu = 0
      Text = "&File"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem FileNew
         SpecialMenu = 0
         Text = "New Document"
         Index = -2147483648
         ShortcutKey = "N"
         Shortcut = "Cmd+N"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileNewPreset
         SpecialMenu = 0
         Text = "New Preset"
         Index = -2147483648
         ShortcutKey = "N"
         Shortcut = "Cmd+Shift+N"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileOpen
         SpecialMenu = 0
         Text = "Open…"
         Index = -2147483648
         ShortcutKey = "O"
         Shortcut = "Cmd+O"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileOpenRecent
         SpecialMenu = 0
         Text = "Open Recent"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
      End
      Begin MenuItem FileClose
         SpecialMenu = 0
         Text = "Close"
         Index = -2147483648
         ShortcutKey = "W"
         Shortcut = "Cmd+W"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileImport
         SpecialMenu = 0
         Text = "Import…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileSave
         SpecialMenu = 0
         Text = "Save"
         Index = -2147483648
         ShortcutKey = "S"
         Shortcut = "Cmd+S"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileSaveAs
         SpecialMenu = 0
         Text = "Save As…"
         Index = -2147483648
         ShortcutKey = "S"
         Shortcut = "Cmd+Shift+S"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator4
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileExport
         SpecialMenu = 0
         Text = "Export…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileDeploy
         SpecialMenu = 0
         Text = "Deploy…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator0
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin QuitMenuItem FileQuit
         SpecialMenu = 0
         Text = "#App.kFileQuit"
         Index = -2147483648
         ShortcutKey = "#App.kFileQuitShortcut"
         Shortcut = "#App.kFileQuitShortcut"
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem EditMenu
      SpecialMenu = 0
      Text = "&Edit"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem EditUndo
         SpecialMenu = 0
         Text = "&Undo"
         Index = -2147483648
         ShortcutKey = "Z"
         Shortcut = "Cmd+Z"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditSeparator1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCut
         SpecialMenu = 0
         Text = "Cu&t"
         Index = -2147483648
         ShortcutKey = "X"
         Shortcut = "Cmd+X"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditCopy
         SpecialMenu = 0
         Text = "&Copy"
         Index = -2147483648
         ShortcutKey = "C"
         Shortcut = "Cmd+C"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditPaste
         SpecialMenu = 0
         Text = "&Paste"
         Index = -2147483648
         ShortcutKey = "V"
         Shortcut = "Cmd+V"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditClear
         SpecialMenu = 0
         Text = "#App.kEditClear"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem EditSeparator2
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditSelectAll
         SpecialMenu = 0
         Text = "Select &All"
         Index = -2147483648
         ShortcutKey = "A"
         Shortcut = "Cmd+A"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem ViewMenu
      SpecialMenu = 0
      Text = "View"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem ViewDashboard
         SpecialMenu = 0
         Text = "Home"
         Index = -2147483648
         ShortcutKey = "H"
         Shortcut = "Cmd+Shift+H"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator9
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewDocuments
         SpecialMenu = 0
         Text = "Documents"
         Index = -2147483648
         ShortcutKey = "1"
         Shortcut = "Cmd+1"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewPresets
         SpecialMenu = 0
         Text = "Presets"
         Index = -2147483648
         ShortcutKey = "2"
         Shortcut = "Cmd+2"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewEngrams
         SpecialMenu = 0
         Text = "Engrams"
         Index = -2147483648
         ShortcutKey = "3"
         Shortcut = "Cmd+3"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewTools
         SpecialMenu = 0
         Text = "Tools"
         Index = -2147483648
         ShortcutKey = "4"
         Shortcut = "Cmd+4"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ViewSearch
         SpecialMenu = 0
         Text = "Search"
         Index = -2147483648
         ShortcutKey = "5"
         Shortcut = "Cmd+5"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem DocumentMenu
      SpecialMenu = 0
      Text = "Document"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem DocumentRestoreConfigToDefault
         SpecialMenu = 0
         Text = "Restore Config to Default"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator2
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem DocumentAddBeacon
         SpecialMenu = 0
         Text = "Add Loot Source…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem DocumentDuplicateBeacon
         SpecialMenu = 0
         Text = "Duplicate Loot Source"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem DocumentRemoveBeacon
         SpecialMenu = 0
         Text = "Remove Loot Source"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem DocumentAddItemSet
         SpecialMenu = 0
         Text = "Add Item Set"
         Index = -2147483648
         AutoEnable = False
         SubMenu = True
         Visible = True
         Begin MenuItem AddItemSetEmpty
            SpecialMenu = 0
            Text = "New Empty Set"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem DocumentRemoveItemSet
         SpecialMenu = 0
         Text = "Remove Item Set"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator7
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem DocumentRebuildPresets
         SpecialMenu = 0
         Text = "Rebuild Item Sets from Presets"
         Index = -2147483648
         PCAltKey = True
         AutoEnable = False
         Visible = True
      End
   End
   Begin MenuItem WindowMenu
      SpecialMenu = 0
      Text = "Window"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem WindowMinimize
         SpecialMenu = 0
         Text = "Minimize"
         Index = -2147483648
         ShortcutKey = "M"
         Shortcut = "Cmd+M"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem WindowZoom
         SpecialMenu = 0
         Text = "Zoom"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator3
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem HelpMenu
      SpecialMenu = 0
      Text = "Help"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin ApplicationMenuItem HelpAboutBeacon
         SpecialMenu = 0
         Text = "About Beacon"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem UntitledSeparator5
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem HelpCheckforUpdates
         SpecialMenu = 0
         Text = "Check for Updates…"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin ApplicationMenuItem HelpReleaseNotes
         SpecialMenu = 0
         Text = "Release Notes…"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator6
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpAdminSpawnCodes
         SpecialMenu = 0
         Text = "Admin Spawn Codes"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpReportAProblem
         SpecialMenu = 0
         Text = "Report a Problem…"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpMakeADonation
         SpecialMenu = 0
         Text = "Make a Donation…"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpOpenDataFolder
         SpecialMenu = 0
         Text = "Open Data Folder"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
End
#tag EndMenu
