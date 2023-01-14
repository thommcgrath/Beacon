<?php

namespace Ark;

class Engram extends \BeaconAPI\Ark\Engram {
	protected $recipe = null;
	
	protected function __construct(\BeaconPostgreSQLRecordSet $row) {
		parent::__construct($row);
		
		$recipe = is_null($row->Field('recipe')) ? null : json_decode($row->Field('recipe'), true);
		if (is_null($recipe)) {
			$this->recipe = null;	
		} else {
			$this->recipe = [];
			foreach ($recipes as $ingredient) {
				$this->recipe[] = [
					'engram' => [
						'Schema' => 'Beacon.BlueprintReference',
						'Version' => 1,
						'Kind' => 'Engram',
						'UUID' => $ingredient['object_id'],
						'Path' => $ingredient['path'],
						'Class' => $ingredient['class_string'],
						'ModUUID' => $ingredient['mod_id']
					],
					'quantity' => $ingredient['quantity'],
					'exact' => $ingredient['exact']
				];
			}
		}
	}
	
	public static function BuildDatabaseSchema(): \BeaconAPI\DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->importColumn('(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id, ingredients.path, ingredients.class_string, ingredients.mod_id, quantity, exact FROM ark.crafting_costs INNER JOIN ark.engrams AS ingredients ON (ark.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = ark.engrams.object_id) AS recipe_template) AS recipe');
		return $schema;
	}
	
	public function Recipe() {
		return $this->recipe;
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id, ingredients.path, ingredients.class_string, ingredients.mod_id, quantity, exact FROM ark.crafting_costs INNER JOIN ark.engrams AS ingredients ON (ark.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = ark.engrams.object_id) AS recipe_template) AS recipe';
		return $columns;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		
		if (is_null($obj->recipe) === false) {
			$recipe = [];
			foreach ($obj->recipe as $ingredient) {
				$recipe[] = [
					'engram' => [
						'Schema' => 'Beacon.BlueprintReference',
						'Version' => 1,
						'Kind' => 'Engram',
						'UUID' => $ingredient['object_id'],
						'Path' => $ingredient['path'],
						'Class' => $ingredient['class_string'],
						'ModUUID' => $ingredient['mod_id']
					],
					'quantity' => $ingredient['quantity'],
					'exact' => $ingredient['exact']
				];
			}
			$obj->recipe = $recipe;
		}
		
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ark/engram/' . urlencode($this->ObjectID()));
		if (is_null($this->recipe) || count($this->recipe) == 0) {
			$json['recipe'] = null;
		} else {
			$json['recipe'] = $this->recipe;
		}
		return $json;
	}
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		$object_id = $this->ObjectID();
		
		if (is_null($this->recipe)) {
			$database->Query('DELETE FROM ark.crafting_costs WHERE engram_id = $1;', $object_id);
			return;
		}
		
		$keep_ingredients = [];
		foreach ($this->recipe as $ingredient) {
			$ingredient_id = $ingredient['engram']['UUID'];
			$quantity = intval($ingredient['quantity']);
			$require_exact = boolval($ingredient['exact']);
			
			if (\BeaconCommon::IsUUID($ingredient_id) === false) {
				throw new \Exception('Recipe ingredient should be a v4 UUID.');
			}
			$keep_ingredients[] = $ingredient_id;
			
			$database->Query('INSERT INTO ark.crafting_costs (engram_id, ingredient_id, quantity, exact) VALUES ($1, $2, $3, $4) ON CONFLICT (engram_id, ingredient_id) DO UPDATE SET quantity = $3, exact = $4 WHERE crafting_costs.quantity IS DISTINCT FROM $3 OR crafting_costs.exact IS DISTINCT FROM $4;', $object_id, $ingredient_id, $quantity, $require_exact);
		}
		
		$database->Query('DELETE FROM ark.crafting_costs WHERE engram_id = $1 AND ingredient_id NOT IN (\'' . implode('\',\'', $keep_ingredients) . '\');', $object_id);
	}
}

?>
