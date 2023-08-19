---
title: Frequently Asked Questions
parent: Troubleshooting
nav_order: 1
---
# {{page.title}}
{: .no_toc }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Loot drops do not contain the intended items

Here are some things to check when your loot drops aren't quite what you were expecting.

### Not all loot drops have been customized

When you set your project's maps in Beacon, the **New Drop**{:.ui-keyword} button will show you exactly which drops are needed for your map or maps. Maps such as Ragnarok, Valguero, Crystal Isles, and Lost Island need drops from many other maps. For example, Ragnarok will use the Scorched versions of drops in the desert area. Since the drops appear identical, it won't be obvious which version a player is opening.

### Minimum and maximums have not been set

Take a look at the [Loot Drops guide](/configs/lootdrops/) for a refresher on all the options. Specifically pay attention to the **Minimum Item Sets**{:.ui-keyword}, **Maximum Item Sets**{:.ui-keyword}, **Minimum Entries**{:.ui-keyword}, and **Maximum Entries**{:.ui-keyword} settings. For example, if you want your drop to always contain all item sets, make sure **Minimum Item Sets**{:.ui-keyword} is at least equal to the number of item sets in the drop. Use the **Simulator**{:.ui-keyword} at the bottom of the **Item Sets**{:.ui-keyword} column to preview your settings.

If the **Add Item Sets to Default**{:.ui-keyword} option is enabled, Beacon's default item set weights are much higher than the weights in Ark's default loot. This option also gives up a lot of control. Instead of turning this on, you should consider turning on the **Load Default Contents When Available**{:.ui-keyword} option in the **New Drop**{:.ui-keyword} window. This will load the default loot so you can make changes.

## Question 2

## Question 3