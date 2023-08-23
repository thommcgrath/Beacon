{:.editor-title}
# The {{page.title}} Editor

{% if page.supportedgames %}
<p class="supported-games">
{% if page.supportedgames.size == 1 %}
This editor is compatible with {{page.supportedgames.first}} projects.
{% elsif page.supportedgames.size == 2 %}
This is compatible with {{page.supportedgames.first}} and {{page.supportedgames.last}} projects.
{% else %}
{% assign skiplast = page.supportedgames.size | minus: 1 %}This editor is compatible with {% for key in page.supportedgames limit: skiplast %}{{key}}, {% endfor %} and {{page.supportedgames.last}} projects.
{% endif %}
</p>
{% endif %}
