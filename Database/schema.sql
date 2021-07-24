--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

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
-- Name: article_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.article_type AS ENUM (
    'Blog',
    'Help'
);


ALTER TYPE public.article_type OWNER TO thommcgrath;

--
-- Name: email; Type: DOMAIN; Schema: public; Owner: thommcgrath
--

CREATE DOMAIN public.email AS public.citext
	CONSTRAINT email_check CHECK ((VALUE OPERATOR(public.~) '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::public.citext));


ALTER DOMAIN public.email OWNER TO thommcgrath;

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
-- Name: compute_class_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.compute_class_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	NEW.class_string = SUBSTRING(NEW.path, '\.([a-zA-Z0-9\-\_]+)$') || '_C';
	RETURN NEW;
END;
$_$;


ALTER FUNCTION public.compute_class_trigger() OWNER TO thommcgrath;

--
-- Name: enforce_mod_owner(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.enforce_mod_owner() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.enforce_mod_owner() OWNER TO thommcgrath;

--
-- Name: engram_delete_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.engram_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO deletions (object_id, from_table, label, min_version, tag) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version, OLD.path;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION public.engram_delete_trigger() OWNER TO thommcgrath;

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
-- Name: generic_update_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.generic_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.generic_update_trigger() OWNER TO thommcgrath;

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
	v_user := SUBSTRING(p_address, '^([^@]+)@.+$');
	v_domain := SUBSTRING(p_address, '^[^@]+@(.+)$');
	
	IF LENGTH(v_user) <= p_precision THEN
		v_kvalue := '@' || v_domain;
	ELSE
		v_kvalue := SUBSTRING(v_user, 1, p_precision) || '*@' || v_domain;
	END IF;
	
	RETURN MD5(LOWER(v_kvalue));
END;
$_$;


ALTER FUNCTION public.group_key_for_email(p_address public.email, p_precision integer) OWNER TO thommcgrath;

--
-- Name: loot_source_icons_update_loot_source(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.loot_source_icons_update_loot_source() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE loot_sources SET last_update = CURRENT_TIMESTAMP(0) WHERE icon = NEW.object_id;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.loot_source_icons_update_loot_source() OWNER TO thommcgrath;

--
-- Name: mods_delete_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.mods_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	IF OLD.confirmed = TRUE THEN
		EXECUTE 'INSERT INTO deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.mod_id, TG_TABLE_NAME, OLD.name, 10500000;
	END IF;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION public.mods_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_delete_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.object_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION public.object_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_insert_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.object_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION public.object_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_update_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.object_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.object_update_trigger() OWNER TO thommcgrath;

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
-- Name: presets_json_sync_function(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.presets_json_sync_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.label = NEW.contents->>'Label';
	NEW.object_id = (NEW.contents->>'ID')::UUID;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.presets_json_sync_function() OWNER TO thommcgrath;

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
-- Name: update_color_last_update(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_color_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM deletions WHERE object_id = generate_uuid_from_text('color ' || NEW.color_id::text) AND from_table = 'colors';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO deletions (object_id, from_table, label, min_version, action_time) VALUES (generate_uuid_from_text('color ' || OLD.color_id::text), 'colors', OLD.color_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION public.update_color_last_update() OWNER TO thommcgrath;

--
-- Name: update_color_set_last_update(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_color_set_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM deletions WHERE object_id = NEW.color_set_id AND from_table = 'color_sets';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.color_set_id, 'color_sets', OLD.label, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION public.update_color_set_last_update() OWNER TO thommcgrath;

--
-- Name: update_creature_modified(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_creature_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' OR TG_OP = 'TRUNCATE' OR (TG_OP = 'UPDATE' AND NEW.creature_id != OLD.creature_id) THEN
		UPDATE creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = OLD.creature_id;
	END IF;
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = NEW.creature_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.update_creature_modified() OWNER TO thommcgrath;

--
-- Name: update_engram_timestamp(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_engram_timestamp() RETURNS trigger
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
		UPDATE engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
	END IF;
	IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
		UPDATE engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION public.update_engram_timestamp() OWNER TO thommcgrath;

--
-- Name: update_event_last_update(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_event_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM deletions WHERE object_id = NEW.event_id AND from_table = 'events';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.event_id, 'events', OLD.event_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION public.update_event_last_update() OWNER TO thommcgrath;

--
-- Name: update_event_last_update_from_children(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_event_last_update_from_children() RETURNS trigger
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


ALTER FUNCTION public.update_event_last_update_from_children() OWNER TO thommcgrath;

--
-- Name: update_last_update_column(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_last_update_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_last_update_column() OWNER TO thommcgrath;

--
-- Name: update_spawn_point_timestamp(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_spawn_point_timestamp() RETURNS trigger
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
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP FROM spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_oldid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP FROM spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_newid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
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
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP FROM spawn_point_set_entries, spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_oldid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP FROM spawn_point_set_entries, spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_newid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
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
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
		END IF;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION public.update_spawn_point_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_module_timestamp(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_support_article_module_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.module_updated := CURRENT_TIMESTAMP;
	UPDATE support_articles SET article_updated = CURRENT_TIMESTAMP WHERE content_markdown LIKE '%[module:' || NEW.module_name || ']%';
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_support_article_module_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_timestamp(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_support_article_timestamp() RETURNS trigger
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


ALTER FUNCTION public.update_support_article_timestamp() OWNER TO thommcgrath;

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
	FOR v_row IN SELECT DISTINCT group_key_precision FROM email_addresses ORDER BY group_key_precision DESC
	LOOP
		SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key = group_key_for_email(p_address, v_row.group_key_precision) AND CRYPT(LOWER(p_address), address) = address;
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
	k_target_precision CONSTANT INTEGER := 5;
BEGIN
	v_uuid := uuid_for_email(p_address);
	IF v_uuid IS NULL THEN
		IF p_create = TRUE THEN
			INSERT INTO email_addresses (address, group_key, group_key_precision) VALUES (CRYPT(LOWER(p_address), GEN_SALT('bf')), group_key_for_email(p_address, k_target_precision), k_target_precision) RETURNING email_id INTO v_uuid;
		END IF;
	ELSE
		SELECT group_key_precision INTO v_precision FROM email_addresses WHERE email_id = v_uuid;
		IF v_precision != k_target_precision THEN
			UPDATE email_addresses SET group_key = group_key_for_email(p_address, k_target_precision), group_key_precision = k_target_precision WHERE email_id = v_uuid;
		END IF;
	END IF;
	RETURN v_uuid;	
END;
$$;


ALTER FUNCTION public.uuid_for_email(p_address public.email, p_create boolean) OWNER TO thommcgrath;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.documents (
    document_id uuid NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    map integer NOT NULL,
    difficulty numeric(12,4) NOT NULL,
    console_safe boolean NOT NULL,
    last_update timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    download_count integer DEFAULT 0 NOT NULL,
    published public.publish_status DEFAULT 'Private'::public.publish_status NOT NULL,
    mods uuid[] NOT NULL,
    included_editors text[] NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.documents OWNER TO thommcgrath;

--
-- Name: guest_documents; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.guest_documents (
    document_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.guest_documents OWNER TO thommcgrath;

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
-- Name: allowed_documents; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.allowed_documents AS
 SELECT documents.document_id,
    documents.user_id,
    documents.user_id AS owner_id,
    documents.title,
    documents.description,
    documents.map,
    documents.difficulty,
    documents.console_safe,
    documents.last_update,
    documents.revision,
    documents.download_count,
    documents.published,
    documents.mods,
    documents.included_editors,
    'Owner'::text AS role
   FROM public.documents
  WHERE (documents.deleted = false)
UNION
 SELECT documents.document_id,
    guest_documents.user_id,
    documents.user_id AS owner_id,
    documents.title,
    documents.description,
    documents.map,
    documents.difficulty,
    documents.console_safe,
    documents.last_update,
    documents.revision,
    documents.download_count,
    documents.published,
    documents.mods,
    documents.included_editors,
    'Guest'::text AS role
   FROM (public.guest_documents
     JOIN public.documents ON ((guest_documents.document_id = documents.document_id)))
  WHERE (documents.deleted = false)
UNION
 SELECT documents.document_id,
    users.user_id,
    users.parent_account_id AS owner_id,
    documents.title,
    documents.description,
    documents.map,
    documents.difficulty,
    documents.console_safe,
    documents.last_update,
    documents.revision,
    documents.download_count,
    documents.published,
    documents.mods,
    documents.included_editors,
    'Team'::text AS role
   FROM (public.documents
     JOIN public.users ON ((documents.user_id = users.parent_account_id)))
  WHERE (documents.deleted = false);


ALTER TABLE public.allowed_documents OWNER TO thommcgrath;

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
-- Name: objects; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.objects (
    object_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label public.citext NOT NULL,
    min_version integer DEFAULT 0 NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    mod_id uuid DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[],
    alternate_label public.citext
);


ALTER TABLE public.objects OWNER TO thommcgrath;

--
-- Name: creatures; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.creatures (
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
INHERITS (public.objects);


ALTER TABLE public.creatures OWNER TO thommcgrath;

--
-- Name: engrams; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.engrams (
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
INHERITS (public.objects);


ALTER TABLE public.engrams OWNER TO thommcgrath;

--
-- Name: loot_sources; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.loot_sources (
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
    CONSTRAINT loot_sources_check CHECK ((((sort IS NULL) AND (min_version >= 10303300) AND (modern_sort IS NOT NULL)) OR (sort IS NOT NULL))),
    CONSTRAINT loot_sources_check1 CHECK (((experimental = false) OR (min_version >= 10100202))),
    CONSTRAINT loot_sources_class_string_check1 CHECK ((class_string OPERATOR(public.~~) '%_C'::public.citext)),
    CONSTRAINT loot_sources_uicolor_check1 CHECK ((uicolor ~* '^[0-9a-fA-F]{8}$'::text))
)
INHERITS (public.objects);


ALTER TABLE public.loot_sources OWNER TO thommcgrath;

--
-- Name: COLUMN loot_sources.simple_label; Type: COMMENT; Schema: public; Owner: thommcgrath
--

COMMENT ON COLUMN public.loot_sources.simple_label IS 'simple_label is a more ambiguous name that relies on the client to perform disambiguation';


--
-- Name: spawn_points; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_points (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    CONSTRAINT spawn_points_path_check CHECK ((path OPERATOR(public.~~) '/Game/%'::public.citext))
)
INHERITS (public.objects);


ALTER TABLE public.spawn_points OWNER TO thommcgrath;

--
-- Name: blueprints; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.blueprints AS
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
   FROM public.creatures
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
   FROM public.engrams
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
   FROM public.loot_sources
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
   FROM public.spawn_points;


ALTER TABLE public.blueprints OWNER TO thommcgrath;

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
-- Name: color_sets; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.color_sets (
    color_set_id uuid NOT NULL,
    label public.citext NOT NULL,
    class_string public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.color_sets OWNER TO thommcgrath;

--
-- Name: colors; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.colors (
    color_id integer NOT NULL,
    color_name public.citext NOT NULL,
    color_code public.hex NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.colors OWNER TO thommcgrath;

--
-- Name: computed_engram_availabilities; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.computed_engram_availabilities AS
SELECT
    NULL::uuid AS object_id,
    NULL::public.citext AS class_string,
    NULL::integer AS availability;


ALTER TABLE public.computed_engram_availabilities OWNER TO thommcgrath;

--
-- Name: corrupt_files; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.corrupt_files (
    file_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    contents bytea NOT NULL
);


ALTER TABLE public.corrupt_files OWNER TO thommcgrath;

--
-- Name: crafting_costs; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.crafting_costs (
    engram_id uuid NOT NULL,
    ingredient_id uuid NOT NULL,
    quantity integer NOT NULL,
    exact boolean NOT NULL,
    CONSTRAINT crafting_costs_check CHECK ((engram_id IS DISTINCT FROM ingredient_id)),
    CONSTRAINT crafting_costs_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.crafting_costs OWNER TO thommcgrath;

--
-- Name: creature_engrams; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.creature_engrams (
    relation_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    creature_id uuid NOT NULL,
    engram_id uuid NOT NULL
);


ALTER TABLE public.creature_engrams OWNER TO thommcgrath;

--
-- Name: creature_stats; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.creature_stats (
    creature_id uuid NOT NULL,
    stat_index integer NOT NULL,
    base_value numeric(16,6) NOT NULL,
    per_level_wild_multiplier numeric(16,6) NOT NULL,
    per_level_tamed_multiplier numeric(16,6) NOT NULL,
    add_multiplier numeric(16,6) NOT NULL,
    affinity_multiplier numeric(16,6) NOT NULL,
    CONSTRAINT creature_stats_stat_index_check CHECK (((stat_index >= 0) AND (stat_index <= 11)))
);


ALTER TABLE public.creature_stats OWNER TO thommcgrath;

--
-- Name: deletions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.deletions (
    object_id uuid NOT NULL,
    from_table public.citext NOT NULL,
    label public.citext NOT NULL,
    min_version integer NOT NULL,
    action_time timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    tag text
);


ALTER TABLE public.deletions OWNER TO thommcgrath;

--
-- Name: diet_contents; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.diet_contents (
    diet_entry_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    diet_id uuid NOT NULL,
    engram_id uuid NOT NULL,
    preference_order integer NOT NULL
);


ALTER TABLE public.diet_contents OWNER TO thommcgrath;

--
-- Name: diets; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.diets (
)
INHERITS (public.objects);


ALTER TABLE public.diets OWNER TO thommcgrath;

--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.email_addresses (
    email_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    address text NOT NULL,
    group_key public.hex NOT NULL,
    group_key_precision integer NOT NULL
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
-- Name: event_colors; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.event_colors (
    event_id uuid NOT NULL,
    color_id integer NOT NULL
);


ALTER TABLE public.event_colors OWNER TO thommcgrath;

--
-- Name: event_engrams; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.event_engrams (
    event_id uuid NOT NULL,
    object_id uuid NOT NULL
);


ALTER TABLE public.event_engrams OWNER TO thommcgrath;

--
-- Name: event_rates; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.event_rates (
    event_id uuid NOT NULL,
    ini_option uuid NOT NULL,
    multiplier numeric(8,4) NOT NULL
);


ALTER TABLE public.event_rates OWNER TO thommcgrath;

--
-- Name: events; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.events (
    event_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    event_name public.citext NOT NULL,
    event_code public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.events OWNER TO thommcgrath;

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
-- Name: game_variables; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.game_variables (
    key text NOT NULL,
    value text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.game_variables OWNER TO thommcgrath;

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
-- Name: ini_options; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.ini_options (
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
    CONSTRAINT ini_options_check CHECK ((((nitrado_path IS NULL) AND (nitrado_format IS NULL) AND (nitrado_deploy_style IS NULL)) OR ((nitrado_path IS NOT NULL) AND (nitrado_format IS NOT NULL) AND (nitrado_deploy_style IS NOT NULL)))),
    CONSTRAINT ini_options_check1 CHECK (((file IS DISTINCT FROM 'CommandLineFlag'::public.ini_file) OR ((file = 'CommandLineFlag'::public.ini_file) AND (value_type = 'Boolean'::public.ini_value_type)))),
    CONSTRAINT ini_options_max_allowed_check CHECK (((max_allowed IS NULL) OR (max_allowed >= 1)))
)
INHERITS (public.objects);


ALTER TABLE public.ini_options OWNER TO thommcgrath;

--
-- Name: loot_source_icons; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.loot_source_icons (
    icon_data bytea NOT NULL
)
INHERITS (public.objects);


ALTER TABLE public.loot_source_icons OWNER TO thommcgrath;

--
-- Name: maps; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.maps (
    map_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    mod_id uuid NOT NULL,
    label public.citext NOT NULL,
    ark_identifier text NOT NULL,
    difficulty_scale numeric(8,4) NOT NULL,
    official boolean NOT NULL,
    mask bigint NOT NULL,
    sort integer NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT maps_mask_check CHECK ((ceiling(log((2)::numeric, (mask)::numeric)) = floor(log((2)::numeric, (mask)::numeric))))
);


ALTER TABLE public.maps OWNER TO thommcgrath;

--
-- Name: mods; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.mods (
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


ALTER TABLE public.mods OWNER TO thommcgrath;

--
-- Name: updates; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.updates (
    update_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    build_number integer NOT NULL,
    build_display text NOT NULL,
    notes text NOT NULL,
    mac_url text NOT NULL,
    mac_signature public.citext NOT NULL,
    preview text DEFAULT ''::text NOT NULL,
    stage integer DEFAULT 0 NOT NULL,
    win_64_url text,
    win_32_url text,
    win_combo_url text,
    win_64_signature text,
    win_32_signature text,
    win_combo_signature text,
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
    blog_articles.last_updated AS moment,
    NULL::text AS mac_os_version,
    NULL::text AS win_os_version,
    3 AS stage
   FROM public.blog_articles
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
-- Name: preset_modifiers; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.preset_modifiers (
    pattern text NOT NULL
)
INHERITS (public.objects);


ALTER TABLE public.preset_modifiers OWNER TO thommcgrath;

--
-- Name: presets; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.presets (
    contents jsonb NOT NULL
)
INHERITS (public.objects);


ALTER TABLE public.presets OWNER TO thommcgrath;

--
-- Name: products; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.products (
    product_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    product_name text NOT NULL,
    retail_price numeric(6,2) NOT NULL,
    stripe_sku text NOT NULL,
    child_seat_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.products OWNER TO thommcgrath;

--
-- Name: purchase_code_log; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_code_log (
    log_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    code public.citext NOT NULL,
    user_id uuid NOT NULL,
    attempt_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    source_ip inet NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.purchase_code_log OWNER TO thommcgrath;

--
-- Name: purchase_codes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_codes (
    code public.citext NOT NULL,
    source text,
    creation_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    redemption_date timestamp with time zone,
    redemption_purchase_id uuid,
    purchaser_email_id uuid NOT NULL
);


ALTER TABLE public.purchase_codes OWNER TO thommcgrath;

--
-- Name: purchase_items; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_items (
    line_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    retail_price numeric(6,2) NOT NULL,
    discount numeric(6,2) NOT NULL,
    quantity numeric(6,0) NOT NULL,
    line_total numeric(6,2) NOT NULL
);


ALTER TABLE public.purchase_items OWNER TO thommcgrath;

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
    tax_locality text
);


ALTER TABLE public.purchases OWNER TO thommcgrath;

--
-- Name: purchased_products; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.purchased_products AS
 SELECT products.product_id,
    products.product_name,
    purchases.purchaser_email,
    purchases.purchase_id,
    purchases.client_reference_id,
    (((products.child_seat_count)::numeric * purchase_items.quantity))::integer AS child_seat_count
   FROM (public.purchases
     JOIN (public.purchase_items
     JOIN public.products ON ((purchase_items.product_id = products.product_id))) ON ((purchase_items.purchase_id = purchases.purchase_id)))
  WHERE (purchases.refunded = false);


ALTER TABLE public.purchased_products OWNER TO thommcgrath;

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
    COALESCE(support_articles.preview, support_articles.content_markdown, ''::public.citext) AS body,
    (((setweight(to_tsvector((support_articles.subject)::text), 'A'::"char") || ''::tsvector) || setweight(to_tsvector((COALESCE(support_articles.content_markdown, support_articles.preview, ''::public.citext))::text), 'B'::"char")) || setweight(to_tsvector((support_articles.affected_ini_keys)::text), 'C'::"char")) AS lexemes,
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
    setweight(to_tsvector((support_videos.video_title)::text), 'A'::"char") AS lexemes,
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
    setweight(to_tsvector((((blueprints.label)::text || ' '::text) || (COALESCE(blueprints.alternate_label, ''::public.citext))::text)), 'B'::"char") AS lexemes,
    'Object'::text AS type,
    (( SELECT pg_class.relname
           FROM pg_class
          WHERE (pg_class.oid = blueprints.tableoid)))::text AS subtype,
    ('/object/'::text || (blueprints.object_id)::text) AS uri,
    blueprints.min_version,
    99999999 AS max_version,
    blueprints.mod_id
   FROM public.blueprints
UNION
 SELECT mods.mod_id AS id,
    mods.name AS title,
    ''::text AS body,
    setweight(to_tsvector(mods.name), 'D'::"char") AS lexemes,
    'Mod'::text AS type,
    ''::text AS subtype,
    ('/mods/'::text || mods.mod_id) AS uri,
    0 AS min_version,
    99999999 AS max_version,
    mods.mod_id
   FROM public.mods
  WHERE (mods.confirmed = true)
UNION
 SELECT documents.document_id AS id,
    documents.title,
    documents.description AS body,
    ((setweight(to_tsvector(documents.title), 'C'::"char") || ''::tsvector) || setweight(to_tsvector(documents.description), 'D'::"char")) AS lexemes,
    'Document'::text AS type,
    ''::text AS subtype,
    ('/browse/'::text || documents.document_id) AS uri,
    0 AS min_version,
    99999999 AS max_version,
    NULL::uuid AS mod_id
   FROM public.documents
  WHERE (documents.published = 'Approved'::public.publish_status);


ALTER TABLE public.search_contents OWNER TO thommcgrath;

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
-- Name: spawn_point_limits; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_point_limits (
    spawn_point_id uuid NOT NULL,
    creature_id uuid NOT NULL,
    max_percentage numeric(5,4)
);


ALTER TABLE public.spawn_point_limits OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entries; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_point_set_entries (
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


ALTER TABLE public.spawn_point_set_entries OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entry_levels; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_point_set_entry_levels (
    spawn_point_set_entry_level_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_entry_id uuid NOT NULL,
    difficulty numeric(16,6) NOT NULL,
    min_level numeric(16,6) NOT NULL,
    max_level numeric(16,6) NOT NULL
);


ALTER TABLE public.spawn_point_set_entry_levels OWNER TO thommcgrath;

--
-- Name: spawn_point_set_replacements; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_point_set_replacements (
    spawn_point_set_replacement_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_id uuid NOT NULL,
    target_creature_id uuid NOT NULL,
    replacement_creature_id uuid NOT NULL,
    weight numeric(16,6) NOT NULL
);


ALTER TABLE public.spawn_point_set_replacements OWNER TO thommcgrath;

--
-- Name: spawn_point_sets; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.spawn_point_sets (
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


ALTER TABLE public.spawn_point_sets OWNER TO thommcgrath;

--
-- Name: stw_applicants; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.stw_applicants (
    applicant_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    encrypted_email text,
    email_id uuid NOT NULL,
    generated_purchase_id uuid,
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
-- Name: creatures object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: creatures min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: creatures last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: creatures mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: creatures tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: diets object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: diets min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: diets last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: diets mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: diets tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: engrams object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: engrams min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: engrams last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: engrams mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: engrams tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: ini_options object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: ini_options min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: ini_options last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: ini_options mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: ini_options tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_source_icons object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: loot_source_icons min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: loot_source_icons last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_source_icons mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: loot_source_icons tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_sources object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: loot_sources min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: loot_sources last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_sources mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: loot_sources tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: preset_modifiers object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: preset_modifiers min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: preset_modifiers last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: preset_modifiers mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: preset_modifiers tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: presets object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: presets min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: presets last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: presets mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: presets tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: spawn_points object_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: spawn_points min_version; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points ALTER COLUMN min_version SET DEFAULT 0;


--
-- Name: spawn_points last_update; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: spawn_points mod_id; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points ALTER COLUMN mod_id SET DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid;


--
-- Name: spawn_points tags; Type: DEFAULT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


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
-- Name: color_sets color_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.color_sets
    ADD CONSTRAINT color_sets_pkey PRIMARY KEY (color_set_id);


--
-- Name: colors colors_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (color_id);


--
-- Name: corrupt_files corrupt_files_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.corrupt_files
    ADD CONSTRAINT corrupt_files_pkey PRIMARY KEY (file_id);


--
-- Name: crafting_costs crafting_costs_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.crafting_costs
    ADD CONSTRAINT crafting_costs_pkey PRIMARY KEY (engram_id, ingredient_id);


--
-- Name: creature_engrams creature_engrams_creature_id_engram_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_engram_id_key UNIQUE (creature_id, engram_id);


--
-- Name: creature_engrams creature_engrams_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_engrams
    ADD CONSTRAINT creature_engrams_pkey PRIMARY KEY (relation_id);


--
-- Name: creature_stats creature_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_stats
    ADD CONSTRAINT creature_stats_pkey PRIMARY KEY (creature_id, stat_index);


--
-- Name: creatures creatures_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_pkey PRIMARY KEY (object_id);


--
-- Name: deletions deletions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.deletions
    ADD CONSTRAINT deletions_pkey PRIMARY KEY (object_id, from_table);


--
-- Name: diet_contents diet_contents_diet_id_engram_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_engram_id_key UNIQUE (diet_id, engram_id);


--
-- Name: diet_contents diet_contents_diet_id_preference_order_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_preference_order_key UNIQUE (diet_id, preference_order);


--
-- Name: diet_contents diet_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diet_contents
    ADD CONSTRAINT diet_contents_pkey PRIMARY KEY (diet_entry_id);


--
-- Name: diets diets_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT diets_pkey PRIMARY KEY (object_id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);


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
-- Name: engrams engrams_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams
    ADD CONSTRAINT engrams_pkey PRIMARY KEY (object_id);


--
-- Name: event_colors event_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_colors
    ADD CONSTRAINT event_colors_pkey PRIMARY KEY (event_id, color_id);


--
-- Name: event_rates event_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_rates
    ADD CONSTRAINT event_rates_pkey PRIMARY KEY (event_id, ini_option);


--
-- Name: events events_event_code_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_event_code_key UNIQUE (event_code);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


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
-- Name: game_variables game_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.game_variables
    ADD CONSTRAINT game_variables_pkey PRIMARY KEY (key);


--
-- Name: guest_documents guest_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_documents
    ADD CONSTRAINT guest_documents_pkey PRIMARY KEY (document_id, user_id);


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
-- Name: ini_options ini_options_file_header_key_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options
    ADD CONSTRAINT ini_options_file_header_key_key UNIQUE (file, header, key);


--
-- Name: ini_options ini_options_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options
    ADD CONSTRAINT ini_options_pkey PRIMARY KEY (object_id);


--
-- Name: loot_source_icons loot_source_icons_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons
    ADD CONSTRAINT loot_source_icons_pkey PRIMARY KEY (object_id);


--
-- Name: loot_sources loot_sources_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_pkey1 PRIMARY KEY (object_id);


--
-- Name: maps maps_ark_identifier_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_ark_identifier_key UNIQUE (ark_identifier);


--
-- Name: maps maps_mask_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_mask_key UNIQUE (mask);


--
-- Name: maps maps_mod_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_mod_id_key UNIQUE (mod_id);


--
-- Name: maps maps_official_sort_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_official_sort_key UNIQUE (official, sort);


--
-- Name: maps maps_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (map_id);


--
-- Name: mods mods_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.mods
    ADD CONSTRAINT mods_pkey PRIMARY KEY (mod_id);


--
-- Name: mods mods_prefix_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.mods
    ADD CONSTRAINT mods_prefix_key UNIQUE (prefix);


--
-- Name: mods mods_tag_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.mods
    ADD CONSTRAINT mods_tag_key UNIQUE (tag);


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
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (object_id);


--
-- Name: preset_modifiers preset_modifiers_pattern_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers
    ADD CONSTRAINT preset_modifiers_pattern_key UNIQUE (pattern);


--
-- Name: preset_modifiers preset_modifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers
    ADD CONSTRAINT preset_modifiers_pkey PRIMARY KEY (object_id);


--
-- Name: presets presets_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets
    ADD CONSTRAINT presets_pkey PRIMARY KEY (object_id);


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
-- Name: purchase_code_log purchase_code_log_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_code_log
    ADD CONSTRAINT purchase_code_log_pkey PRIMARY KEY (log_id);


--
-- Name: purchase_codes purchase_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes
    ADD CONSTRAINT purchase_codes_pkey PRIMARY KEY (code);


--
-- Name: purchase_items purchase_items_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
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
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: spawn_point_limits spawn_point_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_pkey PRIMARY KEY (spawn_point_id, creature_id);


--
-- Name: spawn_point_set_entries spawn_point_set_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_pkey PRIMARY KEY (spawn_point_set_entry_id);


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_pkey PRIMARY KEY (spawn_point_set_entry_level_id);


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_pkey PRIMARY KEY (spawn_point_set_replacement_id);


--
-- Name: spawn_point_sets spawn_point_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_pkey PRIMARY KEY (spawn_point_set_id);


--
-- Name: spawn_points spawn_points_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points
    ADD CONSTRAINT spawn_points_pkey PRIMARY KEY (object_id);


--
-- Name: stw_applicants stw_applicants_email_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_applicants
    ADD CONSTRAINT stw_applicants_email_id_key UNIQUE (email_id);


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
-- Name: creatures_class_string_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX creatures_class_string_idx ON public.creatures USING btree (class_string);


--
-- Name: creatures_group_key_group_master_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_group_key_group_master_idx ON public.creatures USING btree (group_key, group_master) WHERE (group_master = true);


--
-- Name: creatures_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_mod_id_class_string_legacy_uidx ON public.creatures USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: creatures_mod_id_path_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_mod_id_path_uidx ON public.creatures USING btree (mod_id, path);


--
-- Name: creatures_path_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX creatures_path_idx ON public.creatures USING btree (path);


--
-- Name: creatures_path_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_path_legacy_uidx ON public.creatures USING btree (path) WHERE (min_version < 10500000);


--
-- Name: email_addresses_group_key_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX email_addresses_group_key_idx ON public.email_addresses USING btree (group_key);


--
-- Name: engrams_class_string_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX engrams_class_string_idx ON public.engrams USING btree (class_string);


--
-- Name: engrams_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_mod_id_class_string_legacy_uidx ON public.engrams USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: engrams_mod_id_path_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_mod_id_path_uidx ON public.engrams USING btree (mod_id, path);


--
-- Name: engrams_path_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX engrams_path_idx ON public.engrams USING btree (path);


--
-- Name: engrams_path_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_path_legacy_uidx ON public.engrams USING btree (path) WHERE (min_version < 10500000);


--
-- Name: exception_users_exception_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX exception_users_exception_id_user_id_idx ON public.exception_users USING btree (exception_id, user_id);


--
-- Name: imported_obelisk_files_path_version_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX imported_obelisk_files_path_version_uidx ON public.imported_obelisk_files USING btree (path, version);


--
-- Name: loot_sources_class_string_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX loot_sources_class_string_idx ON public.loot_sources USING btree (class_string);


--
-- Name: loot_sources_mod_id_class_string_legacy_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_mod_id_class_string_legacy_idx ON public.loot_sources USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: loot_sources_mod_id_path_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_mod_id_path_idx ON public.loot_sources USING btree (mod_id, path);


--
-- Name: loot_sources_path_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX loot_sources_path_idx ON public.loot_sources USING btree (path);


--
-- Name: loot_sources_path_legacy_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_path_legacy_idx ON public.loot_sources USING btree (path) WHERE (min_version < 10500000);


--
-- Name: loot_sources_sort_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_sources_sort_idx ON public.loot_sources USING btree (sort);


--
-- Name: mods_workshop_id_confirmed_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_confirmed_uidx ON public.mods USING btree (abs(workshop_id), confirmed) WHERE (confirmed = true);


--
-- Name: mods_workshop_id_user_id_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_user_id_uidx ON public.mods USING btree (abs(workshop_id), user_id);


--
-- Name: purchases_purchaser_email_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX purchases_purchaser_email_idx ON public.purchases USING btree (purchaser_email);


--
-- Name: spawn_point_set_entry_levels_unique_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_entry_levels_unique_idx ON public.spawn_point_set_entry_levels USING btree (spawn_point_set_entry_id, difficulty);


--
-- Name: spawn_point_set_replacements_unique_replacement_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_replacements_unique_replacement_idx ON public.spawn_point_set_replacements USING btree (spawn_point_set_id, target_creature_id, replacement_creature_id);


--
-- Name: spawn_points_class_string_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX spawn_points_class_string_idx ON public.spawn_points USING btree (class_string);


--
-- Name: spawn_points_mod_id_class_string_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_mod_id_class_string_legacy_uidx ON public.spawn_points USING btree (mod_id, class_string) WHERE (min_version < 10500000);


--
-- Name: spawn_points_mod_id_path_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_mod_id_path_uidx ON public.spawn_points USING btree (mod_id, path);


--
-- Name: spawn_points_path_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX spawn_points_path_idx ON public.spawn_points USING btree (path);


--
-- Name: spawn_points_path_legacy_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_path_legacy_uidx ON public.spawn_points USING btree (path) WHERE (min_version < 10500000);


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
-- Name: computed_engram_availabilities _RETURN; Type: RULE; Schema: public; Owner: thommcgrath
--

CREATE OR REPLACE VIEW public.computed_engram_availabilities AS
 SELECT engrams.object_id,
    engrams.class_string,
    bit_or(creatures.availability) AS availability
   FROM public.creature_engrams,
    public.creatures,
    public.engrams
  WHERE ((creature_engrams.creature_id = creatures.object_id) AND (creature_engrams.engram_id = engrams.object_id))
  GROUP BY engrams.object_id;


--
-- Name: client_notices client_notices_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER client_notices_before_update_trigger BEFORE INSERT OR UPDATE ON public.client_notices FOR EACH ROW EXECUTE FUNCTION public.generic_update_trigger();


--
-- Name: color_sets color_sets_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER color_sets_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.color_sets FOR EACH ROW EXECUTE FUNCTION public.update_color_set_last_update();


--
-- Name: colors colors_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER colors_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.colors FOR EACH ROW EXECUTE FUNCTION public.update_color_last_update();


--
-- Name: crafting_costs crafting_costs_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER crafting_costs_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.crafting_costs FOR EACH ROW EXECUTE FUNCTION public.update_engram_timestamp();


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
-- Name: creature_stats creature_stats_update_creature_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creature_stats_update_creature_trigger AFTER INSERT OR DELETE OR UPDATE ON public.creature_stats FOR EACH ROW EXECUTE FUNCTION public.update_creature_modified();


--
-- Name: creatures creatures_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON public.creatures FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: creatures creatures_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON public.creatures FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: creatures creatures_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON public.creatures FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: creatures creatures_compute_class_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON public.creatures FOR EACH ROW EXECUTE FUNCTION public.compute_class_trigger();


--
-- Name: diets diets_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_after_delete_trigger AFTER DELETE ON public.diets FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: diets diets_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_before_insert_trigger BEFORE INSERT ON public.diets FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: diets diets_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_before_update_trigger BEFORE UPDATE ON public.diets FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: mods enforce_mod_owner; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER enforce_mod_owner BEFORE INSERT OR UPDATE ON public.mods FOR EACH ROW EXECUTE FUNCTION public.enforce_mod_owner();


--
-- Name: engrams engrams_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON public.engrams FOR EACH ROW EXECUTE FUNCTION public.engram_delete_trigger();


--
-- Name: engrams engrams_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON public.engrams FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: engrams engrams_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON public.engrams FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: engrams engrams_compute_class_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON public.engrams FOR EACH ROW EXECUTE FUNCTION public.compute_class_trigger();


--
-- Name: event_colors event_colors_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER event_colors_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON public.event_colors FOR EACH ROW EXECUTE FUNCTION public.update_event_last_update_from_children();


--
-- Name: event_engrams event_engrams_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER event_engrams_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON public.event_engrams FOR EACH ROW EXECUTE FUNCTION public.update_event_last_update_from_children();


--
-- Name: event_rates event_rates_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER event_rates_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON public.event_rates FOR EACH ROW EXECUTE FUNCTION public.update_event_last_update_from_children();


--
-- Name: events events_modified_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER events_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION public.update_event_last_update();


--
-- Name: game_variables game_variables_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON public.game_variables FOR EACH ROW EXECUTE FUNCTION public.generic_update_trigger();


--
-- Name: help_topics help_topics_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER help_topics_before_update_trigger BEFORE INSERT OR UPDATE ON public.help_topics FOR EACH ROW EXECUTE FUNCTION public.generic_update_trigger();


--
-- Name: ini_options ini_options_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER ini_options_after_delete_trigger AFTER DELETE ON public.ini_options FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: ini_options ini_options_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_insert_trigger BEFORE INSERT ON public.ini_options FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: ini_options ini_options_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_update_trigger BEFORE UPDATE ON public.ini_options FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: loot_source_icons loot_source_icons_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_after_delete_trigger AFTER DELETE ON public.loot_source_icons FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: loot_source_icons loot_source_icons_after_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_after_update_trigger AFTER UPDATE ON public.loot_source_icons FOR EACH ROW EXECUTE FUNCTION public.loot_source_icons_update_loot_source();


--
-- Name: loot_source_icons loot_source_icons_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_insert_trigger BEFORE INSERT ON public.loot_source_icons FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: loot_source_icons loot_source_icons_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_update_trigger BEFORE UPDATE ON public.loot_source_icons FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: loot_sources loot_sources_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON public.loot_sources FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: loot_sources loot_sources_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON public.loot_sources FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: loot_sources loot_sources_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON public.loot_sources FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: maps maps_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER maps_before_update_trigger BEFORE INSERT OR UPDATE ON public.maps FOR EACH ROW EXECUTE FUNCTION public.update_last_update_column();


--
-- Name: mods mods_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER mods_after_delete_trigger AFTER DELETE ON public.mods FOR EACH ROW EXECUTE FUNCTION public.mods_delete_trigger();


--
-- Name: mods mods_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER mods_before_update_trigger BEFORE INSERT OR UPDATE ON public.mods FOR EACH ROW EXECUTE FUNCTION public.generic_update_trigger();


--
-- Name: preset_modifiers preset_modifiers_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_after_delete_trigger AFTER DELETE ON public.preset_modifiers FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_insert_trigger BEFORE INSERT ON public.preset_modifiers FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_update_trigger BEFORE UPDATE ON public.preset_modifiers FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: presets presets_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON public.presets FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: presets presets_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON public.presets FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: presets presets_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON public.presets FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: presets presets_json_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_json_sync_trigger BEFORE INSERT OR UPDATE ON public.presets FOR EACH ROW EXECUTE FUNCTION public.presets_json_sync_function();


--
-- Name: spawn_point_limits spawn_point_limits_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_limits_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.spawn_point_limits FOR EACH ROW EXECUTE FUNCTION public.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entries spawn_point_set_entries_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entries_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.spawn_point_set_entries FOR EACH ROW EXECUTE FUNCTION public.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entry_levels_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.spawn_point_set_entry_levels FOR EACH ROW EXECUTE FUNCTION public.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_replacements_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.spawn_point_set_replacements FOR EACH ROW EXECUTE FUNCTION public.update_spawn_point_timestamp();


--
-- Name: spawn_point_sets spawn_point_sets_update_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_sets_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON public.spawn_point_sets FOR EACH ROW EXECUTE FUNCTION public.update_spawn_point_timestamp();


--
-- Name: spawn_points spawn_points_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_after_delete_trigger AFTER DELETE ON public.spawn_points FOR EACH ROW EXECUTE FUNCTION public.object_delete_trigger();


--
-- Name: spawn_points spawn_points_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_insert_trigger BEFORE INSERT ON public.spawn_points FOR EACH ROW EXECUTE FUNCTION public.object_insert_trigger();


--
-- Name: spawn_points spawn_points_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_update_trigger BEFORE UPDATE ON public.spawn_points FOR EACH ROW EXECUTE FUNCTION public.object_update_trigger();


--
-- Name: spawn_points spawn_points_compute_class_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_compute_class_trigger BEFORE INSERT OR UPDATE ON public.spawn_points FOR EACH ROW EXECUTE FUNCTION public.compute_class_trigger();


--
-- Name: blog_articles update_blog_article_hash_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_hash_trigger BEFORE INSERT OR UPDATE ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_hash();


--
-- Name: blog_articles update_blog_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_timestamp_trigger BEFORE INSERT OR UPDATE ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_timestamp();


--
-- Name: support_article_modules update_support_article_module_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_article_module_timestamp_trigger BEFORE INSERT OR UPDATE ON public.support_article_modules FOR EACH ROW EXECUTE FUNCTION public.update_support_article_module_timestamp();


--
-- Name: support_articles update_support_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_article_timestamp_trigger BEFORE INSERT OR UPDATE ON public.support_articles FOR EACH ROW EXECUTE FUNCTION public.update_support_article_timestamp();


--
-- Name: support_images update_support_image_associations_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_image_associations_trigger BEFORE INSERT OR UPDATE ON public.support_images FOR EACH ROW EXECUTE FUNCTION public.update_support_image_associations();


--
-- Name: crafting_costs crafting_costs_engram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.crafting_costs
    ADD CONSTRAINT crafting_costs_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES public.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: crafting_costs crafting_costs_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.crafting_costs
    ADD CONSTRAINT crafting_costs_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.engrams(object_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creature_engrams creature_engrams_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creature_engrams creature_engrams_engram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_engrams
    ADD CONSTRAINT creature_engrams_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES public.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creature_stats creature_stats_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creature_stats
    ADD CONSTRAINT creature_stats_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creatures creatures_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creatures creatures_tamed_diet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_tamed_diet_fkey FOREIGN KEY (tamed_diet) REFERENCES public.diets(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: creatures creatures_taming_diet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_taming_diet_fkey FOREIGN KEY (taming_diet) REFERENCES public.diets(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: diet_contents diet_contents_diet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diet_contents
    ADD CONSTRAINT diet_contents_diet_id_fkey FOREIGN KEY (diet_id) REFERENCES public.diets(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: diet_contents diet_contents_engram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diet_contents
    ADD CONSTRAINT diet_contents_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES public.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: diets diets_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT diets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: documents documents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: email_verification email_verification_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification
    ADD CONSTRAINT email_verification_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: engrams engrams_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams
    ADD CONSTRAINT engrams_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_colors event_colors_color_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_colors
    ADD CONSTRAINT event_colors_color_id_fkey FOREIGN KEY (color_id) REFERENCES public.colors(color_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: event_colors event_colors_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_colors
    ADD CONSTRAINT event_colors_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_engrams
    ADD CONSTRAINT event_engrams_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_engrams
    ADD CONSTRAINT event_engrams_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_rates
    ADD CONSTRAINT event_rates_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_ini_option_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.event_rates
    ADD CONSTRAINT event_rates_ini_option_fkey FOREIGN KEY (ini_option) REFERENCES public.ini_options(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: guest_documents guest_documents_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_documents
    ADD CONSTRAINT guest_documents_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(document_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: guest_documents guest_documents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.guest_documents
    ADD CONSTRAINT guest_documents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ini_options ini_options_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.ini_options
    ADD CONSTRAINT ini_options_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: loot_source_icons loot_source_icons_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons
    ADD CONSTRAINT loot_source_icons_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: loot_sources loot_sources_icon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_icon_fkey FOREIGN KEY (icon) REFERENCES public.loot_source_icons(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: loot_sources loot_sources_mod_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_mod_id_fkey1 FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: maps maps_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.maps
    ADD CONSTRAINT maps_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mods mods_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.mods
    ADD CONSTRAINT mods_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: oauth_tokens oauth_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT oauth_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: objects objects_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.objects
    ADD CONSTRAINT objects_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: preset_modifiers preset_modifiers_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.preset_modifiers
    ADD CONSTRAINT preset_modifiers_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: presets presets_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.presets
    ADD CONSTRAINT presets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: purchase_code_log purchase_code_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_code_log
    ADD CONSTRAINT purchase_code_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase_codes purchase_codes_purchaser_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes
    ADD CONSTRAINT purchase_codes_purchaser_email_id_fkey FOREIGN KEY (purchaser_email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_codes purchase_codes_redemption_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_codes
    ADD CONSTRAINT purchase_codes_redemption_purchase_id_fkey FOREIGN KEY (redemption_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_items purchase_items_product_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
    ADD CONSTRAINT purchase_items_product_id_fkey1 FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: purchase_items purchase_items_purchase_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.purchase_items
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
-- Name: spawn_point_limits spawn_point_limits_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_limits spawn_point_limits_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES public.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES public.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey FOREIGN KEY (spawn_point_set_entry_id) REFERENCES public.spawn_point_set_entries(spawn_point_set_entry_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_replacement_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_replacement_creature_id_fkey FOREIGN KEY (replacement_creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES public.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_target_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_target_creature_id_fkey FOREIGN KEY (target_creature_id) REFERENCES public.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: spawn_point_sets spawn_point_sets_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES public.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_points spawn_points_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.spawn_points
    ADD CONSTRAINT spawn_points_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.mods(mod_id) ON UPDATE CASCADE ON DELETE CASCADE;


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
-- Name: TABLE documents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.documents TO thezaz_website;


--
-- Name: TABLE guest_documents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.guest_documents TO thezaz_website;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO thezaz_website;


--
-- Name: TABLE allowed_documents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.allowed_documents TO thezaz_website;


--
-- Name: TABLE blog_articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.blog_articles TO thezaz_website;


--
-- Name: TABLE objects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.objects TO thezaz_website;


--
-- Name: TABLE creatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creatures TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creatures TO beacon_updater;


--
-- Name: TABLE engrams; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.engrams TO beacon_updater;


--
-- Name: TABLE loot_sources; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.loot_sources TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.loot_sources TO beacon_updater;


--
-- Name: TABLE spawn_points; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_points TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_points TO beacon_updater;


--
-- Name: TABLE blueprints; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.blueprints TO thezaz_website;
GRANT SELECT ON TABLE public.blueprints TO beacon_updater;


--
-- Name: TABLE client_notices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.client_notices TO thezaz_website;


--
-- Name: TABLE color_sets; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.color_sets TO thezaz_website;


--
-- Name: TABLE colors; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.colors TO thezaz_website;


--
-- Name: TABLE computed_engram_availabilities; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.computed_engram_availabilities TO thezaz_website;


--
-- Name: TABLE corrupt_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.corrupt_files TO thezaz_website;


--
-- Name: TABLE crafting_costs; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.crafting_costs TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.crafting_costs TO beacon_updater;


--
-- Name: TABLE creature_engrams; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creature_engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creature_engrams TO beacon_updater;


--
-- Name: TABLE creature_stats; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creature_stats TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creature_stats TO beacon_updater;


--
-- Name: TABLE deletions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.deletions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.deletions TO beacon_updater;


--
-- Name: TABLE diet_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.diet_contents TO thezaz_website;


--
-- Name: TABLE diets; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.diets TO thezaz_website;


--
-- Name: TABLE email_addresses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_addresses TO thezaz_website;


--
-- Name: TABLE email_verification; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_verification TO thezaz_website;


--
-- Name: TABLE event_colors; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.event_colors TO thezaz_website;


--
-- Name: TABLE event_engrams; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.event_engrams TO thezaz_website;


--
-- Name: TABLE event_rates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.event_rates TO thezaz_website;


--
-- Name: TABLE events; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.events TO thezaz_website;


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
-- Name: TABLE game_variables; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.game_variables TO thezaz_website;


--
-- Name: TABLE help_topics; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.help_topics TO thezaz_website;


--
-- Name: TABLE imported_obelisk_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.imported_obelisk_files TO beacon_updater;


--
-- Name: TABLE ini_options; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ini_options TO thezaz_website;


--
-- Name: TABLE loot_source_icons; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.loot_source_icons TO thezaz_website;


--
-- Name: TABLE maps; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.maps TO thezaz_website;
GRANT SELECT ON TABLE public.maps TO beacon_updater;


--
-- Name: TABLE mods; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.mods TO thezaz_website;
GRANT SELECT ON TABLE public.mods TO beacon_updater;


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
-- Name: TABLE preset_modifiers; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.preset_modifiers TO thezaz_website;


--
-- Name: TABLE presets; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.presets TO thezaz_website;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.products TO thezaz_website;


--
-- Name: TABLE purchase_code_log; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.purchase_code_log TO thezaz_website;


--
-- Name: TABLE purchase_codes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.purchase_codes TO thezaz_website;


--
-- Name: TABLE purchase_items; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.purchase_items TO thezaz_website;


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
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sessions TO thezaz_website;


--
-- Name: TABLE spawn_point_limits; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_limits TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_limits TO beacon_updater;


--
-- Name: TABLE spawn_point_set_entries; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_entries TO beacon_updater;


--
-- Name: TABLE spawn_point_set_entry_levels; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_entry_levels TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_entry_levels TO beacon_updater;


--
-- Name: TABLE spawn_point_set_replacements; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_replacements TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_set_replacements TO beacon_updater;


--
-- Name: TABLE spawn_point_sets; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.spawn_point_sets TO beacon_updater;


--
-- Name: TABLE stw_applicants; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.stw_applicants TO thezaz_website;


--
-- Name: TABLE stw_purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.stw_purchases TO thezaz_website;


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
-- Name: TABLE wordlist; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.wordlist TO thezaz_website;


--
-- PostgreSQL database dump complete
--

