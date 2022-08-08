<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Mods');

$mods = \Ark\Mod::GetLive();

?><h1>Supported Mods</h1>
<p>Beacon supports mods, both officially and unofficially! This page lists the Ark mods that Beacon already supports. If you want to add mod items to your own copy of Beacon, <a href="/read.php/5b5b15bf-6540-44cd-8a7c-5ad34e92eeba">here's how</a>. If you are a mod developer and want to add your mod to Beacon for all users to enjoy, <a href="/read.php/f21f4863-8043-4323-b6df-a9f96bbd982c">it's pretty simple</a>.</p>
<table class="generic">
	<thead>
		<th>Mod</th>
		<th>Workshop ID</th>
	</thead>
	<tbody>
		<?php foreach ($mods as $mod) { ?><tr>
			<td><a href="/mods/<?php echo abs($mod->WorkshopID()); ?>"><?php echo htmlentities($mod->Name()); ?></a></td>
			<td><a href="<?php echo BeaconWorkshopItem::URLForModID($mod->WorkshopID()); ?>"><?php echo abs($mod->WorkshopID()); ?></a></td>
		</tr><?php } ?>
	</tbody>
</table>