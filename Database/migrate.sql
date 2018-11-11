CREATE TABLE loot_source_icons (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	icon_data BYTEA NOT NULL
) INHERITS (objects);
GRANT SELECT ON TABLE loot_source_icons TO thezaz_website;

INSERT INTO loot_source_icons (icon_data, label) SELECT DISTINCT icon AS icon_data, '' AS label FROM loot_sources;

ALTER TABLE loot_sources RENAME TO loot_sources_old;

CREATE TABLE loot_sources (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	path CITEXT NOT NULL UNIQUE,
	class_string CITEXT NOT NULL,
	availability INTEGER NOT NULL,
	multiplier_min NUMERIC(6,4) NOT NULL,
	multiplier_max NUMERIC(6,4) NOT NULL,
	uicolor TEXT NOT NULL CHECK (uicolor ~* '^[0-9a-fA-F]{8}$'),
	icon UUID NOT NULL REFERENCES loot_source_icons(object_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	sort INTEGER NOT NULL UNIQUE,
	required_item_sets INTEGER NOT NULL DEFAULT 1,
	experimental BOOLEAN NOT NULL DEFAULT FALSE,
	notes TEXT NOT NULL DEFAULT '',
	CHECK (class_string LIKE '%_C')
) INHERITS (objects);
GRANT SELECT ON TABLE loot_sources TO thezaz_website;

INSERT INTO loot_sources (object_id, mod_id, min_version, last_update, label, path, class_string, availability, multiplier_min, multiplier_max, uicolor, icon, sort, required_item_sets) SELECT loot_sources_old.object_id, loot_sources_old.mod_id, loot_sources_old.min_version, loot_sources_old.last_update, loot_sources_old.label, path, class_string, availability, multiplier_min, multiplier_max, uicolor, loot_source_icons.object_id AS icon, sort, required_item_sets FROM loot_sources_old INNER JOIN loot_source_icons ON (loot_sources_old.icon = loot_source_icons.icon_data) ORDER BY loot_sources_old.sort;

DROP VIEW search_contents;
DROP TABLE loot_sources_old;
CREATE OR REPLACE VIEW search_contents AS (SELECT article_id AS id, title, body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(body), 'B') AS lexemes, 'Article' AS type FROM articles) UNION (SELECT object_id AS id, label AS title, '' AS body, setweight(to_tsvector(label), 'A') AS lexemes, 'Object' AS type FROM objects WHERE objects.tableoid::regclass IN ('engrams', 'creatures', 'loot_sources')) UNION (SELECT mod_id AS id, name AS title, '' AS body, setweight(to_tsvector(name), 'C') AS lexemes, 'Mod' AS type FROM mods WHERE confirmed = TRUE) UNION (SELECT document_id, title, description AS body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(description), 'B') AS lexemes, 'Document' AS type FROM documents WHERE published = 'Approved');
GRANT SELECT ON TABLE search_contents TO thezaz_website;

CREATE TRIGGER loot_source_icons_before_insert_trigger BEFORE INSERT ON loot_source_icons FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER loot_source_icons_before_update_trigger BEFORE UPDATE ON loot_source_icons FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER loot_source_icons_after_delete_trigger AFTER DELETE ON loot_source_icons FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();

CREATE TABLE game_variables (
	key TEXT NOT NULL PRIMARY KEY,
	value TEXT NOT NULL,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
GRANT SELECT ON game_variables TO thezaz_website;

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON game_variables FOR EACH ROW EXECUTE PROCEDURE generic_update_trigger();