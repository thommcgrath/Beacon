--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ark; Type: SCHEMA; Schema: -; Owner: thommcgrath
--

CREATE SCHEMA ark;


ALTER SCHEMA ark OWNER TO thommcgrath;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: loot_quality_tier; Type: TYPE; Schema: ark; Owner: thommcgrath
--

CREATE TYPE ark.loot_quality_tier AS ENUM (
    'Tier1',
    'Tier2',
    'Tier3',
    'Tier4',
    'Tier5',
    'Tier6',
    'Tier7',
    'Tier8',
    'Tier9',
    'Tier10'
);


ALTER TYPE ark.loot_quality_tier OWNER TO thommcgrath;

--
-- Name: article_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.article_type AS ENUM (
    'Blog',
    'Help'
);


ALTER TYPE public.article_type OWNER TO thommcgrath;

--
-- Name: download_platform; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.download_platform AS ENUM (
    'macOS',
    'Windows',
    'Linux'
);


ALTER TYPE public.download_platform OWNER TO thommcgrath;

--
-- Name: download_signature_format; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.download_signature_format AS ENUM (
    'RSA',
    'DSA',
    'ed25519'
);


ALTER TYPE public.download_signature_format OWNER TO thommcgrath;

--
-- Name: email; Type: DOMAIN; Schema: public; Owner: thommcgrath
--

CREATE DOMAIN public.email AS public.citext
	CONSTRAINT email_check CHECK ((VALUE OPERATOR(public.~) '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::public.citext));


ALTER DOMAIN public.email OWNER TO thommcgrath;

--
-- Name: game_identifier; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.game_identifier AS ENUM (
    'Ark'
);


ALTER TYPE public.game_identifier OWNER TO thommcgrath;

--
-- Name: hex; Type: DOMAIN; Schema: public; Owner: thommcgrath
--

CREATE DOMAIN public.hex AS public.citext
	CONSTRAINT hex_check CHECK ((VALUE OPERATOR(public.~) '^[a-fA-F0-9]+$'::public.citext));


ALTER DOMAIN public.hex OWNER TO thommcgrath;

--
-- Name: ini_file; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.ini_file AS ENUM (
    'Game.ini',
    'GameUserSettings.ini',
    'CommandLineFlag',
    'CommandLineOption'
);


ALTER TYPE public.ini_file OWNER TO thommcgrath;

--
-- Name: ini_value_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.ini_value_type AS ENUM (
    'Numeric',
    'Array',
    'Structure',
    'Boolean',
    'Text'
);


ALTER TYPE public.ini_value_type OWNER TO thommcgrath;

--
-- Name: loot_source_kind; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.loot_source_kind AS ENUM (
    'Standard',
    'Bonus',
    'Cave',
    'Sea'
);


ALTER TYPE public.loot_source_kind OWNER TO thommcgrath;

--
-- Name: nitrado_deploy_style; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.nitrado_deploy_style AS ENUM (
    'Guided',
    'Expert',
    'Both'
);


ALTER TYPE public.nitrado_deploy_style OWNER TO thommcgrath;

--
-- Name: nitrado_format; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.nitrado_format AS ENUM (
    'Line',
    'Value'
);


ALTER TYPE public.nitrado_format OWNER TO thommcgrath;

--
-- Name: os_version; Type: DOMAIN; Schema: public; Owner: thommcgrath
--

CREATE DOMAIN public.os_version AS text
	CONSTRAINT os_version_check CHECK ((VALUE ~ '^\d{1,3}\.\d{1,3}\.\d{1,6}$'::text));


ALTER DOMAIN public.os_version OWNER TO thommcgrath;

--
-- Name: point3d; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.point3d AS (
	x numeric(16,6),
	y numeric(16,6),
	z numeric(16,6)
);


ALTER TYPE public.point3d OWNER TO thommcgrath;

--
-- Name: publish_status; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.publish_status AS ENUM (
    'Private',
    'Requested',
    'Approved',
    'Approved But Private',
    'Denied'
);


ALTER TYPE public.publish_status OWNER TO thommcgrath;

--
-- Name: taming_methods; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.taming_methods AS ENUM (
    'None',
    'Knockout',
    'Passive',
    'Trap'
);


ALTER TYPE public.taming_methods OWNER TO thommcgrath;

--
-- Name: update_file_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.update_file_type AS ENUM (
    'Complete',
    'Delta'
);


ALTER TYPE public.update_file_type OWNER TO thommcgrath;

--
-- Name: update_urgency; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.update_urgency AS ENUM (
    'Minor',
    'Normal',
    'Important',
    'Emergency'
);


ALTER TYPE public.update_urgency OWNER TO thommcgrath;

--
-- Name: video_host; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.video_host AS ENUM (
    'YouTube',
    'Vimeo'
);


ALTER TYPE public.video_host OWNER TO thommcgrath;

--
-- Name: break_mod_relationships(uuid[]); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.break_mod_relationships(p_uuids uuid[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	FOR first_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
	LOOP
		FOR second_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
		LOOP
			IF first_idx != second_idx THEN
				DELETE FROM ark.mod_relationships WHERE (first_mod_id = p_uuids[first_idx] AND second_mod_id = p_uuids[second_idx]) OR (first_mod_id = p_uuids[second_idx] AND second_mod_id = p_uuids[first_idx]);
			END IF;
		END LOOP;
	END LOOP;
END;
$$;


ALTER FUNCTION ark.break_mod_relationships(p_uuids uuid[]) OWNER TO thommcgrath;

--
-- Name: compute_class_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.compute_class_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	NEW.class_string = SUBSTRING(NEW.path, '\.([a-zA-Z0-9\-\_]+)$') || '_C';
	RETURN NEW;
END;
$_$;


ALTER FUNCTION ark.compute_class_trigger() OWNER TO thommcgrath;

--
-- Name: create_mod_relationships(uuid[]); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.create_mod_relationships(p_uuids uuid[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	FOR first_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
	LOOP
		FOR second_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
		LOOP
			IF first_idx != second_idx THEN
				INSERT INTO ark.mod_relationships (first_mod_id, second_mod_id) VALUES (p_uuids[first_idx], p_uuids[second_idx]) ON CONFLICT (first_mod_id, second_mod_id) DO NOTHING;
				INSERT INTO ark.mod_relationships (first_mod_id, second_mod_id) VALUES (p_uuids[second_idx], p_uuids[first_idx]) ON CONFLICT (first_mod_id, second_mod_id) DO NOTHING;
			END IF;
		END LOOP;
	END LOOP;
END;
$$;


ALTER FUNCTION ark.create_mod_relationships(p_uuids uuid[]) OWNER TO thommcgrath;

--
-- Name: enforce_mod_owner(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.enforce_mod_owner() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	confirmed_count INTEGER := 0;
BEGIN
	IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE' AND NEW.confirmed = TRUE AND OLD.confirmed = FALSE) THEN
		SELECT INTO confirmed_count COUNT(mod_id) FROM ark.mods WHERE confirmed = TRUE AND workshop_id = NEW.workshop_id;
		IF confirmed_count > 0 THEN
			RAISE EXCEPTION 'Mod is already confirmed by another user.';
		END IF;
		IF NEW.confirmed THEN
			DELETE FROM ark.mods WHERE workshop_id = NEW.workshop_id AND mod_id != NEW.mod_id;
		END IF;
	END IF;
	
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.enforce_mod_owner() OWNER TO thommcgrath;

--
-- Name: engram_delete_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.engram_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO ark.deletions (object_id, from_table, label, min_version, tag) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version, OLD.path;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION ark.engram_delete_trigger() OWNER TO thommcgrath;

--
-- Name: generic_update_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.generic_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.generic_update_trigger() OWNER TO thommcgrath;

--
-- Name: mods_delete_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.mods_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	IF OLD.confirmed = TRUE THEN
		EXECUTE 'INSERT INTO ark.deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.mod_id, TG_TABLE_NAME, OLD.name, 10500000;
	END IF;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION ark.mods_delete_trigger() OWNER TO thommcgrath;

--
-- Name: mods_search_sync(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.mods_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.mod_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.mod_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.confirmed = TRUE THEN
			IF OLD.confirmed = FALSE THEN
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'creatures', 'Save' FROM ark.creatures WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'engrams', 'Save' FROM ark.engrams WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'loot_sources', 'Save' FROM ark.loot_sources WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'spawn_points', 'Save' FROM ark.spawn_points WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			END IF;
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.mod_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'creatures', 'Delete' FROM ark.creatures WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'engrams', 'Delete' FROM ark.engrams WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'loot_sources', 'Delete' FROM ark.loot_sources WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'spawn_points', 'Delete' FROM ark.spawn_points WHERE mod_id = OLD.mod_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.mod_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION ark.mods_search_sync() OWNER TO thommcgrath;

--
-- Name: object_delete_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.object_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO ark.deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION ark.object_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_insert_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.object_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM ark.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION ark.object_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_update_trigger(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.object_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.object_update_trigger() OWNER TO thommcgrath;

--
-- Name: objects_search_sync(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.objects_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.object_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.object_id, TG_TABLE_NAME, 'Save')  ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION ark.objects_search_sync() OWNER TO thommcgrath;

--
-- Name: presets_json_sync_function(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.presets_json_sync_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.label = NEW.contents->>'Label';
	NEW.object_id = (NEW.contents->>'ID')::UUID;
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.presets_json_sync_function() OWNER TO thommcgrath;

--
-- Name: update_color_last_update(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_color_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM ark.deletions WHERE object_id = generate_uuid_from_text('color ' || NEW.color_id::text) AND from_table = 'colors';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO ark.deletions (object_id, from_table, label, min_version, action_time) VALUES (generate_uuid_from_text('color ' || OLD.color_id::text), 'colors', OLD.color_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION ark.update_color_last_update() OWNER TO thommcgrath;

--
-- Name: update_color_set_last_update(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_color_set_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM ark.deletions WHERE object_id = NEW.color_set_id AND from_table = 'color_sets';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO ark.deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.color_set_id, 'color_sets', OLD.label, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION ark.update_color_set_last_update() OWNER TO thommcgrath;

--
-- Name: update_creature_modified(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_creature_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' OR TG_OP = 'TRUNCATE' OR (TG_OP = 'UPDATE' AND NEW.creature_id != OLD.creature_id) THEN
		UPDATE ark.creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = OLD.creature_id;
	END IF;
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE ark.creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = NEW.creature_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION ark.update_creature_modified() OWNER TO thommcgrath;

--
-- Name: update_engram_timestamp(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_engram_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_oldid UUID;
	v_newid UUID;
BEGIN
	IF TG_OP = 'DELETE' THEN
		v_oldid = OLD.engram_id;
	ELSIF TG_OP = 'UPDATE' THEN
		v_oldid = OLD.engram_id;
		v_newid = NEW.engram_id;
	ELSE
		v_newid = NEW.engram_id;
	END IF;
	IF v_oldid IS NOT NULL THEN
		UPDATE ark.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
	END IF;
	IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
		UPDATE ark.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION ark.update_engram_timestamp() OWNER TO thommcgrath;

--
-- Name: update_event_last_update(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_event_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM ark.deletions WHERE object_id = NEW.event_id AND from_table = 'events';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO ark.deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.event_id, 'events', OLD.event_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION ark.update_event_last_update() OWNER TO thommcgrath;

--
-- Name: update_event_last_update_from_children(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_event_last_update_from_children() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE events SET last_update = CURRENT_TIMESTAMP WHERE event_id = NEW.event_id;
	END IF;
	IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND NEW.event_id != OLD.event_id) THEN
		UPDATE events SET last_update = CURRENT_TIMESTAMP WHERE event_id = OLD.event_id;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION ark.update_event_last_update_from_children() OWNER TO thommcgrath;

--
-- Name: update_last_update_column(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_last_update_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.update_last_update_column() OWNER TO thommcgrath;

--
-- Name: update_loot_source_timestamp(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_loot_source_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_oldid UUID;
	v_newid UUID;
BEGIN
	IF TG_TABLE_NAME = 'loot_item_sets' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_source_id;
		END IF;
		IF TG_OP = 'NEW' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_source_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
		END IF;
	ELSIF TG_TABLE_NAME = 'loot_item_set_entries' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_item_set_id;
		END IF;
		IF TG_OP = 'NEW' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_item_set_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP FROM ark.loot_item_sets WHERE loot_item_sets.loot_item_set_id = v_oldid AND loot_item_sets.loot_source_id = loot_sources.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP FROM ark.loot_item_sets WHERE loot_item_sets.loot_item_set_id = v_newid AND loot_item_sets.loot_source_id = loot_sources.object_id;
		END IF;
	ELSIF TG_TABLE_NAME = 'loot_item_set_entry_options' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_item_set_entry_id;
		END IF;
		IF TG_OP = 'NEW' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_item_set_entry_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP FROM ark.loot_item_sets, ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_entry_id = v_oldid AND loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id AND loot_item_sets.loot_source_id = loot_sources.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.loot_sources SET last_update = CURRENT_TIMESTAMP FROM ark.loot_item_sets, ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_entry_id = v_newid AND loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id AND loot_item_sets.loot_source_id = loot_sources.object_id;
		END IF;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION ark.update_loot_source_timestamp() OWNER TO thommcgrath;

--
-- Name: update_spawn_point_timestamp(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_spawn_point_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_oldid UUID;
	v_newid UUID;
BEGIN
	IF TG_TABLE_NAME = 'spawn_point_set_entries' OR TG_TABLE_NAME = 'spawn_point_set_replacements' THEN
		IF TG_OP = 'DELETE' THEN
			v_oldid = OLD.spawn_point_set_id;
		ELSIF TG_OP = 'UPDATE' THEN
			v_oldid = OLD.spawn_point_set_id;
			v_newid = NEW.spawn_point_set_id;
		ELSE
			v_newid = NEW.spawn_point_set_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP FROM ark.spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_oldid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP FROM ark.spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_newid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
	ELSIF TG_TABLE_NAME = 'spawn_point_set_entry_levels' THEN
		IF TG_OP = 'DELETE' THEN
			v_oldid = OLD.spawn_point_set_entry_id;
		ELSIF TG_OP = 'UPDATE' THEN
			v_oldid = OLD.spawn_point_set_entry_id;
			v_newid = NEW.spawn_point_set_entry_id;
		ELSE
			v_newid = NEW.spawn_point_set_entry_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP FROM ark.spawn_point_set_entries, ark.spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_oldid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP FROM ark.spawn_point_set_entries, ark.spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_newid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
	ELSE
		IF TG_OP = 'DELETE' THEN
			v_oldid = OLD.spawn_point_id;
		ELSIF TG_OP = 'UPDATE' THEN
			v_oldid = OLD.spawn_point_id;
			v_newid = NEW.spawn_point_id;
		ELSE
			v_newid = NEW.spawn_point_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE ark.spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
		END IF;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION ark.update_spawn_point_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_module_timestamp(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_support_article_module_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.module_updated := CURRENT_TIMESTAMP;
	UPDATE support_articles SET article_updated = CURRENT_TIMESTAMP WHERE content_markdown LIKE '%[module:' || NEW.module_name || ']%';
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.update_support_article_module_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_timestamp(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.update_support_article_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.article_updated := CURRENT_TIMESTAMP;
	IF TG_OP = 'INSERT' OR (TG_OP = 'UPDATE' AND NEW.subject IS DISTINCT FROM OLD.subject) THEN
		UPDATE support_articles SET article_updated = CURRENT_TIMESTAMP WHERE content_markdown LIKE '%' || NEW.article_id::TEXT || '%';
		UPDATE support_article_modules SET module_updated = CURRENT_TIMESTAMP WHERE module_markdown LIKE '%' || NEW.article_id::TEXT || '%';
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.update_support_article_timestamp() OWNER TO thommcgrath;

--
-- Name: documents_search_sync(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.documents_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.published = 'Approved' AND OLD.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.document_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.published = 'Approved' AND NEW.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.document_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.published = 'Approved' AND NEW.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.document_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.published = 'Approved' AND OLD.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.document_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION public.documents_search_sync() OWNER TO thommcgrath;

--
-- Name: generate_username(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.generate_username() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_record RECORD;
	v_nouncount INTEGER DEFAULT 0;
	v_adjectivecount INTEGER DEFAULT 0;
	v_suffixcount INTEGER DEFAULT 0;
	v_nounoffset INTEGER;
	v_adjectiveoffset INTEGER;
	v_suffixoffset INTEGER;
	v_adjective TEXT;
	v_noun TEXT;
	v_suffix TEXT;
BEGIN
	FOR v_record IN SELECT COUNT(word) AS word_count, isnoun, isadjective, issuffix FROM wordlist GROUP BY isnoun, isadjective, issuffix LOOP
		IF v_record.isnoun = TRUE THEN
			v_nouncount := v_nouncount + v_record.word_count;
		END IF;
		IF v_record.isadjective = TRUE THEN
			v_adjectivecount := v_adjectivecount + v_record.word_count;
		END IF;
		IF v_record.issuffix = TRUE THEN
			v_suffixcount := v_suffixcount + v_record.word_count;
		END IF;
	END LOOP;
	
	IF v_nouncount = 0 OR v_adjectivecount = 0 THEN
		RETURN '';
	END IF;
	
	v_nounoffset := RANDOM() * (v_nouncount - 1);
	v_adjectiveoffset := RANDOM() * (v_adjectivecount - 1);
	SELECT word INTO v_noun FROM wordlist WHERE isnoun = TRUE OFFSET v_nounoffset LIMIT 1;
	SELECT word INTO v_adjective FROM wordlist WHERE isadjective = TRUE OFFSET v_adjectiveoffset LIMIT 1;
	v_suffix = '';
	
	IF v_suffixcount > 0 AND RANDOM() <= 0.1 THEN
		v_suffixoffset := RANDOM() * (v_suffixcount - 1);
		SELECT word INTO v_suffix FROM wordlist WHERE issuffix = TRUE OFFSET v_suffixoffset LIMIT 1;
	END IF;
	
	RETURN INITCAP(TRIM(CONCAT(v_adjective, ' ', v_noun, v_suffix)));
END;
$$;


ALTER FUNCTION public.generate_username() OWNER TO thommcgrath;

--
-- Name: generate_uuid_from_text(text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.generate_uuid_from_text(p_input text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_md5_raw BYTEA;
	v_uuid UUID;
BEGIN
	v_md5_raw := DECODE(MD5(p_input), 'hex');
	v_md5_raw := SET_BYTE(v_md5_raw, 6, ((GET_BYTE(v_md5_raw, 6)::bit(8) & B'00001111') | B'01000000')::integer);
	v_md5_raw := SET_BYTE(v_md5_raw, 8, ((GET_BYTE(v_md5_raw, 8)::bit(8) & B'00111111') | B'10000000')::integer);
	RETURN ENCODE(v_md5_raw, 'hex');
END;
$$;


ALTER FUNCTION public.generate_uuid_from_text(p_input text) OWNER TO thommcgrath;

--
-- Name: group_key_for_email(public.email, integer); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.group_key_for_email(p_address public.email, p_precision integer) RETURNS public.hex
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE
	v_user TEXT;
	v_domain TEXT;
	v_kvalue TEXT;
BEGIN
	IF p_precision > 5 THEN
		RETURN SUBSTRING(ENCODE(SHA512(LOWER(TRIM(p_address))::bytea), 'hex'), 1, p_precision);
	ELSE
		v_user := SUBSTRING(p_address, '^([^@]+)@.+$');
		v_domain := SUBSTRING(p_address, '^[^@]+@(.+)$');
		
		IF LENGTH(v_user) <= p_precision THEN
			v_kvalue := '@' || v_domain;
		ELSE
			v_kvalue := SUBSTRING(v_user, 1, p_precision) || '*@' || v_domain;
		END IF;
	
		RETURN MD5(LOWER(v_kvalue));
	END IF;
END;
$_$;


ALTER FUNCTION public.group_key_for_email(p_address public.email, p_precision integer) OWNER TO thommcgrath;

--
-- Name: group_key_for_email(public.email, integer, text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.group_key_for_email(p_address public.email, p_precision integer, p_alg text) RETURNS public.hex
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE
	v_user TEXT;
	v_domain TEXT;
	v_kvalue TEXT;
BEGIN
	IF LOWER(p_alg) = 'md5' THEN
		v_user := SUBSTRING(p_address, '^([^@]+)@.+$');
		v_domain := SUBSTRING(p_address, '^[^@]+@(.+)$');
		
		IF LENGTH(v_user) <= p_precision THEN
			v_kvalue := '@' || v_domain;
		ELSE
			v_kvalue := SUBSTRING(v_user, 1, p_precision) || '*@' || v_domain;
		END IF;
	
		RETURN MD5(LOWER(v_kvalue));
	ELSE
		RETURN SUBSTRING(ENCODE(DIGEST(LOWER(p_address), p_alg), 'hex'), 1, p_precision);
	END IF;
END;
$_$;


ALTER FUNCTION public.group_key_for_email(p_address public.email, p_precision integer, p_alg text) OWNER TO thommcgrath;

--
-- Name: os_version_as_integer(public.os_version); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.os_version_as_integer(p_version public.os_version) RETURNS bigint
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
	v_matches TEXT[];
	v_major INTEGER DEFAULT 0;
	v_minor INTEGER DEFAULT 0;
	v_bug INTEGER DEFAULT 0;
BEGIN
	v_matches := regexp_matches(p_version::TEXT, '^(\d{1,3})\.(\d{1,3})\.(\d{1,6})$');
	IF v_matches IS NOT NULL THEN
		v_major = v_matches[1];
		v_minor = v_matches[2];
		v_bug = v_matches[3];
	END IF;
	RETURN (v_major::BIGINT * 1000000000) + (v_minor::BIGINT * 1000000) + v_bug::BIGINT;
END; $_$;


ALTER FUNCTION public.os_version_as_integer(p_version public.os_version) OWNER TO thommcgrath;

--
-- Name: set_slug_from_article_subject(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.set_slug_from_article_subject() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.article_slug := slugify(NEW.subject);
	RETURN NEW;
END $$;


ALTER FUNCTION public.set_slug_from_article_subject() OWNER TO thommcgrath;

--
-- Name: set_slug_from_video_title(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.set_slug_from_video_title() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.video_slug := slugify(NEW.video_title);
	RETURN NEW;
END $$;


ALTER FUNCTION public.set_slug_from_video_title() OWNER TO thommcgrath;

--
-- Name: slugify(text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.slugify(p_input text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	v_simplified TEXT;
	v_words TEXT[];
	v_slug TEXT;
BEGIN
	v_simplified := LOWER(unaccent(p_input));
	v_simplified := regexp_replace(v_simplified, '(\S)''(\S)', '\1\2');
	v_simplified := TRIM(regexp_replace(v_simplified, '[^a-z0-9 \\-]+', ' ', 'gi'));
	v_simplified := replace(v_simplified, '\s-\s', ' ');
	v_words := regexp_split_to_array(v_simplified, '\s+');
	LOOP
		v_slug := array_to_string(v_words, '_');
		EXIT WHEN LENGTH(v_slug) <= 32;
		v_words = (SELECT v_words[1:array_upper(v_words, 1) - 1]);
	END LOOP;
	RETURN v_slug;
END;
$$;


ALTER FUNCTION public.slugify(p_input text) OWNER TO thommcgrath;

--
-- Name: support_articles_search_sync(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.support_articles_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.article_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.article_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.article_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.article_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION public.support_articles_search_sync() OWNER TO thommcgrath;

--
-- Name: support_videos_search_sync(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.support_videos_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.video_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.video_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.video_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.published = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.video_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION public.support_videos_search_sync() OWNER TO thommcgrath;

--
-- Name: update_blog_article_hash(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_blog_article_hash() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.article_hash := MD5(NEW.subject || '::' || COALESCE(NEW.content_markdown, '') || '::' || COALESCE(NEW.preview, ''));
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_blog_article_hash() OWNER TO thommcgrath;

--
-- Name: update_blog_article_timestamp(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_blog_article_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_updated = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_blog_article_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_image_associations(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_support_image_associations() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' OR (TG_OP = 'UPDATE' AND (NEW.width_points IS DISTINCT FROM OLD.width_points OR NEW.height_points IS DISTINCT FROM OLD.width_points OR NEW.min_scale IS DISTINCT FROM OLD.min_scale OR NEW.max_scale IS DISTINCT FROM OLD.max_scale OR NEW.extension IS DISTINCT FROM OLD.extension)) THEN
		UPDATE support_articles SET article_updated = CURRENT_TIMESTAMP WHERE content_markdown LIKE '%' || NEW.image_id || '%';
		UPDATE support_article_modules SET module_updated = CURRENT_TIMESTAMP WHERE module_markdown LIKE '%' || NEW.image_id || '%';
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_support_image_associations() OWNER TO thommcgrath;

--
-- Name: uuid_for_email(public.email); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.uuid_for_email(p_address public.email) RETURNS uuid
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	v_row RECORD;
	v_uuid UUID;
BEGIN
	FOR v_row IN SELECT DISTINCT group_key_precision, group_key_alg FROM email_addresses ORDER BY group_key_precision DESC
	LOOP
		SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key = group_key_for_email(p_address, v_row.group_key_precision, v_row.group_key_alg) AND CRYPT(LOWER(p_address), address) = address;
		IF FOUND THEN
			RETURN v_uuid;
		END IF;
	END LOOP;
	
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.uuid_for_email(p_address public.email) OWNER TO thommcgrath;

--
-- Name: uuid_for_email(public.email, boolean); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.uuid_for_email(p_address public.email, p_create boolean) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_uuid UUID;
	v_precision INTEGER;
	v_alg TEXT;
	k_target_precision CONSTANT INTEGER := 5;
	k_target_alg CONSTANT TEXT := 'md5';
BEGIN
	v_uuid := uuid_for_email(p_address);
	IF v_uuid IS NULL THEN
		IF p_create = TRUE THEN
			INSERT INTO email_addresses (address, group_key, group_key_precision, group_key_alg) VALUES (CRYPT(LOWER(p_address), GEN_SALT('bf')), group_key_for_email(p_address, k_target_precision, k_target_alg), k_target_precision, k_target_alg) RETURNING email_id INTO v_uuid;
		END IF;
	ELSE
		SELECT group_key_precision, group_key_alg INTO v_precision, v_alg FROM email_addresses WHERE email_id = v_uuid;
		IF v_precision != k_target_precision OR v_alg != k_target_alg THEN
			UPDATE email_addresses SET group_key = group_key_for_email(p_address, k_target_precision, k_target_alg), group_key_precision = k_target_precision, group_key_alg = k_target_alg WHERE email_id = v_uuid;
		END IF;
	END IF;
	RETURN v_uuid;	
END;
$$;


ALTER FUNCTION public.uuid_for_email(p_address public.email, p_create boolean) OWNER TO thommcgrath;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: objects; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.objects (
    object_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label public.citext NOT NULL,
    min_version integer DEFAULT 0 NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    mod_id uuid DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[],
    alternate_label public.citext
);


ALTER TABLE ark.objects OWNER TO thommcgrath;

--
-- Name: creatures; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.creatures (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer NOT NULL,
    tamable boolean NOT NULL,
    taming_diet uuid,
    taming_method public.taming_methods NOT NULL,
    tamed_diet uuid,
    rideable boolean NOT NULL,
    carryable boolean NOT NULL,
    breedable boolean NOT NULL,
    incubation_time interval,
    mature_time interval,
    mating_interval_min interval,
    mating_interval_max interval,
    used_stats integer,
    group_key public.citext,
    group_master boolean DEFAULT false NOT NULL,
    CONSTRAINT creatures_check CHECK ((((mating_interval_min IS NULL) AND (mating_interval_max IS NULL)) OR ((mating_interval_min IS NOT NULL) AND (mating_interval_max IS NOT NULL)))),
    CONSTRAINT creatures_group_key_check CHECK ((group_key OPERATOR(public.<>) ''::public.citext)),
    CONSTRAINT creatures_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (ark.objects);


ALTER TABLE ark.creatures OWNER TO thommcgrath;

--
-- Name: engrams; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.engrams (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    entry_string public.citext,
    required_points integer,
    required_level integer,
    stack_size integer,
    item_id integer,
    CONSTRAINT engrams_check CHECK ((((entry_string IS NULL) AND (required_points IS NULL) AND (required_level IS NULL)) OR (entry_string IS NOT NULL))),
    CONSTRAINT engrams_entry_string_check CHECK ((entry_string OPERATOR(public.~) '_C$'::public.citext)),
    CONSTRAINT engrams_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (ark.objects);


ALTER TABLE ark.engrams OWNER TO thommcgrath;

--
-- Name: loot_sources; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.loot_sources (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer NOT NULL,
    multiplier_min numeric(6,4) NOT NULL,
    multiplier_max numeric(6,4) NOT NULL,
    uicolor text NOT NULL,
    icon uuid NOT NULL,
    sort integer,
    experimental boolean DEFAULT false NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    requirements jsonb DEFAULT '{}'::jsonb NOT NULL,
    modern_sort integer,
    simple_label public.citext,
    min_item_sets integer NOT NULL,
    max_item_sets integer NOT NULL,
    prevent_duplicates boolean NOT NULL,
    CONSTRAINT loot_sources_check CHECK ((((sort IS NULL) AND (min_version >= 10303300) AND (modern_sort IS NOT NULL)) OR (sort IS NOT NULL))),
    CONSTRAINT loot_sources_check1 CHECK (((experimental = false) OR (min_version >= 10100202))),
    CONSTRAINT loot_sources_class_string_check1 CHECK ((class_string OPERATOR(public.~~) '%_C'::public.citext)),
    CONSTRAINT loot_sources_uicolor_check1 CHECK ((uicolor ~* '^[0-9a-fA-F]{8}$'::text))
)
INHERITS (ark.objects);


ALTER TABLE ark.loot_sources OWNER TO thommcgrath;

--
-- Name: COLUMN loot_sources.simple_label; Type: COMMENT; Schema: ark; Owner: thommcgrath
--

COMMENT ON COLUMN ark.loot_sources.simple_label IS 'simple_label is a more ambiguous name that relies on the client to perform disambiguation';


--
-- Name: spawn_points; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_points (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    CONSTRAINT spawn_points_path_check CHECK ((path OPERATOR(public.~~) '/Game/%'::public.citext))
)
INHERITS (ark.objects);


ALTER TABLE ark.spawn_points OWNER TO thommcgrath;

--
-- Name: blueprints; Type: VIEW; Schema: ark; Owner: thommcgrath
--

CREATE VIEW ark.blueprints AS
 SELECT creatures.object_id,
    creatures.label,
    creatures.alternate_label,
    creatures.tableoid,
    creatures.min_version,
    creatures.last_update,
    creatures.mod_id,
    creatures.path,
    creatures.class_string,
    creatures.availability,
    creatures.tags
   FROM ark.creatures
UNION
 SELECT engrams.object_id,
    engrams.label,
    engrams.alternate_label,
    engrams.tableoid,
    engrams.min_version,
    engrams.last_update,
    engrams.mod_id,
    engrams.path,
    engrams.class_string,
    engrams.availability,
    engrams.tags
   FROM ark.engrams
UNION
 SELECT loot_sources.object_id,
    loot_sources.label,
    loot_sources.alternate_label,
    loot_sources.tableoid,
    loot_sources.min_version,
    loot_sources.last_update,
    loot_sources.mod_id,
    loot_sources.path,
    loot_sources.class_string,
    loot_sources.availability,
    loot_sources.tags
   FROM ark.loot_sources
UNION
 SELECT spawn_points.object_id,
    spawn_points.label,
    spawn_points.alternate_label,
    spawn_points.tableoid,
    spawn_points.min_version,
    spawn_points.last_update,
    spawn_points.mod_id,
    spawn_points.path,
    spawn_points.class_string,
    spawn_points.availability,
    spawn_points.tags
   FROM ark.spawn_points;


ALTER TABLE ark.blueprints OWNER TO thommcgrath;

--
-- Name: color_sets; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.color_sets (
    color_set_id uuid NOT NULL,
    label public.citext NOT NULL,
    class_string public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE ark.color_sets OWNER TO thommcgrath;

--
-- Name: colors; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.colors (
    color_id integer NOT NULL,
    color_name public.citext NOT NULL,
    color_code public.hex NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE ark.colors OWNER TO thommcgrath;

--
-- Name: crafting_costs; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.crafting_costs (
    engram_id uuid NOT NULL,
    ingredient_id uuid NOT NULL,
    quantity integer NOT NULL,
    exact boolean NOT NULL,
    CONSTRAINT crafting_costs_check CHECK ((engram_id IS DISTINCT FROM ingredient_id)),
    CONSTRAINT crafting_costs_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE ark.crafting_costs OWNER TO thommcgrath;

--
-- Name: creature_engrams; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.creature_engrams (
    relation_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    creature_id uuid NOT NULL,
    engram_id uuid NOT NULL
);


ALTER TABLE ark.creature_engrams OWNER TO thommcgrath;

--
-- Name: creature_stats; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.creature_stats (
    creature_id uuid NOT NULL,
    stat_index integer NOT NULL,
    base_value numeric(16,6) NOT NULL,
    per_level_wild_multiplier numeric(16,6) NOT NULL,
    per_level_tamed_multiplier numeric(16,6) NOT NULL,
    add_multiplier numeric(16,6) NOT NULL,
    affinity_multiplier numeric(16,6) NOT NULL,
    CONSTRAINT creature_stats_stat_index_check CHECK (((stat_index >= 0) AND (stat_index <= 11)))
);


ALTER TABLE ark.creature_stats OWNER TO thommcgrath;

--
-- Name: deletions; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.deletions (
    object_id uuid NOT NULL,
    from_table public.citext NOT NULL,
    label public.citext NOT NULL,
    min_version integer NOT NULL,
    action_time timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    tag text
);


ALTER TABLE ark.deletions OWNER TO thommcgrath;

--
-- Name: diet_contents; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.diet_contents (
    diet_entry_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    diet_id uuid NOT NULL,
    engram_id uuid NOT NULL,
    preference_order integer NOT NULL
);


ALTER TABLE ark.diet_contents OWNER TO thommcgrath;

--
-- Name: diets; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.diets (
)
INHERITS (ark.objects);


ALTER TABLE ark.diets OWNER TO thommcgrath;

--
-- Name: event_colors; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.event_colors (
    event_id uuid NOT NULL,
    color_id integer NOT NULL
);


ALTER TABLE ark.event_colors OWNER TO thommcgrath;

--
-- Name: event_engrams; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.event_engrams (
    event_id uuid NOT NULL,
    object_id uuid NOT NULL
);


ALTER TABLE ark.event_engrams OWNER TO thommcgrath;

--
-- Name: event_rates; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.event_rates (
    event_id uuid NOT NULL,
    ini_option uuid NOT NULL,
    multiplier numeric(8,4) NOT NULL
);


ALTER TABLE ark.event_rates OWNER TO thommcgrath;

--
-- Name: events; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.events (
    event_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    event_name public.citext NOT NULL,
    event_code public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE ark.events OWNER TO thommcgrath;

--
-- Name: game_variables; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.game_variables (
    key text NOT NULL,
    value text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ark.game_variables OWNER TO thommcgrath;

--
-- Name: ini_options; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.ini_options (
    native_editor_version integer,
    file public.ini_file NOT NULL,
    header public.citext NOT NULL,
    key public.citext NOT NULL,
    value_type public.ini_value_type NOT NULL,
    max_allowed integer,
    description text NOT NULL,
    default_value text NOT NULL,
    nitrado_path public.citext,
    nitrado_format public.nitrado_format,
    nitrado_deploy_style public.nitrado_deploy_style,
    ui_group public.citext,
    constraints jsonb,
    custom_sort public.citext,
    gsa_placeholder public.citext,
    CONSTRAINT ini_options_check CHECK ((((nitrado_path IS NULL) AND (nitrado_format IS NULL) AND (nitrado_deploy_style IS NULL)) OR ((nitrado_path IS NOT NULL) AND (nitrado_format IS NOT NULL) AND (nitrado_deploy_style IS NOT NULL)))),
    CONSTRAINT ini_options_check1 CHECK (((file IS DISTINCT FROM 'CommandLineFlag'::public.ini_file) OR ((file = 'CommandLineFlag'::public.ini_file) AND (value_type = 'Boolean'::public.ini_value_type)))),
    CONSTRAINT ini_options_max_allowed_check CHECK (((max_allowed IS NULL) OR (max_allowed >= 1)))
)
INHERITS (ark.objects);


ALTER TABLE ark.ini_options OWNER TO thommcgrath;

--
-- Name: loot_item_set_entries; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.loot_item_set_entries (
    loot_item_set_entry_id uuid NOT NULL,
    loot_item_set_id uuid NOT NULL,
    min_quantity integer NOT NULL,
    max_quantity integer NOT NULL,
    min_quality ark.loot_quality_tier NOT NULL,
    max_quality ark.loot_quality_tier NOT NULL,
    blueprint_chance numeric(16,6) NOT NULL,
    weight numeric(16,6) NOT NULL,
    single_item_quantity boolean NOT NULL,
    prevent_grinding boolean NOT NULL,
    stat_clamp_multiplier numeric(16,6) NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE ark.loot_item_set_entries OWNER TO thommcgrath;

--
-- Name: loot_item_set_entry_options; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.loot_item_set_entry_options (
    loot_item_set_entry_option_id uuid NOT NULL,
    loot_item_set_entry_id uuid NOT NULL,
    engram_id uuid NOT NULL,
    weight numeric(16,6) NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE ark.loot_item_set_entry_options OWNER TO thommcgrath;

--
-- Name: loot_item_sets; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.loot_item_sets (
    loot_item_set_id uuid NOT NULL,
    loot_source_id uuid NOT NULL,
    label public.citext NOT NULL,
    min_entries integer NOT NULL,
    max_entries integer NOT NULL,
    weight numeric(16,6) NOT NULL,
    prevent_duplicates boolean NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE ark.loot_item_sets OWNER TO thommcgrath;

--
-- Name: loot_source_icons; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.loot_source_icons (
    icon_data bytea NOT NULL
)
INHERITS (ark.objects);


ALTER TABLE ark.loot_source_icons OWNER TO thommcgrath;

--
-- Name: maps; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.maps (
    map_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    mod_id uuid NOT NULL,
    label public.citext NOT NULL,
    ark_identifier text NOT NULL,
    difficulty_scale numeric(8,4) NOT NULL,
    official boolean NOT NULL,
    mask bigint NOT NULL,
    sort integer NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    engram_groups text[] NOT NULL,
    CONSTRAINT maps_mask_check CHECK ((ceiling(log((2)::numeric, (mask)::numeric)) = floor(log((2)::numeric, (mask)::numeric))))
);


ALTER TABLE ark.maps OWNER TO thommcgrath;

--
-- Name: mod_relationships; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.mod_relationships (
    relation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_mod_id uuid NOT NULL,
    second_mod_id uuid NOT NULL
);


ALTER TABLE ark.mod_relationships OWNER TO thommcgrath;

--
-- Name: mods; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.mods (
    mod_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    workshop_id bigint NOT NULL,
    user_id uuid NOT NULL,
    name text DEFAULT 'Unknown Mod'::text NOT NULL,
    confirmed boolean DEFAULT false NOT NULL,
    confirmation_code uuid DEFAULT public.gen_random_uuid() NOT NULL,
    pull_url text,
    last_pull_hash text,
    console_safe boolean DEFAULT false NOT NULL,
    default_enabled boolean DEFAULT false NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    min_version integer NOT NULL,
    include_in_deltas boolean DEFAULT false NOT NULL,
    tag text,
    prefix text,
    map_folder text,
    is_official boolean DEFAULT false NOT NULL,
    CONSTRAINT mods_check CHECK (((is_official = true) OR ((tag IS NOT NULL) AND (prefix IS NOT NULL)) OR ((tag IS NULL) AND (prefix IS NULL))))
);


ALTER TABLE ark.mods OWNER TO thommcgrath;

--
-- Name: preset_modifiers; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.preset_modifiers (
    pattern text NOT NULL,
    language public.citext NOT NULL,
    CONSTRAINT preset_modifiers_check CHECK (((min_version >= 10600000) OR (language OPERATOR(public.=) 'regex'::public.citext)))
)
INHERITS (ark.objects);


ALTER TABLE ark.preset_modifiers OWNER TO thommcgrath;

--
-- Name: presets; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.presets (
    contents jsonb NOT NULL
)
INHERITS (ark.objects);


ALTER TABLE ark.presets OWNER TO thommcgrath;

--
-- Name: spawn_point_limits; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_limits (
    spawn_point_id uuid NOT NULL,
    creature_id uuid NOT NULL,
    max_percentage numeric(5,4)
);


ALTER TABLE ark.spawn_point_limits OWNER TO thommcgrath;

--
-- Name: spawn_point_populations; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_populations (
    population_id uuid NOT NULL,
    spawn_point_id uuid NOT NULL,
    map_id uuid NOT NULL,
    instances_on_map integer NOT NULL,
    max_population integer NOT NULL
);


ALTER TABLE ark.spawn_point_populations OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entries; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_set_entries (
    spawn_point_set_entry_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_id uuid NOT NULL,
    creature_id uuid NOT NULL,
    weight numeric(16,6),
    override numeric(16,6),
    min_level_multiplier numeric(16,6),
    max_level_multiplier numeric(16,6),
    min_level_offset numeric(16,6),
    max_level_offset numeric(16,6),
    spawn_offset public.point3d
);


ALTER TABLE ark.spawn_point_set_entries OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entry_levels; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_set_entry_levels (
    spawn_point_set_entry_level_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_entry_id uuid NOT NULL,
    difficulty numeric(16,6) NOT NULL,
    min_level numeric(16,6) NOT NULL,
    max_level numeric(16,6) NOT NULL
);


ALTER TABLE ark.spawn_point_set_entry_levels OWNER TO thommcgrath;

--
-- Name: spawn_point_set_replacements; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_set_replacements (
    spawn_point_set_replacement_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_id uuid NOT NULL,
    target_creature_id uuid NOT NULL,
    replacement_creature_id uuid NOT NULL,
    weight numeric(16,6) NOT NULL
);


ALTER TABLE ark.spawn_point_set_replacements OWNER TO thommcgrath;

--
-- Name: spawn_point_sets; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.spawn_point_sets (
    spawn_point_set_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_id uuid NOT NULL,
    label public.citext NOT NULL,
    weight numeric(16,6) NOT NULL,
    spawn_offset public.point3d,
    min_distance_from_players_multiplier numeric(16,6),
    min_distance_from_structures_multiplier numeric(16,6),
    min_distance_from_tamed_dinos_multiplier numeric(16,6),
    spread_radius numeric(16,6),
    water_only_minimum_height numeric(16,6),
    offset_before_multiplier boolean
);


ALTER TABLE ark.spawn_point_sets OWNER TO thommcgrath;

--
-- Name: guest_projects; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.guest_projects (
    project_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.guest_projects OWNER TO thommcgrath;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.projects (
    project_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    user_id uuid NOT NULL,
    title public.citext NOT NULL,
    description public.citext NOT NULL,
    console_safe boolean NOT NULL,
    last_update timestamp with time zone NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    download_count integer DEFAULT 0 NOT NULL,
    published public.publish_status DEFAULT 'Private'::public.publish_status NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    game_specific jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.projects OWNER TO thommcgrath;

--
-- Name: allowed_projects; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.allowed_projects AS
 SELECT projects.project_id,
    projects.game_id,
    projects.user_id,
    projects.user_id AS owner_id,
    projects.title,
    projects.description,
    projects.console_safe,
    projects.last_update,
    projects.revision,
    projects.download_count,
    projects.published,
    projects.game_specific,
    'Owner'::text AS role
   FROM public.projects
  WHERE (projects.deleted = false)
UNION
 SELECT projects.project_id,
    projects.game_id,
    guest_projects.user_id,
    projects.user_id AS owner_id,
    projects.title,
    projects.description,
    projects.console_safe,
    projects.last_update,
    projects.revision,
    projects.download_count,
    projects.published,
    projects.game_specific,
    'Guest'::text AS role
   FROM (public.guest_projects
     JOIN public.projects ON ((guest_projects.project_id = projects.project_id)))
  WHERE (projects.deleted = false);


ALTER TABLE public.allowed_projects OWNER TO thommcgrath;

--
-- Name: blog_articles; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.blog_articles (
    article_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    article_slug character varying(32) NOT NULL,
    subject public.citext NOT NULL,
    content_markdown public.citext NOT NULL,
    preview public.citext NOT NULL,
    article_hash public.hex NOT NULL,
    publish_date timestamp with time zone,
    last_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.blog_articles OWNER TO thommcgrath;

--
-- Name: client_notices; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.client_notices (
    notice_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    message text NOT NULL,
    secondary_message text NOT NULL,
    action_url text NOT NULL,
    min_version integer,
    max_version integer,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    publish_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.client_notices OWNER TO thommcgrath;

--
-- Name: corrupt_files; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.corrupt_files (
    file_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    contents bytea NOT NULL
);


ALTER TABLE public.corrupt_files OWNER TO thommcgrath;

--
-- Name: deletions; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.deletions AS
 SELECT deletions.object_id,
    'Ark'::text AS game_id,
    deletions.from_table,
    deletions.label,
    GREATEST(deletions.min_version, 10600000) AS min_version,
    deletions.action_time,
    deletions.tag
   FROM ark.deletions;


ALTER TABLE public.deletions OWNER TO thommcgrath;

--
-- Name: download_signatures; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.download_signatures (
    signature_id uuid NOT NULL,
    download_id uuid NOT NULL,
    format public.download_signature_format NOT NULL,
    signature text NOT NULL
);


ALTER TABLE public.download_signatures OWNER TO thommcgrath;

--
-- Name: download_urls; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.download_urls (
    download_id uuid NOT NULL,
    update_id uuid NOT NULL,
    url text NOT NULL,
    platform public.download_platform NOT NULL,
    architectures integer NOT NULL
);


ALTER TABLE public.download_urls OWNER TO thommcgrath;

--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.email_addresses (
    email_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    address text NOT NULL,
    group_key public.hex NOT NULL,
    group_key_precision integer NOT NULL,
    group_key_alg public.citext NOT NULL
);


ALTER TABLE public.email_addresses OWNER TO thommcgrath;

--
-- Name: email_verification; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.email_verification (
    email_id uuid NOT NULL,
    code public.hex NOT NULL,
    verified boolean DEFAULT false NOT NULL
);


ALTER TABLE public.email_verification OWNER TO thommcgrath;

--
-- Name: exception_comments; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.exception_comments (
    comment_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    exception_id uuid NOT NULL,
    comments text NOT NULL,
    user_id uuid,
    date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.exception_comments OWNER TO thommcgrath;

--
-- Name: exception_signatures; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.exception_signatures (
    client_hash public.hex NOT NULL,
    client_build integer NOT NULL,
    exception_id uuid NOT NULL,
    trace text NOT NULL
);


ALTER TABLE public.exception_signatures OWNER TO thommcgrath;

--
-- Name: exception_users; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.exception_users (
    exception_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.exception_users OWNER TO thommcgrath;

--
-- Name: exceptions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.exceptions (
    exception_id uuid NOT NULL,
    min_reported_build integer NOT NULL,
    max_reported_build integer NOT NULL,
    location text NOT NULL,
    exception_class text NOT NULL,
    reason text NOT NULL,
    trace text NOT NULL,
    solution_build integer,
    solution_comments text,
    CONSTRAINT exceptions_check1 CHECK (((solution_build IS NULL) OR (solution_build > max_reported_build)))
);


ALTER TABLE public.exceptions OWNER TO thommcgrath;

--
-- Name: gift_code_log; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.gift_code_log (
    log_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    code public.citext NOT NULL,
    user_id uuid NOT NULL,
    attempt_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    source_ip inet NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.gift_code_log OWNER TO thommcgrath;

--
-- Name: gift_codes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.gift_codes (
    code public.citext NOT NULL,
    source_purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    redemption_date timestamp with time zone,
    redemption_purchase_id uuid,
    CONSTRAINT gift_codes_check CHECK ((((redemption_date IS NULL) AND (redemption_purchase_id IS NULL)) OR ((redemption_date IS NOT NULL) AND (redemption_purchase_id IS NOT NULL))))
);


ALTER TABLE public.gift_codes OWNER TO thommcgrath;

--
-- Name: help_topics; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.help_topics (
    config_name public.citext NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    detail_url text DEFAULT ''::text NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL
);


ALTER TABLE public.help_topics OWNER TO thommcgrath;

--
-- Name: imported_obelisk_files; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.imported_obelisk_files (
    path text NOT NULL,
    version text NOT NULL,
    last_import_date timestamp with time zone NOT NULL
);


ALTER TABLE public.imported_obelisk_files OWNER TO thommcgrath;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.licenses (
    license_id uuid DEFAULT gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    expiration timestamp with time zone
);


ALTER TABLE public.licenses OWNER TO thommcgrath;

--
-- Name: updates; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.updates (
    update_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    build_number integer NOT NULL,
    build_display text NOT NULL,
    notes text NOT NULL,
    preview text DEFAULT ''::text NOT NULL,
    stage integer DEFAULT 0 NOT NULL,
    min_mac_version public.os_version NOT NULL,
    min_win_version public.os_version NOT NULL,
    delta_version integer NOT NULL,
    published timestamp with time zone,
    urgency public.update_urgency DEFAULT 'Normal'::public.update_urgency NOT NULL,
    lock_versions int4range,
    CONSTRAINT updates_check CHECK (((published IS NOT NULL) OR (build_number < 10500000)))
);


ALTER TABLE public.updates OWNER TO thommcgrath;

--
-- Name: news; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.news AS
 SELECT client_notices.notice_id AS uuid,
    client_notices.message AS title,
    client_notices.secondary_message AS detail,
    client_notices.action_url AS url,
    client_notices.min_version,
    client_notices.max_version,
    client_notices.publish_date AS moment,
    NULL::text AS mac_os_version,
    NULL::text AS win_os_version,
    3 AS stage
   FROM public.client_notices
UNION
 SELECT blog_articles.article_id AS uuid,
    blog_articles.subject AS title,
    blog_articles.preview AS detail,
    ('/blog/'::text || (blog_articles.article_slug)::text) AS url,
    NULL::integer AS min_version,
    NULL::integer AS max_version,
    GREATEST(blog_articles.last_updated, blog_articles.publish_date) AS moment,
    NULL::text AS mac_os_version,
    NULL::text AS win_os_version,
    3 AS stage
   FROM public.blog_articles
  WHERE (blog_articles.publish_date < CURRENT_TIMESTAMP)
UNION
 SELECT updates.update_id AS uuid,
    (('Beacon '::text || updates.build_display) || ' Now Available'::text) AS title,
    updates.preview AS detail,
    (((('/history'::text || '?stage='::text) || (updates.stage)::text) || '#build'::text) || (updates.build_number)::text) AS url,
    NULL::integer AS min_version,
    NULL::integer AS max_version,
    updates.published AS moment,
    updates.min_mac_version AS mac_os_version,
    updates.min_win_version AS win_os_version,
    updates.stage
   FROM public.updates
  WHERE (updates.published IS NOT NULL);


ALTER TABLE public.news OWNER TO thommcgrath;

--
-- Name: oauth_requests; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.oauth_requests (
    request_id uuid NOT NULL,
    encrypted_payload text NOT NULL,
    encrypted_symmetric_key text NOT NULL,
    expiration timestamp with time zone NOT NULL
);


ALTER TABLE public.oauth_requests OWNER TO thommcgrath;

--
-- Name: oauth_tokens; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.oauth_tokens (
    access_token text NOT NULL,
    user_id uuid NOT NULL,
    valid_until timestamp with time zone,
    refresh_token text NOT NULL
);


ALTER TABLE public.oauth_tokens OWNER TO thommcgrath;

--
-- Name: product_prices; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.product_prices (
    price_id text NOT NULL,
    product_id uuid NOT NULL,
    currency public.citext NOT NULL,
    price numeric(6,2) NOT NULL,
    CONSTRAINT product_prices_currency_check CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.product_prices OWNER TO thommcgrath;

--
-- Name: products; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.products (
    product_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    product_name text NOT NULL,
    retail_price numeric(6,2) NOT NULL,
    stripe_sku text NOT NULL,
    child_seat_count integer DEFAULT 0 NOT NULL,
    updates_length interval,
    flags integer
);


ALTER TABLE public.products OWNER TO thommcgrath;

--
-- Name: purchase_codes_archive; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_codes_archive (
    code public.citext NOT NULL,
    source text,
    creation_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    redemption_date timestamp with time zone,
    redemption_purchase_id uuid,
    purchaser_email_id uuid NOT NULL
);


ALTER TABLE public.purchase_codes_archive OWNER TO thommcgrath;

--
-- Name: purchase_items; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_items (
    line_id uuid DEFAULT gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    currency public.citext NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(6,2) NOT NULL,
    subtotal numeric(6,2) NOT NULL,
    discount numeric(6,2) NOT NULL,
    tax numeric(6,2) NOT NULL,
    line_total numeric(6,2) NOT NULL,
    CONSTRAINT purchase_items_check CHECK ((subtotal = (unit_price * (quantity)::numeric))),
    CONSTRAINT purchase_items_check1 CHECK ((line_total = ((subtotal + tax) - discount))),
    CONSTRAINT purchase_items_currency_check1 CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.purchase_items OWNER TO thommcgrath;

--
-- Name: purchase_items_old; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_items_old (
    line_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    retail_price numeric(6,2) NOT NULL,
    discount numeric(6,2) NOT NULL,
    quantity numeric(6,0) NOT NULL,
    line_total numeric(6,2) NOT NULL,
    currency public.citext NOT NULL,
    CONSTRAINT purchase_items_currency_check CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.purchase_items_old OWNER TO thommcgrath;

--
-- Name: purchases; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchases (
    purchase_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    purchaser_email uuid NOT NULL,
    purchase_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    subtotal numeric(6,2) NOT NULL,
    discount numeric(6,2) NOT NULL,
    tax numeric(6,2) NOT NULL,
    total_paid numeric(6,2) NOT NULL,
    merchant_reference public.citext NOT NULL,
    client_reference_id text,
    refunded boolean DEFAULT false NOT NULL,
    tax_locality text,
    currency public.citext NOT NULL,
    issued boolean DEFAULT false NOT NULL,
    notes text,
    CONSTRAINT purchases_currency_check CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.purchases OWNER TO thommcgrath;

--
-- Name: purchased_products; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.purchased_products AS
 SELECT DISTINCT ON (p.purchaser_email, p.product_id) p.product_id,
    p.product_name,
    p.purchase_id,
    p.purchase_date,
    p.purchaser_email,
    p.client_reference_id,
    licenses.expiration,
    p.flags
   FROM (( SELECT purchases.purchase_id,
            purchases.purchaser_email,
            purchases.purchase_date,
            purchases.client_reference_id,
            products.product_id,
            products.product_name,
            products.flags
           FROM ((public.purchases
             JOIN public.purchase_items ON ((purchases.purchase_id = purchase_items.purchase_id)))
             JOIN public.products ON ((purchase_items.product_id = products.product_id)))
          WHERE (purchases.refunded = false)) p
     JOIN public.licenses ON ((p.purchase_id = licenses.purchase_id)))
  ORDER BY p.purchaser_email, p.product_id, p.purchase_date DESC;


ALTER TABLE public.purchased_products OWNER TO thommcgrath;

--
-- Name: VIEW purchased_products; Type: COMMENT; Schema: public; Owner: thommcgrath
--

COMMENT ON VIEW public.purchased_products IS 'This view combies the most useful parts of the purchases, licenses, and products table to give convenient access to a user''s most recent license info.';


--
-- Name: support_articles; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_articles (
    article_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    article_slug character varying(32) NOT NULL,
    subject public.citext NOT NULL,
    content_markdown public.citext,
    preview public.citext NOT NULL,
    published boolean DEFAULT false NOT NULL,
    forward_url text,
    affected_ini_keys public.citext[] DEFAULT '{}'::public.citext[] NOT NULL,
    group_id uuid,
    sort_order integer DEFAULT 0 NOT NULL,
    min_version integer DEFAULT 0 NOT NULL,
    max_version integer DEFAULT 99999999 NOT NULL,
    article_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT support_articles_check CHECK (((content_markdown IS NOT NULL) OR (forward_url IS NOT NULL)))
);


ALTER TABLE public.support_articles OWNER TO thommcgrath;

--
-- Name: support_videos; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_videos (
    video_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    video_slug character varying(32) NOT NULL,
    video_title public.citext NOT NULL,
    host public.video_host NOT NULL,
    host_video_id text NOT NULL
);


ALTER TABLE public.support_videos OWNER TO thommcgrath;

--
-- Name: search_contents; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.search_contents AS
 SELECT support_articles.article_id AS id,
    support_articles.subject AS title,
    COALESCE(support_articles.content_markdown, ''::public.citext) AS body,
    COALESCE(support_articles.preview, ''::public.citext) AS preview,
    COALESCE((support_articles.affected_ini_keys)::public.citext, ''::public.citext) AS meta_content,
    'Help'::text AS type,
    ''::text AS subtype,
    COALESCE(support_articles.forward_url, ('/help/'::text || (support_articles.article_slug)::text)) AS uri,
    support_articles.min_version,
    support_articles.max_version,
    NULL::uuid AS mod_id
   FROM public.support_articles
  WHERE (support_articles.published = true)
UNION
 SELECT support_videos.video_id AS id,
    support_videos.video_title AS title,
    ''::text AS body,
    ''::text AS preview,
    ''::text AS meta_content,
    'Video'::text AS type,
    ''::text AS subtype,
    ('/videos/'::text || (support_videos.video_slug)::text) AS uri,
    0 AS min_version,
    99999999 AS max_version,
    NULL::uuid AS mod_id
   FROM public.support_videos
UNION
 SELECT blueprints.object_id AS id,
    blueprints.label AS title,
    ''::text AS body,
    ''::text AS preview,
    blueprints.class_string AS meta_content,
    'Object'::text AS type,
    (( SELECT pg_class.relname
           FROM pg_class
          WHERE (pg_class.oid = blueprints.tableoid)))::text AS subtype,
    ('/object/'::text || (blueprints.object_id)::text) AS uri,
    blueprints.min_version,
    99999999 AS max_version,
    blueprints.mod_id
   FROM ark.blueprints
UNION
 SELECT mods.mod_id AS id,
    mods.name AS title,
    ''::text AS body,
    ''::text AS preview,
    ''::text AS meta_content,
    'Mod'::text AS type,
    ''::text AS subtype,
    ('/mods/'::text || mods.mod_id) AS uri,
    0 AS min_version,
    99999999 AS max_version,
    mods.mod_id
   FROM ark.mods
  WHERE (mods.confirmed = true)
UNION
 SELECT projects.project_id AS id,
    projects.title,
    projects.description AS body,
    ''::text AS preview,
    ''::text AS meta_content,
    'Document'::text AS type,
    (projects.game_id)::text AS subtype,
    ('/browse/'::text || projects.project_id) AS uri,
    0 AS min_version,
    99999999 AS max_version,
    NULL::uuid AS mod_id
   FROM public.projects
  WHERE ((projects.published = 'Approved'::public.publish_status) AND (projects.deleted = false));


ALTER TABLE public.search_contents OWNER TO thommcgrath;

--
-- Name: search_sync; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.search_sync (
    object_id uuid NOT NULL,
    table_name public.citext NOT NULL,
    action public.citext NOT NULL,
    moment timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.search_sync OWNER TO thommcgrath;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.sessions (
    session_id public.citext NOT NULL,
    user_id uuid NOT NULL,
    valid_until timestamp with time zone,
    remote_ip inet,
    remote_country text,
    remote_agent text,
    CONSTRAINT sessions_check CHECK ((((remote_ip IS NULL) AND (remote_country IS NULL) AND (remote_agent IS NULL)) OR ((remote_ip IS NOT NULL) AND (remote_country IS NOT NULL) AND (remote_agent IS NOT NULL))))
);


ALTER TABLE public.sessions OWNER TO thommcgrath;

--
-- Name: stw_applicants; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.stw_applicants (
    applicant_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    encrypted_email text,
    email_id uuid NOT NULL,
    generated_purchase_id uuid,
    date_applied timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    desired_product uuid NOT NULL,
    CONSTRAINT stw_applicants_check CHECK ((((encrypted_email IS NOT NULL) AND (generated_purchase_id IS NULL)) OR ((encrypted_email IS NULL) AND (generated_purchase_id IS NOT NULL))))
);


ALTER TABLE public.stw_applicants OWNER TO thommcgrath;

--
-- Name: stw_purchases; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.stw_purchases (
    stw_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    original_purchase_id uuid NOT NULL,
    generated_purchase_id uuid
);


ALTER TABLE public.stw_purchases OWNER TO thommcgrath;

--
-- Name: support_article_groups; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_article_groups (
    group_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    group_name public.citext NOT NULL,
    sort_order integer
);


ALTER TABLE public.support_article_groups OWNER TO thommcgrath;

--
-- Name: support_article_modules; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_article_modules (
    module_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    module_name public.citext NOT NULL,
    module_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    module_markdown text NOT NULL
);


ALTER TABLE public.support_article_modules OWNER TO thommcgrath;

--
-- Name: support_images; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_images (
    image_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    hint text,
    width_points numeric(4,0) NOT NULL,
    height_points numeric(4,0) NOT NULL,
    min_scale integer DEFAULT 1 NOT NULL,
    max_scale integer DEFAULT 1 NOT NULL,
    extension text DEFAULT '.png'::text NOT NULL
);


ALTER TABLE public.support_images OWNER TO thommcgrath;

--
-- Name: support_table_of_contents; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_table_of_contents (
    record_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    article_id uuid NOT NULL,
    group_id uuid NOT NULL,
    sort_order integer
);


ALTER TABLE public.support_table_of_contents OWNER TO thommcgrath;

--
-- Name: template_selectors; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.template_selectors AS
 SELECT preset_modifiers.object_id,
    preset_modifiers.label,
    GREATEST(preset_modifiers.min_version, 10600000) AS min_version,
    preset_modifiers.last_update,
    'Ark'::text AS game_id,
    preset_modifiers.language,
    preset_modifiers.pattern AS code
   FROM ark.preset_modifiers;


ALTER TABLE public.template_selectors OWNER TO thommcgrath;

--
-- Name: templates; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.templates AS
 SELECT presets.object_id,
    presets.label,
    GREATEST(presets.min_version, 10600000) AS min_version,
    presets.last_update,
    'Ark'::text AS game_id,
    presets.contents
   FROM ark.presets;


ALTER TABLE public.templates OWNER TO thommcgrath;

--
-- Name: update_files; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.update_files (
    file_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    version integer NOT NULL,
    type public.update_file_type NOT NULL,
    path text NOT NULL,
    created timestamp with time zone NOT NULL,
    size bigint NOT NULL
);


ALTER TABLE public.update_files OWNER TO thommcgrath;

--
-- Name: user_challenges; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.user_challenges (
    user_id uuid NOT NULL,
    challenge text NOT NULL
);


ALTER TABLE public.user_challenges OWNER TO thommcgrath;

--
-- Name: usercloud; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.usercloud (
    remote_path text NOT NULL,
    content_type public.citext DEFAULT 'application/octet-stream'::public.citext NOT NULL,
    size_in_bytes bigint NOT NULL,
    hash public.hex NOT NULL,
    modified timestamp with time zone NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    header public.hex
);


ALTER TABLE public.usercloud OWNER TO thommcgrath;

--
-- Name: usercloud_cache; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.usercloud_cache (
    cache_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    remote_path text NOT NULL,
    hostname public.citext NOT NULL,
    size_in_bytes bigint NOT NULL,
    last_accessed timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    hash public.hex NOT NULL
);


ALTER TABLE public.usercloud_cache OWNER TO thommcgrath;

--
-- Name: usercloud_queue; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.usercloud_queue (
    remote_path text NOT NULL,
    hostname public.citext NOT NULL,
    request_method public.citext NOT NULL,
    queue_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    http_status integer,
    attempts integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.usercloud_queue OWNER TO thommcgrath;

--
-- Name: users; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.users (
    user_id uuid NOT NULL,
    public_key text NOT NULL,
    private_key public.hex,
    private_key_salt public.hex,
    private_key_iterations integer,
    email_id uuid,
    username public.citext,
    usercloud_key public.hex,
    banned boolean DEFAULT false NOT NULL,
    parent_account_id uuid,
    enabled boolean DEFAULT true NOT NULL,
    require_password_change boolean DEFAULT false NOT NULL,
    CONSTRAINT users_check CHECK ((((email_id IS NULL) AND (username IS NULL) AND (private_key_iterations IS NULL) AND (private_key_salt IS NULL) AND (private_key IS NULL)) OR ((email_id IS NOT NULL) AND (username IS NOT NULL) AND (private_key_iterations IS NOT NULL) AND (private_key_salt IS NOT NULL) AND (private_key IS NOT NULL))))
);


ALTER TABLE public.users OWNER TO thommcgrath;

--
-- Name: wordlist; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.wordlist (
    word public.citext NOT NULL,
    isadjective boolean DEFAULT false NOT NULL,
    isnoun boolean DEFAULT false NOT NULL,
    issuffix boolean DEFAULT false NOT NULL
);


ALTER TABLE public.wordlist OWNER TO thommcgrath;

--
-- Name: creatures object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: creatures min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: creatures last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: creatures mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: creatures tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: diets object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: diets min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: diets last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: diets mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: diets tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: engrams object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: engrams min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: engrams last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: engrams mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: engrams tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: ini_options object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: ini_options min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: ini_options last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: ini_options mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: ini_options tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_source_icons object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: loot_source_icons min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: loot_source_icons last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_source_icons mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: loot_source_icons tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_sources object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: loot_sources min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: loot_sources last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_sources mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: loot_sources tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: preset_modifiers object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: preset_modifiers min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: preset_modifiers last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: preset_modifiers mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: preset_modifiers tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: presets object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: presets min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: presets last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: presets mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: presets tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: spawn_points object_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: spawn_points min_version; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: spawn_points last_update; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: spawn_points mod_id; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: spawn_points tags; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: color_sets color_sets_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.color_sets
    ADD CONSTRAINT color_sets_pkey PRIMARY KEY (color_set_id);


--
-- Name: colors colors_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (color_id);


--
-- Name: crafting_costs crafting_costs_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.crafting_costs
    ADD CONSTRAINT crafting_costs_pkey PRIMARY KEY (engram_id, ingredient_id);


--
-- Name: creature_engrams creature_engrams_creature_id_engram_id_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_engram_id_key UNIQUE (creature_id, engram_id);


--
-- Name: creature_engrams creature_engrams_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_engrams
    ADD CONSTRAINT creature_engrams_pkey PRIMARY KEY (relation_id);


--
-- Name: creature_stats creature_stats_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_stats
    ADD CONSTRAINT creature_stats_pkey PRIMARY KEY (creature_id, stat_index);


--
-- Name: creatures creatures_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures
    ADD CONSTRAINT creatures_pkey PRIMARY KEY (object_id);


--
-- Name: deletions deletions_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.deletions
    ADD CONSTRAINT deletions_pkey PRIMARY KEY (object_id, from_table);


--
-- Name: diet_contents diet_contents_diet_id_engram_id_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_engram_id_key UNIQUE (diet_id, engram_id);


--
-- Name: diet_contents diet_contents_diet_id_preference_order_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_preference_order_key UNIQUE (diet_id, preference_order);


--
-- Name: diet_contents diet_contents_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diet_contents
    ADD CONSTRAINT diet_contents_pkey PRIMARY KEY (diet_entry_id);


--
-- Name: diets diets_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets
    ADD CONSTRAINT diets_pkey PRIMARY KEY (object_id);


--
-- Name: engrams engrams_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams
    ADD CONSTRAINT engrams_pkey PRIMARY KEY (object_id);


--
-- Name: event_colors event_colors_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_colors
    ADD CONSTRAINT event_colors_pkey PRIMARY KEY (event_id, color_id);


--
-- Name: event_rates event_rates_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_rates
    ADD CONSTRAINT event_rates_pkey PRIMARY KEY (event_id, ini_option);


--
-- Name: events events_event_code_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.events
    ADD CONSTRAINT events_event_code_key UNIQUE (event_code);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: game_variables game_variables_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.game_variables
    ADD CONSTRAINT game_variables_pkey PRIMARY KEY (key);


--
-- Name: ini_options ini_options_file_header_key_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options
    ADD CONSTRAINT ini_options_file_header_key_key UNIQUE (file, header, key);


--
-- Name: ini_options ini_options_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options
    ADD CONSTRAINT ini_options_pkey PRIMARY KEY (object_id);


--
-- Name: loot_item_set_entries loot_item_set_entries_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_pkey PRIMARY KEY (loot_item_set_entry_id);


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_pkey PRIMARY KEY (loot_item_set_entry_option_id);


--
-- Name: loot_item_sets loot_item_sets_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_sets
    ADD CONSTRAINT loot_item_sets_pkey PRIMARY KEY (loot_item_set_id);


--
-- Name: loot_source_icons loot_source_icons_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons
    ADD CONSTRAINT loot_source_icons_pkey PRIMARY KEY (object_id);


--
-- Name: loot_sources loot_sources_pkey1; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources
    ADD CONSTRAINT loot_sources_pkey1 PRIMARY KEY (object_id);


--
-- Name: maps maps_ark_identifier_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_ark_identifier_key UNIQUE (ark_identifier);


--
-- Name: maps maps_mask_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_mask_key UNIQUE (mask);


--
-- Name: maps maps_mod_id_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_mod_id_key UNIQUE (mod_id);


--
-- Name: maps maps_official_sort_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_official_sort_key UNIQUE (official, sort);


--
-- Name: maps maps_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (map_id);


--
-- Name: mod_relationships mod_relationships_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mod_relationships
    ADD CONSTRAINT mod_relationships_pkey PRIMARY KEY (relation_id);


--
-- Name: mods mods_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods
    ADD CONSTRAINT mods_pkey PRIMARY KEY (mod_id);


--
-- Name: mods mods_prefix_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods
    ADD CONSTRAINT mods_prefix_key UNIQUE (prefix);


--
-- Name: mods mods_tag_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods
    ADD CONSTRAINT mods_tag_key UNIQUE (tag);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (object_id);


--
-- Name: preset_modifiers preset_modifiers_pattern_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers
    ADD CONSTRAINT preset_modifiers_pattern_key UNIQUE (pattern);


--
-- Name: preset_modifiers preset_modifiers_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers
    ADD CONSTRAINT preset_modifiers_pkey PRIMARY KEY (object_id);


--
-- Name: presets presets_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets
    ADD CONSTRAINT presets_pkey PRIMARY KEY (object_id);


--
-- Name: spawn_point_limits spawn_point_limits_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_pkey PRIMARY KEY (spawn_point_id, creature_id);


--
-- Name: spawn_point_populations spawn_point_populations_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_pkey PRIMARY KEY (population_id);


--
-- Name: spawn_point_set_entries spawn_point_set_entries_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_pkey PRIMARY KEY (spawn_point_set_entry_id);


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_pkey PRIMARY KEY (spawn_point_set_entry_level_id);


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_pkey PRIMARY KEY (spawn_point_set_replacement_id);


--
-- Name: spawn_point_sets spawn_point_sets_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_pkey PRIMARY KEY (spawn_point_set_id);


--
-- Name: spawn_points spawn_points_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points
    ADD CONSTRAINT spawn_points_pkey PRIMARY KEY (object_id);


--
-- Name: blog_articles blog_articles_article_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.blog_articles
    ADD CONSTRAINT blog_articles_article_hash_key UNIQUE (article_hash);


--
-- Name: blog_articles blog_articles_article_slug_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.blog_articles
    ADD CONSTRAINT blog_articles_article_slug_key UNIQUE (article_slug);


--
-- Name: blog_articles blog_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.blog_articles
    ADD CONSTRAINT blog_articles_pkey PRIMARY KEY (article_id);


--
-- Name: client_notices client_notices_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.client_notices
    ADD CONSTRAINT client_notices_pkey PRIMARY KEY (notice_id);


--
-- Name: corrupt_files corrupt_files_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.corrupt_files
    ADD CONSTRAINT corrupt_files_pkey PRIMARY KEY (file_id);


--
-- Name: download_signatures download_signatures_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.download_signatures
    ADD CONSTRAINT download_signatures_pkey PRIMARY KEY (signature_id);


--
-- Name: download_urls download_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.download_urls
    ADD CONSTRAINT download_urls_pkey PRIMARY KEY (download_id);


--
-- Name: download_urls download_urls_url_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.download_urls
    ADD CONSTRAINT download_urls_url_key UNIQUE (url);


--
-- Name: email_addresses email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT email_addresses_pkey PRIMARY KEY (email_id);


--
-- Name: email_verification email_verification_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification
    ADD CONSTRAINT email_verification_pkey1 PRIMARY KEY (email_id);


--
-- Name: exception_comments exception_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_comments
    ADD CONSTRAINT exception_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: exception_signatures exception_signatures_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_signatures
    ADD CONSTRAINT exception_signatures_pkey PRIMARY KEY (client_hash, client_build);


--
-- Name: exceptions exceptions_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exceptions
    ADD CONSTRAINT exceptions_pkey1 PRIMARY KEY (exception_id);


--
-- Name: gift_codes gift_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_codes
    ADD CONSTRAINT gift_codes_pkey PRIMARY KEY (code);


--
-- Name: guest_projects guest_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_projects
    ADD CONSTRAINT guest_projects_pkey PRIMARY KEY (project_id, user_id);


--
-- Name: help_topics help_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.help_topics
    ADD CONSTRAINT help_topics_pkey PRIMARY KEY (config_name);


--
-- Name: imported_obelisk_files imported_obelisk_files_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.imported_obelisk_files
    ADD CONSTRAINT imported_obelisk_files_pkey PRIMARY KEY (path);


--
-- Name: oauth_requests oauth_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.oauth_requests
    ADD CONSTRAINT oauth_requests_pkey PRIMARY KEY (request_id);


--
-- Name: oauth_tokens oauth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_pkey PRIMARY KEY (access_token);


--
-- Name: oauth_tokens oauth_tokens_user_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_user_id_key UNIQUE (user_id);


--
-- Name: product_prices product_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.product_prices
    ADD CONSTRAINT product_prices_pkey PRIMARY KEY (price_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: products products_stripe_sku_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_stripe_sku_key UNIQUE (stripe_sku);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- Name: gift_code_log purchase_code_log_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_log
    ADD CONSTRAINT purchase_code_log_pkey PRIMARY KEY (log_id);


--
-- Name: purchase_codes_archive purchase_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes_archive
    ADD CONSTRAINT purchase_codes_pkey PRIMARY KEY (code);


--
-- Name: purchase_items purchase_items_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_pkey PRIMARY KEY (line_id);


--
-- Name: purchase_items_old purchase_items_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items_old
    ADD CONSTRAINT purchase_items_pkey1 PRIMARY KEY (line_id);


--
-- Name: purchases purchases_merchant_reference_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_merchant_reference_key UNIQUE (merchant_reference);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (purchase_id);


--
-- Name: search_sync search_sync_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.search_sync
    ADD CONSTRAINT search_sync_pkey PRIMARY KEY (object_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: stw_applicants stw_applicants_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_applicants
    ADD CONSTRAINT stw_applicants_pkey PRIMARY KEY (applicant_id);


--
-- Name: stw_purchases stw_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_purchases
    ADD CONSTRAINT stw_purchases_pkey PRIMARY KEY (stw_id);


--
-- Name: support_article_groups support_article_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_article_groups
    ADD CONSTRAINT support_article_groups_pkey PRIMARY KEY (group_id);


--
-- Name: support_article_modules support_article_modules_module_name_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_article_modules
    ADD CONSTRAINT support_article_modules_module_name_key UNIQUE (module_name);


--
-- Name: support_article_modules support_article_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_article_modules
    ADD CONSTRAINT support_article_modules_pkey PRIMARY KEY (module_id);


--
-- Name: support_articles support_articles_article_slug_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_articles
    ADD CONSTRAINT support_articles_article_slug_key UNIQUE (article_slug);


--
-- Name: support_articles support_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_articles
    ADD CONSTRAINT support_articles_pkey PRIMARY KEY (article_id);


--
-- Name: support_images support_images_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_images
    ADD CONSTRAINT support_images_pkey PRIMARY KEY (image_id);


--
-- Name: support_table_of_contents support_table_of_contents_article_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_table_of_contents
    ADD CONSTRAINT support_table_of_contents_article_id_key UNIQUE (article_id);


--
-- Name: support_table_of_contents support_table_of_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_table_of_contents
    ADD CONSTRAINT support_table_of_contents_pkey PRIMARY KEY (record_id);


--
-- Name: support_videos support_videos_host_host_video_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_videos
    ADD CONSTRAINT support_videos_host_host_video_id_key UNIQUE (host, host_video_id);


--
-- Name: support_videos support_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_videos
    ADD CONSTRAINT support_videos_pkey PRIMARY KEY (video_id);


--
-- Name: support_videos support_videos_video_slug_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_videos
    ADD CONSTRAINT support_videos_video_slug_key UNIQUE (video_slug);


--
-- Name: update_files update_files_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.update_files
    ADD CONSTRAINT update_files_pkey PRIMARY KEY (file_id);


--
-- Name: updates updates_build_number_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.updates
    ADD CONSTRAINT updates_build_number_key UNIQUE (build_number);


--
-- Name: updates updates_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.updates
    ADD CONSTRAINT updates_pkey PRIMARY KEY (update_id);


--
-- Name: user_challenges user_challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_pkey PRIMARY KEY (user_id);


--
-- Name: usercloud_cache usercloud_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.usercloud_cache
    ADD CONSTRAINT usercloud_cache_pkey PRIMARY KEY (cache_id);


--
-- Name: usercloud usercloud_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.usercloud
    ADD CONSTRAINT usercloud_pkey PRIMARY KEY (remote_path);


--
-- Name: usercloud_queue usercloud_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.usercloud_queue
    ADD CONSTRAINT usercloud_queue_pkey PRIMARY KEY (remote_path);


--
-- Name: users users_email_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_id_key UNIQUE (email_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: wordlist wordlist_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.wordlist
    ADD CONSTRAINT wordlist_pkey PRIMARY KEY (word);


--
-- Name: ark_mod_relationships_first_mod_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX ark_mod_relationships_first_mod_id_idx ON ark.mod_relationships USING btree (first_mod_id);


--
-- Name: ark_mod_relationships_first_mod_id_second_mod_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX ark_mod_relationships_first_mod_id_second_mod_id_idx ON ark.mod_relationships USING btree (first_mod_id, second_mod_id);


--
-- Name: creatures_class_string_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX creatures_class_string_idx ON ark.creatures USING btree (class_string);


--
-- Name: creatures_group_key_group_master_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_group_key_group_master_idx ON ark.creatures USING btree (group_key, group_master) WHERE (group_master = true);


--
-- Name: creatures_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_mod_id_class_string_legacy_uidx ON ark.creatures USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: creatures_mod_id_path_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_mod_id_path_uidx ON ark.creatures USING btree (mod_id, path);


--
-- Name: creatures_path_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX creatures_path_idx ON ark.creatures USING btree (path);


--
-- Name: creatures_path_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_path_legacy_uidx ON ark.creatures USING btree (path) WHERE (min_version < 10500000);


--
-- Name: engrams_class_string_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX engrams_class_string_idx ON ark.engrams USING btree (class_string);


--
-- Name: engrams_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_mod_id_class_string_legacy_uidx ON ark.engrams USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: engrams_mod_id_path_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_mod_id_path_uidx ON ark.engrams USING btree (mod_id, path);


--
-- Name: engrams_path_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX engrams_path_idx ON ark.engrams USING btree (path);


--
-- Name: engrams_path_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_path_legacy_uidx ON ark.engrams USING btree (path) WHERE (min_version < 10500000);


--
-- Name: loot_item_set_entries_loot_item_set_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX loot_item_set_entries_loot_item_set_id_idx ON ark.loot_item_set_entries USING btree (loot_item_set_id);


--
-- Name: loot_item_set_entries_sort_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_item_set_entries_sort_idx ON ark.loot_item_set_entries USING btree (loot_item_set_id, sync_sort_key);


--
-- Name: loot_item_set_entry_options_loot_item_set_entry_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX loot_item_set_entry_options_loot_item_set_entry_id_idx ON ark.loot_item_set_entry_options USING btree (loot_item_set_entry_id);


--
-- Name: loot_item_set_entry_options_sort_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_item_set_entry_options_sort_idx ON ark.loot_item_set_entry_options USING btree (loot_item_set_entry_id, sync_sort_key);


--
-- Name: loot_item_sets_loot_source_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX loot_item_sets_loot_source_id_idx ON ark.loot_item_sets USING btree (loot_source_id);


--
-- Name: loot_item_sets_sort_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_item_sets_sort_idx ON ark.loot_item_sets USING btree (loot_source_id, sync_sort_key);


--
-- Name: loot_sources_class_string_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX loot_sources_class_string_idx ON ark.loot_sources USING btree (class_string);


--
-- Name: loot_sources_mod_id_class_string_legacy_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_mod_id_class_string_legacy_idx ON ark.loot_sources USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: loot_sources_mod_id_path_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_mod_id_path_idx ON ark.loot_sources USING btree (mod_id, path);


--
-- Name: loot_sources_path_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX loot_sources_path_idx ON ark.loot_sources USING btree (path);


--
-- Name: loot_sources_path_legacy_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_path_legacy_idx ON ark.loot_sources USING btree (path) WHERE (min_version < 10500000);


--
-- Name: loot_sources_sort_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_sort_idx ON ark.loot_sources USING btree (sort);


--
-- Name: mods_workshop_id_confirmed_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_confirmed_uidx ON ark.mods USING btree (abs(workshop_id), confirmed) WHERE (confirmed = true);


--
-- Name: mods_workshop_id_user_id_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_user_id_uidx ON ark.mods USING btree (abs(workshop_id), user_id);


--
-- Name: spawn_point_populations_spawn_point_id_map_id_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_populations_spawn_point_id_map_id_idx ON ark.spawn_point_populations USING btree (spawn_point_id, map_id);


--
-- Name: spawn_point_set_entry_levels_unique_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_entry_levels_unique_idx ON ark.spawn_point_set_entry_levels USING btree (spawn_point_set_entry_id, difficulty);


--
-- Name: spawn_point_set_replacements_unique_replacement_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_replacements_unique_replacement_idx ON ark.spawn_point_set_replacements USING btree (spawn_point_set_id, target_creature_id, replacement_creature_id);


--
-- Name: spawn_points_class_string_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX spawn_points_class_string_idx ON ark.spawn_points USING btree (class_string);


--
-- Name: spawn_points_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_mod_id_class_string_legacy_uidx ON ark.spawn_points USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: spawn_points_mod_id_path_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_mod_id_path_uidx ON ark.spawn_points USING btree (mod_id, path);


--
-- Name: spawn_points_path_idx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE INDEX spawn_points_path_idx ON ark.spawn_points USING btree (path);


--
-- Name: spawn_points_path_legacy_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_path_legacy_uidx ON ark.spawn_points USING btree (path) WHERE (min_version < 10500000);


--
-- Name: download_signatures_download_id_format_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX download_signatures_download_id_format_idx ON public.download_signatures USING btree (download_id, format);


--
-- Name: email_addresses_group_key_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX email_addresses_group_key_idx ON public.email_addresses USING btree (group_key);


--
-- Name: exception_users_exception_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX exception_users_exception_id_user_id_idx ON public.exception_users USING btree (exception_id, user_id);


--
-- Name: imported_obelisk_files_path_version_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX imported_obelisk_files_path_version_uidx ON public.imported_obelisk_files USING btree (path, version);


--
-- Name: product_prices_product_id_currency_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX product_prices_product_id_currency_idx ON public.product_prices USING btree (product_id, currency);


--
-- Name: projects_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX projects_user_id_idx ON public.projects USING btree (user_id);


--
-- Name: purchases_purchaser_email_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX purchases_purchaser_email_idx ON public.purchases USING btree (purchaser_email);


--
-- Name: stw_applicants_email_id_desired_product_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX stw_applicants_email_id_desired_product_idx ON public.stw_applicants USING btree (email_id, desired_product);


--
-- Name: stw_purchases_original_purchase_id_generated_purchase_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX stw_purchases_original_purchase_id_generated_purchase_id_idx ON public.stw_purchases USING btree (original_purchase_id, generated_purchase_id);


--
-- Name: update_files_unique_completes_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX update_files_unique_completes_idx ON public.update_files USING btree (version) WHERE (type = 'Complete'::public.update_file_type);


--
-- Name: update_files_unique_deltas_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX update_files_unique_deltas_idx ON public.update_files USING btree (created, version) WHERE (type = 'Delta'::public.update_file_type);


--
-- Name: usercloud_cache_remote_path_hostname_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX usercloud_cache_remote_path_hostname_idx ON public.usercloud_cache USING btree (remote_path, hostname);


--
-- Name: spawn_point_populations ark_spawn_point_populations_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ark_spawn_point_populations_update_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_populations FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: color_sets color_sets_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER color_sets_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.color_sets FOR EACH ROW EXECUTE FUNCTION ark.update_color_set_last_update();


--
-- Name: colors colors_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER colors_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.colors FOR EACH ROW EXECUTE FUNCTION ark.update_color_last_update();


--
-- Name: crafting_costs crafting_costs_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER crafting_costs_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.crafting_costs FOR EACH ROW EXECUTE FUNCTION ark.update_engram_timestamp();


--
-- Name: creature_stats creature_stats_update_creature_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creature_stats_update_creature_trigger AFTER INSERT OR DELETE OR UPDATE ON ark.creature_stats FOR EACH ROW EXECUTE FUNCTION ark.update_creature_modified();


--
-- Name: creatures creatures_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON ark.creatures FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: creatures creatures_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON ark.creatures FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: creatures creatures_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON ark.creatures FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: creatures creatures_compute_class_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON ark.creatures FOR EACH ROW EXECUTE FUNCTION ark.compute_class_trigger();


--
-- Name: creatures creatures_search_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_search_sync_trigger BEFORE INSERT OR DELETE ON ark.creatures FOR EACH ROW EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: creatures creatures_search_sync_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER creatures_search_sync_update_trigger BEFORE UPDATE ON ark.creatures FOR EACH ROW WHEN ((((old.label IS DISTINCT FROM new.label) OR (old.min_version IS DISTINCT FROM new.min_version)) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: diets diets_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER diets_after_delete_trigger AFTER DELETE ON ark.diets FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: diets diets_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER diets_before_insert_trigger BEFORE INSERT ON ark.diets FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: diets diets_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER diets_before_update_trigger BEFORE UPDATE ON ark.diets FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: mods enforce_mod_owner; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER enforce_mod_owner BEFORE INSERT OR UPDATE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.enforce_mod_owner();


--
-- Name: engrams engrams_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON ark.engrams FOR EACH ROW EXECUTE FUNCTION ark.engram_delete_trigger();


--
-- Name: engrams engrams_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON ark.engrams FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: engrams engrams_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON ark.engrams FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: engrams engrams_compute_class_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON ark.engrams FOR EACH ROW EXECUTE FUNCTION ark.compute_class_trigger();


--
-- Name: engrams engrams_search_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_search_sync_trigger BEFORE INSERT OR DELETE ON ark.engrams FOR EACH ROW EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: engrams engrams_search_sync_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER engrams_search_sync_update_trigger BEFORE UPDATE ON ark.engrams FOR EACH ROW WHEN ((((old.label IS DISTINCT FROM new.label) OR (old.min_version IS DISTINCT FROM new.min_version)) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: event_colors event_colors_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER event_colors_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON ark.event_colors FOR EACH ROW EXECUTE FUNCTION ark.update_event_last_update_from_children();


--
-- Name: event_engrams event_engrams_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER event_engrams_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON ark.event_engrams FOR EACH ROW EXECUTE FUNCTION ark.update_event_last_update_from_children();


--
-- Name: event_rates event_rates_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER event_rates_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON ark.event_rates FOR EACH ROW EXECUTE FUNCTION ark.update_event_last_update_from_children();


--
-- Name: events events_modified_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER events_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.events FOR EACH ROW EXECUTE FUNCTION ark.update_event_last_update();


--
-- Name: game_variables game_variables_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON ark.game_variables FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: ini_options ini_options_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ini_options_after_delete_trigger AFTER DELETE ON ark.ini_options FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: ini_options ini_options_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_insert_trigger BEFORE INSERT ON ark.ini_options FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: ini_options ini_options_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_update_trigger BEFORE UPDATE ON ark.ini_options FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: loot_item_set_entries loot_item_set_entries_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entries_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.loot_item_set_entries FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entry_options_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.loot_item_set_entry_options FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_sets loot_item_sets_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_sets_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.loot_item_sets FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_source_icons loot_source_icons_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_after_delete_trigger AFTER DELETE ON ark.loot_source_icons FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: loot_source_icons loot_source_icons_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_insert_trigger BEFORE INSERT ON ark.loot_source_icons FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: loot_source_icons loot_source_icons_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_update_trigger BEFORE UPDATE ON ark.loot_source_icons FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: loot_sources loot_sources_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON ark.loot_sources FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: loot_sources loot_sources_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON ark.loot_sources FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: loot_sources loot_sources_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON ark.loot_sources FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: loot_sources loot_sources_compute_class_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_compute_class_trigger BEFORE INSERT OR UPDATE ON ark.loot_sources FOR EACH ROW EXECUTE FUNCTION ark.compute_class_trigger();


--
-- Name: loot_sources loot_sources_search_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_search_sync_trigger BEFORE INSERT OR DELETE ON ark.loot_sources FOR EACH ROW EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: loot_sources loot_sources_search_sync_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_search_sync_update_trigger BEFORE UPDATE ON ark.loot_sources FOR EACH ROW WHEN ((((old.label IS DISTINCT FROM new.label) OR (old.min_version IS DISTINCT FROM new.min_version)) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: maps maps_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER maps_before_update_trigger BEFORE INSERT OR UPDATE ON ark.maps FOR EACH ROW EXECUTE FUNCTION ark.update_last_update_column();


--
-- Name: mods mods_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER mods_after_delete_trigger AFTER DELETE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.mods_delete_trigger();


--
-- Name: mods mods_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER mods_before_update_trigger BEFORE INSERT OR UPDATE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: mods mods_search_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER mods_search_sync_trigger BEFORE INSERT OR DELETE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.mods_search_sync();


--
-- Name: mods mods_search_sync_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER mods_search_sync_update_trigger BEFORE UPDATE ON ark.mods FOR EACH ROW WHEN (((old.name IS DISTINCT FROM new.name) OR (old.confirmed IS DISTINCT FROM new.confirmed))) EXECUTE FUNCTION ark.mods_search_sync();


--
-- Name: preset_modifiers preset_modifiers_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_after_delete_trigger AFTER DELETE ON ark.preset_modifiers FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_insert_trigger BEFORE INSERT ON ark.preset_modifiers FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_update_trigger BEFORE UPDATE ON ark.preset_modifiers FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: presets presets_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON ark.presets FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: presets presets_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON ark.presets FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: presets presets_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON ark.presets FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: presets presets_json_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER presets_json_sync_trigger BEFORE INSERT OR UPDATE ON ark.presets FOR EACH ROW EXECUTE FUNCTION ark.presets_json_sync_function();


--
-- Name: spawn_point_limits spawn_point_limits_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_limits_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_limits FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entries spawn_point_set_entries_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entries_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_set_entries FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entry_levels_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_set_entry_levels FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_replacements_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_set_replacements FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: spawn_point_sets spawn_point_sets_update_timestamp_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_sets_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON ark.spawn_point_sets FOR EACH ROW EXECUTE FUNCTION ark.update_spawn_point_timestamp();


--
-- Name: spawn_points spawn_points_after_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_after_delete_trigger AFTER DELETE ON ark.spawn_points FOR EACH ROW EXECUTE FUNCTION ark.object_delete_trigger();


--
-- Name: spawn_points spawn_points_before_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_insert_trigger BEFORE INSERT ON ark.spawn_points FOR EACH ROW EXECUTE FUNCTION ark.object_insert_trigger();


--
-- Name: spawn_points spawn_points_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_update_trigger BEFORE UPDATE ON ark.spawn_points FOR EACH ROW EXECUTE FUNCTION ark.object_update_trigger();


--
-- Name: spawn_points spawn_points_compute_class_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_compute_class_trigger BEFORE INSERT OR UPDATE ON ark.spawn_points FOR EACH ROW EXECUTE FUNCTION ark.compute_class_trigger();


--
-- Name: spawn_points spawn_points_search_sync_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_search_sync_trigger BEFORE INSERT OR DELETE ON ark.spawn_points FOR EACH ROW EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: spawn_points spawn_points_search_sync_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_search_sync_update_trigger BEFORE UPDATE ON ark.spawn_points FOR EACH ROW WHEN ((((old.label IS DISTINCT FROM new.label) OR (old.min_version IS DISTINCT FROM new.min_version)) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: client_notices client_notices_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER client_notices_before_update_trigger BEFORE INSERT OR UPDATE ON public.client_notices FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: blog_articles create_slug_from_article_subject_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER create_slug_from_article_subject_trigger BEFORE INSERT ON public.blog_articles FOR EACH ROW WHEN ((new.article_slug IS NULL)) EXECUTE FUNCTION public.set_slug_from_article_subject();


--
-- Name: support_articles create_slug_from_article_subject_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER create_slug_from_article_subject_trigger BEFORE INSERT ON public.support_articles FOR EACH ROW WHEN ((new.article_slug IS NULL)) EXECUTE FUNCTION public.set_slug_from_article_subject();


--
-- Name: support_videos create_slug_from_video_title_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER create_slug_from_video_title_trigger BEFORE INSERT ON public.support_videos FOR EACH ROW WHEN ((new.video_slug IS NULL)) EXECUTE FUNCTION public.set_slug_from_video_title();


--
-- Name: help_topics help_topics_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER help_topics_before_update_trigger BEFORE INSERT OR UPDATE ON public.help_topics FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: blog_articles insert_blog_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER insert_blog_article_timestamp_trigger BEFORE INSERT ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_timestamp();


--
-- Name: support_articles support_articles_search_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_articles_search_sync_trigger BEFORE INSERT OR DELETE ON public.support_articles FOR EACH ROW EXECUTE FUNCTION public.support_articles_search_sync();


--
-- Name: support_articles support_articles_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_articles_search_sync_update_trigger BEFORE UPDATE ON public.support_articles FOR EACH ROW WHEN ((((((((old.article_slug)::text IS DISTINCT FROM (new.article_slug)::text) OR (old.subject IS DISTINCT FROM new.subject)) OR (old.preview IS DISTINCT FROM new.preview)) OR (old.published IS DISTINCT FROM new.published)) OR (old.min_version IS DISTINCT FROM new.min_version)) OR (old.max_version IS DISTINCT FROM new.max_version))) EXECUTE FUNCTION public.support_articles_search_sync();


--
-- Name: support_videos support_videos_search_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_videos_search_sync_trigger BEFORE INSERT OR DELETE ON public.support_videos FOR EACH ROW EXECUTE FUNCTION public.support_videos_search_sync();


--
-- Name: support_videos support_videos_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_videos_search_sync_update_trigger BEFORE UPDATE ON public.support_videos FOR EACH ROW WHEN ((((old.video_slug)::text IS DISTINCT FROM (new.video_slug)::text) OR (old.video_title IS DISTINCT FROM new.video_title))) EXECUTE FUNCTION public.support_videos_search_sync();


--
-- Name: blog_articles update_blog_article_hash_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_hash_trigger BEFORE INSERT OR UPDATE ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_hash();


--
-- Name: blog_articles update_blog_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_timestamp_trigger BEFORE UPDATE ON public.blog_articles FOR EACH ROW WHEN ((old.content_markdown IS DISTINCT FROM new.content_markdown)) EXECUTE FUNCTION public.update_blog_article_timestamp();


--
-- Name: support_article_modules update_support_article_module_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_article_module_timestamp_trigger BEFORE INSERT OR UPDATE ON public.support_article_modules FOR EACH ROW EXECUTE FUNCTION ark.update_support_article_module_timestamp();


--
-- Name: support_articles update_support_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_article_timestamp_trigger BEFORE INSERT OR UPDATE ON public.support_articles FOR EACH ROW EXECUTE FUNCTION ark.update_support_article_timestamp();


--
-- Name: support_images update_support_image_associations_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_image_associations_trigger BEFORE INSERT OR UPDATE ON public.support_images FOR EACH ROW EXECUTE FUNCTION public.update_support_image_associations();


--
-- Name: crafting_costs crafting_costs_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.crafting_costs
    ADD CONSTRAINT crafting_costs_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: crafting_costs crafting_costs_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.crafting_costs
    ADD CONSTRAINT crafting_costs_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creature_engrams creature_engrams_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creature_engrams creature_engrams_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_engrams
    ADD CONSTRAINT creature_engrams_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creature_stats creature_stats_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creature_stats
    ADD CONSTRAINT creature_stats_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creatures creatures_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures
    ADD CONSTRAINT creatures_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creatures creatures_tamed_diet_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures
    ADD CONSTRAINT creatures_tamed_diet_fkey FOREIGN KEY (tamed_diet) REFERENCES ark.diets(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: creatures creatures_taming_diet_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.creatures
    ADD CONSTRAINT creatures_taming_diet_fkey FOREIGN KEY (taming_diet) REFERENCES ark.diets(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: diet_contents diet_contents_diet_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_fkey FOREIGN KEY (diet_id) REFERENCES ark.diets(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: diet_contents diet_contents_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diet_contents
    ADD CONSTRAINT diet_contents_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: diets diets_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.diets
    ADD CONSTRAINT diets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: engrams engrams_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams
    ADD CONSTRAINT engrams_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_colors event_colors_color_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_colors
    ADD CONSTRAINT event_colors_color_id_fkey FOREIGN KEY (color_id) REFERENCES ark.colors(color_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: event_colors event_colors_event_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_colors
    ADD CONSTRAINT event_colors_event_id_fkey FOREIGN KEY (event_id) REFERENCES ark.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_event_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_engrams
    ADD CONSTRAINT event_engrams_event_id_fkey FOREIGN KEY (event_id) REFERENCES ark.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_object_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_engrams
    ADD CONSTRAINT event_engrams_object_id_fkey FOREIGN KEY (object_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_event_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_rates
    ADD CONSTRAINT event_rates_event_id_fkey FOREIGN KEY (event_id) REFERENCES ark.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_ini_option_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.event_rates
    ADD CONSTRAINT event_rates_ini_option_fkey FOREIGN KEY (ini_option) REFERENCES ark.ini_options(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ini_options ini_options_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.ini_options
    ADD CONSTRAINT ini_options_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: loot_item_set_entries loot_item_set_entries_loot_item_set_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_loot_item_set_id_fkey FOREIGN KEY (loot_item_set_id) REFERENCES ark.loot_item_sets(loot_item_set_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_loot_item_set_entry_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_loot_item_set_entry_id_fkey FOREIGN KEY (loot_item_set_entry_id) REFERENCES ark.loot_item_set_entries(loot_item_set_entry_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_sets loot_item_sets_loot_source_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_sets
    ADD CONSTRAINT loot_item_sets_loot_source_id_fkey FOREIGN KEY (loot_source_id) REFERENCES ark.loot_sources(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_source_icons loot_source_icons_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_source_icons
    ADD CONSTRAINT loot_source_icons_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: loot_sources loot_sources_icon_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources
    ADD CONSTRAINT loot_sources_icon_fkey FOREIGN KEY (icon) REFERENCES ark.loot_source_icons(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: loot_sources loot_sources_mod_id_fkey1; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources
    ADD CONSTRAINT loot_sources_mod_id_fkey1 FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: maps maps_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mod_relationships mod_relationships_first_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mod_relationships
    ADD CONSTRAINT mod_relationships_first_mod_id_fkey FOREIGN KEY (first_mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mod_relationships mod_relationships_second_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mod_relationships
    ADD CONSTRAINT mod_relationships_second_mod_id_fkey FOREIGN KEY (second_mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mods mods_user_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods
    ADD CONSTRAINT mods_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.objects
    ADD CONSTRAINT objects_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: preset_modifiers preset_modifiers_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers
    ADD CONSTRAINT preset_modifiers_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: presets presets_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets
    ADD CONSTRAINT presets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_limits spawn_point_limits_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_limits spawn_point_limits_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES ark.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_populations spawn_point_populations_map_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_map_id_fkey FOREIGN KEY (map_id) REFERENCES ark.maps(map_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_populations spawn_point_populations_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES ark.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES ark.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey FOREIGN KEY (spawn_point_set_entry_id) REFERENCES ark.spawn_point_set_entries(spawn_point_set_entry_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_replacement_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_replacement_creature_id_fkey FOREIGN KEY (replacement_creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES ark.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_target_creature_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_target_creature_id_fkey FOREIGN KEY (target_creature_id) REFERENCES ark.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: spawn_point_sets spawn_point_sets_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES ark.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_points spawn_points_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.spawn_points
    ADD CONSTRAINT spawn_points_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES ark.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: download_signatures download_signatures_download_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.download_signatures
    ADD CONSTRAINT download_signatures_download_id_fkey FOREIGN KEY (download_id) REFERENCES public.download_urls(download_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: download_urls download_urls_update_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.download_urls
    ADD CONSTRAINT download_urls_update_id_fkey FOREIGN KEY (update_id) REFERENCES public.updates(update_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: email_verification email_verification_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification
    ADD CONSTRAINT email_verification_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: exception_comments exception_comments_exception_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_comments
    ADD CONSTRAINT exception_comments_exception_id_fkey1 FOREIGN KEY (exception_id) REFERENCES public.exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: exception_comments exception_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_comments
    ADD CONSTRAINT exception_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: exception_signatures exception_signatures_exception_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_signatures
    ADD CONSTRAINT exception_signatures_exception_id_fkey FOREIGN KEY (exception_id) REFERENCES public.exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: exception_users exception_users_exception_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_users
    ADD CONSTRAINT exception_users_exception_id_fkey FOREIGN KEY (exception_id) REFERENCES public.exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: exception_users exception_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.exception_users
    ADD CONSTRAINT exception_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gift_codes gift_codes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_codes
    ADD CONSTRAINT gift_codes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: gift_codes gift_codes_redemption_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_codes
    ADD CONSTRAINT gift_codes_redemption_purchase_id_fkey FOREIGN KEY (redemption_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gift_codes gift_codes_source_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_codes
    ADD CONSTRAINT gift_codes_source_purchase_id_fkey FOREIGN KEY (source_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: guest_projects guest_projects_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_projects
    ADD CONSTRAINT guest_projects_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guest_projects guest_projects_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_projects
    ADD CONSTRAINT guest_projects_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: licenses licenses_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: licenses licenses_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: oauth_tokens oauth_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_prices product_prices_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.product_prices
    ADD CONSTRAINT product_prices_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: projects projects_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: gift_code_log purchase_code_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_log
    ADD CONSTRAINT purchase_code_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase_codes_archive purchase_codes_purchaser_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes_archive
    ADD CONSTRAINT purchase_codes_purchaser_email_id_fkey FOREIGN KEY (purchaser_email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_codes_archive purchase_codes_redemption_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes_archive
    ADD CONSTRAINT purchase_codes_redemption_purchase_id_fkey FOREIGN KEY (redemption_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_items purchase_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase_items_old purchase_items_product_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items_old
    ADD CONSTRAINT purchase_items_product_id_fkey1 FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase_items purchase_items_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_items_old purchase_items_purchase_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items_old
    ADD CONSTRAINT purchase_items_purchase_id_fkey1 FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchases purchases_purchaser_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_purchaser_email_fkey FOREIGN KEY (purchaser_email) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stw_applicants stw_applicants_desired_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_applicants
    ADD CONSTRAINT stw_applicants_desired_product_fkey FOREIGN KEY (desired_product) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: stw_applicants stw_applicants_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_applicants
    ADD CONSTRAINT stw_applicants_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stw_applicants stw_applicants_generated_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_applicants
    ADD CONSTRAINT stw_applicants_generated_purchase_id_fkey FOREIGN KEY (generated_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: stw_purchases stw_purchases_generated_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_purchases
    ADD CONSTRAINT stw_purchases_generated_purchase_id_fkey FOREIGN KEY (generated_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE SET NULL ON DELETE SET DEFAULT;


--
-- Name: stw_purchases stw_purchases_original_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_purchases
    ADD CONSTRAINT stw_purchases_original_purchase_id_fkey FOREIGN KEY (original_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: support_articles support_articles_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_articles
    ADD CONSTRAINT support_articles_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.support_article_groups(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: support_table_of_contents support_table_of_contents_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_table_of_contents
    ADD CONSTRAINT support_table_of_contents_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.support_articles(article_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: support_table_of_contents support_table_of_contents_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_table_of_contents
    ADD CONSTRAINT support_table_of_contents_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.support_article_groups(group_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_challenges user_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users users_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_parent_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_parent_account_id_fkey FOREIGN KEY (parent_account_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA ark; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA ark TO thezaz_website;
GRANT USAGE ON SCHEMA ark TO beacon_updater;


--
-- Name: TABLE objects; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.objects TO thezaz_website;


--
-- Name: TABLE creatures; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creatures TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creatures TO beacon_updater;


--
-- Name: TABLE engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.engrams TO beacon_updater;


--
-- Name: TABLE loot_sources; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_sources TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_sources TO beacon_updater;


--
-- Name: TABLE spawn_points; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_points TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_points TO beacon_updater;


--
-- Name: TABLE blueprints; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.blueprints TO thezaz_website;
GRANT SELECT ON TABLE ark.blueprints TO beacon_updater;


--
-- Name: TABLE color_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.color_sets TO thezaz_website;


--
-- Name: TABLE colors; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.colors TO thezaz_website;


--
-- Name: TABLE crafting_costs; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.crafting_costs TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.crafting_costs TO beacon_updater;


--
-- Name: TABLE creature_engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_engrams TO beacon_updater;


--
-- Name: TABLE creature_stats; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_stats TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_stats TO beacon_updater;


--
-- Name: TABLE deletions; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.deletions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.deletions TO beacon_updater;


--
-- Name: TABLE diet_contents; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.diet_contents TO thezaz_website;


--
-- Name: TABLE diets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.diets TO thezaz_website;


--
-- Name: TABLE event_colors; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_colors TO thezaz_website;


--
-- Name: TABLE event_engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_engrams TO thezaz_website;


--
-- Name: TABLE event_rates; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_rates TO thezaz_website;


--
-- Name: TABLE events; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.events TO thezaz_website;


--
-- Name: TABLE game_variables; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.game_variables TO thezaz_website;


--
-- Name: TABLE ini_options; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.ini_options TO thezaz_website;


--
-- Name: TABLE loot_item_set_entries; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entries TO beacon_updater;


--
-- Name: TABLE loot_item_set_entry_options; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entry_options TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entry_options TO beacon_updater;


--
-- Name: TABLE loot_item_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_sets TO beacon_updater;


--
-- Name: TABLE loot_source_icons; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.loot_source_icons TO thezaz_website;


--
-- Name: TABLE maps; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.maps TO thezaz_website;
GRANT SELECT ON TABLE ark.maps TO beacon_updater;


--
-- Name: TABLE mod_relationships; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mod_relationships TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mod_relationships TO beacon_updater;


--
-- Name: TABLE mods; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mods TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mods TO beacon_updater;


--
-- Name: TABLE preset_modifiers; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.preset_modifiers TO thezaz_website;


--
-- Name: TABLE presets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.presets TO thezaz_website;


--
-- Name: TABLE spawn_point_limits; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_limits TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_limits TO beacon_updater;


--
-- Name: TABLE spawn_point_populations; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_populations TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_populations TO beacon_updater;


--
-- Name: TABLE spawn_point_set_entries; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entries TO beacon_updater;


--
-- Name: TABLE spawn_point_set_entry_levels; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entry_levels TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entry_levels TO beacon_updater;


--
-- Name: TABLE spawn_point_set_replacements; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_replacements TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_replacements TO beacon_updater;


--
-- Name: TABLE spawn_point_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_sets TO beacon_updater;


--
-- Name: TABLE guest_projects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.guest_projects TO thezaz_website;


--
-- Name: TABLE projects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.projects TO thezaz_website;


--
-- Name: TABLE allowed_projects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.allowed_projects TO thezaz_website;


--
-- Name: TABLE blog_articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.blog_articles TO thezaz_website;


--
-- Name: TABLE client_notices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.client_notices TO thezaz_website;


--
-- Name: TABLE corrupt_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.corrupt_files TO thezaz_website;


--
-- Name: TABLE deletions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.deletions TO thezaz_website;


--
-- Name: TABLE download_signatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.download_signatures TO thezaz_website;


--
-- Name: TABLE download_urls; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.download_urls TO thezaz_website;


--
-- Name: TABLE email_addresses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_addresses TO thezaz_website;


--
-- Name: TABLE email_verification; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_verification TO thezaz_website;


--
-- Name: TABLE exception_comments; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.exception_comments TO thezaz_website;


--
-- Name: TABLE exception_signatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.exception_signatures TO thezaz_website;


--
-- Name: TABLE exception_users; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.exception_users TO thezaz_website;


--
-- Name: TABLE exceptions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.exceptions TO thezaz_website;


--
-- Name: TABLE gift_code_log; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.gift_code_log TO thezaz_website;


--
-- Name: TABLE gift_codes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gift_codes TO thezaz_website;


--
-- Name: TABLE help_topics; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.help_topics TO thezaz_website;


--
-- Name: TABLE imported_obelisk_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.imported_obelisk_files TO beacon_updater;


--
-- Name: TABLE licenses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.licenses TO thezaz_website;


--
-- Name: TABLE updates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.updates TO thezaz_website;


--
-- Name: TABLE news; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.news TO thezaz_website;


--
-- Name: TABLE oauth_requests; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE ON TABLE public.oauth_requests TO thezaz_website;


--
-- Name: TABLE oauth_tokens; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.oauth_tokens TO thezaz_website;


--
-- Name: TABLE product_prices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,UPDATE ON TABLE public.product_prices TO thezaz_website;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.products TO thezaz_website;


--
-- Name: TABLE purchase_items; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.purchase_items TO thezaz_website;


--
-- Name: TABLE purchase_items_old; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.purchase_items_old TO thezaz_website;


--
-- Name: TABLE purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.purchases TO thezaz_website;


--
-- Name: TABLE purchased_products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.purchased_products TO thezaz_website;


--
-- Name: TABLE support_articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_articles TO thezaz_website;


--
-- Name: TABLE support_videos; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_videos TO thezaz_website;


--
-- Name: TABLE search_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.search_contents TO thezaz_website;


--
-- Name: TABLE search_sync; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.search_sync TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.search_sync TO beacon_updater;


--
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sessions TO thezaz_website;


--
-- Name: TABLE stw_applicants; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.stw_applicants TO thezaz_website;


--
-- Name: TABLE stw_purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.stw_purchases TO thezaz_website;


--
-- Name: TABLE support_article_groups; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_article_groups TO thezaz_website;


--
-- Name: TABLE support_article_modules; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.support_article_modules TO thezaz_website;


--
-- Name: TABLE support_images; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.support_images TO thezaz_website;


--
-- Name: TABLE support_table_of_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_table_of_contents TO thezaz_website;


--
-- Name: TABLE template_selectors; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.template_selectors TO thezaz_website;


--
-- Name: TABLE templates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.templates TO thezaz_website;


--
-- Name: TABLE update_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.update_files TO thezaz_website;


--
-- Name: TABLE user_challenges; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_challenges TO thezaz_website;


--
-- Name: TABLE usercloud; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud TO thezaz_website;


--
-- Name: TABLE usercloud_cache; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud_cache TO thezaz_website;


--
-- Name: TABLE usercloud_queue; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud_queue TO thezaz_website;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO thezaz_website;


--
-- Name: TABLE wordlist; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.wordlist TO thezaz_website;


--
-- PostgreSQL database dump complete
--

