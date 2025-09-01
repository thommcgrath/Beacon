---
title: debugPrint
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.debugPrint(message);
parameters:
  - name: message
    description: The message to be sent to output.
examples:
  - title: Print a message
    code: beacon.debugPrint('See you starside');
---
# {{page.title}}

Prints a message to output. Output is visible during testing, as well as stored with the event that triggered the script. As the name implies, this is most useful for debugging.

{% include sentinelfunction.markdown %}
