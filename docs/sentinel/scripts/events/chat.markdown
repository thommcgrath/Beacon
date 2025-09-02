---
title: Chat Message Sent
parent: Events
grand_parent: Scripts
description: "A chat message was sent in-game, from the Sentinel web interface, or (if enabled) from a linked Discord channel."
properties:
  - key: source
    type: String
    notes: One of `Game`, `Script`, `Discord`, `WebService`, or `WebGroup`.
  - key: sourceId
    type: String
    notes: An identifier of the source. This may be a service id, group id, script id, or Discord channel snowflake.
  - key: sourceName
    type: String
    notes: A name for the source.
  - key: originalMessage
    type: String
    notes: The message as it was originally typed. May be censored. Sentinel is not able to capture the uncensored message.
  - key: originalLanguage
    type: String
    notes: The 2 character language code detected by Sentinel's translation service. May be `xx` if translation was not attempted, such as messages sent by the web interface, script, or Discord.
  - key: senderName
    type: String
    notes: The name of the sender.
  - key: scope
    type: String
    notes: One of `Global`, `Alliance`, `Tribe`, `Local`, or `Radio`.
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player that sent the message, if the message was sent from the game.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that sent the message, if the message was sent from the game.
  - key: transations
    type: Object
    notes: An object containing translated versions of the original message.
  - key: analysis
    type: Object
    notes: An object with a guaranteed key of `success`. When true, a `scores` key will also be included. See the [Score Explanations](#score-explanations) section below for a detailed explanation of each category.
scores:
  - key: law
    type: Number
    notes: "Content that contains or tries to elicit detailed or tailored legal advice."
  - key: pii
    type: Number
    notes: "Content that requests, shares, or attempts to elicit personal identifying information such as full names, addresses, phone numbers, social security numbers, or financial account details."
  - key: health
    type: Number
    notes: "Content that contains or tries to elicit detailed or tailored medical advice."
  - key: sexual
    type: Number
    notes: "Material that explicitly depicts, describes, or promotes sexual activities, nudity, or sexual services. This includes pornographic content, graphic descriptions of sexual acts, and solicitation for sexual purposes. Educational or medical content about sexual health presented in a non-explicit, informational context is generally exempted."
  - key: selfharm
    type: Number
    notes: "Content that promotes, instructs, plans, or encourages deliberate self-injury, suicide, eating disorders, or other self-destructive behaviors. This includes detailed methods, glorification, statements of intent, dangerous challenges, and related slang terms"
  - key: financial
    type: Number
    notes: "Content that contains or tries to elicit detailed or tailored financial advice."
  - key: violenceAndThreads
    type: Number
    notes: "Content that describes, glorifies, incites, or threatens physical violence against individuals or groups. This includes graphic depictions of injury or death, explicit threats of harm, and instructions for carrying out violent acts. This category covers both targeted threats and general promotion or glorification of violence."
  - key: hateAndDiscrimination
    type: Number
    notes: "Content that expresses prejudice, hostility, or advocates discrimination against individuals or groups based on protected characteristics such as race, ethnicity, religion, gender, sexual orientation, or disability. This includes slurs, dehumanizing language, calls for exclusion or harm targeted at specific groups, and persistent harassment or bullying of individuals based on these characteristics."
  - key: dangerousAndCriminalContent
    type: Number
    notes: "Content that promotes or provides instructions for illegal activities or extremely hazardous behaviors that pose a significant risk of physical harm, death, or legal consequences. This includes guidance on creating weapons or explosives, encouragement of extreme risk-taking behaviors, and promotion of non-violent crimes such as fraud, theft, or drug trafficking."
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "analysis": {
    "scores": {
      "law": 0.000033,
      "pii": 0.000607,
      "health": 0.000029,
      "sexual": 0.000048,
      "selfharm": 0.000015,
      "financial": 0.000024,
      "violenceAndThreats": 0.005911,
      "hateAndDiscrimination": 0.001099,
      "dangerousAndCriminalContent": 0.008847
    },
    "success": true
  },
  "originalMessage": "I ran out of tranq darts",
  "originalLanguage": "en",
  "translations": {
    "fr": "Ce n'est pas une traduction correcte."
  },
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}

## Score Explanations

{% include propertiestable.markdown properties=page.scores %}

## Notes

The nature of player chat sometimes confuses the translation service. For example, the message `u right i guess lol` is clearly an English message, but gets detected as Italian. This results in an `en` key in the `translations` object that reads `you're right, I guess, lol`. Do not expect translations to be perfect.

Sentinel currently uses DeepL for its translations and Mistral Moderation for content scoring, but these services could be changed at any time.

Although there is no perfect score to determine whether a chat message belongs to a particular category, 0.5 (50%) is generally considered an acceptable threshold.
