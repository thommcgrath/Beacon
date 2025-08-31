{% if page.signatures %}
## Signatures

```javascript{% for signature in page.signatures %}
{{signature}}{% endfor %}
```
{% endif %}
{% if page.parameters %}
## Parameters

{% for parameter in page.parameters %}
### {{parameter.name}}
{{ parameter.description }}{%if parameter.subobject %}
It supports the following properties:

{% include propertiestable.markdown properties=parameter.subobject %}
{% endif %}
{% endfor %}
{% endif %}
{% if page.examples %}
## Examples

{% for example in page.examples %}
### {{example.title}}
```javascript
{{ example.code }}
```{% endfor %}
{% endif %}