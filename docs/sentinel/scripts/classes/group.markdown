---
title: Group
parent: Classes
grand_parent: Scripts
properties:
  - key: groupId
    type: String
    notes: The v4 UUID of the group.
  - key: userId
    type: String
    notes: The Beacon UUID of the group owner.
  - key: name
    type: String
    notes: The name of the group.
  - key: color
    type: String
    notes: One of `None`, `Blue`, `Brown`, `Grey`, `Green`, `Indigo`, `Orange`, `Pink`, `Purple`, `Red`, `Teal`, or `Yellow`.
---
# {{page.title}}

The `Group` class represents a Sentinel server group.

{% capture sample_object %}
{
  "groupId": "29fdfe65-2299-49d5-ac35-8f4757a764de",
  "userId": "00000000-60b4-4e15-91b1-a29ebd4651cd",
  "name": "Servers That Do Not Exist",
  "color": "None"
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}
