<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class Engram extends MutableBlueprint {
	protected ?array $recipe;
	protected ?string $entryString;
	protected ?int $requiredPoints;
	protected ?int $requiredLevel;
	protected ?int $stackSize;
	protected ?int $itemId;
	protected ?string $gfi;

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

	protected static function CustomVariablePrefix(): string {
		return 'engram';
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('engrams');
		$schema->AddColumn(new DatabaseObjectProperty('recipe', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id AS "engramId", quantity, exact FROM ark.crafting_costs INNER JOIN ark.engrams AS ingredients ON (ark.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = ark.engrams.object_id) AS recipe_template)', 'columnName' => 'recipe', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('entryString', ['columnName' => 'entry_string', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('requiredPoints', ['columnName' => 'required_points', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('requiredLevel', ['columnName' => 'required_level', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('stackSize', ['columnName' => 'stack_size', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('itemId', ['columnName' => 'item_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('gfi', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		return $schema;
	}

	public function Recipe(): ?array {
		return $this->recipe;
	}

	public function SpawnCode(): string {
		if (is_null($this->gfi)) {
			return 'cheat gfi ' . substr($this->classString, 0, -2) . ' 1 1 0';
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

	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['engramGroup']);
		$json['spawn'] = $this->SpawnCode();
		$json['entryString'] = $this->entryString;
		$json['requiredPoints'] = $this->requiredPoints;
		$json['requiredLevel'] = $this->requiredLevel;
		$json['stackSize'] = $this->stackSize;
		$json['itemId'] = $this->itemId;
		$json['gfi'] = $this->gfi;
		if (is_null($this->recipe) || count($this->recipe) == 0) {
			$json['recipe'] = null;
		} else {
			$json['recipe'] = $this->recipe;
		}
		return $json;
	}

	protected function SaveChildObjects(BeaconDatabase $database): void {
		parent::SaveChildObjects($database);

		$validIngredients = [];
		if (is_null($this->recipe) === false) {
			foreach ($this->recipe as $ingredient) {
				$ingredientId = $ingredient['engramId'];
				$quantity = $ingredient['quantity'];
				$exact = $ingredient['exact'];

				$validIngredients[] = $ingredientId;
				$database->Query('INSERT INTO ark.crafting_costs (engram_id, ingredient_id, quantity, exact) VALUES ($1, $2, $3, $4) ON CONFLICT (engram_id, ingredient_id) DO UPDATE SET quantity = $3, exact = $4 WHERE crafting_costs.quantity IS DISTINCT FROM $3 OR crafting_costs.exact IS DISTINCT FROM $4;', $this->objectId, $ingredientId, $quantity, $exact);
			}
		}

		$database->Query('DELETE FROM ark.crafting_costs WHERE engram_id = $1 AND NOT (ingredient_id = ANY($2));', $this->objectId, '{' . implode(',', $validIngredients) . '}');
	}
}

?>
