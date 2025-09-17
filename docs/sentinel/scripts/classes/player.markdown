---
title: Player
parent: Classes
grand_parent: Scripts
properties:
  - key: playerId
    type: String
    notes: The player's Sentinel-generated v4 UUID
  - key: name
    type: String
    notes: The most recent player name, pulled from a linked account.
  - key: doNotTrack
    type: Boolean
    notes: True if the player has opted out of Sentinel track. See the [Anonymous Players](/sentinel/anonymousPlayers/) guide for more information about anonymous players.
---
# {{page.title}}

The `Player` class represents a real human player. It is possible for a player to have multiple accounts associated with them. At the moment, Sentinel only tracks Epic Online accounts, but expect Discord accounts to be included as well in the future.

{% capture sample_object %}
{
  "playerId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "name": "Sentinel Sample Player",
  "doNotTrack": false
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}