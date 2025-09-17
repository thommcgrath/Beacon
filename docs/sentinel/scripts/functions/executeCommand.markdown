---
title: executeCommand
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.executeCommand(command);
parameters:
  - name: command
    type: String
    description: The admin command to execute. The `cheat` prefix is allowed, but not required. Behavior is the same with and without the `cheat` prefix.
examples:
  - title: Perform a wild dino wipe
    code: beacon.executeCommand('destroywilddinos');
---
# {{page.title}}

Runs an admin command on the server.

{% include sentinelfunction.markdown %}

## Notes

Sentinel uses a variety of techniques to execute admin commands with the greatest reliability. If an RCON connection is available, most commands are sent over RCON. However, certain commands will crash the server if delivered by RCON. Therefore, the following commands will be executed directly by the Sentinel mod:

- `killplayer`
- `scriptcommand`
- `tribemessage`
- `broadcast`
- `destroytribeidstructures`
- `destroytribeiddinos`
- `destroytribeid`
- `setday`
- `slomo`

These commands will never be delivered to the server:

- `playersonly`
- `gettribeidplayerlist`
- `killaoe`

Commands executed by the Sentinel mod are not 100% reliable. This is because certain commands require an admin playing on the server to issue them. The Sentinel mod looks for an admin and executes the command as soon as it finds one. If there is no admin playing, the mod will still attempt to execute the command, though not all commands work this way.

The Sentinel mod recognizes some commands that it can improve, such as the `killplayer` command. Typically, this command does not kill offline survivors. However, the Sentinel mod intercepts this command and performs the task itself, enabling the command to target offline survivors.
