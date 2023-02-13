<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Ark\{Blueprint, ContentPack};
$id = $_GET['modId'] ?? $_GET['steamId'] ?? $_GET['mod_id'] ?? $_GET['workshop_id'] ?? '';
$view = $_GET['view'] ?? 'engrams';
$viewNames = [
	'engrams' => 'Engrams',
	'creatures' => 'Creatures',
	'lootContainers' => 'Loot Containers',
	'spawnPoints' => 'Spawn Points'
];
$pack = ContentPack::Fetch($id);
if (is_null($pack) || array_key_exists($view, $viewNames) === false) {
	http_response_code(404);
	echo '<h1>Mod Not Found</h1><p>The mod may have been deleted. Hopefully not though.</p>';
	exit;
}

$baseUrl = '/mods/' . $pack->SteamId();
$canonical = $baseUrl . '/' . $view;

$viewUrls = [];
foreach ($viewNames as $viewName => $label) {
	$viewUrls[$viewName] = $baseUrl . '/' . $viewName;
}

$page = $_GET['page'] ?? 1;

$filters = [
	'contentPackId' => $pack->ContentPackId(),
	'blueprintGroup' => $view,
	'page' => $page,
	'pageSize' => 50
];

$queryParams = [];
$siblingParams = [];
if ($page > 1) {
	$queryParams['page'] = $page;
}

$search = strtolower(trim($_GET['search'] ?? ''));
if (empty($search) === false) {
	$queryParams['search'] = $search;
	$siblingParams['search'] = $search;
	$filters['label|alternateLabel|path|class'] = '%' . str_replace('%', '\\%', $search) . '%';
}

if (count($queryParams) > 0) {
	ksort($queryParams);
	$canonical .= '?' . http_build_query($queryParams);
}

if (count($siblingParams) > 0) {
	ksort($siblingParams);
	$ext = '?' . http_build_query($siblingParams);
	foreach ($viewUrls as $viewName => $viewUrl) {
		$viewUrls[$viewName] .= $ext;
	}
}

BeaconTemplate::AddHeaderLine('<link rel="canonical" href="' . htmlentities($canonical) . '">');

$pageContents = Blueprint::Search($filters);
$resultCount = $pageContents['totalResults'];
$page = $pageContents['page'];
$pageSize = $pageContents['pageSize'];
$pageCount = $pageContents['pages'];
$rangeStart = min(1 + (($page - 1) * $pageSize), $resultCount);
$rangeEnd = min($rangeStart + ($pageSize - 1), $resultCount);

BeaconTemplate::SetTitle('Mod: ' . $pack->Name());
BeaconTemplate::SetPageDescription('Beacon has built-in support for the Ark mod "' . $pack->Name() . '" which means its engrams are already part of Beacon\'s database so you can begin using them immediately.');
//$engrams = Engram::Search($filters, true);
//$lootContainers = LootContainer::Search($filters, true);
//$creatures = Creature::Search($filters, true);
//$configOptions = ConfigOption::Search($filters, true);
//$spawnPoints = SpawnPoint::Search($filters, true);
//$hasEngrams = count($engrams) > 0;
//$hasLootContainers = count($lootContainers) > 0;
//$hasCreatures = count($creatures) > 0;
//$hasConfigOptions = false;//count($configOptions) > 0;
//$hasSpawnPoints = count($spawnPoints) > 0;
$hasSomething = true;//$hasEngrams || $hasLootContainers || $hasCreatures || $hasConfigOptions || $hasSpawnPoints;

?><h1><?php echo htmlentities($pack->Name()); ?></h1>
<p>Beacon has built-in support for <a href="<?php echo htmlentities($pack->SteamUrl()); ?>"><?php echo htmlentities($pack->Name()); ?></a>. This means its engrams are already part of Beacon's database and you can begin using them immediately.</p>
<p><form action="<?php echo htmlentities($baseUrl . '/' . $view); ?>" method="get"><input type="search" id="beacon-filter-field" placeholder="Search" autocomplete="off" name="search" value="<?php echo htmlentities($search); ?>"></form></p>
<div class="page-panel" id="panel-blueprints">
	<div class="page-panel-nav">
		<ul>
			<?php
			foreach ($viewUrls as $viewName => $viewUrl) {
				echo '<li' . ($viewName === $view ? ' class="page-panel-active"' : '') . '><a href="' . htmlentities($viewUrl) . '" page="' . htmlentities($viewName) . '">' . htmlentities($viewNames[$viewName]) . '</a></li>';
			}
			?>
		</ul>
	</div>
	<div class="page-panel-pages">
	<div class="page-panel-page page-panel-visible" page="<?php echo htmlentities($view); ?>">
		<?php
		
		if ($pageContents['totalResults'] === 0) {
			echo '<p>';
			if (empty($search)) {
				echo htmlentities($pack->Name()) . ' does not appear to proide any ' . htmlentities($viewNames[$view]) . ' to Beacon.';
			} else {
				echo 'Did not find any ' . htmlentities(strtolower($viewNames[$view])) . ' matching &quot;' . htmlentities($search) . '&quot; in ' . htmlentities($pack->Name());
				echo '</p><p class="text-center"><a href="' . htmlentities($baseUrl . '/' . $view) . '">Clear Search</a>';
			}
			echo '</p>';
		} else {
			echo '<p>Results ' . htmlentities(number_format($rangeStart)) . ' to ' . htmlentities(number_format($rangeEnd)) . ' of ' . htmlentities(number_format($resultCount));
			if (empty($search) === false) {
				echo ' containing &quot;' . htmlentities($search) . '&quot;<br><a href="' . htmlentities($baseUrl . '/' . $view) . '">Clear Search</a>';
			}
			echo '</p>';
			
			echo '<table class="generic">';
			echo '<thead>';
			echo '<tr><th>Name</th><th class="low-priority">Class</th></tr>';
			echo '</thead>';
			echo '<tbody>';
			foreach ($pageContents['results'] as $result) {
				echo '<tr><td><a href="/object/' . $result->UUID() . '">' . htmlentities($result->Label()) . '</a><div class="row-details">Class: ' . htmlentities($result->ClassString()) . '</div></td><td class="low-priority break-code">' . htmlentities($result->ClassString()) . '</td></tr>';
			}
			echo '</tbody>';
			echo '</table>';
			
			if ($pageCount > 1) {
				$targetPages = 9;
				if ($pageCount <= $targetPages) {
					$pagesBefore = $page - 1;
					$pagesAfter = $pageCount - $page;
					$lowestPage = 1;
					$highestPage = $pageCount;
				} else {
					$pagesBefore = intval(floor($targetPages / 2));
					$pagesAfter = $pagesBefore;
					$lowestPage = $page - $pagesBefore;
					$highestPage = $page + $pagesAfter;
					
					if ($lowestPage < 1) {
						$overflow = abs($lowestPage - 1);
						$pagesAfter += $overflow;
						$pagesBefore -= $overflow;
						$lowestPage = 1;
						$highestPage = $page + $pagesAfter;	
					} else if ($highestPage > $pageCount) {
						$overflow = $highestPage - $pageCount;
						$pagesBefore += $overflow;
						$pagesAfter -= $overflow;
						$lowestPage = $page - $pagesBefore;
						$highestPage = $pageCount;
					}
				}
				
				$pageLinks = [];
				if ($lowestPage > 1) {
					$pageLinks[] = '<a href="' . htmlentities(BuildPaginationLink(1)) . '" class="pagination-button pagination-text">&laquo; First</a>';
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				if ($page > 1) {
					$prevUrl = BuildPaginationLink($page - 1);
					$pageLinks[] = '<a href="'. htmlentities($prevUrl) . '" class="pagination-button pagination-text">&lsaquo; Previous</a>';
					BeaconTemplate::AddHeaderLine('<link rel="prev" href="' . htmlentities($prevUrl) . '">');
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				for ($p = $lowestPage; $p <= $highestPage; $p++) {
					if ($p === $page) {
						$pageLinks[] = '<span class="pagination-button pagination-number pagination-current">' . $p . '</span>';
					} else {
						$pageLinks[] = '<a href="' . htmlentities(BuildPaginationLink($p)) . '" class="pagination-button pagination-number">' . htmlentities($p) . '</a>';
					}
				}
				if ($page < $pageCount) {
					$nextUrl = BuildPaginationLink($page + 1);
					$pageLinks[] = '<a href="'. htmlentities($nextUrl) . '" class="pagination-button pagination-text">Next &rsaquo;</a>';
					BeaconTemplate::AddHeaderLine('<link rel="next" href="' . htmlentities($nextUrl) . '">');
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
		}
		?>
	</div>
</div>
<?php

function BuildPaginationLink(int $page): string {
	global $baseUrl, $view, $queryParams;
	$queryParams['page'] = $page;
	return $baseUrl . '/' . $view . '?' . http_build_query($queryParams);
}

?>
