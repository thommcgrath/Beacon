| Property | Type | Notes |
| - | - | - |{% for property in include.properties %}
| {{property.key}} | {{property.type}} | {{property.notes}} |{% endfor %}
{:.classdefinition}