---
title: generateRandomUsername
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.generateRandomUsername();
return:
  - type: String
    description: A username from Beacon's username generator.
examples:
  - title: Rename players named Human when they spawn
    code: "const character = beacon.fetchCharacter(beacon.eventData.characterId);\nif (character.name == 'Human') {\n  beacon.renameCharacter(character.characterId, beacon.generateRandomUsername());\n}"
---
# {{page.title}}

Generates a random username. Some example results:
- Greedy Maewing
- Chilly Diplocaulus
- Squeaky Carbonemys
- Alienated Iguanodon
- Youthful Coelacanth

{% include sentinelfunction.markdown %}
