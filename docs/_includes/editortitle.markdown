{:.editor-title}
# The {{page.title}} Editor

{% if page.supportedgames or page.requiresomni %}
<p class="supported-games">
{% if page.supportedgames %}
{% if page.supportedgames.size == 1 %}
This editor is compatible with {{page.supportedgames.first}} projects{% if page.requiresomni != true %}.{% endif %}
{% elsif page.supportedgames.size == 2 %}
This editor is compatible with {{page.supportedgames.first}} and {{page.supportedgames.last}} projects{% if page.requiresomni != true %}.{% endif %}
{% else %}
{% assign skiplast = page.supportedgames.size | minus: 1 %}This editor is compatible with {% for key in page.supportedgames limit: skiplast %}{{key}}, {% endfor %} and {{page.supportedgames.last}} projects{% if page.requiresomni != true %}.{% endif %}
{% endif %}
{% endif %}
{% if page.requiresomni %}
<span class="omni-notice">{% if page.supportedgames %} and {% else %}This editor {% endif %}requires <a href="https://usebeacon.app/omni">Beacon Omni</a>. All users may use this editor, but only Omni users will be able to generate config files from it.</span>
{% endif %}
</p>
{% endif %}
