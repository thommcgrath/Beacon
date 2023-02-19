<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Ark\{Blueprint, ContentPack};

$mod = null;
$tagHuman = '';

$tag = strtolower(trim($_GET['tag'] ?? ''));
$modSteamId = filter_var($_GET['steamId'] ?? null, FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
$page = filter_var($_GET['page'] ?? 1, FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
$search = strtolower(trim($_GET['search'] ?? ''));
$group = $_GET['group'] ?? 'engrams';

$groupHumanNames = [
	'engrams' => 'Engrams',
	'creatures' => 'Creatures',
	'lootDrops' => 'Loot Drops',
	'spawnPoints' => 'Spawn Points'
];

if (array_key_exists($group, $groupHumanNames) === false) {
	$group = 'engrams';
}

$filters = [
	'page' => $page,
	'pageSize' => 50,
	'blueprintGroup' => $group
];
$queryParams = [];

if (empty($modSteamId) === false) {
	$mod = ContentPack::Fetch($modSteamId);
	if (is_null($mod)) {
		http_response_code(404);
		echo '<h1>Mod Not Found</h1><p>The mod may have been deleted. Hopefully not though.</p>';
		exit;
	}
	$filters['contentPackId'] = $mod->ContentPackId();
}

if (empty($tag) === false) {
	$filters['tag'] = $tag;
	$tagHuman = ucwords(str_replace('_', ' ', $tag));
}

if (empty($search) === false) {
	$filters['label|alternateLabel|path|class'] = '%' . str_replace('%', '\\%', $search) . '%';
	$queryParams['search'] = $search;
}

if (empty($modSteamId)) {
	if (empty($tag)) {
		$baseUrl = '/objects/{{group}}';
		$pageTitle = 'Ark ' . $groupHumanNames[$group] . ' List';
		$pageDescriptionPlain = "This is the master list of all objects in Ark that Beacon knows about.";
		$pageDescriptionHtml = $pageDescriptionPlain;
	} else {
		$baseUrl = '/tags/' . urlencode($tag) . '/{{group}}';
		$pageTitle = 'Ark ' . $groupHumanNames[$group] . ' Tagged "' . $tagHuman . '"';
		$pageDescriptionPlain = 'These Ark objects have the "' . $tagHuman . '" tag.';
		$pageDescriptionHtml = htmlentities($pageDescriptionPlain);
	}
} else {
	if (empty($tag) === false) {
		$queryParams['tag'] = $tag;
	}
	
	$baseUrl = '/mods/' . $modSteamId . '/{{group}}';
	$pageTitle = $groupHumanNames[$group] . ' From ' . $mod->Name();
	
	$modSteamUrl = htmlentities($mod->SteamUrl());
	$modSteamId = urlencode($mod->SteamId());
	$modName = htmlentities($mod->Name());
	
	$pageDescriptionPlain = "Beacon has built-in support for {$modName}. This means its engrams are already part of Beacon's database and you can begin using them immediately.";
	$pageDescriptionHtml = "Beacon has built-in support for <a href=\"{$modSteamUrl}\">{$modName}</a>. This means its engrams are already part of Beacon's database and you can begin using them immediately. We also have a full list of <a href=\"/mods/{$modSteamId}/spawncodes\">spawn codes for {$modName}</a>.";
}

$groupUrls = [];
foreach ($groupHumanNames as $groupName => $groupHumanName) {
	$groupUrls[$groupName] = BuildUrl($baseUrl, $groupName, $queryParams, 1);
}

BeaconTemplate::AddHeaderLine('<link rel="canonical" href="' . BuildUrl($baseUrl, $group, $queryParams, $page) . '">');
BeaconTemplate::SetTitle($pageTitle);
BeaconTemplate::SetPageDescription($pageDescriptionPlain);
	
echo '<h1>' . htmlentities($pageTitle) . '</h1>';
echo '<p>' . $pageDescriptionHtml . '</p>';

$pageContents = Blueprint::Search($filters);
$resultCount = $pageContents['totalResults'];
$page = $pageContents['page'];
$pageSize = $pageContents['pageSize'];
$pageCount = $pageContents['pages'];
$rangeStart = min(1 + (($page - 1) * $pageSize), $resultCount);
$rangeEnd = min($rangeStart + ($pageSize - 1), $resultCount);

$clearSearchUrl = BuildUrl($baseUrl, $group, array_filter($queryParams, function($key) { return $key !== 'search'; }, ARRAY_FILTER_USE_KEY), 1);

?><p><form action="<?php echo htmlentities(str_replace('{{group}}', $group, $baseUrl)); ?>" method="get"><input type="search" id="beacon-filter-field" placeholder="Search" autocomplete="off" name="search" value="<?php echo htmlentities($search); ?>"><?php if (empty($tag) === false && is_null($mod) === false) { ?><input type="hidden" name="tag" value="<?php echo htmlentities($tag); ?>"><?php } ?></form></p>
<div class="page-panel" id="panel-blueprints">
	<div class="page-panel-nav">
		<ul>
			<?php
			foreach ($groupHumanNames as $groupName => $groupHumanName) {
				$groupUrl = $groupUrls[$groupName];
				echo '<li' . ($groupName === $group ? ' class="page-panel-active"' : '') . '><a href="' . htmlentities($groupUrl) . '" page="' . htmlentities($groupName) . '">' . htmlentities($groupHumanName) . '</a></li>';
			}
			?>
		</ul>
	</div>
	<div class="page-panel-pages">
	<div class="page-panel-page page-panel-visible" page="<?php echo htmlentities($group); ?>">
		<?php
		
		if ($pageContents['totalResults'] === 0) {
			echo '<p>';
			if (empty($search)) {
				echo 'Did not find any ' . htmlentities(strtolower($groupHumanNames[$group]));
			} else {
				echo 'Did not find any ' . htmlentities(strtolower($groupHumanNames[$group])) . ' matching &quot;' . htmlentities($search) . '&quot;';
				echo '</p><p class="text-center"><a href="' . htmlentities($clearSearchUrl) . '">Clear Search</a>';
			}
			echo '</p>';
		} else {
			echo '<p>Results ' . htmlentities(number_format($rangeStart)) . ' to ' . htmlentities(number_format($rangeEnd)) . ' of ' . htmlentities(number_format($resultCount));
			if (empty($search) === false) {
				echo ' containing &quot;' . htmlentities($search) . '&quot;<br><a href="' . htmlentities($clearSearchUrl) . '">Clear Search</a>';
			}
			echo '</p>';
			
			if (is_null($mod)) {
				$columnWidths = [
					'name' => 'w-40',
					'mod' => 'w-30',
					'class' => 'w-30'
				];
			} else {
				$columnWidths = [
					'name' => 'w-50',
					'class' => 'w-50'
				];
			}
			
			echo '<table class="generic">';
			echo '<thead>';
			echo '<tr>';
			echo '<th class="' . $columnWidths['name'] . '">Name</th>';
			if (is_null($mod)) {
				echo '<th class="' . $columnWidths['mod'] . ' low-priority">Mod</th>';
			}
			echo '<th class="' . $columnWidths['class'] . ' low-priority">Class</th>';
			echo '</tr>';
			echo '</thead>';
			echo '<tbody>';
			foreach ($pageContents['results'] as $result) {
				$modLink = '<a href="' . htmlentities('/mods/' . $result->ContentPackSteamId()) . '">' . htmlentities($result->ContentPackName()) . '</a>';
				$modDetailLink = '';
				if (is_null($mod)) {
					$modDetailLink = "<span class=\"detail\">Mod: {$modLink}</span>";
				}
				
				echo '<tr>';
				echo '<td><a href="/object/' . $result->UUID() . '">' . htmlentities($result->Label()) . '</a><div class="row-details">' . $modDetailLink . '<span class="detail">Class: ' . htmlentities($result->ClassString()) . '</span></div></td>';
				if (is_null($mod)) {
					echo '<td class="low-priority">' . $modLink . '</td>';
				}
				echo '<td class="low-priority break-code">' . htmlentities($result->ClassString()) . '</td>';
				echo '</tr>';
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
					$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $group, $queryParams, 1)) . '" class="pagination-button pagination-text">&laquo; First</a>';
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				if ($page > 1) {
					$prevUrl = BuildUrl($baseUrl, $group, $queryParams, $page - 1);
					$pageLinks[] = '<a href="'. htmlentities($prevUrl) . '" class="pagination-button pagination-text">&lsaquo; Previous</a>';
					BeaconTemplate::AddHeaderLine('<link rel="prev" href="' . htmlentities($prevUrl) . '">');
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				for ($p = $lowestPage; $p <= $highestPage; $p++) {
					if ($p === $page) {
						$pageLinks[] = '<span class="pagination-button pagination-number pagination-current">' . $p . '</span>';
					} else {
						$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $group, $queryParams, $p)) . '" class="pagination-button pagination-number">' . htmlentities($p) . '</a>';
					}
				}
				if ($page < $pageCount) {
					$nextUrl = BuildUrl($baseUrl, $group, $queryParams, $page + 1);
					$pageLinks[] = '<a href="'. htmlentities($nextUrl) . '" class="pagination-button pagination-text">Next &rsaquo;</a>';
					BeaconTemplate::AddHeaderLine('<link rel="next" href="' . htmlentities($nextUrl) . '">');
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				if ($highestPage < $pageCount) {
					$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $group, $queryParams, $pageCount)) . '" class="pagination-button pagination-text">Last &raquo;</a>';
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				
				echo '<div class="pagination-controls"><div class="pagination-cell">' . implode('</div><div class="pagination-cell">', $pageLinks) . '</div></div>';
			}
		}
		?>
	</div>
</div><?php

function BuildUrl(string $baseUrl, string $group, array $queryParams, int $page): string {
	$url = str_replace('{{group}}', urlencode($group), $baseUrl);
	if ($page > 1) {
		$queryParams['page'] = $page;
	}
	if (count($queryParams) > 0) {
		ksort($queryParams);
		$url .= '?' . http_build_query($queryParams);
	}
	return $url;
}

?>
