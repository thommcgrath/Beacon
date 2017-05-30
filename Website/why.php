<?php
require('../php/engine.php');
ZirconTemplate::SetTitle('Why does Beacon do this?');
ZirconTemplate::AddHeaderLine('<link rel="stylesheet" href="/beacon/assets/beacon.css" type="text/css">');
?><div class="articleheader">
	<h1><a id="Why_does_Beacon_do_this_0"></a>Why does Beacon do this?</h1>
</div>
<div class="articlebody">
	<p>Beacon makes some unexpected decisions about the config files it produces. Since these questions come up frequently, here’s a detailed explanation.</p>
	<h2><a id="There_are_two_entries_for_every_item_in_my_set_4"></a>There are two entries for every item in my set!</h2>
	<p>This is because Ark is weird. For this example, we’re going to be talking about an item set entry of 20x Simple Rifle Ammo with a 50% blueprint chance. There are three possible ways this could be interpreted by Ark:</p>
	<ol>
		<li>50% chance of 20x Simple Rifle Ammo and 50% chance of 20x Simple Rifle Ammo Blueprint</li>
		<li>50% chance of 20x Simple Rifle Ammo and 50% chance of 1x Simple Rifle Ammo Blueprint</li>
		<li>10x Simple Rifle Ammo and 10x Simple Rifle Ammo Blueprint</li>
	</ol>
	<p>Either of the first two scenarios make sense, with #2 likely being the most expected. Who needs 20 blueprints of the same thing anyway?</p>
	<p>Unfortunately, that’s not how it works. Ark chose to go with option #3. For every item in the quantity, the blueprint chance is reevaluated. It could be 9x and 11x or 12x and 8x, the point is you’d get a mixture.</p>
	<p>So Beacon computes two config entries in this case. The first has a 0% chance of being a blueprint and the original quantities. The second has a 100% chance of being a blueprint and 1x quantity. This is to simulate option #2 as best as possible. The weight of each entry is divided by the blueprint chance. In the case of our example, if the weight is 30, since the blueprint chance is 50%, each of the produced entries would have a weight of 15.</p>
	<h2><a id="Beacon_is_producing_weird_quality_values_The_min_quality_is_higher_than_the_max_18"></a>Beacon is producing weird quality values. The min quality is higher than the max!</h2>
	<p>Every loot source in Ark has built-in min and max quality multiplier. Here’s some actual numbers:</p>
	<table class="generic_table">
		<thead>
			<tr>
				<td>Beacon</td>
				<td>Min Multiplier</td>
				<td>Max Multiplier</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="alt">Island White</td>
				<td>1.00</td>
				<td>1.00</td>
			</tr>
			<tr>
				<td>Island White Bonus</td>
				<td>2.00</td>
				<td>2.50</td>
			</tr>
			<tr>
				<td class="alt">Swamp Red</td>
				<td>3.25</td>
				<td>4.00</td>
			</tr>
		</tbody>
	</table>
	<p>This means that an entry quality of 2.0 produces a different result for each beacon. Speaking of qualities, that’s another thing Beacon does differently.</p>
	<p>The numeric values for each quality use statistics gathered by the community by spawning thousands of items and recording the results. It is time consuming, but gives us the best idea we can possibly get. Ark introduces a random quality multiplier which we cannot control, so the best we can do is use statistics. The quality values Beacon uses are <em>the most statistically likely to produce the desired result.</em> Unfortunately, this still isn’t great, as some qualities like Mastercraft have a statistically low chance of producing the desired outcome. So even if you choose Mastercraft-Mastercraft quality, only about 50% of the time will it actually be Mastercraft. The rest is roughly 25% Ascendant and 25% Journeyman. Unfortunately, this is just the way Ark is.</p>
	<p>With that in mind, here are the quality values Beacon uses:</p>
	<table class="generic_table">
		<thead>
			<tr>
				<td>Quality</td>
				<td>Value</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Primitive</td>
				<td>0.00</td>
			</tr>
			<tr class="alt">
				<td>Ramshackle</td>
				<td>1.25</td>
			</tr>
			<tr>
				<td>Apprentice</td>
				<td>2.00</td>
			</tr>
			<tr>
				<td class="alt">Journeyman</td>
				<td>3.75</td>
			</tr>
			<tr>
				<td>Mastercraft</td>
				<td>5.50</td>
			</tr>
			<tr>
				<td class="alt">Ascendant</td>
				<td>7.00</td>
			</tr>
			<tr>
				<td>Epic</td>
				<td>9.00</td>
			</tr>
			<tr>
				<td class="alt">Legendary</td>
				<td>12.00</td>
			</tr>
			<tr>
				<td>Pearlescent</td>
				<td>16.00</td>
			</tr>
		</tbody>
	</table>
	<p>As you can see, Pearlescent items are significantly overpowered. They are not recommended for PvP.</p>
	<p>Beacon’s goal is always to craft a config that most closely matches your <em>intentions</em>. Therefore, the loot source multipliers are taken into account when crafting the config. Here’s a chart of some example results:</p>
	<table class="generic_table">
		<thead>
			<tr>
				<td>Desired Min Quality</td>
				<td>Desired Max Quality</td>
				<td>Loot Source Min Multiplier</td>
				<td>Loot Source Max Multiplier</td>
				<td>Computed Min Quality</td>
				<td>Computed Max Quality</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1.25</td>
				<td>3.75</td>
				<td>1.00</td>
				<td>1.00</td>
				<td>1.25</td>
				<td>3.75</td>
			</tr>
			<tr class="alt">
				<td>1.25</td>
				<td>3.75</td>
				<td>2.00</td>
				<td>2.00</td>
				<td>0.625</td>
				<td>1.875</td>
			</tr>
			<tr>
				<td>1.25</td>
				<td>3.75</td>
				<td>3.25</td>
				<td>4.00</td>
				<td>0.333</td>
				<td>0.9375</td>
			</tr>
			<tr class="alt">
				<td>3.75</td>
				<td>3.75</td>
				<td>3.25</td>
				<td>4.00</td>
				<td>1.154</td>
				<td>0.9375</td>
			</tr>
		</tbody>
	</table>
	<p>The last entry in that chart brings us back to the point. In that case, the item is defined as a minimum and maximum quality of Journeyman. The loot source’s multiplier affect how that is computed, so the minimum quality that Beacon outputs is actually higher than the maximum quality.</p>
	<p>Unfortunately, it is unknown at this time what Ark actually does in this scenario. Does it reverse the values and select a number in the range 0.9375-1.154? Is it capped to the lower value? Is the capped to the higher value? Wildcard has not responded to my request for information, so this is the way Beacon works for now. Testing appears to produce good results, but some confirmation would be nice.</p>
	<p>This is why Beacon uses quality names instead of allowing users to input values. These numbers can change. The loot source multipliers can change. How we understand the configuration can change. Beacon works on the user’s intentions and attempts to craft a config file to match. As the game changes, Beacon can adapt without anything more than a reexport from the user.</p>
</div>