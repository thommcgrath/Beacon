<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Browse Projects');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('generator.scss'));

use BeaconAPI\v4\Ark\{Map, Project};

$searchKeys = [
	'published' => 'Approved',
	'pageSize' => 25,
	'page' => 1,
	'sort' => 'downloadCount',
	'direction' => 'DESC',
	'gameId' => 'Ark'
];

$selectedMaps = Map::CombinedMask(Map::Search([], true));
$mapOperator = 'any';
if (array_key_exists('maps_operator', $_GET) && $_GET['maps_operator'] === 'all') {
	$mapOperator = 'all';
}
if (array_key_exists('maps', $_GET)) {
	if (is_array($_GET['maps'])) {
		$mapMask = 0;
		foreach ($_GET['maps'] as $mask) {
			$mapMask = $mapMask | intval($mask);
		}
		$searchKeys["{$mapOperator}Maps"] = $mapMask;
		$selectedMaps = $mapMask;
	} elseif (is_string($_GET['maps'])) {
		$searchKeys["{$mapOperator}Maps"] = intval($_GET['maps']);
		$selectedMaps = intval($_GET['maps']);
	}
}
if (array_key_exists('sort', $_GET)) {
	switch ($_GET['sort']) {
	case 'recently_updated':
		$searchKeys['sort'] = 'lastUpdate';
		break;
	case 'most_downloaded':
		$searchKeys['sort'] = 'downloadCount';
		break;
	}
}
if (isset($_GET['page'])) {
	$page = filter_var($_GET['page'], FILTER_VALIDATE_INT);
	if ($page !== false) {
		$searchKeys['page'] = $page;
	}
} else if (isset($_GET['offset'])) {
	$offset = filter_var($_GET['offset'], FILTER_VALIDATE_INT);
	if ($offset !== false) {
		$searchKeys['page'] = floor($offset / $searchKeys['pageSize']);
	}
}
if (array_key_exists('console_safe', $_GET)) {
	$searchKeys['consoleSafe'] = filter_var($_GET['console_safe'], FILTER_VALIDATE_BOOL);
}

$startTime = microtime(true);
$projectResults = Project::Search($searchKeys);
$endTime = microtime(true);
$projectCount = $projectResults['totalResults'];
$projects = $projectResults['results'];

$maps = Map::Search([], true);
$mapCheckboxes = [];
foreach ($maps as $map) {
	$mapCheckboxes[] = '<div><label class="checkbox"><input type="checkbox" name="maps[]" value="' . $map->Mask() . '" id="map_checkbox_' . $map->Mask() . '"' . (($selectedMaps & $map->Mask()) == $map->Mask() ? ' checked' : '') . '><span></span>' . htmlentities($map->Label()) . '</label></div>';
}

?><h1>Browse Projects</h1>
<div id="search_form" class="separator-color">
	<form action="" method="get">
		<table id="options_table">
			<tr>
				<td class="label">Maps</td>
				<td>
					<div class="option_group">
						<?php echo implode("\n", $mapCheckboxes); ?>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">Require</td>
				<td>
					<div class="option_group">
						<div><label class="radio"><input type="radio" name="maps_operator" value="any" id="map_operator_radio_any"<?php if ($mapOperator === 'any') { echo ' checked'; } ?>><span></span>Any Selected Map</label></div>
						<div><label class="radio"><input type="radio" name="maps_operator" value="all" id="map_operator_radio_all"<?php if ($mapOperator === 'all') { echo ' checked'; } ?>><span></span>All Selected Maps</label></div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="label">Compatibility</td>
				<td>
					<label class="checkbox"><input type="checkbox" name="console_safe" value="true" id="console_checkbox"<?php if (isset($searchKeys['consoleSafe']) && $searchKeys['consoleSafe']) { echo ' checked'; } ?>><span></span>Show only console-compatible projects</label>
				</td>
			</tr>
			<tr>
				<td class="label"><label for="sort_menu">Sort By</label></td>
				<td>
					<div class="select"><span></span>
						<select name="sort" id="sort_menu">
							<option value="most_downloaded"<?php if ($searchKeys['sort'] === 'downloadCount') { echo ' selected'; } ?>>Most Downloaded</option>
							<option value="recently_updated"<?php if ($searchKeys['sort'] === 'lastUpdate') { echo ' selected'; } ?>>Recently Updated</option>
						</select>
					</div>
				</td>
			</tr>
		</table>
		<p class="text-center"><input type="submit" value="Search"></p>
	</form>
</div>
<?php

if ($projectCount == 0) {
	echo '<p class="text-center">No projects found</p>';
	exit;
}

if (count($projects) > 0) {
	echo '<p>Found ' . number_format($projectCount) . ' projects</p>';
	echo '<table id="browse_results" class="generic">';
	echo '<thead><tr><th>Name</th><th class="low-priority">Downloads</th><th class="low-priority">Updated</th><th class="low-priority">Revision</th></thead><tbody>';
	foreach ($projects as $project) {
		echo '<tr>';
		echo '<td><a href="' . urlencode($project->ProjectId()) . '?map_filter=' . $selectedMaps . '" class="document_name">' . htmlentities($project->Title()) . '</a><br><span class="document_description">' . htmlentities($project->Description()) . '</span><div class="row-details"><span class="detail">Updated: ' . $project->LastUpdated()->format('M jS, Y g:i A') . ' UTC</span></div></td>';
		echo '<td class="text-right low-priority">' . number_format($project->DownloadCount()) . '</td>';
		echo '<td class="nowrap text-center low-priority"><time datetime="' . $project->LastUpdated()->format('c') . '">' . $project->LastUpdated()->format('M jS, Y g:i A') . ' UTC</time></td>';
		echo '<td class="text-right low-priority">' . number_format($project->Revision()) . '</td>';
		echo '</tr>';
	}
	echo '</tbody></table>';
}

if ($projectCount > count($projects)) {
	// navigation
	if ($projectResults['page'] > 1) {
		$prev = $_GET;
		$prev['page'] = max($projectResults['page'] - 1, 1);
		$prev_link = '<a href="?' . http_build_query($prev) . '">&laquo; Previous</a>';
	} else {
		$prev_link = '&laquo; Previous';
	}
	
	if ($projectResults['page'] < $projectResults['pages']) {
		$next = $_GET;
		$next['page'] = min($projectResults['page'] + 1, $projectResults['pages']);
		$next_link = '<a href="?' . http_build_query($next) . '">More &raquo;</a>';
	} else {
		$next_link = 'More &raquo;';
	}
	
	echo '<p class="text-center">' . $prev_link . ' ' . $next_link . '</p>';
}

?>