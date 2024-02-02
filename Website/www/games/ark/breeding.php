<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark: Survival Evolved Breeding Chart');

use BeaconAPI\v4\Ark\Creature;
use BeaconAPI\v4\ContentPack;

$msm = isset($_GET['msm']) ? floatval($_GET['msm']) : 1.0;
$ipm = isset($_GET['ipm']) ? floatval($_GET['ipm']) : 1.0;
$ism = isset($_GET['ism']) ? floatval($_GET['ism']) : 1.0;
$iam = isset($_GET['iam']) ? floatval($_GET['iam']) : 1.0;

$steamIds = [];
$m = isset($_GET['m']) ? explode(',', $_GET['m']) : [];
for ($idx = 0; $idx < count($m); $idx++) {
	$id = filter_var($m[$idx], FILTER_VALIDATE_INT);
	if ($id !== false) {
		$steamIds[] = $id;
	}
}

$msm = ($msm > 0) ? $msm : 1.0;
$ipm = ($ipm > 0) ? $ipm : 1.0;
$ism = ($ism > 0) ? $ism : 1.0;
$iam = ($iam > 0) ? $iam : 1.0;

$database = BeaconCommon::Database();
$results = $database->Query('SELECT value::INTEGER FROM ark.game_variables WHERE key = $1;', 'Cuddle Period');
if ($results->RecordCount() != 1) {
	http_response_code(500);
	echo "There was a problem loading the default imprint interval.";
	exit;
}
$official_cuddle_period = $results->Field('value');
$computed_cuddle_period = round($official_cuddle_period * $ipm);

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('breeding.css'));

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
		<div class="breeding-stats-value"><?php echo htmlentities(BeaconCommon::SecondsToEnglish($computed_cuddle_period, true)); ?></div>
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

		$cache_key = 'ark.breeding:msm=' . number_format($msm, 8) . ';ipm=' . number_format($ipm, 8) . ';ism=' . number_format($ism, 8) . ';iam=' . number_format($iam, 8) . ';m=' . implode(',', $steamIds);
		$cached = BeaconCache::Get($cache_key);

		if (is_null($cached)) {
			ob_start();

			$results = $database->Query('SELECT MAX(build_number) AS newest_build FROM updates;');
			$min_version = $results->Field('newest_build');

			$officialPacks = ContentPack::Search(['minVersion' => $min_version, 'isOfficial' => true], true);
			$officialPackIds = [];
			foreach ($officialPacks as $officialPack) {
				$officialPackIds[] = $officialPack->ContentPackId();
			}

			$marketplacePacks = ContentPack::Search(['minVersion' => $min_version, 'marketplace' => 'Steam Workshop', 'marketplaceId' => implode(',', $steamIds)], true);
			$marketplacePackIds = [];
			foreach ($marketplacePacks as $marketplacePack) {
				$marketplacePackIds[] = $marketplacePack->ContentPackId();
			}

			$showModNames = count($steamIds) > 0;
			$combinedPackIds = array_merge($officialPackIds, $marketplacePackIds);
			$creatures = Creature::Search(['minVersion' => $min_version, 'contentPackId' => $combinedPackIds], true);
			foreach ($creatures as $creature) {
				if (is_null($creature->IncubationTimeSeconds()) || is_null($creature->MatureTimeSeconds())) {
					continue;
				}

				$incubation_seconds = $creature->IncubationTimeSeconds() / $ism;
				$mature_seconds = $creature->MatureTimeSeconds() / $msm;

				$max_cuddles = 0;
				$per_cuddle = 0;
				if ($iam > 0) {
					$max_cuddles = floor($mature_seconds / $computed_cuddle_period);

					if ($max_cuddles > 0) {
						$per_cuddle = min((1 / $max_cuddles) * $iam, 1.0);
						$max_cuddles = ceil(1.0 / $per_cuddle);
					}
				}
				if ($max_cuddles == 0) {
					$cuddle_text = 'Can\'t Imprint';
				} else {
					$cuddle_text = number_format($per_cuddle * 100, 0) . '% ea / ' . $max_cuddles . ' total';
				}

				$label = htmlentities($creature->Label());
				if ($showModNames) {
					$label .= '<span class="beacon-engram-mod-name"><br>' . htmlentities($creature->ContentPackName()) . '</span>';
				}

				$incubation_text = BeaconCommon::SecondsToEnglish(round($incubation_seconds), true);
				$mature_text = BeaconCommon::SecondsToEnglish(round($mature_seconds), true);
				echo '<tr><td>' . $label . '<span class="narrow-only text-lighter"><br><strong>Incubation Time:</strong> ' . htmlentities($incubation_text) . '<br><strong>Mature Time:</strong> ' . htmlentities($mature_text) . '<br><strong>Imprinting:</strong> ' . htmlentities($cuddle_text) . '</span></td><td class="wide-only">' . htmlentities($incubation_text) . '</td><td class="wide-only">' . htmlentities($mature_text) . '</td><td class="wide-only">' . htmlentities($cuddle_text) . '</td></tr>';
			}

			$cached = ob_get_contents();
			ob_end_clean();
			BeaconCache::Set($cache_key, $cached);
		}

		echo $cached;
		?>
	</tbody>
</table>
<p class="smaller text-center">Any creature that can be imprinted can be imprinted to 100%</p>
