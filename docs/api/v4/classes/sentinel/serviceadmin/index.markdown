---
title: "ServiceAdmin"
parent: "Sentinel"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "sentinel/serviceAdmins"
identifierProperty: "serviceAdminId"
supportedClassMethods:
  - POST
  - GET
  - DELETE
supportedInstanceMethods:
  - PUT
  - GET
  - DELETE
filters:
  - key: serviceId
    mode: exact
  - key: playerId
    mode: exact
  - key: serviceDisplayName
    mode: websearch
  - key: playerName
    mode: websearch
properties:
  - key: serviceAdminId
    type: UUID
  - key: serviceId
    type: UUID
  - key: serviceDisplayName
    type: String
  - key: serviceColor
    type: String
  - key: playerId
    type: UUID
  - key: playerName
    type: String
---
# {{page.title}}

{% capture sample_object %}
{
  "serviceAdminId": "eddb6322-c1a5-4a90-8583-023d7f0c37df",
  "serviceId": "a516c6dc-b075-49c9-8f18-96a8d91e5dd0",
  "serviceDisplayName": "Ascendant Test Server",
  "serviceColor": "Green",
  "playerId": "838e8170-ec10-4ce2-94f6-adf12462a9b7",
  "playerName": "Miserable Manticore"
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}

## In-Game

Creating a `ServerAdmin` will immediately grant cheat access to the player's survivors on the server. Deleting a `ServiceAdmin` will kick the player if they are active on the server. Sentinel stores admin records in the map save data, so these features will persist even while disconnected from the Sentinel network.
