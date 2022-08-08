<?php

namespace Ark;

class Blueprint extends \BeaconAPI\Ark\Blueprint {
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
						$availability = $availability | Maps::TheIsland;
					}
					if ($environment === 'scorched') {
						$availability = $availability | Maps::ScorchedEarth;
					}
					if ($environment === 'center') {
						$availability = $availability | Maps::TheCenter;
					}
					if ($environment === 'ragnarok') {
						$availability = $availability | Maps::Ragnarok;
					}
					if (($environment === 'abberation') || ($environment === 'aberration')) {
						$availability = $availability | Maps::Aberration;
					}
					if ($environment === 'extinction') {
						$availability = $availability | Maps::Extinction;
					}
					if ($environment === 'valguero') {
						$availability = $availability | Maps::Valguero;
					}
					if ($environment === 'genesis') {
						$availability = $availability | Maps::Genesis;
					}
					if ($environment === 'crystalisles') {
						$availability = $availability | Maps::CrystalIsles;
					}
				}
				$this->availability = $availability;
			}
		}
	}
	
	public function jsonSerialize(): mixed {
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
		return $this->AvailableTo(Maps::TheIsland);
	}
	
	public function SetAvailableToIsland(bool $available) {
		return $this->SetAvailableTo(Maps::TheIsland, $available);
	}
	
	public function AvailableToScorched() {
		return $this->AvailableTo(Maps::ScorchedEarth);
	}
	
	public function SetAvailableToScorched(bool $available) {
		return $this->SetAvailableTo(Maps::ScorchedEarth, $available);
	}
	
	public function AvailableToCenter() {
		return $this->AvailableTo(Maps::TheCenter);
	}
	
	public function SetAvailableToCenter(bool $available) {
		return $this->SetAvailableTo(Maps::TheCenter, $available);
	}
	
	public function AvailableToRagnarok() {
		return $this->AvailableTo(Maps::Ragnarok);
	}
	
	public function SetAvailableToRagnarok(bool $available) {
		return $this->SetAvailableTo(Maps::Ragnarok, $available);
	}
	
	public function AvailableToAberration() {
		return $this->AvailableTo(Maps::Aberration);
	}
	
	public function SetAvailableToAberration(bool $available) {
		return $this->SetAvailableTo(Maps::Aberration, $available);
	}
	
	public function AvailableToExtinction() {
		return $this->AvailableTo(Maps::Extinction);
	}
	
	public function SetAvailableToExtinction(bool $available) {
		return $this->SetAvailableTo(Maps::Extinction, $available);
	}
	
	public function AvailableToValguero() {
		return $this->AvailableTo(Maps::Valguero);
	}
	
	public function SetAvailableToValguero(bool $available) {
		return $this->SetAvailableTo(Maps::Valguero, $available);
	}
	
	public function AvailableToGenesis() {
		return $this->AvailableTo(Maps::Genesis);
	}
	
	public function SetAvailableToGenesis(bool $available) {
		return $this->SetAvailableTo(Maps::Genesis, $available);
	}
	
	public function AvailableToCrystalIsles() {
		return $this->AvailableTo(Maps::CrystalIsles);
	}
	
	// Typo, still here for compatibility
	public function SetAvailableToCrystlIsles(bool $available) {
		return $this->SetAvailableTo(Maps::CrystalIsles, $available);
	}
	
	public function SetAvailableToCrystalIsles(bool $available) {
		return $this->SetAvailableTo(Maps::CrystalIsles, $available);
	}
}

?>
