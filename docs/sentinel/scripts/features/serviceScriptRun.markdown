---
title: Server Menu Item
parent: Features
grand_parent: Scripts
description: "Adds a menu item to the \"Run Script\" menu of the server page in Sentinel web interface."
---
# {{ page.title }}

{{ page.description }}

## Identity

- **Menu Text**: Each menu item should have a unique name, though Sentinel will not enforce this as it is possible multiple scripts can add menu items with the same name. Sentinel will not execute multiple menu items with the same name, but it will be hard to tell them apart in the web interface.
- **Fields**: Menu items can define fields used to receive values from the web interface. Field values are available within the menu item code using the `beacon.params` structure.
