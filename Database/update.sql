-- used to transform the database into the new format

DROP TRIGGER engrams_before_insert_trigger ON engrams;
DROP TRIGGER engrams_before_update_trigger ON engrams;
DROP TRIGGER engrams_after_delete_trigger ON engrams;
DROP TRIGGER loot_sources_before_insert_trigger ON loot_sources;
DROP TRIGGER loot_sources_before_update_trigger ON loot_sources;
DROP TRIGGER loot_sources_after_delete_trigger ON loot_sources;
DROP TRIGGER presets_before_insert_trigger ON presets;
DROP TRIGGER presets_before_update_trigger ON presets;
DROP TRIGGER presets_after_delete_trigger ON presets;
DROP VIEW updatable_objects;
DROP TABLE deletions;

ALTER TABLE presets RENAME COLUMN classstring TO preset_id;
ALTER TABLE presets ALTER COLUMN preset_id SET DATA TYPE uuid USING preset_id::UUID;

ALTER TABLE loot_sources RENAME COLUMN classstring TO class_string;

DROP TABLE engrams;
CREATE TABLE engrams (
	path CITEXT NOT NULL PRIMARY KEY,
	label CITEXT NOT NULL,
	availability INTEGER NOT NULL DEFAULT 0,
	can_blueprint BOOLEAN NOT NULL DEFAULT TRUE,
	last_update TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0),
	min_version INTEGER,
	mod_id UUID REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE engrams TO thezaz_website;

-- fill engrams

CREATE UNIQUE INDEX engrams_classstring_mod_id_uidx ON engrams(class_string, mod_id);

CREATE OR REPLACE VIEW updatable_objects AS (SELECT class_string AS unique_id, label, last_update, min_version FROM loot_sources) UNION (SELECT preset_id::text AS unique_id, label, last_update, NULL FROM presets) UNION (SELECT path AS unique_id, label, last_update, min_version FROM engrams);
GRANT SELECT ON updatable_objects TO thezaz_website;

CREATE TABLE deletions (
	deletion_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	from_table CITEXT NOT NULL,
	unique_id CITEXT NOT NULL,
	action_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0)
);
CREATE UNIQUE INDEX deletions_table_unique_id_idx ON deletions(from_table, unique_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE deletions TO thezaz_website;

CREATE OR REPLACE FUNCTION cache_insert_trigger () RETURNS TRIGGER AS $$
DECLARE
	column_name TEXT;
	unique_id TEXT;
BEGIN
	column_name := TG_ARGV[0];
	
	EXECUTE format('SELECT $1.%I;', column_name) USING NEW INTO unique_id;
	
	EXECUTE 'DELETE FROM deletions WHERE from_table = $1 AND unique_id = $2;' USING TG_TABLE_NAME, unique_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cache_update_trigger () RETURNS TRIGGER AS $$
DECLARE
	column_name TEXT;
	old_unique_id TEXT;
	new_unique_id TEXT;
BEGIN
	column_name := TG_ARGV[0];
	
	EXECUTE format('SELECT $1.%I;', column_name) USING OLD INTO old_unique_id;
	EXECUTE format('SELECT $1.%I;', column_name) USING NEW INTO new_unique_id;
	
	IF old_unique_id != new_unique_id THEN
		EXECUTE 'DELETE FROM deletions WHERE from_table = $1 AND unique_id = $2;' USING TG_TABLE_NAME, new_unique_id;
		EXECUTE 'INSERT INTO deletions (from_table, unique_id) VALUES ($1, $2);' USING TG_TABLE_NAME, old_unique_id;
	END IF;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cache_delete_trigger () RETURNS TRIGGER AS $$
DECLARE
	column_name TEXT;
	unique_id TEXT;
BEGIN
	column_name := TG_ARGV[0];
	
	EXECUTE format('SELECT $1.%I;', column_name) USING OLD INTO unique_id;
	
	EXECUTE 'INSERT INTO deletions (from_table, unique_id) VALUES ($1, $2);' USING TG_TABLE_NAME, unique_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION presets_json_sync_function () RETURNS TRIGGER AS $$
BEGIN
	NEW.label = NEW.contents->>'Label';
	NEW.classstring = NEW.contents->>'ID'::UUID;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('path');
CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('path');
CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('path');

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('class_string');
CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('class_string');
CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('class_string');

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON presets FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('preset_id');
CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON presets FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('preset_id');
CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON presets FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('preset_id');