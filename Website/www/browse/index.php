<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Browse Documents');

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

$start_time = microtime(true);
$document_count = BeaconDocumentMetadata::Search($search_keys, $sort_order, $limit, $offset, true);
$documents = BeaconDocumentMetadata::Search($search_keys, $sort_order, $limit, $offset, false);
$end_time = microtime(true);
echo '<!-- Query took ' . number_format($end_time - $start_time, 4) . ' seconds -->';

?><h1>Browse Documents</h1>
<form action="" method="get">
	<p>
		<input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::TheIsland; ?>" id="map_checkbox_island"<?php if (($selected_maps & BeaconMaps::TheIsland) == BeaconMaps::TheIsland) { echo ' checked'; } ?>> <label for="map_checkbox_island">The Island</label><br>
		<input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::ScorchedEarth; ?>" id="map_checkbox_scorched"<?php if (($selected_maps & BeaconMaps::ScorchedEarth) == BeaconMaps::ScorchedEarth) { echo ' checked'; } ?>> <label for="map_checkbox_scorched">Scorched Earth</label><br>
		<input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::Aberration; ?>" id="map_checkbox_aberration"<?php if (($selected_maps & BeaconMaps::Aberration) == BeaconMaps::Aberration) { echo ' checked'; } ?>> <label for="map_checkbox_aberration">Aberration</label><br>
		<input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::TheCenter; ?>" id="map_checkbox_center"<?php if (($selected_maps & BeaconMaps::TheCenter) == BeaconMaps::TheCenter) { echo ' checked'; } ?>> <label for="map_checkbox_center">The Center</label><br>
		<input type="checkbox" name="maps[]" value="<?php echo BeaconMaps::Ragnarok; ?>" id="map_checkbox_ragnarok"<?php if (($selected_maps & BeaconMaps::Ragnarok) == BeaconMaps::Ragnarok) { echo ' checked'; } ?>> <label for="map_checkbox_ragnarok">Ragnarok</label><br>
		<hr>
		<input type="radio" name="maps_operator" value="any" id="map_operator_radio_any"<?php if ($map_operator === 'any') { echo ' checked'; } ?>> <label for="map_operator_radio_any"> Any Selected Map</label><br>
		<input type="radio" name="maps_operator" value="all" id="map_operator_radio_all"<?php if ($map_operator === 'all') { echo ' checked'; } ?>> <label for="map_operator_radio_all"> All Selected Maps</label>
	</p>
	<p>
		<label for="sort_menu">Sort By</label> <select name="sort" id="sort_menu">
			<option value="most_downloaded"<?php if ($sort_order === 'download_count DESC') { echo ' selected'; } ?>>Most Downloaded</option>
			<option value="recently_updated"<?php if ($sort_order === 'last_update DESC') { echo ' selected'; } ?>>Recently Updated</option>
		</select>
	</p>
	<p><input type="submit" value="Search"></p>
</form>
<?php

if ($document_count == 0) {
	echo '<p class="text-center">No documents found</p>';
	exit;
}

if (count($documents) > 0) {
	echo '<table id="browse_results" class="generic">';
	echo '<thead><tr><td>Name</td><td>Downloads</td><td>Updated</td><td>Revision</td></thead>';
	foreach ($documents as $document) {
		echo '<tr>';
		echo '<td><a href="view.php?document_id=' . urlencode($document->DocumentID()) . '&map_filter=' . $selected_maps . '" class="document_name">' . htmlentities($document->Name()) . '</a><br><span class="document_description">' . htmlentities($document->Description()) . '</span></td>';
		echo '<td class="text-right">' . number_format($document->DownloadCount()) . '</td>';
		echo '<td class="nowrap"><time datetime="' . $document->LastUpdated()->format('c') . '">' . $document->LastUpdated()->format('M jS, Y g:i A') . ' UTC</time></td>';
		echo '<td class="text-right">' . number_format($document->Revision()) . '</td>';
		echo '</tr>';
	}
	echo '</table>';
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