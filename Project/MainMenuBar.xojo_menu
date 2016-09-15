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
      Begin MenuItem UntitledSeparator9
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileImportConfig
         SpecialMenu = 0
         Text = "Import Config…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileExportConfig
         SpecialMenu = 0
         Text = "Export Config…"
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
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCopy
         SpecialMenu = 0
         Text = "&Copy"
         Index = -2147483648
         ShortcutKey = "C"
         Shortcut = "Cmd+C"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditPaste
         SpecialMenu = 0
         Text = "&Paste"
         Index = -2147483648
         ShortcutKey = "V"
         Shortcut = "Cmd+V"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditClear
         SpecialMenu = 0
         Text = "#App.kEditClear"
         Index = -2147483648
         AutoEnable = True
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
   Begin MenuItem DocumentMenu
      SpecialMenu = 0
      Text = "Document"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem DocumentAddBeacon
         SpecialMenu = 0
         Text = "Add Beacon…"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem DocumentDuplicateBeacon
         SpecialMenu = 0
         Text = "Duplicate Beacon"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem DocumentRemoveBeacon
         SpecialMenu = 0
         Text = "Remove Beacon"
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
         Begin MenuItem UntitledSeparator2
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem AddItemSetThatchHousing
            SpecialMenu = 0
            Text = "Thatch Housing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetWoodHousing
            SpecialMenu = 0
            Text = "Wood Housing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetAdobeHousing
            SpecialMenu = 0
            Text = "Adobe Housing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetStoneHousing
            SpecialMenu = 0
            Text = "Stone Housing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetMetalHousing
            SpecialMenu = 0
            Text = "Metal Housing"
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
         Begin MenuItem AddItemSetStoneTools
            SpecialMenu = 0
            Text = "Primitive Tools"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetMetalTools
            SpecialMenu = 0
            Text = "Advanced Tools"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem UntitledSeparator8
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem AddItemSetBasicFurniture
            SpecialMenu = 0
            Text = "Basic Furniture"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetAdvancedFurniture
            SpecialMenu = 0
            Text = "Advanced Furniture"
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
         Begin MenuItem AddItemSetSimpleFirearms
            SpecialMenu = 0
            Text = "Simple Firearms"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetAdvancedFirearms
            SpecialMenu = 0
            Text = "Advanced Firearms"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem UntitledSeparator6
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem AddItemSetSmallSaddles
            SpecialMenu = 0
            Text = "Small Saddles"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetMediumSaddles
            SpecialMenu = 0
            Text = "Medium Saddles"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetLargeSaddles
            SpecialMenu = 0
            Text = "Large Saddles"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetPlatformSaddles
            SpecialMenu = 0
            Text = "Platform Saddles"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem UntitledSeparator5
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem AddItemSetSupplies
            SpecialMenu = 0
            Text = "Raw Materials"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetGardening
            SpecialMenu = 0
            Text = "Gardening"
            Index = -2147483648
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
         Begin MenuItem AddItemSetClothClothing
            SpecialMenu = 0
            Text = "Cloth Clothing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetDesertClothClothing
            SpecialMenu = 0
            Text = "Desert Cloth Clothing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetHideClothing
            SpecialMenu = 0
            Text = "Hide Clothing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetChitinArmor
            SpecialMenu = 0
            Text = "Chitin Armor"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetGhillieSuit
            SpecialMenu = 0
            Text = "Ghillie Suit"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetFurArmor
            SpecialMenu = 0
            Text = "Fur Clothing"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetFlakArmor
            SpecialMenu = 0
            Text = "Flak Armor"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AddItemSetRiotArmor
            SpecialMenu = 0
            Text = "Riot Armor"
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
   End
End
#tag EndMenu
