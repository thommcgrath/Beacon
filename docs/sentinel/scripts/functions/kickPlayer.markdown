---
title: kickPlayer
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.kickPlayer(playerId);
parameters:
  - name: playerId
    type: String
    description: A Sentinel player ID to be kicked from the server.
examples:
  - title: Kick a player
    code: beacon.kickPlayer('fc4c921c-ba83-4d1b-8470-a08fedf8246f');
---
# {{page.title}}

Immediately kicks the player from the server. Since this is a kick and not a ban, the player will be able to rejoin.

{% include sentinelfunction.markdown %}
