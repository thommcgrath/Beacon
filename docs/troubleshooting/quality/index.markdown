---
title: Item Quality Is Different Than Expected
parent: Troubleshooting
nav_order: 1
---
# {{page.title}}

## Loot Quality Multiplier

The general advice is to design your loot drop contents with your intended qualities. If, after testing, you find qualities are consistently too low or too high, the **Supply Crate Loot Quality Multiplier**{:.ui-keyword} setting in the [General Settings editor](/configs/othersettings/) can be adjusted. A value higher than 1 increases quality, so values lower than 1 decrease quality. Doing it this way allows you more rapidly make adjustments as needed, and Beacon will automatically restore the setting to 100% when Beacon's quality formulas change - which isn't often.

Small changes to this value can have big effects. The recommended range is 0.8 to 1.2. As quality increases, so does the number of ingredients required to craft blueprints. Ark has a hard limit of 65,535 of any ingredient, and going over this limit will cause the value to reset to 0 and start counting up again. So something that needs 65,600 of an ingredient will actually need 64 in game. That's why increasing the quality multiplier too much can have negative effects on the game.

## Ark's Quality Formulas

Beacon's math is based on [this forum post](https://forums.unrealengine.com/development-discussion/modding/ark-survival-evolved/93237-tutorial-understanding-arbitrary-item-quality) from 2016. These formulas are why Beacon asks about server difficulty, so it can properly compute the `BAQ` value, and Beacon already knows the `CQM` values for each loot drop. So Beacon is able to accurately compute the `AIQ` values for a given range.

The problem is the random `X` value, which is described as "a float value determined by the Random Number Generator between 0 and the AIQ * the Randomizer Range Override." Beacon is able to account for every value in the formula, but the fact that `X` can be equal to 0 means that even when generating loot with the max quality value of 100, the `X` multiplier can bring the actual loot quality all the way down to 0.

If it wasn't for the fact that `X` can be so low, Beacon could compute a range of values that guarantees desired loot quality. Instead, Beacon has to essentially guess. Imagine you're rolling a single die, and to win you need to roll a 6 or higher. Well, 6 is already the limit, so odds of winning are 1/6. Now imagine you're able to roll two dice, whose total need to be 6 or higher. In that case, the odds of winning go up to 6/12! This is essentially what Beacon is doing with the maximum quality numbers. Since the minimum cannot be enforced, the maximum needs to be overestimated in order to provide a reasonable chance to actually get loot in the desired range.

If the minimum cannot be enforced, why select a minimum at all? The minimum is still useful for two reasons. First, it tells Beacon what you'd *like* to happen, which helps Beacon decide on quality values to use. Second, should Ark ever change, Beacon will already have your intentions known. Beacon could adopt new formulas and give you loot closer (or hopefully exactly) as you intended.

