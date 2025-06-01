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
  - playerId:
      mode: exact
  - serviceId:
      mode: exact
  - groupId:
      mode: exact
      notes: "Though not a true property, will find sessions for any service in the specified group."
  - playerName:
      mode: contains
  - serviceDisplayName:
      mode: contains
  - isConnected
      mode: exact
properties:
  - playerSessionId:
      type: UUID
  - playerId:
      type: UUID
  - playerName:
      type: String
  - serviceId:
      type: UUID
  - serviceDisplayName:
      type: String
  - connectTime:
      type: Timestamp
  - disconnectTime:
      type: Timestamp
      notes: "Is null when the player is currently playing on a server."
  - playTime:
      type: Float
      notes: "If the player is currently playing on a server, this value is the number of seconds since they started playing. Otherwise, it is the number of seconds they were playing."
  - isConnected:
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