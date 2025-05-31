---
title: "Template"
parent: "Classes"
grand_parent: "Version 4"
has_children: false
apiVersion: 4
classPath: "templates"
identifierProperty: "templateId"
supportedClassMethods:
  - GET
supportedInstanceMethods:
  - GET
---
# {{page.title}}

{% capture sample_object %}
{}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}