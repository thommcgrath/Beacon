---
title: Survivor Spawned
parent: Events
grand_parent: Scripts
description: "A survivor has spawned. This includes first time spawn and respawn after death, but not reconnecting or fast traveling. This event is expected to execute whenever the player would see the \"arm scratch\" animation, even if turned off."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor was renamed.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that was renamed.
  - key: specimenId
    type: Number
    notes: The specimen / implant number of the survivor.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
  - key: tribeName
    type: String
    notes: The name of the tribe the survivor belongs to.
  - key: identityProvider
    type: String
    notes: Currently always `EOS`.
  - key: identityProviderId
    type: String
    notes: The unique id from the identity provider. Currently always the player's EOS ID.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "specimenId": 99277501
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "tribeName": "Reusable Breakfast Cereals",
  "identityProvider": "EOS",
  "identityProviderId": "00020000000000000000000000000000"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
