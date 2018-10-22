<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$method = strtoupper($_SERVER['REQUEST_METHOD']);
switch ($method) {
case 'GET':
	if (isset($_GET['exception'])) {
		$exception_hash = $_GET['exception'];
		$build = isset($_GET['build']) ? intval($_GET['build']) : 34;
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT exception_type, location, reason, trace, solution_details, solution_min_build FROM exceptions WHERE exception_hash = $1 AND build <= $2 ORDER BY build DESC LIMIT 1;', $exception_hash, $build);
		if ($results->RecordCount() == 0) {
			http_response_code(404);
			echo '<h1>Unknown Error</h1><p>No exception with this id has been reported yet.</p>';
			exit;
		}
		
		$force_view = isset($_GET['action']) && strtolower($_GET['action']) == 'view';
		if (is_null($results->Field('solution_details')) && $force_view == false) {
			BeaconTemplate::StartStyles();
			?><style type="text/css">
			
			#reporter_container {
				max-width: 460px;
				margin-top: 40px;
				margin-left: auto;
				margin-right: auto;
				margin-bottom: 40px;
				text-align: center;
			}
			
			#reporter_disclaimer {
				font-size: smaller;
				color: rgba(0, 0, 0, 0.5);
				text-align: right;
				width: 300px;
				margin-left: auto;
			}
			
			</style><?php
			BeaconTemplate::FinishStyles();
			
			?><h1>Beacon Error Reporter</h1>
			<div id="reporter_container">
				<p class="text-left"><strong>The error has been reported.</strong> If you have any information about how to reproduce the error, please include it here. Otherwise, it is safe to leave this page.</p>
				<form action="<?php echo basename(__FILE__); ?>" method="post">
					<input type="hidden" name="hash" value="<?php echo htmlentities($exception_hash); ?>">
					<input type="hidden" name="build" value="<?php echo htmlentities($build); ?>">
					<p><textarea name="comments" placeholder="Comments" rows="5"></textarea></p>
					<p class="text-right"><input type="submit" value="Submit Comments"></p>
					<p id="reporter_disclaimer">This data is anonymous. It will not be possible for Beacon's developers to contact you about this issue.</p>
				</form>
			</div><?php
			exit;
		}
		
		$details_only = is_null($results->Field('solution_details'));
		
		echo '<h1>Error Report</h1>';
		if ($details_only == false) {
			echo '<h2>Solution</h2>';
			if (intval($results->Field('solution_min_build')) > $build) {
				$build_details = $database->Query('SELECT build_display, mac_url, win_url FROM updates WHERE build_number = $1;', $results->Field('solution_min_build'));
				if ($build_details->RecordCount() == 1) {
					$url = BeaconCommon::IsMacOS() ? $build_details->Field('mac_url') : $build_details->Field('win_url');
					echo '<p>Update to <a href="' . htmlentities($url) . '">Beacon ' . htmlentities($build_details->Field('build_display')) . '</a> to fix this problem.</p>';
				} else {
					echo '<p>This problem will be resolved in a future update.</p>';
				}
			}
			
			$parser = new Parsedown();
			$html = $parser->text($results->Field('solution_details'));
			$html = str_replace('<table>', '<table class="generic">', $html);
			echo $html;
			
			BeaconTemplate::StartScript();
			?><script>
			
			document.addEventListener('DOMContentLoaded', function() {
				var link = document.getElementById('show_technical_details');
				link.addEventListener('click', function(event) {
					event.preventDefault();
					
					link.style.display = 'none';
					document.getElementById('technical_details').style.display = 'block';
					
					return false;
				});
			});
			
			</script><?php
			BeaconTemplate::FinishScript();
			
			BeaconTemplate::StartStyles();
			?><style>
			
			#technical_details {
				border: 1px solid rgba(0, 0, 0, 0.1);
				background-color: rgba(255, 255, 255, 0.1);
				padding: 20px;
				font-size: smaller;
				display: none;
			}
			
			#show_technical_details {
				font-size: smaller;
			}
			
			</style><?php
			BeaconTemplate::FinishStyles();
			
			echo '<p><a href="" id="show_technical_details">Show Technical Details</a></p>';
			echo '<div id="technical_details">';
		}
		
		echo '<h2>Technical Details</h2>';
		echo '<p><strong>Type</strong>: ' . htmlentities($results->Field('exception_type')) . '<br>';
		echo '<strong>Location</strong>: ' . htmlentities($results->Field('location')) . '<br>';
		echo '<strong>Reason</strong>: ' . htmlentities($results->Field('reason')) . '</p>';
		echo '<p><strong>Stack Trace</strong></p>';
		echo '<ol>';
		$trace = explode(chr(10), $results->Field('trace'));
		foreach ($trace as $line) {
			echo '<li>' . htmlentities($line) . '</li>';
		}
		echo '</ol>';
		
		if ($details_only == false) {
			echo '</div>';
		}
	} else {
		BeaconCommon::Redirect('https://github.com/thommcgrath/Beacon/issues', true);
	}
	break;
case 'POST':
	if (BeaconCommon::HasAllKeys($_POST, 'build', 'hash', 'comments')) {
		$build = intval($_POST['build']);
		$hash = $_POST['hash'];
		$comments = trim($_POST['comments']);
		
		try {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('INSERT INTO exception_comments (exception_hash, build, comments) VALUES ($1, $2, $3);', $hash, $build, $comments);
			$database->Commit();
			
			$details_url = BeaconCommon::AbsoluteURL('/' . basename(__FILE__) . '?exception=' . urlencode($hash) . '&build=' . urlencode($build) . '&action=view');
			$arr = array(
				'attachments' => array(
					array(
						'title' => 'New exception comment',
						'text' => $comments,
						'actions' => array(
							array(
								'type' => 'button',
								'text' => 'View Exception',
								'url' => $details_url
							)
						)
					)
				)
			);
			
			BeaconCommon::PostSlackRaw(json_encode($arr));
		} catch (Exception $e) {
			// Likely some sort of tomfoolery, just pretend all is well.
		}
		
		echo '<h1>Beacon Error Reporter</h1><p>Thank you, your comments have been added.</p>';
		exit;
	}
	
	header('Content-Type: application/json');
	
	if (!BeaconCommon::HasAllKeys($_POST, 'build', 'hash', 'type', 'location', 'reason', 'trace')) {
		http_response_code(400);
		echo json_encode(array(
			'reported' => false,
			'solution' => null,
			'error_reason' => 'POST request requires build, hash, type, location, reason, and trace keys.'
		), JSON_PRETTY_PRINT);
		exit;
	}
	
	$build = intval($_POST['build']);
	$hash = $_POST['hash'];
	$type = $_POST['type'];
	$location = $_POST['location'];
	$reason = $_POST['reason'];
	$trace = $_POST['trace'];
	
	if ($build < 34) {
		http_response_code(400);
		echo json_encode(array(
			'reported' => false,
			'solution' => null,
			'error_reason' => 'Build number does not make any sense.'
		), JSON_PRETTY_PRINT);
		exit;
	}
	
	if (preg_match('/[a-f0-9]{40}/i', $hash) == 0) {
		http_response_code(400);
		echo json_encode(array(
			'reported' => false,
			'solution' => null,
			'error_reason' => 'Exception hash should be a hex-encoded SHA-1 hash.'
		), JSON_PRETTY_PRINT);
		exit;
	}
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT solution_min_build FROM exceptions WHERE exception_hash = $1 AND build <= $2 ORDER BY build DESC LIMIT 1;', $hash, $build);
	if ($results->RecordCount() == 0) {
		// Record the exception
		$database->BeginTransaction();
		$database->Query('INSERT INTO exceptions (exception_hash, build, exception_type, location, reason, trace) VALUES ($1, $2, $3, $4, $5, $6);', $hash, $build, $type, $location, $reason, $trace);
		$database->Commit();
		
		$details_url = BeaconCommon::AbsoluteURL('/' . basename(__FILE__) . '?exception=' . urlencode($hash) . '&build=' . urlencode($build) . '&action=view');
		
		$arr = array(
			'attachments' => array(
				array(
					'title' => 'New ' . $type . ' in ' . $location . ' reported',
					'text' => $reason,
					'actions' => array(
						array(
							'type' => 'button',
							'text' => 'View Details',
							'url' => $details_url
						)
					)
				)
			)
		);
		
		BeaconCommon::PostSlackRaw(json_encode($arr));
	}
	
	if ($results->RecordCount() == 0 || is_null($results->Field('solution_min_build'))) {
		// No solution yet
		echo json_encode(array(
			'reported' => true,
			'solution' => null,
			'error_reason' => null
		), JSON_PRETTY_PRINT);
	} else {
		// Solution is known
		echo json_encode(array(
			'reported' => true,
			'solution' => BeaconCommon::AbsoluteURL('/reportaproblem.php?exception=' . urlencode($hash) . '&build=' . urlencode($build)),
			'error_reason' => null
		), JSON_PRETTY_PRINT);
	}
	
	break;
}

?>