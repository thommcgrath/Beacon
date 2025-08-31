---
title: Tribe
parent: Classes
grand_parent: Scripts
properties:
  - key: tribeId
    type: String
    notes: The tribe's Sentinel-generated v5 UUID.
  - key: tribeNumber
    type: Number
    notes: The tribe's in-game unique id number. For survivors without a tribe, this number should match the survivor's specimen ID
  - key: name
    type: String
    notes: The name of the tribe.
---
# {{page.title}}

The `Tribe` class represents a tribe. All survivors have a tribe, even if alone.

{% capture sample_object %}
{
	"tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
	"tribeNumber": 780901340,
	"name": "Reusable Breakfast Cereals"
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}