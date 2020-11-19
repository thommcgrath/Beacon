<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark Breeding Chart');

$msm = isset($_GET['msm']) ? floatval($_GET['msm']) : 1.0;
$ipm = isset($_GET['ipm']) ? floatval($_GET['ipm']) : 1.0;
$ism = isset($_GET['ism']) ? floatval($_GET['ism']) : 1.0;
$iam = isset($_GET['iam']) ? floatval($_GET['iam']) : 1.0;

$msm = ($msm > 0) ? $msm : 1.0;
$ipm = ($ipm > 0) ? $ipm : 1.0;
$ism = ($ism > 0) ? $ism : 1.0;
$iam = ($iam > 0) ? $iam : 1.0;

$database = BeaconCommon::Database();
$results = $database->Query('SELECT value::INTEGER FROM game_variables WHERE key = $1;', 'Cuddle Period');
if ($results->RecordCount() != 1) {
	http_response_code(500);
	echo "There was a problem loading the default imprint interval.";
	exit;
}
$official_cuddle_period = $results->Field('value');
$computed_cuddle_period = $official_cuddle_period * $ipm;

BeaconTemplate::StartStyles(); ?>
<style>

#breeding-stats {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	align-items: center;
	align-content: center;
}

.breeding-stats-column {
	flex: 1 1 auto;
	display: flex;
}

.breeding-stats-label,
.breeding-stats-value {
	flex: 1 1 auto;
	padding: 3px;
}

.breeding-stats-label {
	text-align: right;
	font-weight: 600;
}

.breeding-stats-value {
	text-align: left;
}

#creature-chart {
	margin-top: 20px;
	width: 100%;
}

.wide-only {
	display: none;
}

.narrow-only {
	display: inline;
}

@media (min-width: 450px) {
	.wide-only {
		display: table-cell;
	}
	
	.narrow-only {
		display: none;
	}
}

</style><?php
BeaconTemplate::FinishStyles();

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
			
		$cache_key = 'breeding:msm=' . number_format($msm, 8) . ';ipm=' . number_format($ipm, 8) . ';ism=' . number_format($ism, 8) . ';iam=' . number_format($iam, 8);
		$cached = BeaconCache::Get($cache_key);
		
		if (is_null($cached)) {
			ob_start();
			
			$results = $database->Query('SELECT MAX(build_number) AS newest_build FROM updates;');
			$min_version = $results->Field('newest_build');
			
			$creatures = BeaconCreature::GetAll($min_version);
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
				
				$incubation_text = BeaconCommon::SecondsToEnglish($incubation_seconds, true);
				$mature_text = BeaconCommon::SecondsToEnglish($mature_seconds, true);
				echo '<tr><td>' . htmlentities($creature->Label()) . '<span class="narrow-only text-lighter"><br><strong>Incubation Time:</strong> ' . htmlentities($incubation_text) . '<br><strong>Mature Time:</strong> ' . htmlentities($mature_text) . '<br><strong>Imprinting:</strong> ' . htmlentities($cuddle_text) . '</span></td><td class="wide-only">' . htmlentities($incubation_text) . '</td><td class="wide-only">' . htmlentities($mature_text) . '</td><td class="wide-only">' . htmlentities($cuddle_text) . '</td></tr>';
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