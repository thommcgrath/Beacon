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