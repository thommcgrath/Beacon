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
CREATE TABLE users (
	user_id UUID NOT NULL PRIMARY KEY,
	public_key TEXT NOT NULL,
	patreon_id INTEGER,
	is_patreon_supporter BOOLEAN NOT NULL DEFAULT FALSE
);
GRANT SELECT, INSERT ON TABLE users TO thezaz_website;
INSERT INTO users (user_id, public_key) VALUES ('90217323-e0c4-4b28-ba24-eed4676f2a83', E'-----BEGIN PUBLIC KEY-----\nMIIBIDANBgkqhkiG9w0BAQEFAAOCAQ0AMIIBCAKCAQEAv5cpgtzTlpTYEDpGTVzB\n3tAuAkL5HfZCxLdF1pJoEOOXh4vKlFDX3pIxtIRq3KWDTpAPJQGlgapoPPBMEka1\nYq6sbiyewGNAPQQyFSee9xnuqFHaF673uBujKGdDyx18t3SKRuyFohIcW4hkwhbY\n7wYjuBUc35L6X7iBtVGo749L5nH4ihBMb+mw5Et8GLxY6gLyv9xvE8eJ4+fpELdd\nWkyNNBE/BhwGTc5L7StOqgdJ7V0cJsY/syBAfkx57lnho8Ux2zC2hhmYE4FYA4r9\n3mdE7jy42v+qYpg88NZHisnBzy/S4IY4D5HKO+EF/9/ON4w2shKoeBVZ7YwMTZJK\nwwIBEQ==\n-----END PUBLIC KEY-----');
-- End Users

-- Documents: Files that are shareable in the community (time to rethink this?)
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
-- End Documents

-- Mods: The three core packs are now listed as mods. They have been "hard coded" into this database.
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
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed) VALUES ('30bbab29-44b2-4f4b-a373-6d4740d9d3b5', 346110, '90217323-e0c4-4b28-ba24-eed4676f2a83', 'Ark Prime', TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed) VALUES ('55dd6a68-7041-46aa-9405-9adc5ae1825f', 512540, '90217323-e0c4-4b28-ba24-eed4676f2a83', 'Scorched Earth', TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed) VALUES ('38b6b5ae-1a60-4f2f-9bc6-9a23620b56d8', 708770, '90217323-e0c4-4b28-ba24-eed4676f2a83', 'Aberration', TRUE);
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

-- Patreon Tokens: So the server can periodically refresh Patreon supporter information.
CREATE TABLE patreon_tokens (
	access_token TEXT NOT NULL PRIMARY KEY,
	user_id UUID NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	valid_until TIMESTAMP WITH TIME ZONE,
	refresh_token TEXT NOT NULL
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE patreon_tokens TO thezaz_website;
-- End Patreon Tokens

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
	EXECUTE 'INSERT INTO deletions (object_id, from_table, label) VALUES ($1, $2, $3);' USING OLD.object_id, TG_TABLE_NAME, OLD.label;
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
	'Sea',
	'BossSpider',
	'BossGorilla',
	'BossDragon',
	'BossManticore'
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
	min_version INTEGER,
	last_update TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	mod_id UUID NOT NULL DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5' REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE objects to thezaz_website;

CREATE TABLE deletions (
	object_id UUID NOT NULL PRIMARY KEY,
	from_table CITEXT NOT NULL,
	label CITEXT NOT NULL,
	action_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE deletions TO thezaz_website;
-- End Core Object Structure

-- Loot Sources: All the lootable objects that Beacon can customize
CREATE TABLE loot_sources (
	PRIMARY KEY (object_id),
	FOREIGN KEY (mod_id) REFERENCES mods(mod_id) ON DELETE CASCADE ON UPDATE CASCADE,
	class_string CITEXT NOT NULL UNIQUE,
	kind loot_source_kind NOT NULL,
	availability INTEGER NOT NULL,
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
CREATE UNIQUE INDEX engrams_classstring_mod_id_uidx ON engrams(class_string, mod_id);
CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON engrams FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON engrams FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON engrams FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
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
	shoulder_mounted BOOLEAN NOT NULL,
	breedable BOOLEAN NOT NULL,
	egg_engram UUID REFERENCES engrams(object_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CHECK (path LIKE '/%')
) INHERITS (objects);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE creatures TO thezaz_website;
CREATE UNIQUE INDEX creatures_classstring_mod_id_uidx ON creatures(class_string, mod_id);
CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON creatures FOR EACH ROW EXECUTE PROCEDURE object_insert_trigger();
CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON creatures FOR EACH ROW EXECUTE PROCEDURE object_update_trigger();
CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON creatures FOR EACH ROW EXECUTE PROCEDURE object_delete_trigger();
CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON creatures FOR EACH ROW EXECUTE PROCEDURE compute_class_trigger();
-- End Creatures

-- Saddles: Since multiple creatures can use the same saddle (Ankylo + Aberrant Ankylo) and one create can use multiple saddles (Drake Saddle + Drake Tek Saddle) we need this table to support a many-to-many relationship.
CREATE TABLE saddles (
	saddle_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	engram_id UUID NOT NULL REFERENCES engrams(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	creature_id UUID NOT NULL REFERENCES creatures(object_id) ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE (engram_id, creature_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE saddles TO thezaz_website;
-- End Saddles