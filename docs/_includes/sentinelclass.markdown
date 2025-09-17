{% if page.properties %}
## Properties

{% include propertiestable.markdown properties=page.properties %}
{% endif %}
{% if include.sample %}
## Example Instance

```json
{{include.sample | strip}}
```
{% endif %}

