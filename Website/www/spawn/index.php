<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Item Spawn Codes');
BeaconTemplate::AddScript(BeaconCommon::AssetURI('clipboard-polyfill.js'));
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('spawncodes.scss'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('spawncodes.js'));

use BeaconAPI\v4\Ark\{Blueprint, ContentPack};

$id = $_GET['modId'] ?? $_GET['steamId'] ?? $_GET['mod_id'] ?? $_GET['workshop_id'] ?? '';
$pack = null;

if (empty($id) === false) {
	if (BeaconCommon::IsUUID($id) === false && filter_var($id, FILTER_VALIDATE_INT, ['options' => ['min_range' => -9223372036854775808, 'max_range' => 9223372036854775807]]) === false) {
		header('Location: https://www.youtube.com/watch?v=dQw4w9WgXcQ');
		http_response_code(302);
		echo 'caught';
		exit;
	}
	
	$pack = ContentPack::Fetch($id);
	if (is_null($pack)) {
		http_response_code(404);
		echo '<h1>Mod is not registered with Beacon.</h1>';
		echo '<p>If you are the mod owner, see <a href="' . BeaconCommon::AbsoluteURL('/help/registering_your_mod_with_beacon') . '">Registering your mod with Beacon</a> for help.</p>';
		exit;
	}
}

$database = BeaconCommon::Database();
$results = $database->Query("SELECT build_number FROM updates WHERE stage >= 3 ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() == 1) {
	$build = intval($results->Field('build_number'));
} else {
	$build = 0;
}

$filters = [
	'minVersion' => $build,
	'blueprintGroup' => 'engrams,creatures,lootContainers',
	'pageSize' => 50
];
if (isset($_GET['page'])) {
	$page = filter_var($_GET['page'], FILTER_VALIDATE_INT);
	if ($page !== false) {
		$filters['page'] = $page;
	}
}
if (isset($_GET['search'])) {
	$_GET['search'] = strtolower(trim($_GET['search']));
	$filters['label|alternateLabel|classString|path'] = '%' . str_replace('%', '\\%', $_GET['search']) . '%';
}

$results = $database->Query("SELECT MAX(last_update) FROM ark.objects WHERE min_version <= $1;", $build);
$lastDatabaseUpdate = new DateTime($results->Field("max"), new DateTimeZone('UTC'));
$includeModNames = true;

if (is_null($pack)) {
	$filters['contentPackId'] = ContentPack::Search(['isOfficial' => true, 'minVersion' => $build], true);
	$title = 'Ark Spawn Codes';
	$baseUrl = '/spawn/';
} else {
	$filters['contentPackId'] = $pack;
	$title = 'Spawn codes for ' . $pack->Name();
	$includeModNames = false;
	$baseUrl = '/mods/' . urlencode($pack->SteamId()) . '/spawncodes';
}

$results = Blueprint::Search($filters);
$blueprints = $results['results'];
$blueprintCount = $results['totalResults'];
$pageSize = $results['pageSize'];
$pageNum = $results['page'];
$pageCount = $results['pages'];
$rangeStart = min(1 + (($pageNum - 1) * $pageSize), $blueprintCount);
$rangeEnd = min($rangeStart + ($pageSize - 1), $blueprintCount);

$canonicalUrl = BeaconCommon::AbsoluteUrl(BuildPaginationLink($pageNum));
BeaconTemplate::AddHeaderLine('<link href="' . htmlentities($canonicalUrl) . '" rel="canonical">');

?><h1><?php echo htmlentities($title); ?><br><span class="subtitle">Up to date as of <?php echo '<time datetime="' . $lastDatabaseUpdate->format('c') . '">' . $lastDatabaseUpdate->format('F jS, Y') . ' at ' . $lastDatabaseUpdate->format('g:i A') . ' UTC</time>'; ?></span></h1>
<?php if (is_null($pack) || $pack->IsOfficial() === true) { ?><div class="notice-block notice-info">
	<p class="bold">These GFI codes are pretty nuts, do they really work?</p>
	<p>Yes! We've computed the absolute shortest codes to spawn the desired item. They may look weird, but they really do work.</p>
	<p class="italic smaller">Disclaimer: These GFI codes are based on the official Ark content. Mods could conflict with these GFI codes.</p>
</div><?php } ?>
<p><form action="<?php echo htmlentities($baseUrl); ?>" method="get"><input type="search" id="beacon-filter-field" placeholder="Search" autocomplete="off" name="search"></form></p>
<?php

echo '<p>Results ' . htmlentities(number_format($rangeStart)) . ' to ' . htmlentities(number_format($rangeEnd)) . ' of ' . htmlentities(number_format($blueprintCount));
if (empty($_GET['search']) === false) {
	echo ' containing &quot;' . htmlentities($_GET['search']) . '&quot;<br><a href="' . htmlentities($baseUrl) . '">Clear Search</a>';
}
echo '</p>'

?><table id="spawntable" class="generic">
	<thead>
		<tr>
			<td>Item Name</td>
			<td>Spawn Code</td>
			<td>Copy</td>
		</tr>
	</thead>
	<tbody>
	<?php
		
	uasort($blueprints, 'CompareBlueprints');
	
	// get gfi codes
	$engramIds = [];
	$gfiCodes = [];
	foreach ($blueprints as $blueprint) {
		if ($blueprint->ObjectGroup() === 'engrams') {
			$engramIds[] = $blueprint->UUID();
		}
	}
	if (count($engramIds) > 0) {
		$gfiRows = $database->Query("SELECT object_id, gfi FROM ark.engrams WHERE object_id = ANY($1) AND gfi IS NOT NULL;", '{' . implode(',', $engramIds) . '}');
		while (!$gfiRows->EOF()) {
			$gfiCodes[$gfiRows->Field('object_id')] = $gfiRows->Field('gfi');
			$gfiRows->MoveNext();
		}
	}
	
	foreach ($blueprints as $blueprint) {
		$id = $blueprint->UUID();
		$class = $blueprint->ClassString();
		$label = $blueprint->Label();
		$spawn = CreateSpawnCode($blueprint);
		$packName = $blueprint->ContentPackName();
		
		echo '<tr id="spawn_' . htmlentities($id) . '" class="beacon-engram" beacon-label="' . htmlentities(strtolower($label)) . '" beacon-spawn-code="' . htmlentities($spawn) . '" beacon-uuid="' . $id . '">';
		echo '<td>' . htmlentities($label) . ($includeModNames ? '<span class="beacon-engram-mod-name"><br>' . htmlentities($packName) . '</span>' : '') . '<div class="beacon-spawn-code-small source-code-font">' . htmlentities($spawn) . '</div></td>';
		echo '<td class="source-code-font">' . htmlentities($spawn) . '</td>';
		echo '<td><button class="beacon-engram-copy" beacon-uuid="' . htmlentities($id) . '">Copy</button></td>';
		echo '</tr>';
	}
	
	?>
	</tbody>
</table><?php

if ($pageCount > 1) {
	$targetPages = 9;
	if ($pageCount <= $targetPages) {
		$pagesBefore = $pageNum - 1;
		$pagesAfter = $pageCount - $pageNum;
		$lowestPage = 1;
		$highestPage = $pageCount;
	} else {
		$pagesBefore = intval(floor($targetPages / 2));
		$pagesAfter = $pagesBefore;
		$lowestPage = $pageNum - $pagesBefore;
		$highestPage = $pageNum + $pagesAfter;
		
		if ($lowestPage < 1) {
			$overflow = abs($lowestPage - 1);
			$pagesAfter += $overflow;
			$pagesBefore -= $overflow;
			$lowestPage = 1;
			$highestPage = $pageNum + $pagesAfter;	
		} else if ($highestPage > $pageCount) {
			$overflow = $highestPage - $pageCount;
			$pagesBefore += $overflow;
			$pagesAfter -= $overflow;
			$lowestPage = $pageNum - $pagesBefore;
			$highestPage = $pageCount;
		}
	}
	
	$pageLinks = [];
	if ($lowestPage > 1) {
		$pageLinks[] = '<a href="' . htmlentities(BuildPaginationLink(1)) . '" class="pagination-button pagination-text">&laquo; First</a>';
	} else {
		$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
	}
	if ($pageNum > 1) {
		$pageLinks[] = '<a href="'. htmlentities(BuildPaginationLink($pageNum - 1)) . '" class="pagination-button pagination-text">&lsaquo; Previous</a>';
	} else {
		$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
	}
	for ($p = $lowestPage; $p <= $highestPage; $p++) {
		if ($p === $pageNum) {
			$pageLinks[] = '<span class="pagination-button pagination-number pagination-current">' . $p . '</span>';
		} else {
			$pageLinks[] = '<a href="' . htmlentities(BuildPaginationLink($p)) . '" class="pagination-button pagination-number">' . htmlentities($p) . '</a>';
		}
	}
	if ($pageNum < $pageCount) {
		$pageLinks[] = '<a href="'. htmlentities(BuildPaginationLink($pageNum + 1)) . '" class="pagination-button pagination-text">Next &rsaquo;</a>';
	} else {
		$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
	}
	if ($highestPage < $pageCount) {
		$pageLinks[] = '<a href="' . htmlentities(BuildPaginationLink($pageCount)) . '" class="pagination-button pagination-text">Last &raquo;</a>';
	} else {
		$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
	}
	
	echo '<div class="pagination-controls"><div class="pagination-cell">' . implode('</div><div class="pagination-cell">', $pageLinks) . '</div></div>';
}
BeaconTemplate::SetTitle($title);

function CompareBlueprints($left, $right) {
	$left_label = strtolower($left->Label());
	$right_label = strtolower($right->Label());
	if ($left_label === $right_label) {
		return 0;
	}
	
	return ($left_label < $right_label) ? -1 : 1;
}

function CreateSpawnCode(Blueprint $blueprint): string {
	global $gfiCodes;
	
	$classString = $blueprint->ClassString();
	switch ($blueprint->ObjectGroup()) {
	case 'engrams':
		$gfi = $gfiCodes[$blueprint->UUID()] ?? null;
		if (is_null($gfi) === false) {
			return "cheat gfi {$gfi} 1 0 0";
		}
		
		return "cheat giveitem {$classString} 1 0 0";
		break;
	case 'creatures':
		return "cheat spawndino {$classString} 1 1 30";
		break;
	case 'lootContainers':
		return "cheat summon {$classString}";
		break;
	}
}

function BuildPaginationLink(int $pageNum): string {
	global $baseUrl, $urlParams;
	
	$params = array_filter($_GET, function($value, $key) {
		if (empty($value)) {
			return false;
		}
		
		switch ($key) {
		case 'search':
			return true;
		}
		
		return false;
	}, ARRAY_FILTER_USE_BOTH);
	
	$params['page'] = $pageNum;
	ksort($params);
	
	return $baseUrl . '?' . http_build_query($params);
}

?>