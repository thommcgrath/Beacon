<?php

class BeaconDocument extends BeaconDocumentMetadata {
	protected $content = '';
	
	public function Content(bool $compressed = false, bool $parsed = true) {
		$content = $this->content;
		$compressed = $compressed && ($parsed == false);
		$is_compressed = BeaconCommon::IsCompressed($content);
		if ($is_compressed == true && $compressed == false) {
			$content = gzdecode($content);
		} elseif ($is_compressed == false && $compressed == true) {
			return gzencode($content);
		}
		if ($parsed) {
			return json_decode($content, true);
		} else {
			return $content;
		}
	}
	
	protected static function GetFromResult(BeaconRecordSet $results) {
		$document = parent::GetFromResult($results);
		if ($document === null) {
			return null;
		}
		
		if (is_null($results->Field('contents'))) {
			// must be in the user's cloud
			$contents = BeaconCloudStorage::GetFile($document->CloudStoragePath());
			if (empty($contents)) {
				return null;
			}
		} else {
			$contents = $results->Field('contents');
		}
		
		$document->content = $contents;
		
		return $document;
	}
	
	public static function DatabaseColumns() {
		$columns = parent::DatabaseColumns();
		$columns[] = 'contents';
		return $columns;
	}
	
	public static function SaveFromContent(string $document_id, string $user_id, $content, string &$reason, bool $as_migration = false) {
		if (is_array($content)) {
			$document = $content;
		} elseif (is_string($content)) {
			if (BeaconCommon::IsCompressed($content)) {
				$content = gzdecode($content);
			}
			$document = json_decode($content, true);
			if (is_null($document)) {
				$reason = 'Unable to parse JSON.';
				return false;
			}
		} else {
			$reason = 'Supplied content is unknown data type.';
			return false;
		}
		
		if (!BeaconCommon::HasAllKeys($document, 'Version', 'Identifier')) {
			$reason = 'Not all keys are present.';
			return false;
		}
		if (is_null($document_id) == false && strtolower($document['Identifier']) !== strtolower($document_id)) {
			$reason = 'Document UUID of ' . strtolower($document['Identifier']) . ' in content does not match the resource UUID of ' . strtolower($document_id) . '.';
			return false;
		}
		
		$document_version = intval($document['Version']);
		if ($document_version < 2) {
			$reason = 'Version 1 documents are no longer not accepted.';
			return false;
		}
		
		// confirm ownership of the document
		$database = BeaconCommon::Database();
		$document_id = $document['Identifier'];
		$new_document = true;
		$results = $database->Query('SELECT user_id FROM documents WHERE document_id = $1;', $document_id);
		if ($results->RecordCount() == 1) {
			if (strtolower($results->Field('user_id')) !== $user_id) {
				$reason = 'Document ' . $document_id . ' does not belong to you.';
				return false;
			}
			$new_document = false;
		}
		
		// gather document details
		$editor_names = array();
		$mod_ids = array();
		$loot_drops_config = null;
		$console_safe = false;
		$title = '';
		$description = '';
		$difficulty = 4;
		$mask = 1;
		$public = false;
		if (array_key_exists('Map', $document)) {
			$mask = intval($document['Map']);
		}
		if ($document_version >= 3) {
			foreach ($document['Configs'] as $configname => $configcontent) {
				if ($configname === 'LootDrops') {
					$loot_drops_config = $configcontent['Contents'];
					$editor_names[] = $configname;
				} elseif ($configname === 'Metadata') {
					$title = $configcontent['Title'];
					$description = $configcontent['Description'];
					$public = $configcontent['Public'];
				} elseif ($configname === 'Difficulty') {
					$difficulty = intval($configcontent['MaxDinoLevel']) / 30;
				} else {
					$editor_names[] = $configname;
				}
			}
		} else {
			$loot_drops_config = $document['LootSources'];
			if (array_key_exists('Title', $document)) {
				$title = $document['Title'];
			}
			if (array_key_exists('Description', $document)) {
				$description = $document['Description'];
			}
			if (array_key_exists('DifficultyValue', $document)) {
				$difficulty = $document['DifficultyValue'];
			}
			if (array_key_exists('Public', $document)) {
				$public = $document['Public'];
			}
			$editor_names[] = 'LootDrops';
		}
		if (is_null($loot_drops_config) === false) {
			$engram_classes = array();
			$engram_paths = array();
			try {
				foreach($loot_drops_config as $drop) {
					$sets = $drop['ItemSets'];
					foreach ($sets as $set) {
						$entries = $set['ItemEntries'];
						foreach ($entries as $entry) {
							$items = $entry['Items'];
							foreach ($items as $item) {
								if (array_key_exists('Path', $item)) {
									$engram_paths[] = $database->EscapeLiteral($item['Path']);
								} elseif (array_key_exists('Class', $item)) {
									$engram_classes[] = $database->EscapeLiteral($item['Class']);
								}
							}
						}
					}
				}
				
				$engram_classes = array_unique($engram_classes);
				$engram_paths = array_unique($engram_paths);
				$clauses = array();
				if (count($engram_classes) > 0) {
					$clauses[] = 'engrams.class_string IN (' . implode(',', $engram_classes) . ')';
				}
				if (count($engram_paths) > 0) {
					$clauses[] = 'engrams.path IN (' . implode(',', $engram_paths) . ')';
				}
				
				if (count($clauses) > 0) {
					try {
						$mods_lookup = $database->Query('SELECT DISTINCT mods.mod_id, mods.console_safe FROM engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id) WHERE ' . implode(' OR ', $clauses) . ';');
						if ($mods_lookup->RecordCount() > 0) {
							$console_safe = true;
						}
						while (!$mods_lookup->EOF()) {
							$console_safe = $console_safe && $mods_lookup->Field('console_safe');
							$mod_ids[] = $mods_lookup->Field('mod_id');
							$mods_lookup->MoveNext();
						}
						
						// that finds us the known mods, but doesn't help us with the rest.
						if (array_key_exists('23ecf24c-377f-454b-ab2f-d9d8f31a5863', $mod_ids) === false && count($engram_classes) > 0) {
							$unknown_results = $database->Query('SELECT * FROM (VALUES (' . implode('),(', $engram_classes) . ')) AS list(class_string) WHERE NOT EXISTS (SELECT class_string FROM engrams WHERE engrams.class_string = list.class_string);');
							if ($unknown_results->RecordCount() > 0) {
								$console_safe = false;
								$mod_ids[] = '23ecf24c-377f-454b-ab2f-d9d8f31a5863';
							}
						}
						if (array_key_exists('23ecf24c-377f-454b-ab2f-d9d8f31a5863', $mod_ids) === false && count($engram_paths) > 0) {
							$unknown_results = $database->Query('SELECT * FROM (VALUES (' . implode('),(', $engram_paths) . ')) AS list(path) WHERE NOT EXISTS (SELECT path FROM engrams WHERE engrams.path = list.path);');
							if ($unknown_results->RecordCount() > 0) {
								$console_safe = false;
								$mod_ids[] = '23ecf24c-377f-454b-ab2f-d9d8f31a5863';
							}
						}
					} catch (Exception $err) {
						$reason = 'Database error: ' . $err->getMessage();
						return false;
					}
				}
			} catch (Exception $err) {
			}
		}
		
		if (BeaconCloudStorage::PutFile(BeaconDocument::GenerateCloudStoragePath($user_id, $document_id), gzencode(json_encode($document))) === false) {
			$reason = 'Unable to upload document to cloud storage platform.';
			return false;
		}
		
		$mods = '{' . implode(',',$mod_ids) . '}';
		$editors = '{' . implode(',', $editor_names) . '}';
		try {
			$database->BeginTransaction();
			if ($new_document) {
				$database->Query('INSERT INTO documents (document_id, user_id, title, description, map, difficulty, console_safe, mods, included_editors, last_update) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, CURRENT_TIMESTAMP);', $document_id, $user_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
			} else {
				if ($as_migration) {
					$database->Query('UPDATE documents SET title = $3, description = $4, map = $5, difficulty = $6, console_safe = $7, mods = $8, included_editors = $9, contents = NULL WHERE document_id = $1 AND user_id = $2;', $document_id, $user_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
				} else {
					$database->Query('UPDATE documents SET revision = revision + 1, title = $3, description = $4, map = $5, difficulty = $6, console_safe = $7, mods = $8, included_editors = $9, last_update = CURRENT_TIMESTAMP WHERE document_id = $1 AND user_id = $2;', $document_id, $user_id, $title, $description, $mask, $difficulty, $console_safe, $mods, $editors);
				}
			}
			$database->Commit();
		} catch (Exception $err) {
			$reason = 'Database error: ' . $err->getMessage();
			return false;
		}
		
		// see if a publish request is needed
		$results = $database->Query('SELECT published FROM documents WHERE document_id = $1;', $document_id);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($public) {
			if ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED_PRIVATE) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED;
			} elseif ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_PRIVATE) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_REQUESTED;
				
				$attachment = array(
					'title' => $title,
					'text' => $description,
					'fallback' => 'Unable to show response buttons.',
					'callback_id' => 'publish_document:' . $document_id,
					'actions' => array(
						array(
							'name' => 'status',
							'text' => 'Approve',
							'type' => 'button',
							'value' => BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED,
							'confirm' => array(
								'text' => 'Are you sure you want to approve this document?',
								'ok_text' => 'Approve'
							)
						),
						array(
							'name' => 'status',
							'text' => 'Deny',
							'type' => 'button',
							'value' => BeaconDocumentMetadata::PUBLISH_STATUS_DENIED,
							'confirm' => array(
								'text' => 'Are you sure you want to reject this document?',
								'ok_text' => 'Deny'
							)
						)
					),
					'fields' => array()
				);
				
				$user = BeaconUser::GetByUserID($user_id);
				if (is_null($user) === false) {
					if ($user->IsAnonymous()) {
						$username = 'Anonymous';
					} else {
						$username = $user->Username() . '#' . $user->Suffix();
					}
					$attachment['fields'][] = array(
						'title' => 'Author',
						'value' => $username
					);
				}
				
				$obj = array(
					'text' => 'Request to publish document',
					'attachments' => array($attachment)
				);
				BeaconCommon::PostSlackRaw(json_encode($obj));	
			}
		} else {
			if ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED_PRIVATE;
			} elseif ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_REQUESTED) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_PRIVATE;
			}
		}
		if ($new_status != $current_status) {
			$database->BeginTransaction();
			$database->Query('UPDATE documents SET published = $2 WHERE document_id = $1;', $document_id, $new_status);
			$database->Commit();
		}
		
		return true;
	}
}

?>