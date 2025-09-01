---
title: renameCharacter
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.renameCharacter(characterId, newName);
parameters:
  - name: characterId
    type: String
    description: The Sentinel UUID of the survivor to be renamed.
  - name: newName
    type: String
    description: The survivor's new name.
examples:
  - title: Rename a survivor
    code: beacon.renameCharacter('305b1849-c7ac-5a4b-afe9-86628d91bf23', 'Slartibartfast');
---
# {{page.title}}

Renames a survivor, even if the player is offline.

{% include sentinelfunction.markdown %}
