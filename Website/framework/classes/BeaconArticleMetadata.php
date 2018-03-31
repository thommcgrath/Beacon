<?php

class BeaconArticleMetadata {
	const TYPE_BLOG = 'Blog';
	const TYPE_HELP = 'Help';
	
	protected $article_id;
	protected $publish_time;
	protected $last_update;
	protected $title;
	protected $type;
	
	protected function __construct(BeaconRecordSet $result) {
		$this->article_id = $result->Field('article_id');
		$this->publish_time = new DateTime($result->Field('publish_time'));
		$this->last_update = new DateTime($result->Field('last_update'));
		$this->title = $result->Field('title');
		$this->type = $result->Field('type');
	}
	
	public function ArticleID() {
		return $this->article_id;
	}
	
	public function PublishTime() {
		return $this->publish_time;
	}
	
	public function LastUpdate() {
		return $this->last_update;
	}
	
	public function Title() {
		return $this->title;
	}
	
	public function Type() {
		return $this->type;
	}
	
	public static function GetByArticleID($article_id) {
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
			$ids = array();
			foreach ($article_id as $id) {
				if (BeaconCommon::IsUUID($id)) {
					$ids[] = $id;
				}
			}
			$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE article_id = ANY($1);', '{' . implode(',', $ids) . '}');
			$arr = array();
			while (!$results->EOF()) {
				$arr[] = new static($results);
				$results->MoveNext();
			}
			return $arr;
		}
	}
	
	public static function GetRecentArticles(int $count, string $type) {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE type = $1 ORDER BY publish_time DESC LIMIT $2;', $type, $count);
		$articles = array();
		while (!$results->EOF()) {
			$articles[] = new static($results);
			$results->MoveNext();
		}
		return $articles;
	}
	
	public static function GetAll(string $type) {
		$columns = static::Columns();
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT ' . implode(', ', $columns) . ' FROM articles WHERE type = $1 ORDER BY title;', $type);
		$articles = array();
		while (!$results->EOF()) {
			$articles[] = new static($results);
			$results->MoveNext();
		}
		return $articles;
	}
	
	protected static function Columns() {
		return array('article_id', 'publish_time', 'last_update', 'title', 'type');
	}
}

?>