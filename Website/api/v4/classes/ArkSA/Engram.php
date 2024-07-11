<?php

namespace BeaconAPI\v4\ArkSA;
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
	protected ?array $stats;

	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);

		$this->entryString = $row->Field('entry_string');
		$this->requiredPoints = filter_var($row->Field('required_points'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->requiredLevel = filter_var($row->Field('required_level'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->stackSize = filter_var($row->Field('stack_size'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->itemId = filter_var($row->Field('item_id'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
		$this->gfi = $row->Field('gfi');
		$this->stats = is_null($row->Field('stats')) ? null : json_decode($row->Field('stats'), true);

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
		$schema->AddColumn(new DatabaseObjectProperty('recipe', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(recipe_template))) FROM (SELECT ingredients.object_id AS "engramId", quantity, exact FROM arksa.crafting_costs INNER JOIN arksa.engrams AS ingredients ON (arksa.crafting_costs.ingredient_id = ingredients.object_id) WHERE engram_id = arksa.engrams.object_id) AS recipe_template)', 'columnName' => 'recipe', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('entryString', ['columnName' => 'entry_string', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('requiredPoints', ['columnName' => 'required_points', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('requiredLevel', ['columnName' => 'required_level', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('stackSize', ['columnName' => 'stack_size', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('itemId', ['columnName' => 'item_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('gfi', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
		$schema->AddColumn(new DatabaseObjectProperty('stats', ['accessor' => '(SELECT array_to_json(array_agg(row_to_json(template))) FROM (SELECT stat_index AS "statIndex", randomizer_range_override AS "randomizerRangeOverride", randomizer_range_multiplier AS "randomizerRangeMultiplier", state_modifier_scale AS "stateModifierScale", rating_value_multiplier AS "ratingValueMultiplier", initial_value_constant AS "initialValueConstant" FROM arksa.engram_stats WHERE engram_stats.engram_id = engrams.object_id ORDER BY stat_index) AS template)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]));
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
		$json['stats'] = $this->stats;
		return $json;
	}

	protected function SaveChildObjects(BeaconDatabase $database): void {
		parent::SaveChildObjects($database);

		$ingredientRows = $database->Query('SELECT ingredient_id FROM arksa.crafting_costs WHERE engram_id = $1;', $this->objectId);
		$existingIngredients = [];
		while (!$ingredientRows->EOF()) {
			$existingIngredients[$ingredientRows->Field('ingredient_id')] = true;
			$ingredientRows->MoveNext();
		}
		if (is_null($this->recipe) === false) {
			foreach ($this->recipe as $ingredient) {
				$ingredientId = $ingredient['engramId'];
				$quantity = $ingredient['quantity'];
				$exact = $ingredient['exact'];

				if (array_key_exists($ingredientId, $existingIngredients)) {
					unset($existingIngredients[$ingredientId]);
					$database->Query('UPDATE arksa.crafting_costs SET quantity = $3, exact = $4 WHERE engram_id = $1 AND ingredient_id = $2 AND (quantity != $3 OR exact != $4);', $this->objectId, $ingredientId, $quantity, $exact);
				} else {
					$database->Query('INSERT INTO arksa.crafting_costs (engram_id, ingredient_id, quantity, exact) VALUES ($1, $2, $3, $4);', $this->objectId, $ingredientId, $quantity, $exact);
				}
			}
		}
		foreach ($existingIngredients as $ingredientId => $true) {
			$database->Query('DELETE FROM arksa.crafting_costs WHERE engram_id = $1 AND ingredient_id = $2;', $this->objectId, $ingredientId);
		}

		$statRows = $database->Query('SELECT stat_index FROM arksa.engram_stats WHERE engram_id = $1;', $this->objectId);
		$existingStats = [];
		while (!$statRows->EOF()) {
			$existingStats[$statRows->Field('stat_index')] = true;
			$statRows->MoveNext();
		}
		if (is_null($this->stats) === false) {
			foreach ($this->stats as $stat) {
				$statIndex = intval($stat['statIndex']);

				if (array_key_exists($statIndex, $existingStats)) {
					unset($existingStats[$statIndex]);
					$sql = 'UPDATE arksa.engram_stats SET randomizer_range_override = $3, randomizer_range_multiplier = $4, state_modifier_scale = $5, rating_value_multiplier = $6, initial_value_constant = $7 WHERE engram_id = $1 AND stat_index = $2 AND (randomizer_range_override != $3::NUMERIC(16,6) OR randomizer_range_multiplier != $4::NUMERIC(16,6) OR state_modifier_scale != $5::NUMERIC(16,6) OR rating_value_multiplier != $6::NUMERIC(16,6) OR initial_value_constant != $7::NUMERIC(16,6));';
				} else {
					$sql = 'INSERT INTO arksa.engram_stats (engram_id, stat_index, randomizer_range_override, randomizer_range_multiplier, state_modifier_scale, rating_value_multiplier, initial_value_constant) VALUES ($1, $2, $3, $4, $5, $6, $7);';
				}
				$database->Query($sql, $this->objectId, $statIndex, $stat['randomizerRangeOverride'], $stat['randomizerRangeMultiplier'], $stat['stateModifierScale'], $stat['ratingValueMultiplier'], $stat['initialValueConstant']);
			}
		}
		foreach ($existingStats as $statIndex => $true) {
			$database->Query('DELETE FROM arksa.engram_stats WHERE engram_id = $1 AND stat_index = $2;', $this->objectId, $statIndex);
		}
	}
}

?>
