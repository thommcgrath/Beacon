<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark: Survival Ascended Breeding Chart');

use BeaconAPI\v4\ArkSA\Creature;
use BeaconAPI\v4\ContentPack;

$msm = isset($_GET['msm']) ? floatval($_GET['msm']) : 1.0;
$ipm = isset($_GET['ipm']) ? floatval($_GET['ipm']) : 1.0;
$ism = isset($_GET['ism']) ? floatval($_GET['ism']) : 1.0;
$iam = isset($_GET['iam']) ? floatval($_GET['iam']) : 1.0;

$contentPackIds = [];
$curseForgeIds = [];
$m = isset($_GET['m']) ? explode(',', $_GET['m']) : [];
for ($idx = 0; $idx < count($m); $idx++) {
	$id = filter_var($m[$idx], FILTER_VALIDATE_INT);
	if ($id !== false) {
		$curseForgeIds[] = $id;
	} elseif (BeaconCommon::IsUUID($m[$idx])) {
		$contentPackIds[] = $m[$idx];
	}
}

$msm = ($msm > 0) ? $msm : 1.0;
$ipm = ($ipm > 0) ? $ipm : 1.0;
$ism = ($ism > 0) ? $ism : 1.0;
$iam = ($iam > 0) ? $iam : 1.0;

$database = BeaconCommon::Database();
$results = $database->Query('SELECT MAX(build_number) AS newest_build FROM updates;');
$minVersion = $results->Field('newest_build');

$officialPacks = ContentPack::Search(['minVersion' => $minVersion, 'isOfficial' => true], true);
foreach ($officialPacks as $officialPack) {
	$contentPackIds[] = $officialPack->ContentPackId();
}

$marketplacePacks = ContentPack::Search(['minVersion' => $minVersion, 'marketplace' => 'CurseForge', 'marketplaceId' => implode(',', $curseForgeIds)], true);
foreach ($marketplacePacks as $marketplacePack) {
	$contentPackIds[] = $marketplacePack->ContentPackId();
}

$results = $database->Query('SELECT MAX(EXTRACT(EPOCH FROM last_update)) AS last_update FROM public.content_update_times WHERE min_version <= $1 AND content_pack_id = ANY($2);', $minVersion, '{' . implode(',', $contentPackIds) . '}');
$lastUpdate = $results->Field('last_update');

$cacheKey = md5('arksa.breeding:' . $lastUpdate . ';msm=' . number_format($msm, 8) . ';ipm=' . number_format($ipm, 8) . ';ism=' . number_format($ism, 8) . ';iam=' . number_format($iam, 8) . ';m=' . implode(',', $contentPackIds));
if (isset($_SERVER['HTTP_IF_NONE_MATCH'])) {
	$tags = explode(',', stripslashes($_SERVER['HTTP_IF_NONE_MATCH']));
	$validMatches = ['"' . $cacheKey . '"', 'W/"' . $cacheKey . '"'];
	foreach ($tags as $tag) {
		$tag = trim($tag);
		if (in_array($tag, $validMatches)) {
			http_response_code(304);
			header('Content-Type: text/plain');
			exit;
		}
	}
}

header('ETag: "' . $cacheKey . '"');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('breeding.css'));

$cached = BeaconCache::Get($cacheKey);
if (is_null($cached) === false) {
	echo $cached;
	exit;
}

$results = $database->Query('SELECT value::INTEGER FROM arksa.game_variables WHERE key = $1;', 'Cuddle Period');
if ($results->RecordCount() != 1) {
	http_response_code(500);
	echo "There was a problem loading the default imprint interval.";
	exit;
}
$officialCuddlePeriod = $results->Field('value');
$computedCuddlePeriod = round($officialCuddlePeriod * $ipm);

ob_start();

?><div id="breeding-stats">
	<div id="breeding-stats-msm" class="breeding-stats-column">
		<div class="breeding-stats-label">Mature Speed:</div>
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::FormatFloat($msm)); ?></div>
	</div>
	<div id="breeding-stats-ism" class="breeding-stats-column">
		<div class="breeding-stats-label">Incubation Speed:</div>
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::FormatFloat($ism)); ?></div>
	</div>
	<div id="breeding-stats-ipm" class="breeding-stats-column">
		<div class="breeding-stats-label">Imprint Period:</div>
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::FormatFloat($ipm)); ?></div>
	</div>
	<div id="breeding-stats-if" class="breeding-stats-column">
		<div class="breeding-stats-label">Imprint Amount:</div>
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::FormatFloat($iam)); ?></div>
	</div>
	<div id="breeding-stats-if" class="breeding-stats-column">
		<div class="breeding-stats-label">Imprint Frequency:</div>
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::SecondsToEnglish($computedCuddlePeriod, true)); ?></div>
	</div>
</div>
<table id="creature-chart" class="generic">
	<thead>
		<tr>
			<th>Creature</th>
			<th class="wide-only">Incubation Time</th>
			<th class="wide-only">Mature Time</th>
			<th class="wide-only">Imprints</th>
		</tr>
	</thead>
	<tbody>
		<?php

		$showModNames = count($curseForgeIds) > 0;
		$creatures = Creature::Search(['minVersion' => $minVersion, 'contentPackId' => $contentPackIds], true);
		foreach ($creatures as $creature) {
			if (is_null($creature->IncubationTimeSeconds()) || is_null($creature->MatureTimeSeconds())) {
				continue;
			}

			$incubationSeconds = $creature->IncubationTimeSeconds() / $ism;
			$matureSeconds = $creature->MatureTimeSeconds() / $msm;

			$maxCuddles = 0;
			$perCuddle = 0;
			if ($iam > 0) {
				$maxCuddles = floor($matureSeconds / $computedCuddlePeriod);

				if ($maxCuddles > 0) {
					$perCuddle = min((1 / $maxCuddles) * $iam, 1.0);
					$maxCuddles = ceil(1.0 / $perCuddle);
				}
			}
			if ($maxCuddles == 0) {
				$cuddleText = 'Can\'t Imprint';
			} else {
				$cuddleText = number_format($perCuddle * 100, 0) . '% ea / ' . $maxCuddles . ' total';
			}

			$label = htmlentities($creature->Label());
			if ($showModNames) {
				$label .= '<span class="beacon-engram-mod-name"><br>' . htmlentities($creature->ContentPackName()) . '</span>';
			}

			$incubationText = BeaconCommon::SecondsToEnglish(round($incubationSeconds), true);
			$matureText = BeaconCommon::SecondsToEnglish(round($matureSeconds), true);
			echo '<tr><td>' . $label . '<span class="narrow-only text-lighter"><br><strong>Incubation Time:</strong> ' . htmlentities($incubationText) . '<br><strong>Mature Time:</strong> ' . htmlentities($matureText) . '<br><strong>Imprinting:</strong> ' . htmlentities($cuddleText) . '</span></td><td class="wide-only">' . htmlentities($incubationText) . '</td><td class="wide-only">' . htmlentities($matureText) . '</td><td class="wide-only">' . htmlentities($cuddleText) . '</td></tr>';
		}

		?>
	</tbody>
</table>
<p class="smaller text-center">Any creature that can be imprinted can be imprinted to 100%</p><?php

$cached = ob_get_contents();
ob_end_clean();
BeaconCache::Set($cacheKey, $cached);
echo $cached;

?>
