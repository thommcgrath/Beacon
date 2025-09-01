---
title: log
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.log(message);
  - beacon.log(message, level);
parameters:
  - name: message
    type: String
    description: The custom log message.
  - name: level
    type: String
    description: The urgency of the message. In order of least urgent to most urgent. The possible values are `Debug`, `Informational`, `Notice`, `Warning`, `Error`, `Critical`, `Alert`, and `Emergency`. Defaults to `Informational`.
examples:
  - title: Create a custom log message
    code: beacon.log('A game of hide-and-seek was started!');
---
# {{page.title}}

Saves a message to Sentinel's logs.

{% include sentinelfunction.markdown %}
