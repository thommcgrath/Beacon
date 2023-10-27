<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\ContentPack;
use BeaconAPI\v4\ArkSA\{Blueprint, BlueprintGroup};

$currentGroup = BlueprintGroup::FindGroup($_GET['group'] ?? '');
if (is_null($currentGroup)) {
	$currentGroup = BlueprintGroup::EngramsGroup();
}

$tagHuman = '';
$tag = trim($_GET['tag'] ?? '');
$page = filter_var($_GET['page'] ?? 1, FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
$search = strtolower(trim($_GET['search'] ?? ''));

$filters = [
	'page' => $page,
	'pageSize' => 50,
	'blueprintGroup' => $currentGroup->ApiVersion()
];
$queryParams = [];

$pack = null;
$contentPackId = $_GET['contentPackId'] ?? null;
if (is_null($contentPackId) === false) {
	if (BeaconCommon::IsUUID($contentPackId)) {
		$pack = ContentPack::Fetch($contentPackId);
	} elseif (filter_var($contentPackId, FILTER_VALIDATE_INT, ['options' => ['min_range' => -9223372036854775808, 'max_range' => 9223372036854775807]])) {
		$packs = ContentPack::Search(['gameId' => 'ArkSA', 'marketplaceId' => $contentPackId, 'isConfirmed' => true], true);
		if (count($packs) === 1) {
			$pack = $packs[0];
		}
	}

	if (is_null($pack) || $pack->GameId() !== 'ArkSA') {
		http_response_code(404);
		echo '<h1>Mod is not registered with Beacon.</h1>';
		echo '<p>If you are the mod owner, see <a href="' . BeaconCommon::AbsoluteURL('/help/registering_your_mod_with_beacon') . '">Registering your mod with Beacon</a> for help.</p>';
		exit;
	}
}

if (empty($tag) === false) {
	$tagInfo = Blueprint::ConvertTag($tag);
	$tag = $tagInfo['tag'];
	$tagHuman = $tagInfo['human'];
	$tagUrl = $tagInfo['url'];
	$filters['tag'] = $tag;
}

if (empty($search) === false) {
	$filters['label|alternateLabel|path|class'] = '%' . str_replace('%', '\\%', $search) . '%';
	$queryParams['search'] = $search;
}

if (is_null($pack)) {
	if (empty($tag)) {
		$baseUrl = '/Games/ArkSA/{{group}}';
		$pageTitle = 'Ark ' . $currentGroup->HumanVersion() . ' List';
		$pageDescriptionPlain = "This is the master list of all objects in Ark that Beacon knows about.";
		$pageDescriptionHtml = $pageDescriptionPlain;
	} else {
		$baseUrl = '/Games/ArkSA/Tags/' . urlencode($tagUrl) . '/{{group}}';
		$pageTitle = 'Ark ' . $currentGroup->HumanVersion() . ' Tagged "' . $tagHuman . '"';
		$pageDescriptionPlain = 'These Ark objects have the "' . $tagHuman . '" tag.';
		$pageDescriptionHtml = htmlentities($pageDescriptionPlain);
	}
} else {
	if (empty($tag) === false) {
		$queryParams['tag'] = $tag;
	}

	$modSteamUrl = htmlentities($pack->MarketplaceUrl());
	$modSteamId = urlencode($pack->MarketplaceId());
	$modName = htmlentities($pack->Name());
	$filters['contentPackId'] = $pack->ContentPackId();

	$baseUrl = '/Games/ArkSA/Mods/' . $modSteamId . '/{{group}}';
	$pageTitle = $currentGroup->HumanVersion() . ' From ' . $pack->Name();

	$pageDescriptionPlain = "Beacon has built-in support for {$modName}. This means its blueprints are already part of Beacon's database and you can begin using them immediately.";
	$pageDescriptionHtml = "Beacon has built-in support for <a href=\"{$modSteamUrl}\">{$modName}</a>. This means its blueprints are already part of Beacon's database and you can begin using them immediately. We also have a full list of <a href=\"/Games/ArkSA/Mods/{$modSteamId}/Cheats\">spawn codes for {$modName}</a>.";
}

BeaconTemplate::SetCanonicalPath(BuildUrl($baseUrl, $currentGroup, $queryParams, $page, false));
BeaconTemplate::SetTitle($pageTitle);
BeaconTemplate::SetPageDescription($pageDescriptionPlain);

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('ArkSA', 'Ark: Survival Ascended');
if (is_null($pack) === false) {
	$breadcrumbs->AddComponent('Mods', 'Mods');
	$breadcrumbs->AddComponent(urlencode($pack->MarketplaceId()), $pack->Name());
}
$breadcrumbs->AddComponent($currentGroup->UrlVersion(), $currentGroup->HumanVersion());
echo $breadcrumbs->Render();

echo '<h1>' . htmlentities($pageTitle) . '</h1>';
echo '<p>' . $pageDescriptionHtml . '</p>';

$pageContents = Blueprint::Search($filters);
$resultCount = $pageContents['totalResults'];
$page = $pageContents['page'];
$pageSize = $pageContents['pageSize'];
$pageCount = $pageContents['pages'];
$rangeStart = min(1 + (($page - 1) * $pageSize), $resultCount);
$rangeEnd = min($rangeStart + ($pageSize - 1), $resultCount);

$clearSearchUrl = BuildUrl($baseUrl, $currentGroup, array_filter($queryParams, function($key) { return $key !== 'search'; }, ARRAY_FILTER_USE_KEY), 1);

?><p><form action="<?php echo htmlentities(str_replace('{{group}}', $currentGroup->UrlVersion(), $baseUrl)); ?>" method="get"><input type="search" id="beacon-filter-field" placeholder="Search" autocomplete="off" name="search" value="<?php echo htmlentities($search); ?>"><?php if (empty($tag) === false && is_null($pack) === false) { ?><input type="hidden" name="tag" value="<?php echo htmlentities($tag); ?>"><?php } ?></form></p>
<div class="page-panel" id="panel-blueprints">
	<div class="page-panel-nav">
		<ul>
			<?php
			$groups = BlueprintGroup::Groups();
			foreach ($groups as $group) {
				$groupUrl = BuildUrl($baseUrl, $group, $queryParams, 1);
				echo '<li' . ($group->ApiVersion() === $currentGroup->ApiVersion() ? ' class="page-panel-active"' : '') . '><a href="' . htmlentities($groupUrl) . '" page="' . htmlentities($group->ApiVersion()) . '">' . htmlentities($group->HumanVersion()) . '</a></li>';
			}
			?>
		</ul>
	</div>
	<div class="page-panel-pages">
	<div class="page-panel-page page-panel-visible" page="<?php echo htmlentities($currentGroup->ApiVersion()); ?>">
		<?php

		if ($pageContents['totalResults'] === 0) {
			echo '<p>';
			if (empty($search)) {
				echo 'Did not find any ' . htmlentities(strtolower($currentGroup->HumanVersion()));
			} else {
				echo 'Did not find any ' . htmlentities(strtolower($currentGroup->HumanVersion())) . ' matching &quot;' . htmlentities($search) . '&quot;';
				echo '</p><p class="text-center"><a href="' . htmlentities($clearSearchUrl) . '">Clear Search</a>';
			}
			echo '</p>';
		} else {
			echo '<p>Results ' . htmlentities(number_format($rangeStart)) . ' to ' . htmlentities(number_format($rangeEnd)) . ' of ' . htmlentities(number_format($resultCount));
			if (empty($search) === false) {
				echo ' containing &quot;' . htmlentities($search) . '&quot;<br><a href="' . htmlentities($clearSearchUrl) . '">Clear Search</a>';
			}
			echo '</p>';

			if (is_null($pack)) {
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
			if (is_null($pack)) {
				echo '<th class="' . $columnWidths['mod'] . ' low-priority">Mod</th>';
			}
			echo '<th class="' . $columnWidths['class'] . ' low-priority">Class</th>';
			echo '</tr>';
			echo '</thead>';
			echo '<tbody>';
			foreach ($pageContents['results'] as $result) {
				$modLink = '<a href="' . htmlentities('/Games/ArkSA/Mods/' . urlencode($result->ContentPackMarketplaceId())) . '">' . htmlentities($result->ContentPackName()) . '</a>';
				$modDetailLink = '';
				if (is_null($pack)) {
					$modDetailLink = "<span class=\"detail\">Mod: {$modLink}</span>";
				}

				echo '<tr>';
				echo '<td><a href="/Games/ArkSA/Mods/' . $result->ContentPackMarketplaceId() . '/' . urlencode($result->ClassString()) . '">' . htmlentities($result->Label()) . '</a><div class="row-details">' . $modDetailLink . '<span class="detail">Class: ' . htmlentities($result->ClassString()) . '</span></div></td>';
				if (is_null($pack)) {
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
					$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $currentGroup, $queryParams, 1)) . '" class="pagination-button pagination-text">&laquo; First</a>';
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				if ($page > 1) {
					$prevUrl = BuildUrl($baseUrl, $currentGroup, $queryParams, $page - 1);
					$pageLinks[] = '<a href="'. htmlentities($prevUrl) . '" class="pagination-button pagination-text">&lsaquo; Previous</a>';
					BeaconTemplate::AddHeaderLine('<link rel="prev" href="' . htmlentities($prevUrl) . '">');
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				for ($p = $lowestPage; $p <= $highestPage; $p++) {
					if ($p === $page) {
						$pageLinks[] = '<span class="pagination-button pagination-number pagination-current">' . $p . '</span>';
					} else {
						$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $currentGroup, $queryParams, $p)) . '" class="pagination-button pagination-number">' . htmlentities($p) . '</a>';
					}
				}
				if ($page < $pageCount) {
					$nextUrl = BuildUrl($baseUrl, $currentGroup, $queryParams, $page + 1);
					$pageLinks[] = '<a href="'. htmlentities($nextUrl) . '" class="pagination-button pagination-text">Next &rsaquo;</a>';
					BeaconTemplate::AddHeaderLine('<link rel="next" href="' . htmlentities($nextUrl) . '">');
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}
				if ($highestPage < $pageCount) {
					$pageLinks[] = '<a href="' . htmlentities(BuildUrl($baseUrl, $currentGroup, $queryParams, $pageCount)) . '" class="pagination-button pagination-text">Last &raquo;</a>';
				} else {
					$pageLinks[] = '<span class="pagination-placeholder">&nbsp;</span>';
				}

				echo '<div class="pagination-controls"><div class="pagination-cell">' . implode('</div><div class="pagination-cell">', $pageLinks) . '</div></div>';
			}
		}
		?>
	</div>
</div><?php

function BuildUrl(string $baseUrl, BlueprintGroup $group, array $queryParams, int $page, bool $absolute = true): string {
	$url = str_replace('{{group}}', urlencode($group->UrlVersion()), $baseUrl);
	if ($page > 1) {
		$url .= '/' . $page;
	}
	if (count($queryParams) > 0) {
		ksort($queryParams);
		$url .= '?' . http_build_query($queryParams);
	}
	if ($absolute) {
		return BeaconCommon::AbsoluteUrl($url);
	} else {
		return $url;
	}
}

?>
