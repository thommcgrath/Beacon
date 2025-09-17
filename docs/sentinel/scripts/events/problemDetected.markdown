---
title: Problem Detected
parent: Events
grand_parent: Scripts
description: "Sentinel has detect a generic problem, such as server clock sync problem."
properties:
  - key: problemType
    type: String
    notes: One of `incorrectClusterId`, `incorrectServerClock`, `subscriptionExpired`, or `badTimestampFormat`.
  - key: timestamp
    type: String
    notes: The timestamp string the server sent. Valid for `incorrectServerClock` and `badTimestampFormat`.
  - key: sentEpoch
    type: Number
    notes: The parsed timestamp as a unix epoch. Valid for `incorrectServerClock`.
  - key: correctEpoch
    type: Number
    notes: The correct unix epoch. Valid for `incorrectServerClock`.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "problemType": "incorrectServerClock",
  "timestamp": "2025-04-03 00:22:56.243",
  "sentEpoch": 1743639776.243,
  "correctEpoch": 1743636173.515
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}

## Problem Types

### incorrectClusterId
The UUIDs for survivors, tribes, and dinos are constructed using your cluster ID as its namespace. This allows transfer between servers without generating new UUIDs, while ensuring there is no collision with other clusters. If the server's cluster ID changes, Sentinel's previously logged data no longer makes any sense. So if the cluster ID is not what Sentinel expects, the connection will be rejected. To allow the connection, which will wipe Sentinel's data for the server, the "Allow Cluster ID Change" option must be turned on in the server's Sentinel settings. Once the server connects to Sentinel again, this option will be turned off.

### incorrectServerClock
To ensure logical data, the game server's clock will be checked against Sentinel's clock. If there is more than 30 seconds difference between the two, the connection will be refused.

### subscriptionExpired
The server owner's Sentinel subscription has expired.

### badTimestampFormat
This would be a rare problem caused by unexpected formatting changes in Unreal or possibly a third-party mod attempting to connect to Sentinel.
