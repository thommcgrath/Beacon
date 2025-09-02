---
title: convertGameClock
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.convertGameClock(secondsFromWorldStart);
  - beacon.convertGameClock(clockInfo);
  - beacon.convertGameClock(days, hours, minutes);
parameters:
  - name: secondsFromWorldStart
    type: Number
    description: The total number of seconds since day 1 00:00. Returns an object with days, hours, and minutes.
  - name: clockInfo
    type: Object
    description: An object with keys `day`, `hours`, and `minutes`. Returns the number of seconds since day 1 00:00.
  - name: days
    type: Number
    description: The day number. The first day of a new save is 1, not 0.
  - name: hours
    type: Number
    description: The hours on the clock, 0 to 23.
  - name: minutes
    type: Number
    description: The minutes on the clock, 0 to 59.
examples:
  - title: Convert total seconds to object
    code: "const clock = beacon.convertGameClock(394896);\nbeacon.debugPrint(`Day ${clock.day} at ${clock.hours}:${clock.minutes}`);\n// Outputs \"Day 4 at 13:41\""
  - title: Convert object to total seconds
    code: "const clock = {\n  day: 4,\n  hours: 13,\n  minutes: 41,\n};\nconst totalSeconds = beacon.convertGameClock(clock);\nbeacon.debugPrint(totalSeconds);\n// Outputs \"394896\""
  - title: Convert clock values to total seconds
    code: "const totalSeconds = beacon.convertGameClock(4, 13, 41);\nbeacon.debugPrint(totalSeconds);\n// Outputs \"394896\""
---
# {{page.title}}

Converts between the game's representation of the clock and human-readable values.

{% include sentinelfunction.markdown %}
