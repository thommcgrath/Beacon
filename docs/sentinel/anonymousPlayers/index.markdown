---
title: Anonymous Players
parent: Sentinel
---
# {{page.title}}

Beacon Sentinel is required to allow players to opt out of tracking. This guide will explain how players can opt out and the implications for servers that use Beacon Sentinel.

## How to Opt Out of Beacon Sentinel Tracking

Players can join any Sentinel-monitored server and type **sentinel opt out** into the chat window. Sentinel will then anonymize their account identifiers and randomize the account name it has stored for the player. It will also stop logging future events from the player.

## Feature Limitations for Anonymous Players

- Chat messages are not logged, translated, scanned, or forwarded to cluster servers or Discord channels.
- Neither player nor survivor event scripts will fire, including manual survivor scripts.
- Script functions that return lists of players or survivors will exclude anonymous players and their survivors.
- Nearly all player and survivor events involving anonymous players will be ignored.
- The creation of tribes by anonymous players is still reported, with the players' and survivors' information anonymized.
- Death events involving anonymous players will be logged, with the players' and survivors' information anonymized.

## Options for Server Administrators

Only the game server administrator can decide whether these limitations are acceptable. For instance, a casual PvE server might be more accepting of these limitations than a PvP event server.

Server administrators can kick anonymous players from their servers. This option is enabled by default. It is a server-specific setting found in the "Compatibility Settings" section of the server's "Settings" tab of the Beacon Sentinel website.

Players who opt out while connected to a server that has chosen to kick anonymous players will be kicked immediately once the anonymization process is complete.

## How a Player Can Opt Back In

Players who have opted out can opt back in by submitting a support ticket at [https://usebeacon.app/help/contact](https://usebeacon.app/help/contact). The ticket must include your Ark EOS ID.
