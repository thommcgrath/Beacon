---
title: Player Joined
parent: Events
grand_parent: Scripts
description: "A player has joined the server."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player who joined the server.
  - key: ipFingerprint
    type: String
    notes: This is a hash of the IP address the player is connecting from. The input address is salted with the server's cluster ID, making them unique to each cluster. This allows for comparison to other servers in the cluster, but not to other clusters. Sentinel will not reveal the user's raw IP address.
  - key: connectionDetails
    type: Object
    notes: An object conforming to the [AddressLookupResult](../classes/addressLookupResult.html) class.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "ipFingerprint": "-re_fNDgYtU2l4Ps_dM2DTy2g2-rAFzXK8vJkwqSeEs"
  "connectionDetails": {
    "success": true,
    "countryCode": "AQ",
    "continentCode": "AN",
    "timezone": "Antarctica/Syowa",
    "vpn": false
  }
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
