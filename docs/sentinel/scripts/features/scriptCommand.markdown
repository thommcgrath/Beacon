---
title: ScriptCommand Cheat
parent: Features
grand_parent: Scripts
description: "Adds a \"scriptcommand\" in-game admin cheat."
---
# {{ page.title }}

{{ page.description }}

## Identity

- **Keyword**: Each cheat command should have a unique keyword, though Sentinel will not enforce this as it is possible multiple scripts can add cheat commands with the same keyword. Sentinel will execute all cheat commands matching the keyword.
- **Arguments**: Cheat commands can define positional arguments used to receive values from the admin. Argument values are available within the script command code using the `beacon.params` structure. Since arguments are separated by spaces, string arguments must be escaped with ' or " if the value needs to contain a space. It is acceptable to wrap a string even if it does not need it.

### String Argument Examples

```text
cheat scriptcommand sentinel renameme Raptor
```

```text
cheat scriptcommand sentinel renameme 'Parasaur'
```

```text
cheat scriptcommand sentinel renameme 'Watercooled Ceratosaurus'
```

```text
cheat scriptcommand sentinel renameme "Badger's Revenge"
```
