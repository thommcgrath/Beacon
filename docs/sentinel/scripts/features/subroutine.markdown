---
title: Subroutine
parent: Features
grand_parent: Scripts
description: "Adds code that can be triggered by other events or features in the same script."
---
# {{ page.title }}

{{ page.description }}

Subroutines are executed with the [runSubroutine](../functions/runSubroutine.html) function.

## Identity

- **Name**: Each subroutine should have a name that is unique to the script. However, Sentinel will not enforce uniqueness. If two subroutines share the same name, **both** will execute. There is no character limitation, however it is advised to avoid characters like ' and " to make it easier to call from JavaScript without the need to escape characters.
- **Arguments**: A subroutine can define arguments used to receive values from the calling code. For example, a subroutine that posts a chat message on a delay might define arguments for the message and the delay to use. See the `runSubroutine` documentation (linked above) for more details about passing values into a subroutine. Argument values are available within the subroutine using the `beacon.params` structure.
