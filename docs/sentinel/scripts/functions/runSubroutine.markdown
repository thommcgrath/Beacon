---
title: runSubroutine
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.runSubroutine(subroutineName);
  - beacon.runSubroutine(subroutineName, delay);
  - beacon.runSubroutine(subroutineName, delay, arguments);
parameters:
  - name: subroutineName
    type: String
    description: The name of the subroutine to run.
  - name: delay
    type: Number
    description: Number of milliseconds (1 / 1000th of a second) to delay the start of the subroutine. The default value of 0 will start the subroutine immediately, likely before the current script has finished.
  - name: arguments
    type: Object
    description: An object of argument values to pass into the subroutine. Since arguments have positional data, it is also possible to substitute plain values. See the example below.
examples:
  - title: Start and close a poll
    code: "beacon.sendChat('Should we run the swamp cave? Voting ends in 30 seconds.');\nbeacon.runSubroutine('Finish Poll', 30000);"
  - title: Warn about dino wipe using positional arguments
    code: "beacon.runSubroutine('Delayed Chat Message', 0, 'Dino wipe coming in 5');\nbeacon.runSubroutine('Delayed Chat Message', 1000, 'Dino wipe coming in 4');\nbeacon.runSubroutine('Delayed Chat Message', 2000, 'Dino wipe coming in 3');\nbeacon.runSubroutine('Delayed Chat Message', 3000, 'Dino wipe coming in 2');\nbeacon.runSubroutine('Delayed Chat Message', 4000, 'Dino wipe coming in 1');\nbeacon.runSubroutine('Dino Wipe', 5000, 'Enjoy your few moments of peace');"
  - title: Perfectly balanced, as all things should be
    code: "// Assumes an array of character objects has been selected.\n// Loops over the array and performs a Snap Survivor routine,\n// each on an increasing delay for dramatic effect. The\n// subroutine could simply kill the survivor, or even ban\n// them. The survivor is passed using an arguments object\n// instead of positional arguments.\nlet delay = 0;\ncharacters.forEach((character) => {\n  beacon.runSubroutine('Snap Survivor', delay, {\n    characterId: character.characterId,\n  });\n  delay = delay + 3000;\n});"
---
# {{page.title}}

Schedules a [subroutine feature](../features/subroutine.html) to run. This is mostly useful for performing tasks after a certain amount of time has passed.

{% include sentinelfunction.markdown %}
