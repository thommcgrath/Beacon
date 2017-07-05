<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('The ConfigOverrideSupplyCrateItems Spec');
?><h1 id="arklootoverrides">Ark Loot Overrides</h1>
<p>The information in this document is gathered from all over the community, discussions with users, and pulled from the dev kit.</p>
<p>Below are the three object specifications for the ConfigOverrideSupplyCrateItems command line option. All keys are optional, except where it doesn't make sense to omit, such as the keys which actually specify items. When a key is omitted, the default value will be used.</p>
<h2 id="lootsourceobject">Loot Source Object</h2>
<ul>
	<li><strong>SupplyCrateClassString</strong> specifies which loot source is being edited.</li>
	<li><strong>MinItemSets</strong> and <strong>MaxItemSets</strong> specifies the number of item sets to be selected.<br>Range: Number<em>Of</em>Item_Sets >= MaxItemSets >= MinItemSets >= 1<br>Default: 1</li>
	<li><strong>NumItemSetsPower</strong> is mostly unknown. According to Wildcard, this should be left at 1.0<br>Default: 1.0</li>
	<li><strong>bSetsRandomWithoutReplacement</strong> when set to true, instructs the loot engine to select an item set no more than once.<br>Default: true</li>
	<li><strong>ItemSets</strong> is an array of item set objects.</li>
</ul>
<h2 id="itemsetobject">Item Set Object</h2>
<ul>
	<li><strong>SetName</strong> is a cosmetic name not used in-game, but recognized by the Ark Dev Kit and Beacon.<br>Default: ""</li>
	<li><strong>MinNumItems</strong> and <strong>MaxNumItems</strong> works much the same as MinItemSets and MaxItemSets from the loot source object.<br>Range: Number_Of_Set_Entries >= MinNumItems >= MaxNumItems >= 1<br>Default: 1</li>
	<li><strong>NumItemsPower</strong> should also be kept at 1.0.<br>Default 1.0</li>
	<li><strong>SetWeight</strong> a percentage chance of the item set being selected. Ideally, the weights of all item sets in a loot source should sum to 1.0. However, this is not strictly necessary. Three item sets with equal weights will have an equal chance of selection.<br>Range: 1.0 >= SetWeight > 0.0<br>Default: equal weights for all sets</li>
	<li><strong>bItemsRandomWithoutReplacement</strong> is just like bSetsRandomWithoutReplacement in that a set entry will not be selected more than once <em>in this item set</em> when set to true. However, two item sets with similar items can cause duplicates if each item set is chosen.<br>Default: true</li>
	<li><strong>ItemEntries</strong> is an array of set entry objects.</li>
</ul>
<h2 id="setentryobject">Set Entry Object</h2>
<ul>
	<li><strong>EntryWeight</strong> works just like SetWeight.<br>Default: equal weight for all entries.</li>
	<li><strong>Items</strong> is an array of Blueprint-generated classes. See &quot;<a href="#engramspecifiers">Engram Specifiers</a>&quot; below.</li>
	<li><strong>ItemClassStrings</strong> is an array of class strings. See &quot;<a href="#engramspecifiers">Engram Specifiers</a>&quot; below.</li>
	<li><strong>ItemsWeights</strong> is not a typo. For each item in Items or ItemClassStrings, a weight may be specified. Works just like EntryWeight and SetWeight.<br>Default: equal weight for all items.</li>
	<li><strong>MinQuality</strong> and <strong>MaxQuality</strong> specifies the numeric quality multiplier to apply to the item. Ark always add its own random multiplier, so this range is not strictly followed.<br>Range: MaxQuality >= MinQuality > 0<br>Default: 0.0</li>
	<li><strong>MinQuantity</strong> and <strong>MaxQuantity</strong> is the number of items to create. See &quot;<a href="#quantitynotes">Quantity Notes</a>&quot; below.<br>Default: 1.0</li>
	<li><strong>bForceBlueprint</strong> will cause the loot engine to create blueprints instead of actual items when set to true.<br>Default: false</li>
	<li><strong>ChanceToActuallyGiveItem</strong> is a percentage chance to create an actual item instead of a blueprint, when bForceBlueprint is false. See &quot;<a href="#blueprintchances">Blueprint Chances</a>&quot; below.<br>Default: 1.0</li>
	<li><strong>ChanceToBeBlueprintOverride</strong> is a percent chance to create a blueprint instead of an actual item, when bForceBlueprint is false. See &quot;<a href="#blueprintchances">Blueprint Chances</a>&quot; below.<br>Default: 0.0</li>
</ul>
<h3 id="engramspecifiers">Engram Specifiers</h3>
<p>There are two keys to specify items: Items and ItemClassStrings. Only one should be used at a time. Each have advantages and disadvantages. For this example, we're going to talk about Stone, which has a blueprint path of </p>
<pre class="code">/Game/PrimalEarth/CoreBlueprints/Resources/PrimalItemResource_Stone.PrimalItemResource_Stone</pre>
<p>ItemClassStrings uses an array of class strings, which are the &quot;tail&quot; of the blueprint, with a &quot;_C&quot; appended. So in this example, the class string for Stone is &quot;PrimalItemResource_Stone_C&quot;. This is the option that was provided to the community when the loot overrides were first introduced. When using mods however, it has the disadvantage of not being unique. For example, the Smithy from the Smithy+ mod and Structures+ mod both use the same class string. For a server with both mods installed, it is undefined which one will be selected. Ark seems to always pick the same one, so load order might be important, but it is still difficult to predict.</p>
<p>Items uses an array of Blueprint-generated classes. These are the full blueprint path, with a &quot;BlueprintGeneratedClass&quot; prefix, and &quot;_C&quot; suffix. So in this example, the Blueprint-generated class for Stone is </p>
<pre class="code">BlueprintGeneratedClass'/Game/PrimalEarth/CoreBlueprints/Resources/PrimalItemResource_Stone.PrimalItemResource_Stone_C'</pre>
<p>Note that using a &quot;regular&quot; blueprint is NOT acceptable in this scenario. Using a full path allows Ark to always generate the intended loot. However, using this option has a few problems, which is why Beacon has stopped using it. While this works fine on dedicated servers, it often seems to crash the Ark client when used locally. The theory is that BlueprintGeneratedClass creates an instance of the class immediately. But since the Ark client loads some content on-demand, such as mod and DLC content, the items simply don't exist in memory when the Game.ini file is loaded. Class strings appear to resolve on-demand instead of at load, which makes them more reliable for single player.</p>
<p>Interestingly, the default loot tables use the Items key and Blueprint-generated classes. For example, find</p>
<pre class="code">/Game/PrimalEarth/Structures/SupplyCrate_Level03</pre>
<p>This is the object that gets altered when SupplyCrateClassString is set to SupplyCrate_Level03_C. If you open this up, you should see the familiar &quot;Item Sets&quot; key which we override with the Game.ini file. There is also &quot;Item Sets Override&quot; which points to an object containing the default loot. In this case, it points to </p>
<pre class="code">/Game/PrimalEarth/CoreBlueprints/ItemLootSets/LootItemSets_SupplyDrop_Level03.</pre>
<p>When opening that item, it has a single &quot;Item Sets&quot; key with a number of item sets. Right-click any of them, copy, and paste into a text editor. The structure is identical to the item set configuration we know. Except it uses the Items key instead of ItemClassStrings. There are also various other keys added or omitted.</p>
<h3 id="quantitynotes">Quantity Notes</h3>
<p>Quantities are not what most users expect. Ark will create a brand-new item for each value in a quantity. For example, if MinQuantity and MaxQuantity are both 2, ark will create 2 items from scratch. That means 2 quality selections, 2 item selections, 2 blueprint chances, and so on.</p>
<p>For developers, this process would look something like the following psuedo-code:</p>
<pre class="code">Quantity = RandomInRange(MinQuantity, MaxQuantity)
For I = 1 To Quantity {
    Item = RandomFromSet(ItemClassStrings)
    Quality = RandomInRange(MinQuality, MaxQuality)
    IsBlueprint = bForceBlueprint Or RandomInRange(0.0, 1.0) &gt; ChanceToBeBlueprintOverride
}
</pre>
<p>This means that if a blueprint is a possibility, and quantity is more than 1, there could be multiple blueprints generated.</p>
<h3 id="blueprintchances">Blueprint Chances</h3>
<p>Both ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to do the same thing, and for the most part, they do. One is merely an inverse of the other.</p>
<p>So why do both exist? Possibly because of sloppy development. The default loot tables use ChanceToActuallyGiveItem instead of ChanceToBeBlueprintOverride. But ChanceToBeBlueprintOverride is the one demonstrated to the community in the <a href="http://steamcommunity.com/app/346110/discussions/10/350532536100692514/">242 release notes</a>. It is unclear which is correct, better to use, takes precedent, and so on. So to play it safe, Beacon generates both.</p>