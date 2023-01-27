<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class Engram extends Blueprint {
	protected $recipe = null;
	protected $entryString = null;
	protected $requiredPoints = null;
	protected $requiredLevel = null;
	protected $stackSize = null;
	protected $itemId = null;
	protected $gfi = null;
	
	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
			
		$this->entryString = $row->Field('entry_string');
		$this->requiredPoints = filter_var($row->Field('required_points'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->requiredLevel = filter_var($row->Field('required_level'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->stackSize = filter_var($row->Field('stack_size'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->itemId = filter_var($row->Field('item_id'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->gfi = $row->Field('gfi');
		
		$recipe = is_null($row->Field('recipe')) ? null : json_decode($row->Field('recipe'), true);
		if (is_null($recipe)) {
			$this->recipe = null;	
		} else {
			$this->recipe = [];
			foreach ($recipe as $ingredient) {
				$this->recipe[] = [
					'engramId' => $ingredient['engramId'],
					'quantity' => $ingredient['quantity'],
					'exact' => $ingredient['exact']
				];
			}
		}
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('engrams');
		$schema->AddColumn(new DatabaseObjectProperty('recipe', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id AS "engramId", quantity, exact FROM ark.crafting_costs INNER JOIN ark.engrams AS ingredients ON (ark.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = ark.engrams.object_id) AS recipe_template)', 'columnName' => 'recipe']));
		$schema->AddColumn(new DatabaseObjectProperty('entryString', ['columnName' => 'entry_string']));
		$schema->AddColumn(new DatabaseObjectProperty('requiredPoints', ['columnName' => 'required_points']));
		$schema->AddColumn(new DatabaseObjectProperty('requiredLevel', ['columnName' => 'required_level']));
		$schema->AddColumn(new DatabaseObjectProperty('stackSize', ['columnName' => 'stack_size']));
		$schema->AddColumn(new DatabaseObjectProperty('itemId', ['columnName' => 'item_id']));
		$schema->AddColumn(new DatabaseObjectProperty('gfi'));
		return $schema;
	}
	
	public function Recipe(): ?array {
		return $this->recipe;
	}
	
	public function SpawnCode(): string {
		if (is_null($this->gfi)) {
			return 'cheat giveitem ' . $this->classString . ' 1 1 0';
		} else {
			return 'cheat gfi ' . $this->gfi . ' 1 1 0';
		}
	}
	
	public function EntryString(): ?string {
		return $this->entryString;
	}
	
	public function RequiredPoints(): ?int {
		return $this->requiredPoints;
	}
	
	public function RequiredLevel(): ?int {
		return $this->requiredLevel;
	}
	
	public function StackSize(): ?int {
		return $this->stackSize;
	}
	
	public function ItemId(): ?int {
		return $this->itemId;
	}
	
	/*protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id, ingredients.path, ingredients.class_string, ingredients.mod_id, quantity, exact FROM ark.crafting_costs INNER JOIN ark.engrams AS ingredients ON (ark.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = ark.engrams.object_id) AS recipe_template) AS recipe';
		return $columns;
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
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
	}*/
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['spawn'] = $this->SpawnCode();
		$json['entryString'] = $this->entryString;
		$json['requiredPoints'] = $this->requiredPoints;
		$json['requiredLevel'] = $this->requiredLevel;
		$json['stackSize'] = $this->stackSize;
		$json['itemId'] = $this->itemId;
		if (is_null($this->recipe) || count($this->recipe) == 0) {
			$json['recipe'] = null;
		} else {
			$json['recipe'] = $this->recipe;
		}
		return $json;
	}
	
	/*protected function SaveChildrenHook(BeaconDatabase $database) {
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
			
			if (BeaconCommon::IsUUID($ingredient_id) === false) {
				throw new Exception('Recipe ingredient should be a v4 UUID.');
			}
			$keep_ingredients[] = $ingredient_id;
			
			$database->Query('INSERT INTO ark.crafting_costs (engram_id, ingredient_id, quantity, exact) VALUES ($1, $2, $3, $4) ON CONFLICT (engram_id, ingredient_id) DO UPDATE SET quantity = $3, exact = $4 WHERE crafting_costs.quantity IS DISTINCT FROM $3 OR crafting_costs.exact IS DISTINCT FROM $4;', $object_id, $ingredient_id, $quantity, $require_exact);
		}
		
		$database->Query('DELETE FROM ark.crafting_costs WHERE engram_id = $1 AND ingredient_id NOT IN (\'' . implode('\',\'', $keep_ingredients) . '\');', $object_id);
	}*/
}

?>
