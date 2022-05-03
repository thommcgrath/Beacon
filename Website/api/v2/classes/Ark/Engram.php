<?php

namespace Ark;

class Engram extends \BeaconAPI\Ark\Engram {
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT object_id, quantity, exact FROM ark.crafting_costs WHERE engram_id = ark.engrams.object_id) AS recipe_template) AS recipe';
		return $columns;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('engram/' . urlencode($this->ObjectID()));
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
			$ingredient_id = $ingredient['object_id'];
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
