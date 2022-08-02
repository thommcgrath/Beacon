<?php

abstract class BeaconExceptions {
	// Truncates a stack trace to only lines that actually mean something.
	public static function CleanupStackTrace(string $trace): array {
		$trace = str_replace(chr(13) . chr(10), chr(10), $trace); // CRLF to LF
		$trace = str_replace(chr(13), chr(10), $trace); // CR to LF
		$raw_lines = explode(chr(10), $trace);
		$meaningful_lines = [];
		foreach ($raw_lines as $line) {
			$line = trim($line);
			if (empty($line)) {
				continue;
			}
			if (substr($line, 0, 1) == '_' || $line == 'TimerEnabledGetter' || strpos($line, '._') !== false) {
				break;
			}
			$meaningful_lines[] = $line;
		}
		return $meaningful_lines;
	}
	
	// Finds an exception based on its trace, but does not change anything.
	public static function FindException(string $trace, string $type, string $client_hash): ?string {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT DISTINCT exception_id FROM exception_signatures WHERE client_hash = $1 LIMIT 1;', $client_hash);
		if ($results->RecordCount() === 1) {
			return $results->Field('exception_id');
		}
		
		$trace_cleaned = static::CleanupStackTrace($trace);
		if (count($trace_cleaned) == 0) {
			return null;
		}
		
		$location = $trace_cleaned[0];
		$results = $database->Query('SELECT exception_id, trace FROM exceptions WHERE LOWER(location) = $1 AND LOWER(exception_class) = $2;', strtolower($location), strtolower($type));
		$best_id = null;
		$best_score = null;
		while (!$results->EOF()) {
			$score = static::CompareTraces($trace_cleaned, static::CleanupStackTrace($results->Field('trace')));
			if ($score == 1.0) {
				return $results->Field('exception_id');
			} elseif ($score > 0.6 && (is_null($best_id) || $score > $best_score)) {
				$best_id = $results->Field('exception_id');
				$best_score = $score;
			}
			$results->MoveNext();
		}
		
		if (is_null($best_id) === false) {
			// Didn't find a perfect match, but found a good match.
			return $best_id;
		}
		
		return null;
	}	
	
	// Records the exception and returns the uuid or null on error.
	public static function RecordException(string $trace, string $type, string $reason, string $client_hash, int $client_build, ?string $user_id): ?string {
		$exception_id = static::FindException($trace, $type, $client_hash);
		if (is_null($exception_id) === false && static::UpdateException($exception_id, $trace, $client_hash, $client_build, $user_id)) {
			return $exception_id;
		}
		
		return static::CreateException($trace, $type, $reason, $client_hash, $client_build, $user_id);
	}
	
	// Updates an existing exception with additional data and returns true or false.
	private static function UpdateException(string $exception_id, string $trace, string $client_hash, int $client_build, ?string $user_id): bool {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT solution_build, min_reported_build, max_reported_build, location, reason FROM exceptions WHERE exception_id = $1;', $exception_id);
		if ($results->RecordCount() == 0) {
			return false;
		}
		
		$location = $results->Field('location');
		$reason = $results->Field('reason');
		$solution_build = $results->Field('solution_build');
		$min_build = $results->Field('min_reported_build');
		$max_build = $results->Field('max_reported_build');
		$changes = [];
		if (is_null($solution_build) == false && $client_build >= $solution_build) {
			// This previously solved exception is no longer solved.
			$changes['solution_build'] = null;
			$changes['solution_comments'] = null;
		}
		if ($client_build < $min_build) {
			$changes['min_reported_build'] = $client_build;
		}
		if ($client_build > $max_build) {
			$changes['max_reported_build'] = $client_build;
		}
		$database->BeginTransaction();
		if (count($changes) > 0) {
			$database->Update('exceptions', $changes, ['exception_id' => $exception_id]);
		}
		$database->Query('INSERT INTO exception_signatures (exception_id, client_build, client_hash, trace) VALUES ($1, $2, $3, $4) ON CONFLICT DO NOTHING;', $exception_id, $client_build, $client_hash, $trace);
		if (is_null($user_id) == false) {
			$database->Query('INSERT INTO exception_users (exception_id, user_id) SELECT $1, user_id FROM users WHERE user_id = $2 ON CONFLICT DO NOTHING;', $exception_id, $user_id);
		}
		$database->Commit();
		
		if (count($changes) > 0) {
			$details_url = BeaconCommon::AbsoluteURL('/reportaproblem?uuid=' . urlencode($exception_id) . '&action=view');
			$arr = [
				'attachments' => [
					[
						'title' => 'An exception in ' . $location . ' has been updated.',
						'title_link' => $details_url,
						'text' => $reason,
						'fields' => [
							[
								'title' => 'Min Version',
								'value' => BeaconCommon::BuildNumberToVersion(min($client_build, $min_build)),
								'short' => true
							],
							[
								'title' => 'Max Version',
								'value' => BeaconCommon::BuildNumberToVersion(max($client_build, $max_build)),
								'short' => true
							]
						]
					]
				]
			];
			BeaconCommon::PostSlackRaw(json_encode($arr));
		}
		
		return true;
	}
	
	// Records a new exception and returns the uuid or null on error.
	private static function CreateException(string $trace, string $type, string $reason, string $client_hash, int $client_build, ?string $user_id): ?string {
		$trace_cleaned = static::CleanupStackTrace($trace);
		if (count($trace_cleaned) == 0) {
			return null;
		}
		
		$location = $trace_cleaned[0];
		$exception_id = BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO exceptions (exception_id, min_reported_build, max_reported_build, exception_class, location, reason, trace) VALUES ($1, $2, $2, $3, $4, $5, $6);', $exception_id, $client_build, $type, $location, $reason, $trace);
		$database->Query('INSERT INTO exception_signatures (exception_id, client_build, client_hash, trace) VALUES ($1, $2, $3, $4);', $exception_id, $client_build, $client_hash, $trace);
		if (!is_null($user_id)) {
			$database->Query('INSERT INTO exception_users (exception_id, user_id) SELECT $1, user_id FROM users WHERE user_id = $2;', $exception_id, $user_id);
		}
		$database->Commit();
		
		$details_url = BeaconCommon::AbsoluteURL('/reportaproblem?uuid=' . urlencode($exception_id) . '&action=view');
		$arr = [
			'attachments' => [
				[
					'title' => 'New ' . $type . ' in ' . $location . ' reported',
					'title_link' => $details_url,
					'text' => $reason,
					'fields' => [
						[
							'title' => 'Version',
							'value' => BeaconCommon::BuildNumberToVersion($client_build),
							'short' => true
						]
					]
				]
			]
		];
		BeaconCommon::PostSlackRaw(json_encode($arr));
		
		return $exception_id;
	}
	
	// Returns a value between 0 and 1, the higher the value, the better the match.
	private static function CompareTraces(array $left_trace, array $right_trace): float {
		if (count($left_trace) == 0 || count($right_trace) == 0) {
			return 0;
		}
		
		$potential_score = 0;
		$score = 0;
		$num = min(count($left_trace), count($right_trace));
		for ($i = 0; $i < $num; $i++) {
			$left_line = strtolower($left_trace[$i]);
			$right_line = strtolower($right_trace[$i]);
			$potential_value = 100 / ($i + 1);
			$potential_score += $potential_value;
			
			if ($left_line == $right_line) {
				$score += $potential_value;
			}
		}
		return ($score / $potential_score);
	}
	
	// Add comments to exception
	public static function AddComments(string $exception_id, string $comments, ?string $user_id): bool {
		try {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('INSERT INTO exception_comments (exception_id, comments, user_id) VALUES ($1, $2, $3);', $exception_id, $comments, $user_id);
			$database->Commit();
			
			$results = $database->Query('SELECT location, solution_build FROM exceptions WHERE exception_id = $1;', $exception_id);
			$location = $results->Field('location');
			
			if (is_null($results->Field('solution_build'))) {
				$details_url = BeaconCommon::AbsoluteURL('/reportaproblem?uuid=' . urlencode($exception_id) . '&action=view');
				$arr = [
					'attachments' => [
						[
							'title' => 'New exception comment',
							'title_link' => $details_url,
							'text' => $comments,
							'fields' => [
								[
									'title' => 'Location',
									'value' => $location,
									'short' => false
								]
							]
						]
					]
				];
				
				if (!is_null($user_id)) {
					$user = BeaconUser::GetByUserID($user_id);
					if (!is_null($user)) {
						$arr['attachments'][0]['fields'][] = [
							'title' => 'User',
							'value' => $user->Username() . '#' . $user->Suffix(),
							'short' => false
						];
					}
				}
				
				BeaconCommon::PostSlackRaw(json_encode($arr));
			}
			
			return true;
		} catch (Exception $e) {
			return false;
		}
	}
}

?>