---
title: Difficulty
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
configkeys:
  - DifficultyOffset
  - OverrideOfficialDifficulty
supportedgames:
  - "Ark: Survival Ascended"
---
{% include editortitle.markdown %}

{% include image.html file="difficulty.png" file2x="difficulty@2x.png" caption="The difficulty editor allows adjusting the server's creature level / difficulty, and computes some common values for your reference." %}

Ark's difficulty setting has a big impact on the server. Its main effect is on the creature levels that can spawn on the server. Unless you're using custom levels in the [Creature Spawns editor](/configs/spawnpoints/), creatures always spawn in 30 multiples of the server difficulty. For example, if the difficulty is 4.0, the server will get creatures at 4, 8, 12, 16, etc., up to level 120. Another way to think of it is `Difficulty x 1`, `Difficulty x 2`, `Difficulty x 3`, etc., through `Difficulty x 30`.

So, Beacon lets you set the difficulty in the opposite direction: tell it the highest creature level you want to see, using the **Maximum Creature Level**{:.ui-keyword} setting, and Beacon will compute the difficulty for you.

In the **Reference Values**{:.ui-keyword} section below Beacon will show you some additional values that might be useful to you:

- **Loot Scale**{:.ui-keyword}: In Ark, higher difficulties mean higher quality loot. **However**, Beacon's loot quality formulas know this value and will counter this effect.
- **Difficulty Value**{:.ui-keyword}: The difficulty Beacon calculated by diving **Maximum Creature Level**{:.ui-keyword} by 30.
- **Difficulty Offset**{:.ui-keyword}: Every server's `DifficultyOffset` should be 1.0, so that is all this field will ever show.
- **Override Official Difficulty**{:.ui-keyword}: The server's `OverrideOfficialDifficulty` settings should be set to this value to achieve the desired difficulty.
- **Max Tek Level**{:.ui-keyword}: The maximum level of tek creatures you will find on the map. This is `Difficulty x 36`.
- **Max Wyvern Level**{:.ui-keyword}: The maximum level of wyverns you will find on the map. This is `Difficulty x 38`.
- **Max Crystal Wyvern Level**{:.ui-keyword}: The maximum level of crystal wyvern you will find on the map. This is `Difficulty x 45`.

{% include affectedkeys.html %}