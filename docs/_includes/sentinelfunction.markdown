{% if page.restricted == true %}
{:.caution}
> This function is [restricted](/sentinel/scripts/#restrictions). Use of this function in your script will require a manual review before it will execute on the Sentinel infrastructure.
{% endif %}
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
{%if parameter.supportsMessage %}{{ parameter.supportsMessage }}{% else %}It supports the following properties:{% endif %}

{% include propertiestable.markdown properties=parameter.subobject %}
{% endif %}
{% endfor %}
{% endif %}
{% if page.return %}
## Return Values

| Type | Notes |
| - | - |{% for return in page.return %}
| {{ return.type }} | {{ return.description }} |{% endfor %}
{:.classdefinition}
{% endif %}
{% if page.examples %}
## Examples

{% for example in page.examples %}
### {{example.title}}
```javascript
{{ example.code }}
```{% if example.notes %}
{{ example.notes }}
{% endif %}{% endfor %}
{% endif %}
{% if page.seealso %}
## See Also

{% for also in page.seealso %}
- [{{ also }}]({{ also }}.html)
{% endfor %}
{% endif %}