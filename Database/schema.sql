-- diet_contents should update the diets last_update column.

CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION pgcrypto;
CREATE EXTENSION citext;

-- Updates: Build info and release notes
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
-- End Updates

-- Users: The absolute minimum we need to track, with "hard-coded" value for the developer.
CREATE DOMAIN email AS citext CHECK (value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$');
CREATE DOMAIN hex AS citext CHECK (value ~ '^[a-fA-F0-9]+$');

CREATE TABLE users (
	user_id UUID NOT NULL PRIMARY KEY,
	login_key email UNIQUE,
	public_key TEXT NOT NULL,
	private_key hex,
	private_key_salt hex,
	private_key_iterations INTEGER,
	patreon_id INTEGER,
	is_patreon_supporter BOOLEAN NOT NULL DEFAULT FALSE,
	CHECK ((login_key IS NULL AND private_key_iterations IS NULL AND private_key_salt IS NULL AND private_key IS NULL) OR (login_key IS NOT NULL AND private_key_iterations IS NOT NULL AND private_key_salt IS NOT NULL AND private_key IS NOT NULL))
);
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE users TO thezaz_website;
-- End Users

-- Documents: Files that are shareable in the community (time to rethink this?)
CREATE TABLE documents (
	document_id UUID NOT NULL PRIMARY KEY,
	user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	title TEXT NOT NULL,
	description TEXT NOT NULL,
	is_public BOOLEAN NOT NULL,
	map INTEGER NOT NULL,
	difficulty NUMERIC(8, 4) NOT NULL,
	console_safe BOOLEAN NOT NULL,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT clock_timestamp(),
	revision INTEGER NOT NULL DEFAULT 1,
	download_count INTEGER NOT NULL DEFAULT 0,
	contents JSONB NOT NULL
);
GRANT SELECT, INSERT, UPDATE, DELETE ON documents TO thezaz_website;

CREATE OR REPLACE FUNCTION documents_maintenance_function() RETURNS TRIGGER AS $$
DECLARE
	p_update_meta BOOLEAN;
	p_console_safe_known BOOLEAN;
	p_rec RECORD;
BEGIN
	IF TG_OP = 'INSERT' THEN
		NEW.document_id = (NEW.contents->>'Identifier')::UUID;
		p_update_meta = TRUE;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.document_id != OLD.document_id OR NEW.contents->>'Identifier' != OLD.contents->>'Identifier' THEN
			RAISE EXCEPTION 'Cannot change document identifier';
		END IF;
		IF NEW.contents != OLD.contents THEN
			NEW.last_update = clock_timestamp();
			NEW.revision = NEW.revision + 1;
			p_update_meta = TRUE;
		ELSE
			IF NEW.title != OLD.title OR NEW.description != OLD.description OR NEW.is_public != OLD.is_public OR NEW.map != OLD.map OR NEW.difficulty != OLD.difficulty OR NEW.console_safe != OLD.console_safe THEN
				RAISE EXCEPTION 'Do not change meta properties. Change the contents JSON instead.';
			END IF;
		END IF;
	END IF;
	IF p_update_meta = TRUE THEN
		NEW.title = coalesce(NEW.contents->>'Title', 'Untitled Document');
		NEW.description = coalesce(NEW.contents->>'Description', '');
		NEW.is_public = coalesce((NEW.contents->>'Public')::boolean, FALSE);
		NEW.map = coalesce((NEW.contents->>'Map')::integer, 1);
		NEW.difficulty = coalesce((NEW.contents->>'DifficultyValue')::numeric, 4.0);
		NEW.console_safe = TRUE;
		p_console_safe_known = FALSE;
		FOR p_rec IN SELECT DISTINCT mods.console_safe FROM (SELECT DISTINCT jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(NEW.contents->'LootSources')->'ItemSets')->'ItemEntries')->'Items')->>'Path' AS path) AS items LEFT JOIN (engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id)) ON (items.path = engrams.path) LOOP
			NEW.console_safe = NEW.console_safe AND coalesce(p_rec.console_safe, FALSE);
			p_console_safe_known = TRUE;
		END LOOP;
		IF NOT p_console_safe_known THEN
			NEW.console_safe = FALSE;
		END IF;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER documents_maintenance_trigger BEFORE INSERT OR UPDATE ON documents FOR EACH ROW EXECUTE PROCEDURE documents_maintenance_function();
-- End Documents

-- Mods: The three core packs are now listed as mods. They have been "hard coded" into this database.
CREATE TABLE mods (
	mod_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	workshop_id BIGINT NOT NULL,
	user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	name TEXT NOT NULL DEFAULT 'Unknown Mod',
	confirmed BOOLEAN NOT NULL DEFAULT FALSE,
	confirmation_code UUID NOT NULL DEFAULT gen_random_uuid(),
	pull_url TEXT,
	last_pull_hash TEXT,
	console_safe BOOLEAN NOT NULL DEFAULT FALSE
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
-- End Mods

-- Sessions: PHP/Website sessions
CREATE TABLE sessions (
	session_id CITEXT NOT NULL PRIMARY KEY,
	user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	valid_until TIMESTAMP WITH TIME ZONE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE sessions TO thezaz_website;
-- End Sessions

-- OAuth Tokens: So the server can periodically refresh connected accounts.
CREATE TABLE oauth_tokens (
	access_token TEXT NOT NULL PRIMARY KEY,
	user_id UUID NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	valid_until TIMESTAMP WITH TIME ZONE,
	refresh_token TEXT NOT NULL
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE oauth_tokens TO thezaz_website;
-- End OAuth Tokens

-- Delete Tracking Functions: These functions allow the update JSON to include a section for deleted objects, since they'd be otherwise missing.
CREATE OR REPLACE FUNCTION object_insert_trigger () RETURNS TRIGGER AS $$
BEGIN
	EXECUTE 'DELETE FROM deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION object_update_trigger () RETURNS TRIGGER AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION object_delete_trigger () RETURNS TRIGGER AS $$
BEGIN
	EXECUTE 'INSERT INTO deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
-- End Delete Tracking Functions

-- This function takes the value of the path column and computes the class into the class_string column.
CREATE OR REPLACE FUNCTION compute_class_trigger () RETURNS TRIGGER AS $$
BEGIN
	NEW.class_string = SUBSTRING(NEW.path, '\.([a-zA-Z0-9\-\_]+)$') || '_C';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Enums
CREATE TYPE loot_source_kind AS ENUM (
	'Standard',
	'Bonus',
	'Cave',
	'Sea'
);

CREATE TYPE taming_methods AS ENUM (
	'None',
	'Knockout',
	'Passive',
	'Trap'
);
-- End Enums

-- Core Object Structure: Most objects will inherit from the objects table, which allows the website to determine changes for delta updates.
CREATE TABLE objects (
	object_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	label CITEXT NOT NULL,
	min_version INTEGER NOT NULL DEFAULT 0,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	mod_id UUID NOT NULL DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5' REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE objects to thezaz_website;

CREATE TABLE deletions (
	object_id UUID NOT NULL PRIMARY KEY,
	from_table CITEXT NOT NULL,
	label CITEXT NOT NULL,
	min_version INTEGER NOT NULL,
	action_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	tag TEXT
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE deletions TO thezaz_website;
-- End Core Object Structure

-- Loot Sources: All the lootable objects that Beacon can customize
CREATE TABLE loot_sources (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	path CITEXT NOT NULL UNIQUE,
	class_string CITEXT NOT NULL,
	availability INTEGER NOT NULL,
	kind loot_source_kind NOT NULL,
	multiplier_min NUMERIC(6,4) NOT NULL,
	multiplier_max NUMERIC(6,4) NOT NULL,
	uicolor TEXT NOT NULL CHECK (uicolor ~* '^[0-9a-fA-F]{8}$'),
	icon BYTEA NOT NULL,
	sort INTEGER NOT NULL UNIQUE,
	required_item_sets INTEGER NOT NULL DEFAULT 1,
	CHECK (class_string LIKE '%_C')
) INHERITS (objects);
GRANT SELECT ON TABLE loot_sources TO thezaz_website;
CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON loot_sources FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
-- End Loot Sources

-- Engrams: Any item that can find its way into a loot source.
-- Note: uses custom delete trigger to track the path for legacy versions.
CREATE TABLE engrams (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	path CITEXT NOT NULL UNIQUE,
	class_string CITEXT NOT NULL,
	availability INTEGER NOT NULL DEFAULT 0,
	can_blueprint BOOLEAN NOT NULL DEFAULT TRUE,
	CHECK (path LIKE '/%')
) INHERITS (objects);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE engrams TO thezaz_website;
CREATE OR REPLACE FUNCTION engram_delete_trigger () RETURNS TRIGGER AS $$
BEGIN
	EXECUTE 'INSERT INTO deletions (object_id, from_table, label, min_version, tag) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version, OLD.path;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE UNIQUE INDEX engrams_classstring_mod_id_uidx ON engrams(class_string, mod_id);
CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON engrams FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON engrams FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON engrams FOR EACH ROW EXECUTE PROCEDURE engram_delete_trigger();
CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON engrams FOR EACH ROW EXECUTE PROCEDURE compute_class_trigger();
-- End Engrams

-- Diets: Creatures each a variety of foods, this isn't just carnivores vs herbivores.
CREATE TABLE diets (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE
) INHERITS (objects);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE diets TO thezaz_website;
CREATE TRIGGER diets_before_insert_trigger BEFORE INSERT ON diets FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER diets_before_update_trigger BEFORE UPDATE ON diets FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER diets_after_delete_trigger AFTER DELETE ON diets FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();

CREATE TABLE diet_contents (
	diet_entry_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	diet_id UUID NOT NULL REFERENCES diets(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	engram_id UUID NOT NULL REFERENCES engrams(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	preference_order INTEGER NOT NULL,
	UNIQUE (diet_id, preference_order),
	UNIQUE (diet_id, engram_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE diet_contents TO thezaz_website;
-- End Diets

-- Creatures: Complete list of all creatures on Ark. Detailed, but not wiki-detailed.
CREATE TABLE creatures (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	path CITEXT NOT NULL UNIQUE,
	class_string CITEXT NOT NULL,
	availability INTEGER NOT NULL,
	tamable BOOLEAN NOT NULL,
	taming_diet UUID REFERENCES diets(object_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	taming_method taming_methods NOT NULL,
	tamed_diet UUID REFERENCES diets(object_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	rideable BOOLEAN NOT NULL,
	carryable BOOLEAN NOT NULL,
	breedable BOOLEAN NOT NULL,
	CHECK (path LIKE '/%')
) INHERITS (objects);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE creatures TO thezaz_website;
CREATE UNIQUE INDEX creatures_classstring_mod_id_uidx ON creatures(class_string, mod_id);
CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON creatures FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON creatures FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON creatures FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON creatures FOR EACH ROW EXECUTE PROCEDURE compute_class_trigger();
-- End Creatures

-- Creature Engrams: Saddles, produced items, drops, eggs, kibble, etc. but not the stuff eaten by the creature.
CREATE TABLE creature_engrams (
	relation_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	creature_id UUID NOT NULL REFERENCES creatures(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	engram_id UUID NOT NULL REFERENCES engrams(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE (creature_id, engram_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE creature_engrams TO thezaz_website;
-- End Creature Engrams

-- Presets
CREATE TABLE presets (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	contents JSONB NOT NULL
) INHERITS (objects);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE presets TO thezaz_website;

CREATE OR REPLACE FUNCTION presets_json_sync_function () RETURNS TRIGGER AS $$
BEGIN
	NEW.label = NEW.contents->>'Label';
	NEW.object_id = (NEW.contents->>'ID')::UUID;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON presets FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON presets FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON presets FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
CREATE TRIGGER presets_json_sync_trigger BEFORE INSERT OR UPDATE ON presets FOR EACH ROW EXECUTE PROCEDURE presets_json_sync_function();

CREATE TABLE preset_modifiers (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	pattern TEXT NOT NULL UNIQUE
) INHERITS (objects);
GRANT SELECT ON TABLE preset_modifiers TO thezaz_website;

CREATE TRIGGER preset_modifiers_before_insert_trigger BEFORE INSERT ON preset_modifiers FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER preset_modifiers_before_update_trigger BEFORE UPDATE ON preset_modifiers FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER preset_modifiers_after_delete_trigger AFTER DELETE ON preset_modifiers FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
-- End Presets

-- Articles
CREATE TYPE article_type AS ENUM (
	'Blog',
	'Help'
);

CREATE TABLE articles (
	article_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	publish_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	title TEXT NOT NULL,
	body TEXT NOT NULL,
	type article_type NOT NULL
);
GRANT SELECT ON TABLE articles TO thezaz_website;
-- End Articles

-- Search
CREATE OR REPLACE VIEW search_contents AS (SELECT article_id AS id, title, body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(body), 'B') AS lexemes, 'Article' AS type FROM articles) UNION (SELECT object_id AS id, label AS title, '' AS body, setweight(to_tsvector(label), 'A') AS lexemes, 'Object' AS type FROM objects WHERE objects.tableoid::regclass IN ('engrams', 'creatures', 'loot_sources')) UNION (SELECT mod_id AS id, name AS title, '' AS body, setweight(to_tsvector(name), 'C') AS lexemes, 'Mod' AS type FROM mods) UNION (SELECT document_id, title, description AS body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(description), 'B') AS lexemes, 'Document' AS type FROM documents WHERE is_public = TRUE);
GRANT SELECT ON TABLE search_contents TO thezaz_website;
-- End Search