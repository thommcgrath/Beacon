CREATE EXTENSION uuid-ossp;
CREATE EXTENSION pgcrypto;
CREATE EXTENSION citext;

CREATE TABLE updates (
	update_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	build_number INTEGER NOT NULL UNIQUE,
	build_display TEXT NOT NULL,
	notes TEXT NOT NULL,
	mac_url TEXT NOT NULL,
	mac_signature CITEXT NOT NULL,
	win_url TEXT NOT NULL,
	win_signature CITEXT NOT NULL
);
GRANT SELECT ON TABLE updates TO thezaz_website;

CREATE TABLE users (
	user_id UUID NOT NULL PRIMARY KEY,
	public_key TEXT NOT NULL
);
GRANT SELECT, INSERT ON TABLE users TO thezaz_website;

CREATE TABLE documents (
	document_id UUID NOT NULL PRIMARY KEY,
	user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	title TEXT NOT NULL,
	description TEXT NOT NULL,
	revision INTEGER NOT NULL DEFAULT 1,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	download_count INTEGER NOT NULL DEFAULT 0,
	contents TEXT NOT NULL,
	contents_hash CITEXT NOT NULL,
	is_public BOOLEAN NOT NULL DEFAULT FALSE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE documents TO thezaz_website;

CREATE TYPE loot_source_kind AS ENUM (
	'Standard',
	'Bonus',
	'Cave',
	'Sea',
	'BossSpider',
	'BossGorilla',
	'BossDragon',
	'BossManticore'
);

CREATE TABLE loot_sources (
	class_string CITEXT NOT NULL PRIMARY KEY,
	label CITEXT NOT NULL,
	kind loot_source_kind NOT NULL,
	engram_mask INTEGER NOT NULL,
	multiplier_min NUMERIC(6,4) NOT NULL,
	multiplier_max NUMERIC(6,4) NOT NULL,
	last_update TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0),
	min_version INTEGER,
	uicolor TEXT NOT NULL CHECK (uicolor ~* '^[0-9a-fA-F]{8}$'),
	sort INTEGER NOT NULL UNIQUE,
	CHECK (class_string LIKE '%_C')
);
GRANT SELECT ON TABLE loot_sources TO thezaz_website;

CREATE TABLE mods (
	mod_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	workshop_id BIGINT NOT NULL,
	user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	name TEXT NOT NULL DEFAULT 'Unknown Mod',
	confirmed BOOLEAN NOT NULL DEFAULT FALSE,
	confirmation_code UUID NOT NULL DEFAULT gen_random_uuid(),
	pull_url TEXT,
	last_pull_hash TEXT
);
CREATE UNIQUE INDEX mods_workshop_id_user_id_uidx ON mods(workshop_id, user_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE mods TO thezaz_website;

CREATE OR REPLACE FUNCTION enforce_mod_owner() RETURNS trigger AS $$
DECLARE
	confirmed_count INTEGER := 0;
BEGIN
	IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE' AND NEW.confirmed = TRUE AND OLD.confirmed = FALSE) THEN
		SELECT INTO confirmed_count COUNT(mod_id) FROM mods WHERE confirmed = TRUE AND workshop_id = NEW.workshop_id;
		IF confirmed_count > 0 THEN
			RAISE EXCEPTION 'Mod is already confirmed by another user.';
		END IF;
		IF NEW.confirmed THEN
			DELETE FROM mods WHERE workshop_id = NEW.workshop_id AND mod_id != NEW.mod_id;
		END IF;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_mod_owner BEFORE INSERT OR UPDATE ON mods FOR EACH ROW EXECUTE PROCEDURE enforce_mod_owner();

CREATE TABLE engrams (
	path CITEXT NOT NULL PRIMARY KEY,
	class_string CITEXT NOT NULL,
	label CITEXT NOT NULL,
	availability INTEGER NOT NULL DEFAULT 0,
	can_blueprint BOOLEAN NOT NULL DEFAULT TRUE,
	last_update TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0),
	min_version INTEGER,
	mod_id UUID REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK (path LIKE '/%')
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE engrams TO thezaz_website;
CREATE UNIQUE INDEX engrams_classstring_mod_id_uidx ON engrams(class_string, mod_id);

CREATE TABLE presets (
	preset_id UUID NOT NULL PRIMARY KEY,
	label CITEXT NOT NULL,
	contents JSON NOT NULL,
	last_update TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0)
);
GRANT SELECT ON TABLE presets TO thezaz_website;

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

DROP TRIGGER IF EXISTS engrams_compute_class_trigger ON engrams;

DROP TRIGGER IF EXISTS engrams_before_insert_trigger ON engrams;
DROP TRIGGER IF EXISTS engrams_before_update_trigger ON engrams;
DROP TRIGGER IF EXISTS engrams_after_delete_trigger ON engrams;

DROP TRIGGER IF EXISTS loot_sources_before_insert_trigger ON loot_sources;
DROP TRIGGER IF EXISTS loot_sources_before_update_trigger ON loot_sources;
DROP TRIGGER IF EXISTS loot_sources_after_delete_trigger ON loot_sources;

DROP TRIGGER IF EXISTS presets_before_insert_trigger ON presets;
DROP TRIGGER IF EXISTS presets_before_update_trigger ON presets;
DROP TRIGGER IF EXISTS presets_after_delete_trigger ON presets;
DROP TRIGGER IF EXISTS presets_json_sync_trigger ON presets;

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

CREATE OR REPLACE FUNCTION compute_class_trigger () RETURNS TRIGGER AS $$
BEGIN
	NEW.class_string = SUBSTRING(NEW.path, '\.([a-zA-Z0-9\-\_]+)$') || '_C';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON engrams_test FOR EACH ROW EXECUTE PROCEDURE compute_class_trigger('');

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('path');
CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('path');
CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON engrams FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('path');

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('class_string');
CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('class_string');
CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('class_string');

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON presets FOR EACH ROW EXECUTE PROCEDURE cache_insert_trigger('preset_id');
CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON presets FOR EACH ROW EXECUTE PROCEDURE cache_update_trigger('preset_id');
CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON presets FOR EACH ROW EXECUTE PROCEDURE cache_delete_trigger('preset_id');

CREATE TRIGGER presets_json_sync_trigger BEFORE INSERT OR UPDATE ON presets FOR EACH ROW EXECUTE PROCEDURE presets_json_sync_function();
