---
title: banPlayer
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.banPlayer(playerIdOrEOSId, reason);
  - beacon.banPlayer(playerIdOrEOSId, reason, groupId);
  - beacon.banPlayer(playerIdOrEOSId, reason, expirationEpoch);
  - beacon.banPlayer(playerIdOrEOSId, reason, groupId, expirationEpoch);
parameters:
  - name: playerIdOrEOSId
    description: Either a Sentinel player ID, which looks like `fc4c921c-ba83-4d1b-8470-a08fedf8246f`, or an EOS ID, which looks like `00024f40082f46b0a93f280080009f2a`.
  - name: reason
    description: A reason to be listed with the ban. This is required because human memories are not perfect.
  - name: groupId
    description: A Sentinel group ID. If supplied, the player will be banned from the specified group, affecting all servers in the group. If not supplied, the player will be banned from the server running the script.
  - name: expirationEpoch
    description: If the ban should expire, provide a unix timestmp of the expiration.
examples:
  - title: Permanently ban a player from the current server
    code: beacon.banPlayer('fc4c921c-ba83-4d1b-8470-a08fedf8246f', 'Harassing the dodos');
  - title: Ban a player from the current server for 5 minutes
    code: beacon.banPlayer('fc4c921c-ba83-4d1b-8470-a08fedf8246f', 'Swearing', (Date.now() / 1000) + 300);
---
# {{page.title}}

Bans a player from a server or group.

{% include sentinelfunction.markdown %}
