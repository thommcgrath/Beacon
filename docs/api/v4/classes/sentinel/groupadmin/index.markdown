---
title: "GroupAdmin"
parent: "Sentinel"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "sentinel/groupAdmins"
identifierProperty: "groupAdminId"
supportedClassMethods:
  - POST
  - GET
  - DELETE
supportedInstanceMethods:
  - PUT
  - GET
  - DELETE
filters:
  - key: groupId
    mode: exact
  - key: playerId
    mode: exact
  - key: groupName
    mode: websearch
  - key: playerName
    mode: websearch
properties:
  - key: groupAdminId
    type: UUID
  - key: groupId
    type: UUID
  - key: groupName
    type: String
  - key: groupColor
    type: String
  - key: playerId
    type: UUID
  - key: playerName
    type: String
---
# {{page.title}}

{% capture sample_object %}
{
  "groupAdminId": "92875929-ed44-4c40-a1c7-8cd99cef6a3b",
  "groupId": "743670c6-e238-4709-a4ac-fd37caf8464c",
  "groupName": "Infinitely Sandwich",
  "groupColor": "Indigo",
  "playerId": "838e8170-ec10-4ce2-94f6-adf12462a9b7",
  "playerName": "Miserable Manticore"
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}

## In-Game

Creating a `GroupAdmin` will immediately grant cheat access to the player's survivors on any server in the referenced group. Deleting the `GroupAdmin` will kick the player if they are on an affected server. Sentinel stores admin records in the map save data, so these features will persist even while disconnected from the Sentinel network.
