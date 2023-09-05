<?php

class BeaconBreadcrumbs {
	protected array $components = [];
	
	public function AddComponent(string $url, string $caption) {
		$absolute = str_starts_with($url, '/');
		if (!$absolute && count($this->components) > 0) {
			$url = $this->components[count($this->components) - 1]['url'] . '/' . $url;
		}
		
		$this->components[] = ['url' => $url, 'caption' => $caption];
	}
	
	public function Render(): string {
		$bound = count($this->components) - 1;
		ob_start();
		echo '<div class="breadcrumbs">';
		for ($idx = 0; $idx <= $bound; $idx++) {
			$component = $this->components[$idx];
			$last = ($idx === $bound);
			$url = $component['url'];
			$caption = $component['caption'];
			
			if ($last) {
				echo '<div class="breadcrumb active">' . htmlentities($caption) . '</div>';
			} else {
				echo '<div class="breadcrumb"><a href="' . htmlentities($url) . '">' . htmlentities($caption) . '</a></div><div class="divider">&nbsp;</div>';
			}
		}
		echo '</div>';
		$rendered = ob_get_contents();
		ob_end_clean();
		return $rendered;
	}
}

?>
