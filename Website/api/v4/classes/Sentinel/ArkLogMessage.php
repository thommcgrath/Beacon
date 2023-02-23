<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconCommon;

/* Examples
Player Death:
	Zeke - Lvl 130 () was killed by a Sabertooth - Lvl 800 ()!
	ty - Lvl 130 (alajme) was killed!
	One punch man - Lvl 130 () was killed! [KillerSID: 960237409]
	Humain - Lvl 130 (Alpha) was killed by Griffin [Clone] - Lvl 1259 (Griffin) (Twinkle Toes)! [KillerSID: 24178472]
	Shadow - Lvl 130 (IGWT) was killed by Yeet - Lvl 1300 (Paraceratherium) (Rust Gigachat)!
		
Dino Death:
	Bloodstalker - Lvl 136 (Bloodstalker) () was killed by a Carnotaurus - Lvl 480 ()!

Tribemember Death:
	Tribemember Humain - Lvl 130 was killed by Griffin [Clone] - Lvl 1259 (Griffin) (Twinkle Toes)!)
	Tribemember Humain - Lvl 130 was killed by Tweaker - Lvl 1459 (Giganotosaurus)!)
	Tribemember Humain - Lvl 130 was killed by V2 910 - Lvl 130!)
	Tribemember Bye - Lvl 130 was killed!)
	
Tribemember Kill:
	Your Tribe killed Gary - Lvl 130 (Tribe of Bye)!)
	Your Tribe killed Pteranodon - Lvl 1180 (Pteranodon) (M O N K E Y)!)
	Your Tribe killed Rex [Clone] - Lvl 1259 (Rex)!)

*/

class ArkLogMessage extends LogMessage {
	const TribeMessagePattern = 'Tribe (?P<tribe_name>.+), ID (?P<tribe_id>\d+): Day (?P<clock_day>\d+), (?P<clock_hour>\d{2}):(?P<clock_minute>\d{2}):(?P<clock_second>\d{2}):';
	const Patterns = [
		'Partial' => [
			'Timestamp' => '/^\d{4}\.\d{2}\.\d{2}_\d{2}\.\d{2}\.\d{2}: /',
			'Rich Color' => '/<RichColor Color="([0-9\.]+), ([0-9\.]+), ([0-9\.]+), ([0-9\.]+)">(.+?(?=<\/>))<\/>/',
			'Chat Image' => '/<img src="Chat.Image" path="(.+?)"\/>/'
		],
		'Full' => [
			'Player Joined' => '/^(?P<player_name>.+) joined this ARK!$/',
			'Player Left' => '/^(?P<player_name>.+) left this ARK!$/',
			'Login Request' => '/^Login request: .+?=(?P<player_name>.+)$/',
			'Dupe Removal' => '/^Removed duped item due to (?P<reason>.+), (?P<item_class>.+)(_\d+), from (?P<structure_class>.+)(_\d+), owned by Tribe (?P<tribe_name>.+) \((?P<tribe_id>\d+)\)$/',
			'Auto Destroy' => '/^' . self::TribeMessagePattern . ' Your \'(?P<structure_class>.+)\' was auto-decay destroyed!$/',
			'Tribe Lost Structure' => '/^' . self::TribeMessagePattern . ' (.+) - Lvl \d+( \((.+)\))? destroyed your \'(.+)\'!$/',
			'Tribe Destroyed Structure' => '/^' . self::TribeMessagePattern . ' (.+) - Lvl \d+ destroyed their \'(.+)\s+\((.+)\)\'\)!$/',
			'Dino Death' => '/^(?P<dino_name>.+?) - Lvl (?P<dino_level>\d+) \((?P<dino_species>.*?)\) \((?P<tribe_name>.*?)\) was killed( by ((a (?P<wild_dino_species>.+?) - Lvl (?P<wild_dino_level>\d+))|((?P<enemy_dino_name>.+?) - Lvl (?P<enemy_dino_level>\d+) \((?P<enemy_dino_species>.+?)\))))?( \((?P<enemy_tribe_name>.*?)\))?!( \[KillerSID: (?P<killer_sid>\d+)\])?$/',
			'Player Death' => '/^(?P<player_name>.+?) - Lvl (?P<player_level>\d+) \((?P<tribe_name>.*?)\) was killed( by ((a (?P<wild_dino_species>.+?) - Lvl (?P<wild_dino_level>\d+))|((?P<enemy_dino_name>.+?) - Lvl (?P<enemy_dino_level>\d+) \((?P<enemy_dino_species>.+?)\))))?( \((?P<enemy_tribe_name>.*?)\))?!( \[KillerSID: (?P<killer_sid>\d+)\])?$/',
			'Tribemember Death' => '/^' . self::TribeMessagePattern . ' Tribemember (?P<victim_name>.+?) - Lvl (?P<victim_level>\d+) was killed( by (?P<enemy_name>.+?) - Lvl (?P<enemy_level>\d+)( \((?P<enemy_species>.+?)\))?( \((?P<enemy_tribe_name>.+?)\))?)?!\)$/',
			'Tribemember Kill' => '/^' . self::TribeMessagePattern . ' Your Tribe killed (?P<victim_name>.+?) - Lvl (?P<victim_level>\d+)( \((?P<victim_species>.+?)\))?( \((?P<enemy_tribe_name>.+?)\))?!\)$/',
			'Cryopod Freeze' => '/^' . self::TribeMessagePattern . ' (?P<player_name>.+?) froze (?P<dino_name>.+?) - Lvl (?P<dino_level>\d+) \((?P<dino_species>.+)\)\)$/',
			'Dino Frozen By' => '/^Frozen by ID: (?P<player_id>\d+)$/',
			'Tamed' => '/^(.+?)( of Tribe (.*))? Tamed a (.+) - Lvl (\d+) \(.+\)!$/',
			'Claimed' => '//',
			'Chat' => '/^(.+) \((.+?)\): (.+)$/',
			'Dino Uploaded' => '//',
			'Dino Downloaded' => '//',
			'Player Joined Tribe' => '//',
			'Player Left Tribe' => '//'
		]
	];
	
	protected static function ParseTimestamp(string $timestamp): float {
		$timeExpression = '/^(\d{4})\.(\d{2})\.(\d{2})-(\d{2})\.(\d{2})\.(\d{2}):(\d{3})$/';
		if (preg_match($timeExpression, $timestamp, $matches) !== 1) {
			return 0;
		}
		
		return gmmktime($matches[4], $matches[5], $matches[6], $matches[2], $matches[3], $matches[1]) + ($matches[7] / 1000);
	}
	
	protected static function HookConsumeLogLines(string $serviceId, float $lastTimestamp, array $lines): array {
		$messages = [];
		$consecutiveMessages = [];
		$consecutiveTimestamp = 0;
		$partialExpressions = self::Patterns['Partial'];
		$lineCount = min(count($lines), 2000);
		
		for ($idx = 0; $idx < $lineCount; $idx++) {
			$line = $lines[$idx];
			if (strlen($line) < 60) {
				continue;
			}
			
			$timestamp = static::ParseTimestamp(substr($line, 1, 23));
			if ($timestamp === 0 || $timestamp <= $lastTimestamp) {
				continue;
			}
			
			// remove the timestamp
			$line = substr($line, 30);
			
			// if the line starts with a second time stamp, we don't care
			if (preg_match($partialExpressions['Timestamp'], $line) === 1) {
				$line = substr($line, 21);
			}
			
			// remove line coloring
			$line = preg_replace($partialExpressions['Rich Color'], '\5', $line);
			
			// fix emoji
			$line = preg_replace_callback($partialExpressions['Chat Image'], function($matches) {
				return static::ResolveChatImage($matches[1]);
			}, $line);
			
			if (count($consecutiveMessages) === 0) {
				$consecutiveMessages[] = $line;
			} else {
				if ($timestamp - $consecutiveTimestamp < 0.005) {
					$consecutiveMessages[] = $line;
				} else {
					$messages = array_merge($messages, static::ProcessLineGroup($serviceId, $consecutiveMessages, $consecutiveTimestamp));
					$consecutiveMessages = [$line];
				}
			}
			$consecutiveTimestamp = $timestamp;
			
			/*$metadata = [];
			$level = self::LogLevelInfo;
			$should_analyze = false;
				
			// player join messages
			(function (&$line, &$level, &$metadata, &$should_analyze, $expressions) {
				if (preg_match($expressions['player_joined'], $line, $matches) === 1) {
					$metadata['player']['name'] = $matches[1];
					$metadata['event'] = 'Player Join';
					return;
				}
				
				if (preg_match($expressions['player_left'], $line, $matches) === 1) {
					$metadata['player']['name'] = $matches[1];
					$metadata['event'] = 'Player Left';
					return;
				}
				
				if (preg_match($expressions['login_request'], $line, $matches) === 1) {
					$level = self::LogLevelDebug;
					$metadata['player']['name'] = trim($matches[1]);
					$metadata['event'] = 'Login Request';
					return;
				}
				
				if (preg_match($expressions['dupe_removal'], $line, $matches) === 1) {
					$level = self::LogLevelNotice;
					$metadata['event'] = 'Duplicate Item Removed';
					$metadata['tribe']['name'] = $matches[6];
					$metadata['tribe']['id'] = intval($matches[7]);
					$metadata['reason'] = $matches[1];
					$metadata['item_class'] = $matches[2];
					$metadata['structure_class'] = $matches[4];
					return;
				}
				
				if (preg_match($expressions['tribe_message'], $line, $matches) === 1) {
					$metadata['tribe']['name'] = $matches[1];
					$metadata['tribe']['id'] = intval($matches[2]);
					$metadata['clock']['day'] = intval($matches[3]);
					$metadata['clock']['time'] = intval($matches[4] . $matches[5] . $matches[6]);
					$line = $matches[7];
					// don't return
				}
				
				if (preg_match($expressions['tribe_lost_structure'], $line, $matches) === 1) {
					$metadata['event'] = 'Lost Structure';
					if (!empty($matches[3])) {
						$metadata['attacker']['tribe']['name'] = $matches[3];
						$metadata['attacker']['player']['name'] = $matches[1];
					} else {
						$metadata['attacker']['dino']['name'] = $matches[1];
					}
					$metadata['victim']['tribe'] = $metadata['tribe']['name'];
					$metadata['lost_structure'] = trim($matches[4]);
					return;
				}
				
				if (preg_match($expressions['tribe_destroyed_structure'], $line, $matches) === 1) {
					$metadata['event'] = 'Destroyed Structure';
					$metadata['attacker']['player'] = $matches[1];
					$metadata['attacker']['tribe'] = $metadata['tribe']['name'];
					$metadata['victim']['tribe'] = $matches[3];
					$metadata['lost_structure'] = trim($matches[2]);
					// remove the extra closing parenthesis, thanks Wildcard.
					if (str_ends_with($line, ')\')!')) {
						$line = substr($line, 0, -2) . '!';
					}
					return;	
				}
				
				if (preg_match($expressions['auto_decay'], $line, $matches) === 1) {
					$metadata['event'] = 'Auto Destroy';
					return;	
				}
				
				if (preg_match($expressions['tamed'], $line, $matches) === 1) {
					$metadata['event'] = 'Wild Tame';
					$metadata['dino']['species'] = $matches[4];
					$metadata['dino']['level'] = intval($matches[5]);
					$metadata['player']['name'] = $matches[1];
					if (!empty($matches[3]) && !isset($metadata['tribe']['name'])) {
						$metadata['tribe']['name'] = $matches[3];
					}
					return;
				}
				
				if (preg_match($expressions['cryopod_freeze'], $line, $matches) === 1) {
					$metadata['event'] = 'Cryopod Freeze';
					$metadata['player']['name'] = $matches[1];
					$metadata['dino']['name'] = $matches[2];
					$metadata['dino']['level'] = intval($matches[3]);
					$metadata['dino']['species'] = $matches[4];
					return;
				}
				
				// detect chat last
				if (preg_match($expressions['chat'], $line, $matches) === 1) {
					$metadata['event'] = 'Chat';
					$metadata['player']['name'] = $matches[1];
					$metadata['tribe']['name'] = $matches[2];
					$line = $matches[3];
					$should_analyze = strlen($line) > 2;
					return;
				}
				
				// this message was not identified
				$metadata['event'] = 'Unidentified';
			})($line, $level, $metadata, $should_analyze, $expressions);
			
			$message = static::Create($line, $serviceId);
			$message->time = $timestamp;
			$message->type = self::LogTypeGameplay;
			$message->metadata = $metadata;
			$message->level = $level;
			if ($should_analyze) {
				$message->analyzer_status = self::AnalyzerStatusPending;
			}*/
		}
		
		if (count($consecutiveMessages) > 0) {
			$messages = array_merge($messages, static::ProcessLineGroup($serviceId, $consecutiveMessages, $consecutiveTimestamp));
		}
		
		return $messages;
	}
	
	protected static function ProcessLineGroup(string $serviceId, array $lines, float $timestamp): array {
		$messages = [];
		
		$expressions = self::Patterns['Full'];
		$pool = $lines;
		$results = [];
		for ($idx = count($pool) - 1; $idx >= 0; $idx--) {
			foreach ($expressions as $expression => $pattern) {
				if (empty($pattern) || $pattern === '//') {
					continue;
				}
				
				if (preg_match($pattern, $pool[$idx], $matches) === 1) {
					$siblings = $results[$expression] ?? [];
					$siblings[] = $matches;
					$results[$expression] = $siblings;
					unset($pool[$idx]);
					continue 2;
				}
			}
			
			// unmatched
			$siblings = $results['Unidentified'] ?? [];
			$siblings[] = [$pool[$idx]];
			$results['Unidentified'] = $siblings;
		}
		
		/*echo "results:\n";
		echo json_encode($results, JSON_PRETTY_PRINT);
		echo "\n";*/
		
		if (isset($results['Dupe Removal'])) {
			$siblings = $results['Dupe Removal'];
			foreach ($siblings as $matches) {
				$message = static::Create($matches[0], $serviceId);
				$message->time = $timestamp;
				$message->type = self::LogTypeGameplay;
				$message->level = self::LogLevelNotice;
				$message->metadata = [
					'event' => 'Duplicate Item Removed',
					'tribe' => [
						'name' => $matches['tribe_name'],
						'id' => intval($matches['tribe_id'])
					],
					'reason' => $matches['reason'],
					'item' => [
						'class' => $matches['item_class']
					],
					'structure' => [
						'class' => $matches['structure_class']
					]
				];
				$messages[] = $message;
			}
		}
		
		$simplePlayerMessages = ['Player Joined', 'Player Left', 'Login Request'];
		foreach ($simplePlayerMessages as $messageClass) {
			if (isset($results[$messageClass])) {
				$siblings = $results[$messageClass];
				foreach ($siblings as $matches) {
					$message = static::Create($matches[0], $serviceId);
					$message->time = $timestamp;
					$message->type = self::LogTypeGameplay;
					$message->metadata = [
						'event' => $messageClass,
						'player' => [
							'name' => trim($matches['player_name'])
						]
					];
					$messages[] = $message;
				}
			}
		}
		
		if (isset($results['Cryopod Freeze'])) {
			$siblings = $results['Cryopod Freeze'];
			$idLines = $results['Dino Frozen By'] ?? [];
			
			for ($idx = 0; $idx < count($siblings); $idx++) {
				$matches = $siblings[$idx];
				$player = [
					'name' => $matches['player_name']
				];
				$dino = [
					'name' => $matches['dino_name'],
					'level' => intval($matches['dino_level']),
					'species' => $matches['dino_species']
				];
				
				if (isset($idLines[$idx])) {
					$player['id'] = intval($idLines[$idx][1]);
				}
				
				$metadata = [
					'event' => 'Cryopod Freeze',
					'player' => $player,
					'dino' => $dino
				];
				
				$tribe = static::CreateTribeStructure($matches);
				if (is_null($tribe) === false) {
					$metadata['tribe'] = $tribe;
				}
				
				$clock = static::CreateClockStructure($matches);
				if (is_null($clock) === false) {
					$metadata['clock'] = $clock;
				}
				
				$message = static::Create("{$dino['name']} - Lvl {$dino['level']} ({$dino['species']}) was frozen by {$player['name']} ({$player['id']})", $serviceId);
				$message->time = $timestamp;
				$message->type = self::LogTypeGameplay;
				$message->metadata = $metadata;
				$messages[] = $message;
			}
		}
		
		if (isset($results['Player Death'])) {
			$siblings = $results['Player Death'];
			$victimTribeNotices = $results['Tribemember Death'] ?? [];
			$attackerTribeNotices = $results['Tribemember Kill'] ?? [];
			
			/*echo "siblings\n";
			echo json_encode($siblings, JSON_PRETTY_PRINT) . "\n";
			if (empty($victimTribeNotices) === false) {
				echo "victim notices\n";
				echo json_encode($victimTribeNotices, JSON_PRETTY_PRINT) . "\n";
			}
			if (empty($attackerTribeNotices) === false) {
				echo "attacker notices\n";
				echo json_encode($attackerTribeNotices, JSON_PRETTY_PRINT) . "\n";
			}*/
			
			for ($idx = 0; $idx < count($siblings); $idx++) {
				$matches = $siblings[$idx];
				
				$metadata = [
					'event' => 'Player Death',
					'player' => [
						'name' => $matches['player_name'],
						'level' => intval($matches['player_level'])
					]
				];
				if (empty($matches['tribe_name']) === false) {
					$metadata['tribe'] = [
						'name' => $matches['tribe_name']
					];	
				}
				
				$logLine = '';
				if (empty($matches['wild_dino_species']) === false) {
					// Killed by wild dino
					$metadata['killer'] = [
						'type' => 'Wild Dino',
						'species' => $matches['wild_dino_species'],
						'level' => intval($matches['wild_dino_level'])
					];
					$logLine = "{$matches['player_name']} was killed by a wild {$matches['wild_dino_species']}";
				} elseif (empty($matches['enemy_dino_name']) === false) {
					// Killed by tamed dino
					$metadata['killer'] = [
						'type' => 'Tamed Dino',
						'species' => $matches['enemy_dino_species'],
						'level' => intval($matches['enemy_dino_level']),
						'name' => $matches['enemy_dino_name']
					];
					$logLine = "{$matches['player_name']} was killed by a tamed {$matches['enemy_dino_species']}";
					if (empty($matches['enemy_tribe_name']) === false) {
						$logLine .= " owned by {$matches['enemy_tribe_name']}";
						$metadata['tribe'] = [
							'name' => $matches['enemy_tribe_name']
						];
					}
					if (empty($matches['killer_sid']) === false) {
						$metadata['killer']['rider']['implant'] = intval($matches['killer_sid']);
						if (empty($matches['enemy_tribe_name']) === false) {
							$logLine .= " and";	
						}
						$logLine .= " ridden by {$matches['killer_sid']}";
					}
				} elseif (empty($matches['killer_sid']) === false) {
					// Killed by another player ?
					$metadata['killer'] = [
						'type' => 'Player',
						'player' => [
							'implant' => intval($matches['killer_sid'])
						]
					];
					$logLine = "{$matches['player_name']} was killed by {$matches['killer_sid']}";
				} else {
					// Just... died
					$metadata['killer'] = [
						'type' => 'Mishap'
					];
					$logLine = "{$matches['player_name']} died";
				}
				
				foreach ($attackerTribeNotices as $notice) {
					if ($notice['victim_name'] === $matches['player_name'] && $notice['victim_level'] === $matches['player_level']) {
						$metadata['killer']['tribe'] = [
							'name' => $notice['tribe_name'],
							'id' => $notice['tribe_id']
						];
						if ($metadata['killer']['type'] === 'Mishap') {
							$metadata['killer']['type'] = 'Player';
							$logLine = "{$matches['player_name']} was killed by tribe {$notice['tribe_name']}";
						}
						break;
					}
				}
				
				$message = static::Create($logLine, $serviceId);
				$message->time = $timestamp;
				$message->type = self::LogTypeGameplay;
				$message->metadata = $metadata;
				$messages[] = $message;
			}
		}
		
		if (isset($results['Unidentified'])) {
			$siblings = $results['Unidentified'];
			foreach ($siblings as $matches) {
				$message = static::Create($matches[0], $serviceId);
				$message->time = $timestamp;
				$message->type = self::LogTypeGameplay;
				$message->metadata = [
					'event' => 'Unidentified'
				];
				$messages[] = $message;
			}
		}
		
		/*foreach ($lines as $line) {
			if (array_key_exists($line, $results)) {
				$analysis = $results[$line];
				switch ($analysis['expression']) {
				case 'Dupe Removal':
					break;
				}
			} else {
				$message = static::Create($line, $serviceId);
				$message->time = $timestamp;
				$message->type = self::LogTypeGameplay;
				$message->metadata = [
					'event' => 'Unidentified'
				];
				$messages[] = $message;
			}
		}*/
		
		return $messages;
	}
	
	protected static function CreateTribeStructure(array $matches): ?array {
		if (BeaconCommon::HasAllKeys($matches, 'tribe_name', 'tribe_id') === false) {
			return null;
		}
		
		return [
			'name' => $matches['tribe_name'],
			'id' => $matches['tribe_id']
		];
	}
	
	protected static function CreateClockStructure(array $matches): ?array {
		if (BeaconCommon::HasAllKeys($matches, 'clock_day', 'clock_hour', 'clock_minute', 'clock_second') === false) {
			return null;
		}
		
		return [
			'day' => intval($matches['clock_day']),
			'time' => intval($matches['clock_hour'] . $matches['clock_minute'] . $matches['clock_second'])
		];
	}
	
	
	
	protected static function ResolveChatImage(string $image_path): string {
		switch ($image_path) {
		case '/Game/PrimalEarth/Emo/Emo_Blank.Emo_Blank':
			return '😐';
		case '/Game/PrimalEarth/Emo/Emo_Evil.Emo_Evil':
			return '😈';
		case '/Game/PrimalEarth/Emo/Emo_Eyes.Emo_Eyes':
			return '😳';
		case '/Game/PrimalEarth/Emo/Emo_Laugh.Emo_Laugh':
			return '😃';
		case '/Game/PrimalEarth/Emo/Emo_Sad.Emo_Sad':
			return '😢';
		case '/Game/PrimalEarth/Emo/Emo_Smile.Emo_Smile':
			return '😊';
		case '/Game/PrimalEarth/Emo/Emo_Tongue.Emo_Tongue':
			return '😝';
		case '/Game/PrimalEarth/Emo/Emo_Wink.Emo_Wink':
			return '😉';
		default:
			return "Image:$image_path:";
		}
	}
}

?>
