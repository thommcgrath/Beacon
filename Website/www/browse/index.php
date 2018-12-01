<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Browse Documents');
BeaconTemplate::AddStylesheet('/assets/css/generator.css');

$search_keys = array(
	'public' => true
);

$sort_order = 'download_count DESC';
$limit = 25;
$offset = 0;
$selected_maps = BeaconMaps::All();
$map_operator = 'any';
if (array_key_exists('maps_operator', $_GET) && $_GET['maps_operator'] === 'all') {
	$map_operator = 'all';
}
if (array_key_exists('maps', $_GET)) {
	if (is_array($_GET['maps'])) {
		$map_mask = 0;
		foreach ($_GET['maps'] as $mask) {
			$map_mask = $map_mask | intval($mask);
		}
		$search_keys['map_' . $map_operator] = $map_mask;
		$selected_maps = $map_mask;
	} elseif (is_string($_GET['maps'])) {
		$search_keys['map_' . $map_operator] = intval($_GET['maps']);
		$selected_maps = intval($_GET['maps']);
	}
}
if (array_key_exists('sort', $_GET)) {
	switch ($_GET['sort']) {
	case 'recently_updated':
		$sort_order = 'last_update DESC';
		break;
	case 'most_downloaded':
		$sort_order = 'download_count DESC';
		break;
	}
}
if (array_key_exists('offset', $_GET)) {
	$offset = intval($_GET['offset']);
}
if (array_key_exists('console_safe', $_GET)) {
	$search_keys['console_safe'] = boolval($_GET['console_safe']);
}

$start_time = microtime(true);
$document_count = BeaconDocumentMetadata::Search($search_keys, $sort_order, $limit, $offset, true);
$documents = BeaconDocumentMetadata::Search($search_keys, $sort_order, $limit, $offset, false);
$end_time = microtime(true);

?><h1>Browse Documents</h1>
<div id="search_form">
	<form action="" method="get">
		<table id="options_table">
			<tr>
				<td class="label">Maps</td>
				<td>
					<div class="option_group">
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::TheIsland; ?>" id="map_checkbox_island"<?php if (($selected_maps & BeaconMaps::TheIsland) == BeaconMaps::TheIsland) { echo ' checked'; } ?>><span></span>The Island</label></div>
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::ScorchedEarth; ?>" id="map_checkbox_scorched"<?php if (($selected_maps & BeaconMaps::ScorchedEarth) == BeaconMaps::ScorchedEarth) { echo ' checked'; } ?>><span></span>Scorched Earth</label></div>
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::Aberration; ?>" id="map_checkbox_aberration"<?php if (($selected_maps & BeaconMaps::Aberration) == BeaconMaps::Aberration) { echo ' checked'; } ?>><span></span>Aberration</label></div>
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::Extinction; ?>" id="map_checkbox_aberration"<?php if (($selected_maps & BeaconMaps::Extinction) == BeaconMaps::Extinction) { echo ' checked'; } ?>><span></span>Extinction</label></div>
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::TheCenter; ?>" id="map_checkbox_center"<?php if (($selected_maps & BeaconMaps::TheCenter) == BeaconMaps::TheCenter) { echo ' checked'; } ?>><span></span>The Center</label></div>
						<div><label class="checkbox"><input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::Ragnarok; ?>" id="map_checkbox_ragnarok"<?php if (($selected_maps & BeaconMaps::Ragnarok) == BeaconMaps::Ragnarok) { echo ' checked'; } ?>><span></span>Ragnarok</label></div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">Require</td>
				<td>
					<div class="option_group">
						<div><label class="radio"><input type="radio" name="maps_operator" value="any" id="map_operator_radio_any"<?php if ($map_operator === 'any') { echo ' checked'; } ?>><span></span>Any Selected Map</label></div>
						<div><label class="radio"><input type="radio" name="maps_operator" value="all" id="map_operator_radio_all"<?php if ($map_operator === 'all') { echo ' checked'; } ?>><span></span>All Selected Maps</label></div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">Compatibility</td>
				<td>
					<label class="checkbox"><input type="checkbox" name="console_safe" value="true" id="console_checkbox"<?php if (isset($search_keys['console_safe']) && boolval($search_keys['console_safe'])) { echo ' checked'; } ?>><span></span>Show only console-compatible documents</label>
				</td>
			</tr>
			<tr>
				<td class="label"><label for="sort_menu">Sort By</label></td>
				<td>
					<div class="select"><span></span>
						<select name="sort" id="sort_menu">
							<option value="most_downloaded"<?php if ($sort_order === 'download_count DESC') { echo ' selected'; } ?>>Most Downloaded</option>
							<option value="recently_updated"<?php if ($sort_order === 'last_update DESC') { echo ' selected'; } ?>>Recently Updated</option>
						</select>
					</div>
				</td>
			</tr>
		</table>
		<p class="text-center"><input type="submit" value="Search"></p>
	</form>
</div>
<?php

if ($document_count == 0) {
	echo '<p class="text-center">No documents found</p>';
	exit;
}

if (count($documents) > 0) {
	echo '<table id="browse_results" class="generic">';
	echo '<thead><tr><th>Name</th><th class="low-priority-detail">Downloads</th><th class="low-priority-detail">Updated</th><th class="low-priority-detail">Revision</th></thead><tbody>';
	foreach ($documents as $document) {
		echo '<tr>';
		echo '<td><a href="view.php?document_id=' . urlencode($document->DocumentID()) . '&map_filter=' . $selected_maps . '" class="document_name">' . htmlentities($document->Name()) . '</a><br><span class="document_description">' . htmlentities($document->Description()) . '</span><div class="properties-text">Updated: ' . $document->LastUpdated()->format('M jS, Y g:i A') . ' UTC</div></td>';
		echo '<td class="text-right low-priority-detail">' . number_format($document->DownloadCount()) . '</td>';
		echo '<td class="nowrap text-center low-priority-detail"><time datetime="' . $document->LastUpdated()->format('c') . '">' . $document->LastUpdated()->format('M jS, Y g:i A') . ' UTC</time></td>';
		echo '<td class="text-right low-priority-detail">' . number_format($document->Revision()) . '</td>';
		echo '</tr>';
	}
	echo '</tbody></table>';
}

if ($document_count > count($documents)) {
	// navigation
	if ($offset > 0) {
		$prev = $_GET;
		$prev['offset'] = max($offset - $limit, 0);
		$prev_link = '<a href="?' . http_build_query($prev) . '">&laquo; Previous</a>';
	} else {
		$prev_link = '&laquo; Previous';
	}
	
	if ($offset + $limit < $document_count) {
		$next = $_GET;
		$next['offset'] = $offset + $limit;
		$next_link = '<a href="?' . http_build_query($next) . '">More &raquo;</a>';
	} else {
		$next_link = 'More &raquo;';
	}
	
	echo '<p class="text-center">' . $prev_link . ' ' . $next_link . '</p>';
}

?>