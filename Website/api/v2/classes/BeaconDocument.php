<?php

class BeaconDocument extends BeaconAPI\Document {
	public function Versions() {
		$path = self::GenerateCloudStoragePath($this->OwnerID(), $this->DocumentID());
		$versions = BeaconCloudStorage::VersionsForFile($path);
		$api_path = $this->ResourceURL();
		$api_query = '';
		$pos = strpos($api_path, '?');
		if ($pos !== false) {
			$api_query = substr($api_path, $pos + 1);
			$api_path = substr($api_path, 0, $pos);
		}
		if ($api_query !== '') {
			$api_query = '?' . $api_query;
		}
		for ($idx = 0; $idx < count($versions); $idx++) {
			$url = $this->ResourceURL();
			$versions[$idx]['resource_url'] = $api_path . '/versions/' . urlencode($versions[$idx]['version_id']) . $api_query;
		}
		return $versions;
	}
}

?>
