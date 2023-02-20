#tag Menu
Begin Menu MainMenuBar
   Begin DesktopMenuItem FileMenu
      SpecialMenu = 0
      Index = -2147483648
      Text = "&File"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin DesktopMenuItem FileNew
         SpecialMenu = 0
         Index = -2147483648
         Text = "New Project"
         ShortcutKey = "N"
         Shortcut = "Cmd+N"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem FileNewPreset
         SpecialMenu = 0
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
      Begin DesktopMenuItem FileOpen
         SpecialMenu = 0
         Index = -2147483648
         Text = "Open…"
         ShortcutKey = "O"
         Shortcut = "Cmd+O"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem FileOpenRecent
         SpecialMenu = 0
         Index = -2147483648
         Text = "Open Recent"
         AutoEnabled = True
         AutoEnable = True
         SubMenu = True
         Visible = True
      End
      Begin DesktopMenuItem FileClose
         SpecialMenu = 0
         Index = -2147483648
         Text = "Close"
         ShortcutKey = "W"
         Shortcut = "Cmd+W"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem FileImport
         SpecialMenu = 0
         Index = -2147483648
         Text = "Import…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem FileSave
         SpecialMenu = 0
         Index = -2147483648
         Text = "Save"
         ShortcutKey = "S"
         Shortcut = "Cmd+S"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem FileSaveAs
         SpecialMenu = 0
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
      Begin DesktopMenuItem UntitledSeparator4
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem FileExport
         SpecialMenu = 0
         Index = -2147483648
         Text = "Export…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem FileDeploy
         SpecialMenu = 0
         Index = -2147483648
         Text = "Deploy…"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator0
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopQuitMenuItem FileQuit
         SpecialMenu = 0
         Index = -2147483648
         Text = "#App.kFileQuit"
         ShortcutKey = "#App.kFileQuitShortcut"
         Shortcut = "#App.kFileQuitShortcut"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin DesktopMenuItem EditMenu
      SpecialMenu = 0
      Index = -2147483648
      Text = "&Edit"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin DesktopMenuItem EditUndo
         SpecialMenu = 0
         Index = -2147483648
         Text = "&Undo"
         ShortcutKey = "Z"
         Shortcut = "Cmd+Z"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem EditSeparator1
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem EditCut
         SpecialMenu = 0
         Index = -2147483648
         Text = "Cu&t"
         ShortcutKey = "X"
         Shortcut = "Cmd+X"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem EditCopy
         SpecialMenu = 0
         Index = -2147483648
         Text = "&Copy"
         ShortcutKey = "C"
         Shortcut = "Cmd+C"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem EditPaste
         SpecialMenu = 0
         Index = -2147483648
         Text = "&Paste"
         ShortcutKey = "V"
         Shortcut = "Cmd+V"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem EditClear
         SpecialMenu = 0
         Index = -2147483648
         Text = "#App.kEditClear"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem EditSeparator2
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem EditSelectAll
         SpecialMenu = 0
         Index = -2147483648
         Text = "Select &All"
         ShortcutKey = "A"
         Shortcut = "Cmd+A"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem EditPrefsSeparator
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem EditPreferences
         SpecialMenu = 0
         Index = -2147483648
         Text = "#App.kEditPreferences"
         ShortcutKey = ","
         Shortcut = "Cmd+,"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin DesktopMenuItem ViewMenu
      SpecialMenu = 0
      Index = -2147483648
      Text = "View"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin DesktopMenuItem ViewDashboard
         SpecialMenu = 0
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
      Begin DesktopMenuItem UntitledSeparator9
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem ViewDocuments
         SpecialMenu = 0
         Index = -2147483648
         Text = "Projects"
         ShortcutKey = "1"
         Shortcut = "Cmd+1"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem ViewEngrams
         SpecialMenu = 0
         Index = -2147483648
         Text = "Blueprints"
         ShortcutKey = "2"
         Shortcut = "Cmd+2"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem ViewTemplates
         SpecialMenu = 0
         Index = -2147483648
         Text = "Templates"
         ShortcutKey = "3"
         Shortcut = "Cmd+3"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem ViewHelp
         SpecialMenu = 0
         Index = -2147483648
         Text = "Help"
         ShortcutKey = "4"
         Shortcut = "Cmd+4"
         MenuModifier = True
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator7
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem ViewSwitchToBaseConfigSet
         SpecialMenu = 0
         Index = -2147483648
         Text = "Switch to Base Config Set"
         ShortcutKey = "B"
         Shortcut = "Cmd+B"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
   End
   Begin DesktopMenuItem WindowMenu
      SpecialMenu = 0
      Index = -2147483648
      Text = "Window"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin DesktopMenuItem WindowMinimize
         SpecialMenu = 0
         Index = -2147483648
         Text = "Minimize"
         ShortcutKey = "M"
         Shortcut = "Cmd+M"
         MenuModifier = True
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem WindowZoom
         SpecialMenu = 0
         Index = -2147483648
         Text = "Zoom"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator3
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin DesktopMenuItem HelpMenu
      SpecialMenu = 0
      Index = -2147483648
      Text = "Help"
      AutoEnabled = True
      AutoEnable = True
      Visible = True
      Begin DesktopApplicationMenuItem HelpAboutBeacon
         SpecialMenu = 0
         Index = -2147483648
         Text = "About Beacon"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopApplicationMenuItem UntitledSeparator5
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopApplicationMenuItem HelpShowWhatsNewWindow
         SpecialMenu = 0
         Index = -2147483648
         Text = "What's New in Beacon…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopApplicationMenuItem HelpCheckforUpdates
         SpecialMenu = 0
         Index = -2147483648
         Text = "Check for Beacon Updates…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopApplicationMenuItem HelpReleaseNotes
         SpecialMenu = 0
         Index = -2147483648
         Text = "Release Notes…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopApplicationMenuItem HelpSeparator2
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpUpdateEngrams
         SpecialMenu = 0
         Index = -2147483648
         Text = "Update Blueprints"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem HelpRefreshBlueprints
         SpecialMenu = 0
         Index = -2147483648
         Text = "Refresh Blueprints"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem HelpSyncCloudFiles
         SpecialMenu = 0
         Index = -2147483648
         Text = "Sync Cloud Files"
         AutoEnabled = False
         AutoEnable = False
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator6
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpAdminSpawnCodes
         SpecialMenu = 0
         Index = -2147483648
         Text = "Admin Spawn Codes"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpArkConfigFileReference
         SpecialMenu = 0
         Index = -2147483648
         Text = "Ark Config File Reference"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator1
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpCreateSupportTicket
         SpecialMenu = 0
         Index = -2147483648
         Text = "Create Support Ticket…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpOpenDataFolder
         SpecialMenu = 0
         Index = -2147483648
         Text = "Open Data Folder"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpCreateOfflineAuthorizationRequest
         SpecialMenu = 0
         Index = -2147483648
         Text = "Create Offline Authorization Request…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem UntitledSeparator2
         SpecialMenu = 0
         Index = -2147483648
         Text = "-"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpAPIGuide
         SpecialMenu = 0
         Index = -2147483648
         Text = "API Guide…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
      Begin DesktopMenuItem HelpAPIBuilder
         SpecialMenu = 0
         Index = -2147483648
         Text = "API Builder…"
         AutoEnabled = True
         AutoEnable = True
         Visible = True
      End
   End
End
#tag EndMenu
