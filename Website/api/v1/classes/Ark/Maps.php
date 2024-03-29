<?php

namespace Ark;

abstract class Maps {
	const TheIsland = 1;
	const ScorchedEarth = 2;
	const TheCenter = 4;
	const Ragnarok = 8;
	const Aberration = 16;
	const Extinction = 32;
	const Valguero = 64;
	const Genesis = 128;
	const CrystalIsles = 256;
	
	public static function All() {
		return self::TheIsland | self::ScorchedEarth | self::TheCenter | self::Ragnarok | self::Aberration | self::Extinction | self::Valguero | self::Genesis | self::CrystalIsles;
	}
	
	public static function Names(int $mask) {
		$names = array();
		if (($mask & self::TheIsland) == self::TheIsland) {
			$names[] = 'The Island';
		}
		if (($mask & self::ScorchedEarth) == self::ScorchedEarth) {
			$names[] = 'Scorched Earth';
		}
		if (($mask & self::Aberration) == self::Aberration) {
			$names[] = 'Aberration';
		}
		if (($mask & self::Extinction) == self::Extinction) {
			$names[] = 'Extinction';
		}
		if (($mask & self::Genesis) == self::Genesis) {
			$names[] = 'Genesis';
		}
		if (($mask & self::TheCenter) == self::TheCenter) {
			$names[] = 'The Center';
		}
		if (($mask & self::Ragnarok) == self::Ragnarok) {
			$names[] = 'Ragnarok';
		}
		if (($mask & self::Valguero) == self::Valguero) {
			$names[] = 'Valguero';
		}
		if (($mask & self::CrystalIsles) == self::CrystalIsles) {
			$names[] = 'Crystal Isles';
		}
		return $names;
	}
	
	public static function ValueForName(string $name) {
		switch ($name) {
		case 'The Island':
			return self::TheIsland;
		case 'Scorched Earth':
			return self::ScorchedEarth;
		case 'Aberration':
			return self::Aberration;
		case 'The Center':
			return self::TheCenter;
		case 'Ragnarok':
			return self::Ragnarok;
		case 'Extinction':
			return self::Extinction;
		case 'Valguero':
			return self::Valguero;
		case 'Genesis':
			return self::Genesis;
		case 'Crystal Isles';
			return self::CrystalIsles;
		default:
			return 0;
		}
	}
}

?>
