{% if include.sample %}
## Example Instance

```json
{{include.sample | strip}}
```
{% endif %}
{% if page.properties %}
## Properties

{% include propertiestable.markdown properties=page.properties %}
{% endif %}
