<?php

class BeaconSearch {
	private $requests = [];
	private $results = [];
	private $total_result_count = 0;
	private $raw_response = null;
	private $applicationId;

	public function __construct(string $appId) {
		$this->applicationId = $appId;
	}

	public function SaveObject(string $object_id, bool $autocommit = true) {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT search_contents.id, search_contents.title, search_contents.body, search_contents.preview, search_contents.meta_content, search_contents.type, search_contents.subtype, search_contents.uri, search_contents.min_version, search_contents.max_version, search_contents.game_id, games.game_name, content_packs.content_pack_id, content_packs.name AS content_pack_name FROM search_contents LEFT JOIN public.content_packs ON (search_contents.mod_id = content_packs.content_pack_id) LEFT JOIN public.games ON (search_contents.game_id = games.game_id) WHERE (content_packs.confirmed = TRUE OR search_contents.mod_id IS NULL) AND search_contents.id = $1;', $object_id);
		if ($rows->RecordCount() === 0) {
			return false;
		}
		$this->SaveObjectRows($rows);
		if ($autocommit) {
			return $this->Commit();
		}
	}

	public function DeleteObject(string $object_id, bool $autocommit = true): bool {
		$this->requests[] = [
			'action' => 'deleteObject',
			'body' => [
				'objectID' => $object_id
			]
		];
		if ($autocommit) {
			return $this->Commit();
		} else {
			return true;
		}
	}

	private function SaveObjectRows(BeaconRecordSet $rows): void {
		while ($rows->EOF() === false) {
			$this->requests[] = [
				'action' => 'updateObject',
				'body' => [
					'objectID' => $rows->Field('id'),
					'title' => trim($rows->Field('title')),
					'body' => trim($rows->Field('body')),
					'preview' => trim($rows->Field('preview')),
					'meta_content' => trim($rows->Field('meta_content')),
					'type' => $rows->Field('type'),
					'subtype' => $rows->Field('subtype'),
					'uri' => $rows->Field('uri'),
					'min_version' => intval($rows->Field('min_version')),
					'max_version' => intval($rows->Field('max_version')),
					'mod_id' => $rows->Field('content_pack_id'),
					'mod_name' => $rows->Field('content_pack_name'),
					'game_id' => $rows->Field('game_id'),
					'game_name' => $rows->Field('game_name'),
				]
			];
			$rows->MoveNext();
		}
	}

	public function Rollback(): void {
		$this->requests = [];
	}

	public function Commit(): bool {
		if (count($this->requests) === 0) {
			return true;
		}

		$app_id = BeaconCommon::GetGlobal('Algolia Application ID');
		$index = BeaconCommon::GetGlobal('Algolia Index Name');
		$api_key = BeaconCommon::GetGlobal('Algolia API Key');

		$url = 'https://' . urlencode($app_id) . '.algolia.net/1/indexes/' . urlencode($index) . '/batch';
		$handle = curl_init($url);
		curl_setopt($handle, CURLOPT_HTTPHEADER, [
			'Content-Type: application/json',
			'X-Algolia-Application-Id: ' . $app_id,
			'X-Algolia-API-Key: ' . $api_key
		]);
		curl_setopt($handle, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($handle, CURLOPT_POSTFIELDS, json_encode(['requests' => $this->requests]));
		$this->raw_response = curl_exec($handle);
		$status = curl_getinfo($handle, CURLINFO_HTTP_CODE);
		curl_close($handle);

		if ($status === 200) {
			$this->Rollback(); // Don't panic
			return true;
		}

		return false;
	}

	public function Search(string $query, int|null $client_version, int $result_count, string|null $type = null): array {
		if (filter_var($query, FILTER_VALIDATE_EMAIL) !== false) {
			$this->results = [];
			$this->total_result_count = 0;
			return $this->results;
		}

		/*if ($this->applicationId === '12877547-7ad0-466f-a001-77815043c96b') {
			$clientReferer = $_SERVER['HTTP_REFERER'] ?? '';
			$clientChallenge = $_SERVER['HTTP_X_BEACON_CHALLENGE'] ?? '';
			if (str_starts_with($clientReferer, BeaconCommon::AbsoluteURL('/')) === false || $clientChallenge !== '4a320f02-d10a-4248-a11f-a8624196ef33') {
				$this->results = [];
				$this->total_result_count = 0;
				return $this->results;
			}
		}*/

		$app_id = BeaconCommon::GetGlobal('Algolia Application ID');
		$index = BeaconCommon::GetGlobal('Algolia Index Name');
		$api_key = BeaconCommon::GetGlobal('Algolia API Key');

		$url = 'https://' . urlencode($app_id) . '.algolia.net/1/indexes/' . urlencode($index) . '?query=' . urlencode(mb_strtolower($query)) . '&hitsPerPage=100';

		$filters = [];
		if (empty($client_version) === false) {
			$filters[] = 'min_version <= ' . $client_version;
			$filters[] = 'max_version >= ' . $client_version;
		}
		if (empty($type) === false) {
			$filters[] = 'type:' . $type;
		}
		if (count($filters) > 0) {
			$url .= '&filters=' . urlencode(implode(' AND ', $filters));
		}

		$cache_key = md5($url);
		$this->raw_response = BeaconCache::Get($cache_key);
		if (is_null($this->raw_response)) {
			$handle = curl_init($url);
			curl_setopt($handle, CURLOPT_HTTPHEADER, [
				'X-Algolia-Application-Id: ' . $app_id,
				'X-Algolia-API-Key: ' . $api_key
			]);
			curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
			$this->raw_response = curl_exec($handle);
			$status = curl_getinfo($handle, CURLINFO_HTTP_CODE);
			curl_close($handle);
			if ($status !== 200) {
				return [];
			}
			BeaconCache::Set($cache_key, $this->raw_response);
		}

		$response = json_decode($this->raw_response, true);
		$this->results = array_slice($response['hits'], 0, $result_count);
		$this->total_result_count = $response['nbHits'];

		if ($this->total_result_count === 0) {
			$clientAddress = BeaconCommon::RemoteAddr(false);
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('INSERT INTO public.search_empty_queries (terms, ip_address, application_id, num_searches) VALUES ($1, $2, $3, 1) ON CONFLICT (terms, ip_address, application_id) DO UPDATE SET num_searches = search_empty_queries.num_searches + 1;', $query, $clientAddress, $this->applicationId);
			$database->Commit();
		}

		return $this->results;
	}

	public function Results(): array {
		return $this->results;
	}

	public function TotalResultCount(): int {
		return $this->total_result_count;
	}

	public function RawResponse(): ?string {
		return $this->raw_response;
	}

	public function Sync(): bool {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$rows = $database->Query('SELECT object_id FROM search_sync WHERE action = $1;', 'Delete');
		while ($rows->EOF() === false) {
			$this->DeleteObject($rows->Field('object_id'), false);
			$rows->MoveNext();
		}

		$sql = 'SELECT search_contents.id, search_contents.title, search_contents.body, search_contents.preview, search_contents.meta_content, search_contents.type, search_contents.subtype, search_contents.uri, search_contents.min_version, search_contents.max_version, search_contents.game_id, games.game_name, content_packs.content_pack_id, content_packs.name AS content_pack_name FROM search_sync INNER JOIN search_contents ON (search_sync.object_id = search_contents.id) LEFT JOIN public.content_packs ON (search_contents.mod_id = content_packs.content_pack_id) LEFT JOIN public.games ON (search_contents.game_id = games.game_id) WHERE (content_packs.confirmed = TRUE OR search_contents.mod_id IS NULL) AND search_sync.action = $1';
		if (BeaconCommon::InProduction() === false) {
			$sql .= ' LIMIT 100';
		}
		$sql .= ';';
		$rows = $database->Query($sql, 'Save');
		$this->SaveObjectRows($rows);
		$database->Query('DELETE FROM search_sync;');

		if (count($this->requests) === 0) {
			$database->Rollback();
			return true;
		}

		if ($this->Commit() === true) {
			$database->Commit();
			return true;
		} else {
			$database->Rollback();
			return false;
		}
	}
}

?>
