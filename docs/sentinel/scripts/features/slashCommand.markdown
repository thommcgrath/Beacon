---
title: Slash Command
parent: Features
grand_parent: Scripts
description: "Adds a slash command. A slash command is an in-game chat message that starts with / to perform a task. The most well-known slash command is \"/kit\"."
---
# {{ page.title }}

{{ page.description }}

## Identity

- **Keyword**: Each slash command should have a unique keyword, though Sentinel will not enforce this as it is possible multiple scripts can add slash commands with the same keyword. Sentinel will execute all slash commands matching the keyword.
- **Arguments**: Slash commands can define positional arguments used to receive values from the player. Argument values are available within the slash command code using the `beacon.params` structure. Since arguments are separated by spaces, string arguments must be escaped with ' or " if the value needs to contain a space. It is acceptable to wrap a string even if it does not need it.

### String Argument Examples

```text
/renameme Raptor
```

```text
/renameme 'Parasaur'
```

```text
/renameme 'Watercooled Ceratosaurus'
```

```text
/renameme "Badger's Revenge"
```
