<?php

class BeaconBlueprint extends BeaconAPI\Blueprint {
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
		
		if (array_key_exists('availability', $json) === false || is_int($json['availability']) === false) {
			if (array_key_exists('environments', $json)) {
				$environments = $json['environments'];
			} elseif (array_key_exists('availability', $json)) {
				$environments = $json['availability'];
			}
			if (isset($environments)) {
				if (is_array($environments) === false) {
					throw new Exception('Must supply map availability as an array or integer');
				}
				$availability = 0;
				foreach ($environments as $environment) {
					$environment = strtolower(trim($environment));
					if ($environment === 'island') {
						$availability = $availability | BeaconMaps::TheIsland;
					}
					if ($environment === 'scorched') {
						$availability = $availability | BeaconMaps::ScorchedEarth;
					}
					if ($environment === 'center') {
						$availability = $availability | BeaconMaps::TheCenter;
					}
					if ($environment === 'ragnarok') {
						$availability = $availability | BeaconMaps::Ragnarok;
					}
					if (($environment === 'abberation') || ($environment === 'aberration')) {
						$availability = $availability | BeaconMaps::Aberration;
					}
					if ($environment === 'extinction') {
						$availability = $availability | BeaconMaps::Extinction;
					}
					if ($environment === 'valguero') {
						$availability = $availability | BeaconMaps::Valguero;
					}
					if ($environment === 'genesis') {
						$availability = $availability | BeaconMaps::Genesis;
					}
					if ($environment === 'crystalisles') {
						$availability = $availability | BeaconMaps::CrystalIsles;
					}
				}
				$this->availability = $availability;
			}
		}
	}
	
	public function jsonSerialize() {
		$environments = array();
		if ($this->AvailableToIsland()) {
			$environments[] = 'Island';
		}
		if ($this->AvailableToScorched()) {
			$environments[] = 'Scorched';
		}
		if ($this->AvailableToCenter()) {
			$environments[] = 'Center';
		}
		if ($this->AvailableToRagnarok()) {
			$environments[] = 'Ragnarok';
		}
		if ($this->AvailableToAberration()) {
			$environments[] = 'Aberration';
		}
		if ($this->AvailableToExtinction()) {
			$environments[] = 'Extinction';
		}
		if ($this->AvailableToValguero()) {
			$environments[] = 'Valguero';
		}
		if ($this->AvailableToGenesis()) {
			$environments[] = 'Genesis';
		}
		if ($this->AvailableToCrystalIsles()) {
			$environments[] = 'CrystalIsles';
		}
		
		$json = parent::jsonSerialize();
		$json['environments'] = $environments;
		
		return $json;
	}
	
	public function AvailableToIsland() {
		return $this->AvailableTo(BeaconMaps::TheIsland);
	}
	
	public function SetAvailableToIsland(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::TheIsland, $available);
	}
	
	public function AvailableToScorched() {
		return $this->AvailableTo(BeaconMaps::ScorchedEarth);
	}
	
	public function SetAvailableToScorched(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::ScorchedEarth, $available);
	}
	
	public function AvailableToCenter() {
		return $this->AvailableTo(BeaconMaps::TheCenter);
	}
	
	public function SetAvailableToCenter(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::TheCenter, $available);
	}
	
	public function AvailableToRagnarok() {
		return $this->AvailableTo(BeaconMaps::Ragnarok);
	}
	
	public function SetAvailableToRagnarok(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Ragnarok, $available);
	}
	
	public function AvailableToAberration() {
		return $this->AvailableTo(BeaconMaps::Aberration);
	}
	
	public function SetAvailableToAberration(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Aberration, $available);
	}
	
	public function AvailableToExtinction() {
		return $this->AvailableTo(BeaconMaps::Extinction);
	}
	
	public function SetAvailableToExtinction(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Extinction, $available);
	}
	
	public function AvailableToValguero() {
		return $this->AvailableTo(BeaconMaps::Valguero);
	}
	
	public function SetAvailableToValguero(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Valguero, $available);
	}
	
	public function AvailableToGenesis() {
		return $this->AvailableTo(BeaconMaps::Genesis);
	}
	
	public function SetAvailableToGenesis(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::Genesis, $available);
	}
	
	public function AvailableToCrystalIsles() {
		return $this->AvailableTo(BeaconMaps::CrystalIsles);
	}
	
	// Typo, still here for compatibility
	public function SetAvailableToCrystlIsles(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::CrystalIsles, $available);
	}
	
	public function SetAvailableToCrystalIsles(bool $available) {
		return $this->SetAvailableTo(BeaconMaps::CrystalIsles, $available);
	}
}

?>
