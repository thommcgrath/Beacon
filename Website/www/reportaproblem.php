<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('build/reportaproblem.css'));

header('Cache-Control: no-cache');

$method = strtoupper($_SERVER['REQUEST_METHOD']);
switch ($method) {
case 'GET':
	$user_id = isset($_GET['user_id']) ? $_GET['user_id'] : null;
	$client_build = isset($_GET['build']) ? intval($_GET['build']) : null;
	
	if (isset($_GET['exception']) || isset($_GET['uuid'])) {
		$database = BeaconCommon::Database();
		$exception_id = null;
		
		if (isset($_GET['uuid'])) {
			$exception_id = $_GET['uuid'];
		} elseif (isset($_GET['exception']) && is_null($client_build) == false) {
			$results = $database->Query('SELECT exception_id FROM exception_signatures WHERE client_hash = $1 AND client_build = $2;', $_GET['exception'], $client_build);
			if ($results->RecordCount() == 0) {
				http_response_code(404);
				echo '<h1>Exception Not Found</h1><p>No exception with this id has been reported yet.</p>';
				exit;
			}
			
			$exception_id = $results->Field('exception_id');
		}
		
		if (!BeaconCommon::IsUUID($exception_id)) {
			http_response_code(404);
			echo '<h1>Bad Error ID</h1><p>' . htmlentities($exception_id) . ' is not a valid exception UUID.</p>';
			exit;
		}
		
		$results = $database->Query('SELECT exception_id, exception_class, min_reported_build, max_reported_build, location, reason, trace, solution_comments, solution_build FROM exceptions WHERE exception_id = $1;', $exception_id);
		if ($results->RecordCount() == 0) {
			http_response_code(404);
			echo '<h1>Exception Not Found</h1><p>No exception with this id has been reported yet.</p>';
			exit;
		}
		
		$force_view = isset($_GET['action']) && strtolower($_GET['action']) == 'view';
		if (is_null($results->Field('solution_build')) && $force_view == false) {
			// check the version
			$show_update_notice = false;
			if (is_null($client_build) == false) {
				$results = $database->Query('SELECT build_number, build_display FROM updates WHERE stage = 3 ORDER BY build_number DESC LIMIT 1;');
				$show_update_notice = ($results->Field('build_number') > $client_build);
				$display_version = $results->Field('build_display');
			}
			
			?><h1>Beacon Error Reporter</h1>
			<div id="reporter_container">
				<p class="text-left"><strong>The error has been reported.</strong> If you have any information about how to reproduce the error, please include it here. Otherwise, it is safe to leave this page.</p>
				<?php if ($show_update_notice) { ?><p class="inset-note">Your version of Beacon is out of date! Issues can often be fixed just by updating. You should try installing <a href="/download/">version <?php echo $display_version; ?></a>.</p><?php } ?>
				<form action="<?php echo basename(__FILE__); ?>" method="post">
					<input type="hidden" name="uuid" value="<?php echo htmlentities($exception_id); ?>">
					<?php if (!is_null($user_id)) { ?><input type="hidden" name="user_id" value="<?php echo htmlentities($user_id); ?>"><?php } ?>
					<p><textarea name="comments" placeholder="Comments" rows="5"></textarea></p>
					<p class="text-right"><input type="submit" value="Submit Comments"></p>
					<p id="reporter_disclaimer">This data is anonymous. It will not be possible for Beacon's developers to contact you about this issue.</p>
				</form>
			</div><?php
			exit;
		}
		
		$details_only = is_null($results->Field('solution_build'));
		
		echo '<h1>Error Report</h1>';
		if ($details_only == false) {
			echo '<h2>Solution</h2>';
			$build_details = $database->Query('SELECT build_display FROM updates WHERE build_number >= $1 AND stage >= (SELECT stage FROM updates WHERE build_number = $1) ORDER BY build_number DESC LIMIT 1;', $results->Field('solution_build'));
			if ($build_details->RecordCount() == 1) {
				echo '<p>Update to <a href="/download/">Beacon ' . htmlentities($build_details->Field('build_display')) . '</a> to fix this problem.</p>';
			} else {
				echo '<p>This problem will be resolved in a future update.</p>';
			}
			
			$solution_details = $results->Field('solution_comments');
			if (BeaconCommon::IsMacOS()) {
				$solution_details = str_replace('<<appsupport>>', '~/Library/Containers/com.thezaz.beacon/Data/Library/Application Support/The ZAZ/Beacon', $solution_details);
				$solution_details = str_replace('<<pathseparator>>', '/', $solution_details);
			} else {
				$solution_details = str_replace('<<appsupport>>', '%AppData%\The ZAZ\Beacon', $solution_details);
				$solution_details = str_replace('<<pathseparator>>', '\\', $solution_details);
			}
			
			$parser = new Parsedown();
			$html = $parser->text($solution_details);
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
			
			echo '<p><a href="" id="show_technical_details">Show Technical Details</a></p>';
			echo '<div id="technical_details">';
		}
		
		echo '<h2>Technical Details</h2>';
		echo '<p><strong>Type</strong>: ' . htmlentities($results->Field('exception_class')) . '<br>';
		echo '<strong>Location</strong>: ' . htmlentities($results->Field('location')) . '<br>';
		echo '<strong>Reason</strong>: ' . htmlentities($results->Field('reason')) . '<br>';
		echo '<strong>First Reported In</strong>: ' . htmlentities(BeaconCommon::BuildNumberToVersion($results->Field('min_reported_build'))) . '<br>';
		echo '<strong>Last Reported In</strong>: ' . htmlentities(BeaconCommon::BuildNumberToVersion($results->Field('max_reported_build'))) . '</p>';
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
		BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/help/contact'));
	}
	break;
case 'POST':
	if (BeaconCommon::HasAllKeys($_POST, 'uuid', 'comments')) {
		$exception_id = $_POST['uuid'];
		$comments = trim($_POST['comments']);
		$user_id = isset($_POST['user_id']) ? $_POST['user_id'] : null;
		if (!is_null($user_id)) {
			$user = BeaconUser::GetByUserID($user_id);
			if (is_null($user)) {
				$user_id = null;
			}
		}
		
		if (BeaconExceptions::AddComments($exception_id, $comments, $user_id)) {
			echo '<h1>Beacon Error Reporter</h1><p>Thank you, your comments have been added.</p>';
		} else {
			echo '<h1>Error Reporter Error</h1><p>Ironic, I know, but the error reporter hit an error.</p>';
		}
		
		exit;
	}
	
	header('Content-Type: application/json');
	
	$lookup_mode = isset($_POST['lookup']);
	if ($lookup_mode) {
		if (!BeaconCommon::HasAllKeys($_POST, 'trace', 'type', 'hash')) {
			http_response_code(400);
			echo json_encode(array(
				'reported' => false,
				'solution' => null,
				'error_reason' => 'POST request requires trace, type, and hash keys.'
			), JSON_PRETTY_PRINT);
			exit;
		}
		
		$type = $_POST['type'];
		$trace = trim($_POST['trace']);
		$hash = $_POST['hash'];
		
		$exception_id = BeaconExceptions::FindException($trace, $type, $hash);
		if (is_null($exception_id)) {
			http_response_code(404);
			echo json_encode(array(
				'reported' => false,
				'solution' => null,
				'error_reason' => 'Exception has not been reported yet.'
			), JSON_PRETTY_PRINT);
			exit;
		}
	} else {
		if (!BeaconCommon::HasAllKeys($_POST, 'trace', 'type', 'hash', 'build', 'reason')) {
			http_response_code(400);
			echo json_encode(array(
				'reported' => false,
				'solution' => null,
				'error_reason' => 'POST request requires build, hash, type, reason, and trace keys.'
			), JSON_PRETTY_PRINT);
			exit;
		}
		
		$type = $_POST['type'];
		$trace = trim($_POST['trace']);
		$hash = $_POST['hash'];
		$build = intval($_POST['build']);
		$reason = trim($_POST['reason']);
		$user_id = isset($_POST['user_id']) ? $_POST['user_id'] : null;
		$comments = isset($_POST['comments']) ? $_POST['comments'] : null;
		
		if ($build < 34) {
			http_response_code(400);
			echo json_encode(array(
				'reported' => false,
				'solution' => null,
				'error_reason' => 'Build number does not make any sense.'
			), JSON_PRETTY_PRINT);
			exit;
		}
		
		$exception_id = BeaconExceptions::RecordException($trace, $type, $reason, $hash, $build, $user_id);
		if (is_null($exception_id)) {
			http_response_code(500);
			echo json_encode(array(
				'reported' => false,
				'solution' => null,
				'error_reason' => 'Unable to save exception data.'
			), JSON_PRETTY_PRINT);
			exit;
		} elseif (empty($comments) === false) {
			BeaconExceptions::AddComments($exception_id, $comments, $user_id);
		}
	}
	
	$response = array('reported' => true, 'error_reason' => null, 'solution' => null);
	$results = BeaconCommon::Database()->Query('SELECT solution_build, solution_comments FROM exceptions WHERE exception_id = $1;', $exception_id);
	if (!is_null($results->Field('solution_build'))) {
		$response['solution'] = BeaconCommon::AbsoluteURL('/' . basename(__FILE__) . '?uuid=' . urlencode($exception_id));
	}
	
	http_response_code(200);
	echo json_encode($response, JSON_PRETTY_PRINT);
	
	break;
}

?>