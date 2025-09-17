{% if page.parent == 'Features' %}
{% assign eventTitlecase = 'Feature' %}
{% assign eventLowercase = 'feature' %}
{% else %}
{% assign eventTitlecase = 'Event' %}
{% assign eventLowercase = 'event' %}
{% endif %}
{% if page.properties %}
## {{ eventTitlecase }} Data Properties

{% include propertiestable.markdown properties=page.properties %}
{% if include.sample %}
## Sample {{ eventTitlecase }} Data

```json
{{include.sample | strip}}
```
{% endif %}
{% else %}
This {{ eventLowercase }} has no data.
{% endif %}
