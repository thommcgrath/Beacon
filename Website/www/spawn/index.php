<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
//ZirconTemplate::SetTitle('Item Spawn Codes');
//ZirconTemplate::AddHeaderLine('<script src="assets/spawncodes.js"></script>');
//ZirconTemplate::AddHeaderLine('<link rel="stylesheet" href="assets/beacon.css" type="text/css">');
$mod_id = BeaconAPI::ObjectID();
$database = BeaconCommon::Database();

$results = $database->Query("SELECT build_number FROM updates ORDER BY build_number DESC LIMIT 1;");
$build   = $results->Field('build_number');

$results = $database->Query("SELECT MAX(last_update) FROM updatable_objects WHERE min_version IS NULL OR min_version <= $1;", array($build));
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));

if ($mod_id === null) {
	$title = 'All Spawn Codes';
	$engrams = BeaconEngram::GetAll();
} else {
	$engrams = BeaconEngram::GetByModID($mod_id);
	$mod_names = array();
	foreach ($engrams as $engram) {
		if (in_array($engram->ModName(), $mod_names) === false) {
			$mod_names[] = $engram->ModName();
		}
	}
	$mod_names = asort($mod_names);
	
	if (count($mod_names) == 0) {
		echo 'Mod is not registered with Beacon.';
		exit;
	} elseif (count($mod_names) == 1) {
		$title = $mod_names[0];
	} elseif (count($mod_names) == 2) {
		$title = $mod_names[0] . ' and ' . $mod_names[1];
	} else {
		$last = array_pop($mod_names);
		$title = implode(', ', $mod_names) . ', and ' . $last;
	}
	$title = 'Spawn codes for ' . $title;
}
?><div class="articleheader">
	<h1><?php echo htmlentities($title); ?></h1>
	<p>Up to date as of <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?></p>
</div>
<div class="articlebody">
	<p><input type="search" id="beacon-filter-field" placeholder="Filter Engrams" autocomplete="off"></p>
	<table id="spawncodes" class="generic_table">
		<thead>
			<tr>
				<td>Item Name</td>
				<td width="250">Spawn Code</td>
				<td width="100">Copy</td>
			</tr>
		</thead>
		<tbody>
		<?php
		
		foreach ($engrams as $engram) {
			$class = $engram->ClassString();
			$label = $engram->Label();
			$spawn = $engram->SpawnCode();
			echo '<tr class="beacon-engram" beacon-label="' . htmlentities(strtolower($label)) . '"><td>' . htmlentities($label) . '</td><td><input type="text" class="beacon-spawn-code" id="spawn_' . htmlentities(strtolower($class)) . '" value="' . htmlentities($spawn) . '" readonly></td><td class="text-center"><button class="beacon-engram-copy" beacon-class="' . htmlentities($class) . '">Copy</button></tr>';
		}
		
		?>
		</tbody>
	</table>
</div>