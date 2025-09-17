---
title: sendChat
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.sendChat(chatMessage);
  - beacon.sendChat(chatMessage, senderName);
  - beacon.sendChat(chatMessage, chatInfo);
parameters:
  - name: chatMessage
    type: String
    description: The message to be sent to chat. Avoid special characters like emoji and accented characters, as Ark's font cannot handle all characters in every language.
  - name: senderName
    type: String
    description: The name to use as the sender. Defaults to `Sentinel`.
  - name: chatInfo
    type: Object
    description: An object with additional details about the sender and recipient.
    subobject:
      - key: senderName
        type: String
        notes: Works exactly the same as the `senderName` positional parameter.
      - key: specimenId
        type: Number
        notes: The specimen / implant number of the survivor to privately deliver the chat message to.
      - key: characterId
        type: String
        notes: The Sentinel UUID of the survivor to privately deliver the chat message to.
      - key: tribeId
        type: String
        notes: The Sentinel UUID of the tribe to deliver the chat message to.
examples:
  - title: Send a global chat message
    code: beacon.sendChat('Server shutdown in 5 minutes!');
  - title: Send a private message
    code: "beacon.sendChat('Warning, please no swearing on this server', {\n  characterId: '305b1849-c7ac-5a4b-afe9-86628d91bf23',\n});"
---
# {{page.title}}

Sends a chat message. If the server is participating in group chat delivery, the message will be delivered to other servers in the group, including a Discord channel if connected.

{% include sentinelfunction.markdown %}
