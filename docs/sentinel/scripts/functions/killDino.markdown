---
title: killDino
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.killDino(dinoId);
parameters:
  - name: dinoId
    type: String
    description: The Sentinel UUID of the dino that should be killed.
examples:
  - title: Kill a dino
    code: beacon.killDino('8ebd16a3-6055-5d6e-8898-7021b1a19e73');
---
# {{page.title}}

Kills a deployed dino. Dinos in cryopods, upload, or other storage mechanism will not be killed.

{% include sentinelfunction.markdown %}
