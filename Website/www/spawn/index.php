<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Item Spawn Codes');
BeaconTemplate::AddScript(BeaconCommon::AssetURI('clipboard-polyfill.js'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('spawncodes.js'));
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('spawncodes.scss'));
$mod_id = array_key_exists('mod_id', $_GET) ? $_GET['mod_id'] : null;
$database = BeaconCommon::Database();

if (is_null($mod_id) == false) {
	if (BeaconCommon::IsUUID($mod_id) == false) {
		header('Location: https://www.youtube.com/watch?v=dQw4w9WgXcQ');
		http_response_code(302);
		echo 'caught';
		exit;
	}
} elseif (isset($_GET['workshop_id'])) {
	$workshop_id = $_GET['workshop_id'];
	if (is_null(filter_var($workshop_id, FILTER_VALIDATE_INT, ['options' => ['min_range' => -2147483648, 'max_range' => 2147483647], 'flags' => FILTER_NULL_ON_FAILURE]))) {
		header('Location: https://www.youtube.com/watch?v=dQw4w9WgXcQ');
		http_response_code(302);
		exit;
	}
	
	$mod = BeaconMod::GetByConfirmedWorkshopID($workshop_id);
	if (is_array($mod) && count($mod) == 1) {
		$mod_id = $mod[0]->ModID();
	} else {
		echo '<h1>Mod is not registered with Beacon.</h1>';
		echo '<p>If you are the mod owner, see <a href="' . BeaconCommon::AbsoluteURL('/read/f21f4863-8043-4323-b6df-a9f96bbd982c') . '">Registering your mod with Beacon</a> for help.</p>';
		exit;
	}
}

$results = $database->Query("SELECT build_number FROM updates ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() == 1) {
	$build = intval($results->Field('build_number'));
} else {
	$build = 0;
}

$results = $database->Query("SELECT MAX(last_update) FROM objects WHERE min_version <= $1;", array($build));
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));
$include_mod_names = true;
$cache_key = 'spawn_' . (is_null($mod_id) ? 'all' : $mod_id) . '_' . $build . '_' . $last_database_update->format('U');

$cached = BeaconCache::Get($cache_key);
$title = BeaconCache::Get($cache_key . '_title');
if (is_null($cached) || is_null($title)) {
	ob_start();
	if ($mod_id === null) {
		$title = 'All Spawn Codes';
		$engrams = BeaconEngram::GetAll();
		$creatures = BeaconCreature::GetAll();
	} else {
		$engrams = BeaconEngram::Get($mod_id);
		$creatures = BeaconCreature::Get($mod_id);
		$mod_names = array();
		foreach ($engrams as $engram) {
			if (in_array($engram->ModName(), $mod_names) === false) {
				$mod_names[] = $engram->ModName();
			}
		}
		foreach ($creatures as $creature) {
			if (in_array($creature->ModName(), $mod_names) === false) {
				$mod_names[] = $creature->ModName();
			}
		}
		asort($mod_names);
		
		if (count($mod_names) == 0) {
			echo 'Mod is not registered with Beacon.';
			exit;
		} elseif (count($mod_names) == 1) {
			$title = $mod_names[0];
			$include_mod_names = false;
		} elseif (count($mod_names) == 2) {
			$title = $mod_names[0] . ' and ' . $mod_names[1];
		} else {
			$last = array_pop($mod_names);
			$title = implode(', ', $mod_names) . ', and ' . $last;
		}
		$title = 'Spawn codes for ' . $title;
	}
	?><h1><?php echo htmlentities($title); ?><br><span class="subtitle">Up to date as of <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?></span></h1>
	<p><input type="search" id="beacon-filter-field" placeholder="Filter Engrams" autocomplete="off"></p>
	<table id="spawntable" class="generic">
		<thead>
			<tr>
				<td>Item Name</td>
				<td>Spawn Code</td>
				<td>Copy</td>
			</tr>
		</thead>
		<tbody>
		<?php
			
		$blueprints = array_merge($engrams, $creatures);
		uasort($blueprints, 'CompareBlueprints');
		
		foreach ($blueprints as $blueprint) {
			$id = $blueprint->ObjectID();
			$class = $blueprint->ClassString();
			$label = $blueprint->Label();
			$spawn = $blueprint->SpawnCode();
			$mod = $blueprint->ModName();
			
			echo '<tr id="spawn_' . htmlentities($id) . '" class="beacon-engram" beacon-label="' . htmlentities(strtolower($label)) . '" beacon-spawn-code="' . htmlentities($spawn) . '" beacon-uuid="' . $id . '">';
			echo '<td>' . htmlentities($label) . ($include_mod_names ? '<span class="beacon-engram-mod-name"><br>' . htmlentities($mod) . '</span>' : '') . '<div class="beacon-spawn-code-small source-code-font">' . htmlentities($spawn) . '</div></td>';
			echo '<td class="source-code-font">' . htmlentities($spawn) . '</td>';
			echo '<td><button class="beacon-engram-copy" beacon-uuid="' . htmlentities($id) . '">Copy</button></td>';
			echo '</tr>';
		}
		
		?>
		</tbody>
	</table><?php
	$cached = ob_get_contents();
	ob_end_clean();
	BeaconCache::Set($cache_key, $cached);
	BeaconCache::Set($cache_key . '_title', $title);
}
echo $cached;
BeaconTemplate::SetTitle($title);

function CompareBlueprints($left, $right) {
	$left_label = strtolower($left->Label());
	$right_label = strtolower($right->Label());
	if ($left_label === $right_label) {
		return 0;
	}
	
	return ($left_label < $right_label) ? -1 : 1;
}

?>