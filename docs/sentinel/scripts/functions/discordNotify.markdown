---
title: discordNotify
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.discordNotify(message, webhookUrl);
parameters:
  - name: message
    description: The message to send. Markdown will be parsed into a styled message.
  - name: webhookUrl
    description: The URL to deliver the message to. Discord will generate this URL for you. This URL must start with `https://discord.com/api/webhooks/`.
examples:
  - title: Alert the Discord channel when a survivor dies to a wild dino.
    code: "const character = beacon.fetchCharacter(beacon.eventData.characterId);\nbeacon.discordNotify(`${character.name} was just eaten by a wild ${beacon.eventData.attacker.species}.`, 'https://discord.com/api/webhooks/thisIsNotActuallyAValidWebhook');"
---
# {{page.title}}

Sends a message to Discord using a webhook URL. See [discord.com](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks){:target="_blank"} for more details about Discord webhooks, including how to create them for your server.

{% include sentinelfunction.markdown %}
