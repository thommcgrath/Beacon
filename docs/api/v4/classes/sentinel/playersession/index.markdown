---
title: "PlayerSession"
parent: "Sentinel"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "sentinel/playerSessions"
identifierProperty: "playerSessionId"
supportedClassMethods:
  - GET
supportedInstanceMethods:
  - GET
sortableProperties:
  - connectTime
  - playerName
  - serviceDisplayName
filters:
  - key: playerId
    mode: exact
  - key: serviceId
    mode: exact
  - key: groupId
    mode: exact
    notes: "Though not a true property, will find sessions for any service in the specified group."
  - key: playerName
    mode: contains
  - key: serviceDisplayName
    mode: contains
  - key: isConnected
    mode: exact
properties:
  - key: playerSessionId
    type: UUID
  - key: playerId
    type: UUID
  - key: playerName
    type: String
  - key: serviceId
    type: UUID
  - key: serviceDisplayName
    type: String
  - key: connectTime
    type: Timestamp
  - key: disconnectTime
    type: Timestamp
    notes: "Is null when the player is currently playing on a server."
  - key: playTime
    type: Float
    notes: "If the player is currently playing on a server, this value is the number of seconds since they started playing. Otherwise, it is the number of seconds they were playing."
  - key: isConnected
    type: Boolean
    notes: "True when the player is currently playing on a server."
---
# {{page.title}}

{% capture sample_object %}
{
  "playerSessionId": "7f494a48-0ae9-4e4f-a940-1e6913b8e9dc",
  "playerId": "72b12591-21b1-43d9-9980-9a9998d55aab",
  "playerName": "General Manta",
  "serviceId": "cca4e70c-052c-41f3-88f5-ca3ce24eb17c",
  "serviceDisplayName": "This server does not exist",
  "connectTime": 1748726767.085817,
  "disconnectTime": 1748726802.538305,
  "playTime": 35.452488,
  "isConnected": false
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}