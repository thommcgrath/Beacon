<?php

class BeaconArticleMetadata {
	const TYPE_BLOG = 'Blog';
	const TYPE_HELP = 'Help';
	
	protected $article_id;
	protected $publish_time;
	protected $last_update;
	protected $title;
	protected $type;
	
	protected function __construct(BeaconRecordSet $result): void {
		$this->article_id = $result->Field('article_id');
		$this->publish_time = new DateTime($result->Field('publish_time'));
		$this->last_update = new DateTime($result->Field('last_update'));
		$this->title = $result->Field('title');
		$this->type = $result->Field('type');
	}
	
	public function ArticleID(): string {
		return $this->article_id;
	}
	
	public function PublishTime(): DateTime {
		return $this->publish_time;
	}
	
	public function LastUpdate(): DateTime {
		return $this->last_update;
	}
	
	public function Title(): string {
		return $this->title;
	}
	
	public function Type(): string {
		return $this->type;
	}
	
	public static function GetByArticleID($article_id): ?static {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		if (BeaconCommon::IsUUID($article_id)) {
			$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE article_id = $1;', $article_id);
			if ($results->RecordCount() == 1) {
				return new static($results);
			} else {
				return null;
			}
		} elseif (is_array($article_id)) {
			$ids = [];
			foreach ($article_id as $id) {
				if (BeaconCommon::IsUUID($id)) {
					$ids[] = $id;
				}
			}
			$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE article_id = ANY($1);', '{' . implode(',', $ids) . '}');
			$arr = [];
			while (!$results->EOF()) {
				$arr[] = new static($results);
				$results->MoveNext();
			}
			return $arr;
		}
	}
	
	public static function GetRecentArticles(int $count, int $offset, string $type): array {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE type = $1 ORDER BY publish_time DESC LIMIT $2 OFFSET $3;', $type, $count, $offset);
		$articles = [];
		while (!$results->EOF()) {
			$articles[] = new static($results);
			$results->MoveNext();
		}
		return $articles;
	}
	
	public static function GetCount(string $type): int {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT COUNT(article_id) AS article_count FROM articles WHERE type = $1;', $type);
		return intval($results->Field('article_count'));
	}
	
	public static function GetAll(string $type): array {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE type = $1 ORDER BY title;', $type);
		$articles = [];
		while (!$results->EOF()) {
			$articles[] = new static($results);
			$results->MoveNext();
		}
		return $articles;
	}
	
	protected static function Columns(): array {
		return ['article_id', 'publish_time', 'last_update', 'title', 'type'];
	}
}

?>