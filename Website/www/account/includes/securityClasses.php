<?php

trait SignInButtonContainer {
	protected array $buttons = [];

	public function Buttons(): array {
		return $this->buttons;
	}

	public function HasButtons(): bool {
		return count($this->buttons) > 0;
	}

	public function ButtonCount(): int {
		return count($this-buttons);
	}

	public function AddButton(SignInOptionButton $button): void {
		$index = $this->IndexOfButton($button->ButtonId());
		if ($index !== -1) {
			return;
		}
		$this->buttons[] = $button;
	}

	public function RemoveButton(string $buttonId): void {
		$index = $this->IndexOfButton($buttonId);
		if ($index === -1) {
			return;
		}
		array_splice($this->buttons, $index, 1);
	}

	protected function IndexOfButton(string $buttonId): int {
		for ($idx = 0; $idx < count($this->buttons); $idx++) {
			if ($this->buttons[$idx]->ButtonId() === $buttonId) {
				return $idx;
			}
		}
		return -1;
	}
}

class SignInOption {
	use SignInButtonContainer;

	protected string $svg = '';
	protected string $title = 'Option';
	protected array $tags = [];
	protected array $rows = [];
	protected bool $enabled = false;

	public function __construct(string $title, string $svg, bool $enabled = true) {
		$this->svg = $svg;
		$this->title = $title;
		$this->enabled = $enabled;
	}

	public function SVG(): string {
		return $this->svg;
	}

	public function Title(): string {
		return $this->title;
	}

	public function Enabled(): bool {
		return $this->enabled;
	}

	public function HasTags(): bool {
		return count($this->tags) > 0;
	}

	public function TagCount(): int {
		return count($this->tags);
	}

	public function Tags(): array {
		return $this->tags;
	}

	public function AddTag(string $tag): void {
		if (in_array($tag, $this->tags) === false) {
			$this->tags[] = $tag;
		}
	}

	public function RemoveTag(string $tag): void {
		$index = array_search($tag, $this->tags);
		if ($index === false) {
			return;
		}
		array_splice($this->tags, $index, 1);
	}

	public function Rows(): array {
		return $this->rows;
	}

	public function HasRows(): bool {
		return count($this->rows) > 0;
	}

	public function RowCount(): int {
		return count($this->rows);
	}

	public function AddRow(SignInOptionRow $row): void {
		$index = $this->IndexOfRow($row->RowId());
		if ($index !== -1) {
			return;
		}
		$this->rows[] = $row;
	}

	public function RemoveRow(string $rowId): void {
		$index = $this->IndexOfButton($rowId);
		if ($index === -1) {
			return;
		}
		array_splice($this->rows, $index, 1);
	}

	protected function IndexOfRow(string $rowId): int {
		for ($idx = 0; $idx < count($this->rows); $idx++) {
			if ($this->rows[$idx]->RowId() === $rowId) {
				return $idx;
			}
		}
		return -1;
	}
}

class SignInOptionRow {
	use SignInButtonContainer;

	protected string $rowId = '';
	protected string $text = '';

	public function __construct(string $text) {
		$this->rowId = BeaconUUID::v4();
		$this->text = $text;
	}

	public function RowId(): string {
		return $this->rowId;
	}

	public function Text(): string {
		return $this->text;
	}
}

class SignInOptionButton {
	protected string $id = '';
	protected string $caption = '';
	protected array $attributes = [];

	public function __construct(string $id, string $caption, string $class = '') {
		$this->id = $id;
		$this->caption = $caption;
		$this->attributes['class'] = trim('small blue ' . $class);
	}

	public function RenderHtml(): string {
		$html = '<button id="option-button-' . htmlentities($this->id) . '"';
		foreach ($this->attributes as $key => $value) {
			$html .= ' ' . $key . '="'. htmlentities($value) . '"';
		}
		$html .= '>' . htmlentities($this->caption) . '</button>';
		return $html;
	}

	public function ButtonId(): string {
		return $this->id;
	}

	public function Caption(): string {
		return $this->caption;
	}

	public function GetAttribute(string $key): string {
		return $this->attributes[$key] ?? '';
	}

	public function SetAttribute(string $key, string $value): void {
		$this->attributes[$key] = $value;
	}
}

?>
