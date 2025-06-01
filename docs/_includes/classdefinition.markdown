{% if page.classPath %}
## Class Basics

| Class Path | /v{{page.apiVersion}}/{{page.classPath}} |
| Identifier Property | {{page.identifierProperty}} |
| Class Methods | {% if page.supportedClassMethods %}{% assign classMethodBound = page.supportedClassMethods.size | minus: 1 %}{% for method in page.supportedClassMethods limit: classMethodBound %}`{{method}}`, {% endfor %}`{{page.supportedClassMethods.last}}`{% else %}None{% endif %} |
| Instance Methods | {% if page.supportedInstanceMethods.size %}{% assign instanceMethodBound = page.supportedInstanceMethods.size | minus: 1 %}{% for method in page.supportedInstanceMethods limit: instanceMethodBound %}`{{method}}`, {% endfor %}`{{page.supportedInstanceMethods.last}}`{% else %}None{% endif %} |
{:.classdefinition}
{% endif %}
{% if include.sample %}
## Example Instance

```json
{{include.sample | strip}}
```
{% endif %}
{% if page.properties %}
## Properties

| Property | Type | Notes |
| - | - | - |{% for property in page.properties %}{% assign propertyKey = property.first.first %}
| {{propertyKey}} | {{property[propertyKey].type}} | {{property[propertyKey].notes}} |{% endfor %}
{:.classdefinition}
{% endif %}
{% if page.sortableProperties %}
## Sortable Properties

{% for property in page.sortableProperties %}
| {{property}} | {% if forloop.first %}Default{% endif %} |{% endfor %}
{:.classdefinition}
{% endif %}
{% if page.filters %}
## Filters

| Query Parameter | Match Mode | Notes |
| - | - | - |{% for filter in page.filters %}
| {{filter.first.first}} | {{filter[filter.first.first].mode}} | {{filter[filter.first.first].notes}} |{% endfor %}
{:.classdefinition}
{% endif %}