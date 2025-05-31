---
title: "Dino"
parent: "Sentinel"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "sentinel/dinos"
identifierProperty: "dinoId"
supportedClassMethods:
  - POST
  - GET
  - PATCH
  - DELETE
supportedInstanceMethods:
  - PUT
  - GET
  - PATCH
  - DELETE
---
# {{page.title}}

{% capture sample_object %}
{}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}