--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Ubuntu 17.4-1.pgdg22.04+2)
-- Dumped by pg_dump version 17.4 (Ubuntu 17.4-1.pgdg22.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: arksa; Type: SCHEMA; Schema: -; Owner: thommcgrath
--

CREATE SCHEMA arksa;


ALTER SCHEMA arksa OWNER TO thommcgrath;

--
-- Name: palworld; Type: SCHEMA; Schema: -; Owner: thommcgrath
--

CREATE SCHEMA palworld;


ALTER SCHEMA palworld OWNER TO thommcgrath;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: sdtd; Type: SCHEMA; Schema: -; Owner: thommcgrath
--

CREATE SCHEMA sdtd;


ALTER SCHEMA sdtd OWNER TO thommcgrath;

--
-- Name: sentinel; Type: SCHEMA; Schema: -; Owner: thommcgrath
--

CREATE SCHEMA sentinel;


ALTER SCHEMA sentinel OWNER TO thommcgrath;

--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


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
-- Name: loot_quality_tier; Type: TYPE; Schema: arksa; Owner: thommcgrath
--

CREATE TYPE arksa.loot_quality_tier AS ENUM (
    'Tier0',
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


ALTER TYPE arksa.loot_quality_tier OWNER TO thommcgrath;

--
-- Name: map_type; Type: TYPE; Schema: arksa; Owner: thommcgrath
--

CREATE TYPE arksa.map_type AS ENUM (
    'Official Canon',
    'Official Non-Canon',
    'Third Party'
);


ALTER TYPE arksa.map_type OWNER TO thommcgrath;

--
-- Name: config_file; Type: TYPE; Schema: palworld; Owner: thommcgrath
--

CREATE TYPE palworld.config_file AS ENUM (
    'PalWorldSettings.ini'
);


ALTER TYPE palworld.config_file OWNER TO thommcgrath;

--
-- Name: article_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.article_type AS ENUM (
    'Blog',
    'Help'
);


ALTER TYPE public.article_type OWNER TO thommcgrath;

--
-- Name: authenticator_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.authenticator_type AS ENUM (
    'TOTP'
);


ALTER TYPE public.authenticator_type OWNER TO thommcgrath;

--
-- Name: color; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.color AS ENUM (
    'None',
    'Blue',
    'Brown',
    'Grey',
    'Green',
    'Indigo',
    'Orange',
    'Pink',
    'Purple',
    'Red',
    'Teal',
    'Yellow'
);


ALTER TYPE public.color OWNER TO thommcgrath;

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
    'Ark',
    '7DaysToDie',
    'ArkSA',
    'Palworld'
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
-- Name: marketplace; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.marketplace AS ENUM (
    'Steam',
    'Steam Workshop',
    'CurseForge'
);


ALTER TYPE public.marketplace OWNER TO thommcgrath;

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
-- Name: product_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.product_type AS ENUM (
    'One-Time',
    'Subscription'
);


ALTER TYPE public.product_type OWNER TO thommcgrath;

--
-- Name: project_role; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.project_role AS ENUM (
    'Owner',
    'Admin',
    'Editor',
    'Guest'
);


ALTER TYPE public.project_role OWNER TO thommcgrath;

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
-- Name: token_provider; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.token_provider AS ENUM (
    'Nitrado',
    'GameServerApp.com'
);


ALTER TYPE public.token_provider OWNER TO thommcgrath;

--
-- Name: token_type; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.token_type AS ENUM (
    'OAuth',
    'Static'
);


ALTER TYPE public.token_type OWNER TO thommcgrath;

--
-- Name: ui_color; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.ui_color AS ENUM (
    'White',
    'Green',
    'Blue',
    'Purple',
    'Yellow',
    'Red',
    'Cyan',
    'Orange'
);


ALTER TYPE public.ui_color OWNER TO thommcgrath;

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
-- Name: config_option_value_type; Type: TYPE; Schema: sdtd; Owner: thommcgrath
--

CREATE TYPE sdtd.config_option_value_type AS ENUM (
    'Numeric',
    'Boolean',
    'Text'
);


ALTER TYPE sdtd.config_option_value_type OWNER TO thommcgrath;

--
-- Name: chat_message_origin; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.chat_message_origin AS ENUM (
    'Game',
    'WebGroup',
    'WebService',
    'Discord',
    'Script'
);


ALTER TYPE sentinel.chat_message_origin OWNER TO thommcgrath;

--
-- Name: chat_message_scope; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.chat_message_scope AS ENUM (
    'Global',
    'Local',
    'Tribe',
    'Radio',
    'Alliance'
);


ALTER TYPE sentinel.chat_message_scope OWNER TO thommcgrath;

--
-- Name: dino_gender; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.dino_gender AS ENUM (
    'None',
    'Female',
    'Male'
);


ALTER TYPE sentinel.dino_gender OWNER TO thommcgrath;

--
-- Name: dino_status; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.dino_status AS ENUM (
    'Deployed',
    'Dead',
    'Frozen',
    'Uploaded'
);


ALTER TYPE sentinel.dino_status OWNER TO thommcgrath;

--
-- Name: event_name; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.event_name AS ENUM (
    'characterScriptRun',
    'chat',
    'clockTamperingDetected',
    'clusterIdChanged',
    'adminCommand',
    'broadcasted',
    'cron',
    'customMessage',
    'dinoClaimed',
    'dinoCreated',
    'dinoDied',
    'dinoDownloaded',
    'dinoFrozen',
    'dinoMatured',
    'dinoRenamed',
    'dinoRestored',
    'dinoScriptRun',
    'dinoSterilized',
    'dinoTamed',
    'dinoTribeChanged',
    'dinoUnclaimed',
    'dinoUnfrozen',
    'dinoUnsterilized',
    'dinoUploaded',
    'itemGiven',
    'noClusterId',
    'playerCuffed',
    'playerDied',
    'playerJoined',
    'playerLeft',
    'playerRenamed',
    'playerSpawned',
    'playerTribeChanged',
    'playerUncuffed',
    'problemDetected',
    'rollbackDetected',
    'serverConnected',
    'serverDisconnected',
    'serviceScriptRun',
    'slashCommand',
    'structureDestroyed',
    'tribeCreated',
    'tribeDestroyed',
    'tribeRenamed',
    'tribeScriptRun'
);


ALTER TYPE sentinel.event_name OWNER TO thommcgrath;

--
-- Name: event_queue_status; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.event_queue_status AS ENUM (
    'Waiting',
    'Errored'
);


ALTER TYPE sentinel.event_queue_status OWNER TO thommcgrath;

--
-- Name: game_platform; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.game_platform AS ENUM (
    'PC',
    'Xbox',
    'PlayStation',
    'Switch',
    'Universal'
);


ALTER TYPE sentinel.game_platform OWNER TO thommcgrath;

--
-- Name: lang_shortcode; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.lang_shortcode AS ENUM (
    'ar',
    'hy',
    'eu',
    'ca',
    'da',
    'nl',
    'en',
    'fi',
    'fr',
    'de',
    'el',
    'hi',
    'hu',
    'id',
    'ga',
    'it',
    'lt',
    'ne',
    'no',
    'pt',
    'ro',
    'ru',
    'sr',
    'es',
    'sv',
    'ta',
    'tr',
    'yi'
);


ALTER TYPE sentinel.lang_shortcode OWNER TO thommcgrath;

--
-- Name: log_analyzer_status; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.log_analyzer_status AS ENUM (
    'Skipped',
    'Pending',
    'Analyzed'
);


ALTER TYPE sentinel.log_analyzer_status OWNER TO thommcgrath;

--
-- Name: log_level; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.log_level AS ENUM (
    'Emergency',
    'Alert',
    'Critical',
    'Error',
    'Warning',
    'Notice',
    'Informational',
    'Debug'
);


ALTER TYPE sentinel.log_level OWNER TO thommcgrath;

--
-- Name: log_type; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.log_type AS ENUM (
    'Service',
    'Gameplay'
);


ALTER TYPE sentinel.log_type OWNER TO thommcgrath;

--
-- Name: moderation_platform; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.moderation_platform AS ENUM (
    'Mistral',
    'Perspective'
);


ALTER TYPE sentinel.moderation_platform OWNER TO thommcgrath;

--
-- Name: script_approval_status; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.script_approval_status AS ENUM (
    'Probation',
    'Needs Review',
    'Approved',
    'Rejected'
);


ALTER TYPE sentinel.script_approval_status OWNER TO thommcgrath;

--
-- Name: script_language; Type: TYPE; Schema: sentinel; Owner: thommcgrath
--

CREATE TYPE sentinel.script_language AS ENUM (
    'Simple',
    'JavaScript'
);


ALTER TYPE sentinel.script_language OWNER TO thommcgrath;

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
-- Name: deletions_delete(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.deletions_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM public.deletions WHERE object_id = OLD.object_id;
	RETURN OLD;
END;
$$;


ALTER FUNCTION ark.deletions_delete() OWNER TO thommcgrath;

--
-- Name: deletions_insert(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.deletions_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version, action_time, tag) VALUES (NEW.object_id, 'Ark', NEW.from_table, NEW.label, NEW.min_version, NEW.action_time, NEW.tag);
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.deletions_insert() OWNER TO thommcgrath;

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
-- Name: legacy_mod_delete(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.legacy_mod_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM public.content_packs WHERE content_pack_id = OLD.mod_id;
	RETURN OLD;
END;
$$;


ALTER FUNCTION ark.legacy_mod_delete() OWNER TO thommcgrath;

--
-- Name: legacy_mod_insert(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.legacy_mod_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.content_packs (content_pack_id, game_id, marketplace, marketplace_id, user_id, name, confirmed, confirmation_code, console_safe, default_enabled, last_update, min_version, include_in_deltas, is_official, game_specific) VALUES (COALESCE(NEW.mod_id, gen_random_uuid()), 'Ark', (CASE WHEN NEW.workshop_id < 0 THEN 'Steam' ELSE 'Steam Workshop' END)::marketplace, ABS(NEW.workshop_id), NEW.user_id, NEW.name, COALESCE(NEW.confirmed, FALSE), COALESCE(NEW.confirmation_code::UUID, gen_random_uuid()), COALESCE(NEW.console_safe, FALSE), COALESCE(NEW.default_enabled, FALSE), COALESCE(NEW.last_update, CURRENT_TIMESTAMP), COALESCE(NEW.min_version, 10500000), COALESCE(NEW.include_in_deltas, FALSE), COALESCE(NEW.is_official, FALSE), jsonb_strip_nulls(jsonb_build_object('tag', NEW.tag, 'prefix', NEW.prefix, 'map_folder', NEW.map_folder)));
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.legacy_mod_insert() OWNER TO thommcgrath;

--
-- Name: legacy_mod_update(); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.legacy_mod_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE public.content_packs SET user_id = NEW.user_id, name = NEW.name, confirmed = NEW.confirmed, confirmation_code = NEW.confirmation_code, console_safe = NEW.console_safe, default_enabled = NEW.default_enabled, last_update = NEW.last_update, min_version = NEW.min_version, include_in_deltas = NEW.include_in_deltas, is_official = NEW.is_official, game_specific = jsonb_strip_nulls(jsonb_build_object('tag', NEW.tag, 'prefix', NEW.prefix, 'map_folder', NEW.map_folder)) WHERE content_pack_id = NEW.mod_id;
	RETURN NEW;
END;
$$;


ALTER FUNCTION ark.legacy_mod_update() OWNER TO thommcgrath;

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
-- Name: table_to_group(text); Type: FUNCTION; Schema: ark; Owner: thommcgrath
--

CREATE FUNCTION ark.table_to_group(p_table_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_table_name
	WHEN 'ini_options' THEN
		RETURN 'configOptions';
	WHEN 'loot_source_icons' THEN
		RETURN 'lootDropIcons';
	WHEN 'loot_sources' THEN
		RETURN 'lootDrops';
	WHEN 'mods' THEN
		RETURN 'contentPacks';
	WHEN 'spawn_points' THEN
		RETURN 'spawnPoints';
	ELSE
		RETURN p_table_name;
	END CASE;
END
$$;


ALTER FUNCTION ark.table_to_group(p_table_name text) OWNER TO thommcgrath;

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
		UPDATE ark.events SET last_update = CURRENT_TIMESTAMP WHERE event_id = NEW.event_id;
	END IF;
	IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND NEW.event_id != OLD.event_id) THEN
		UPDATE ark.events SET last_update = CURRENT_TIMESTAMP WHERE event_id = OLD.event_id;
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
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
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
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
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
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
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
-- Name: blueprint_insert_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.blueprint_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	IF (NEW.object_id IS NULL) THEN
		NEW.object_id = public.create_object_id(NEW.content_pack_id, NEW.path);
	END IF;
	EXECUTE 'DELETE FROM arksa.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.min_version = GREATEST(NEW.min_version, 20000000);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION arksa.blueprint_insert_trigger() OWNER TO thommcgrath;

--
-- Name: break_content_pack_relationships(uuid[]); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.break_content_pack_relationships(p_uuids uuid[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	FOR first_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
	LOOP
		FOR second_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
		LOOP
			IF first_idx != second_idx THEN
				DELETE FROM arksa.content_pack_relationships WHERE (pack_1 = p_uuids[first_idx] AND pack_2 = p_uuids[second_idx]) OR (pack_1 = p_uuids[second_idx] AND pack_2 = p_uuids[first_idx]);
			END IF;
		END LOOP;
	END LOOP;
END;
$$;


ALTER FUNCTION arksa.break_content_pack_relationships(p_uuids uuid[]) OWNER TO thommcgrath;

--
-- Name: compute_class_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.compute_class_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	NEW.class_string = SUBSTRING(NEW.path, '\.([a-zA-Z0-9\-\_]+)$') || '_C';
	RETURN NEW;
END;
$_$;


ALTER FUNCTION arksa.compute_class_trigger() OWNER TO thommcgrath;

--
-- Name: create_content_pack_relationships(uuid[]); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.create_content_pack_relationships(p_uuids uuid[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	FOR first_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
	LOOP
		FOR second_idx IN array_lower(p_uuids, 1) .. array_upper(p_uuids, 1)
		LOOP
			IF first_idx != second_idx THEN
				INSERT INTO arksa.content_pack_relationships (pack_1, pack_2) VALUES (p_uuids[first_idx], p_uuids[second_idx]) ON CONFLICT (pack_1, pack_2) DO NOTHING;
				INSERT INTO arksa.content_pack_relationships (pack_1, pack_2) VALUES (p_uuids[second_idx], p_uuids[first_idx]) ON CONFLICT (pack_1, pack_2) DO NOTHING;
			END IF;
		END LOOP;
	END LOOP;
END;
$$;


ALTER FUNCTION arksa.create_content_pack_relationships(p_uuids uuid[]) OWNER TO thommcgrath;

--
-- Name: deletions_delete(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.deletions_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM public.deletions WHERE object_id = OLD.object_id;
	RETURN OLD;
END;
$$;


ALTER FUNCTION arksa.deletions_delete() OWNER TO thommcgrath;

--
-- Name: deletions_insert(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.deletions_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version, action_time, tag) VALUES (NEW.object_id, 'ArkSA', NEW.from_table, NEW.label, NEW.min_version, NEW.action_time, NEW.tag);
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.deletions_insert() OWNER TO thommcgrath;

--
-- Name: engram_delete_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.engram_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO arksa.deletions (object_id, from_table, label, min_version, tag) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version, OLD.path;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION arksa.engram_delete_trigger() OWNER TO thommcgrath;

--
-- Name: generic_update_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.generic_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.generic_update_trigger() OWNER TO thommcgrath;

--
-- Name: import_creature(uuid, uuid, integer); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.import_creature(p_creature_id uuid, p_content_pack_id uuid, p_mask integer DEFAULT 2147483647) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_creature ark.creatures%ROWTYPE;
	v_new_creature_id UUID;
	v_related RECORD;
	v_new_engram_id UUID;
	v_stat ark.creature_stats%ROWTYPE;
BEGIN
	SELECT * INTO v_creature FROM ark.creatures WHERE object_id = p_creature_id;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Could not find ArkSE creature %', p_creature_id;
	END IF;
	v_new_creature_id := public.create_object_id(p_content_pack_id, v_creature.path);
	
	IF EXISTS (SELECT object_id FROM arksa.creatures WHERE object_id = v_new_creature_id) THEN
		RETURN v_new_creature_id;
	END IF;
	
	INSERT INTO arksa.creatures (object_id, label, alternate_label, min_version, content_pack_id, tags, path, availability, breedable, incubation_time, mature_time, mating_interval_min, mating_interval_max, used_stats) VALUES (v_new_creature_id, v_creature.label, v_creature.alternate_label, GREATEST(20000000, v_creature.min_version), p_content_pack_id, v_creature.tags, v_creature.path, v_creature.availability & p_mask, v_creature.breedable, v_creature.incubation_time, v_creature.mature_time, v_creature.mating_interval_min, v_creature.mating_interval_max, v_creature.used_stats);
	
	FOR v_related IN SELECT engrams.path, creature_engrams.engram_id FROM ark.creature_engrams INNER JOIN ark.engrams ON (creature_engrams.engram_id = engrams.object_id) WHERE creature_engrams.creature_id = p_creature_id LOOP
		SELECT object_id INTO v_new_engram_id FROM arksa.engrams WHERE path = v_related.path;
		If NOT FOUND THEN
			v_new_engram_id := arksa.import_engram(v_related.engram_id, p_content_pack_id, p_mask);
		END IF;
		INSERT INTO arksa.creature_engrams (relation_id, creature_id, engram_id) VALUES (public.generate_uuid_from_text(v_new_creature_id::TEXT || v_new_engram_id::TEXT), v_new_creature_id, v_new_engram_id);
	END LOOP;
	
	FOR v_stat IN SELECT * FROM ark.creature_stats WHERE creature_id = p_creature_id ORDER BY stat_index LOOP
		INSERT INTO arksa.creature_stats (creature_id, stat_index, base_value, per_level_wild_multiplier, per_level_tamed_multiplier, add_multiplier, affinity_multiplier) VALUES (v_new_creature_id, v_stat.stat_index, v_stat.base_value, v_stat.per_level_wild_multiplier, v_stat.per_level_tamed_multiplier, v_stat.add_multiplier, v_stat.affinity_multiplier);
	END LOOP;
	
	RETURN v_new_creature_id;
END;
$$;


ALTER FUNCTION arksa.import_creature(p_creature_id uuid, p_content_pack_id uuid, p_mask integer) OWNER TO thommcgrath;

--
-- Name: import_engram(uuid, uuid, integer); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.import_engram(p_engram_id uuid, p_content_pack_id uuid, p_mask integer DEFAULT 2147483647) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_engram ark.engrams%ROWTYPE;
	v_new_engram_id UUID;
	v_ingredient RECORD;
	v_new_ingredient_id UUID;
BEGIN
	SELECT * INTO v_engram FROM ark.engrams WHERE object_id = p_engram_id;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Could not find ArkSE engram %', p_engram_id;
	END IF;
	v_new_engram_id := public.create_object_id(p_content_pack_id, v_engram.path);
	
	If EXISTS (SELECT object_id FROM arksa.engrams WHERE object_id = v_new_engram_id) THEN
		RETURN v_new_engram_id;
	END IF;
	
	INSERT INTO arksa.engrams (object_id, label, alternate_label, min_version, content_pack_id, tags, path, availability, entry_string, required_points, required_level, stack_size) VALUES (v_new_engram_id, v_engram.label, v_engram.alternate_label, GREATEST(20000000, v_engram.min_version), p_content_pack_id, v_engram.tags, v_engram.path, v_engram.availability & p_mask, v_engram.entry_string, v_engram.required_points, v_engram.required_level, v_engram.stack_size);
	
	FOR v_ingredient IN SELECT engrams.path, crafting_costs.ingredient_id, crafting_costs.quantity, crafting_costs.exact FROM ark.crafting_costs INNER JOIN ark.engrams ON (crafting_costs.ingredient_id = engrams.object_id) WHERE crafting_costs.engram_id = p_engram_id LOOP
		SELECT object_id INTO v_new_ingredient_id FROM arksa.engrams WHERE path = v_ingredient.path;
		IF NOT FOUND THEN
			v_new_ingredient_id := arksa.import_engram(v_ingredient.ingredient_id, p_content_pack_id, p_mask);
		END IF;
		INSERT INTO arksa.crafting_costs (engram_id, ingredient_id, quantity, exact) VALUES (v_new_engram_id, v_new_ingredient_id, v_ingredient.quantity, v_ingredient.exact);
	END LOOP;
	
	RETURN v_new_engram_id;
END;
$$;


ALTER FUNCTION arksa.import_engram(p_engram_id uuid, p_content_pack_id uuid, p_mask integer) OWNER TO thommcgrath;

--
-- Name: import_loot_drop(uuid, uuid, integer); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.import_loot_drop(p_loot_source_id uuid, p_content_pack_id uuid, p_mask integer DEFAULT 2147483647) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_loot_source ark.loot_sources%ROWTYPE;
	v_loot_icon ark.loot_source_icons%ROWTYPE;
	v_new_drop_id UUID;
	v_new_icon_id UUID;
	v_item_set ark.loot_item_sets%ROWTYPE;
	v_new_item_set_id UUID;
	v_entry ark.loot_item_set_entries%ROWTYPE;
	v_new_entry_id UUID;
	v_option RECORD;
	v_new_option_id UUID;
	v_new_engram_id UUID;
BEGIN
	SELECT * INTO v_loot_source FROM ark.loot_sources WHERE object_id = p_loot_source_id;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Could not find ArkSE loot source %', p_loot_source_id;
	END IF;
	v_new_drop_id := public.create_object_id(p_content_pack_id, v_loot_source.path);
	
	IF EXISTS (SELECT object_id FROM arksa.loot_drops WHERE object_id = v_new_drop_id) THEN
		RETURN v_new_drop_id;
	END IF;
	
	SELECT * INTO v_loot_icon FROM ark.loot_source_icons WHERE object_id = v_loot_source.icon;
	v_new_icon_id := public.generate_uuid_from_text(LOWER(v_loot_icon.label));
	IF NOT EXISTS (SELECT object_id FROM arksa.loot_drop_icons WHERE object_id = v_new_icon_id) THEN
		INSERT INTO arksa.loot_drop_icons (object_id, label, alternate_label, min_version, content_pack_id, tags, icon_data) VALUES (v_new_icon_id, v_loot_icon.label, v_loot_icon.alternate_label, GREATEST(v_loot_icon.min_version, 20000000), p_content_pack_id, v_loot_icon.tags, v_loot_icon.icon_data);
	END IF;
	
	INSERT INTO arksa.loot_drops (object_id, label, alternate_label, min_version, content_pack_id, tags, path, availability, multiplier_min, multiplier_max, uicolor, icon, sort_order, experimental, min_item_sets, max_item_sets, prevent_duplicates) VALUES (v_new_drop_id, v_loot_source.label, v_loot_source.alternate_label, GREATEST(20000000, v_loot_source.min_version), p_content_pack_id, v_loot_source.tags, v_loot_source.path, v_loot_source.availability & p_mask, v_loot_source.multiplier_min, v_loot_source.multiplier_max, v_loot_source.uicolor, v_new_icon_id, LPAD(COALESCE(v_loot_source.modern_sort, 999)::TEXT, 3, '0'), v_loot_source.experimental, v_loot_source.min_item_sets, v_loot_source.max_item_sets, v_loot_source.prevent_duplicates);
	
	FOR v_item_set IN SELECT * FROM ark.loot_item_sets WHERE loot_source_id = p_loot_source_id LOOP
		v_new_item_set_id := public.generate_uuid_from_text(v_new_drop_id::TEXT || ':' || v_item_set.sync_sort_key);
		INSERT INTO arksa.loot_item_sets (loot_item_set_id, loot_drop_id, label, min_entries, max_entries, weight, prevent_duplicates, sync_sort_key) VALUES (v_new_item_set_id, v_new_drop_id, v_item_set.label, v_item_set.min_entries, v_item_set.max_entries, v_item_set.weight, v_item_set.prevent_duplicates, v_item_set.sync_sort_key);
		FOR v_entry IN SELECT * FROM ark.loot_item_set_entries WHERE loot_item_set_id = v_item_set.loot_item_set_id LOOP
			v_new_entry_id := public.generate_uuid_from_text(v_new_item_set_id::TEXT || ':' || v_entry.sync_sort_key);
			INSERT INTO arksa.loot_item_set_entries (loot_item_set_entry_id, loot_item_set_id, min_quantity, max_quantity, min_quality, max_quality, blueprint_chance, weight, single_item_quantity, prevent_grinding, stat_clamp_multiplier, sync_sort_key) VALUES (v_new_entry_id, v_new_item_set_id, v_entry.min_quantity, v_entry.max_quantity, v_entry.min_quality::TEXT::arksa.loot_quality_tier, v_entry.max_quality::TEXT::arksa.loot_quality_tier, v_entry.blueprint_chance, v_entry.weight, v_entry.single_item_quantity, v_entry.prevent_grinding, v_entry.stat_clamp_multiplier, v_entry.sync_sort_key);
			FOR v_option IN SELECT engrams.path, loot_item_set_entry_options.engram_id, loot_item_set_entry_options.weight, loot_item_set_entry_options.sync_sort_key FROM ark.loot_item_set_entry_options INNER JOIN ark.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_id = v_entry.loot_item_set_entry_id LOOP
				v_new_option_id := public.generate_uuid_from_text(v_new_entry_id::TEXT || ':' || v_option.sync_sort_key);
				SELECT object_id INTO v_new_engram_id FROM arksa.engrams WHERE path = v_option.path;
				IF NOT FOUND THEN
					v_new_engram_id := arksa.import_engram(v_option.engram_id, p_content_pack_id, p_mask);
				END IF;
				INSERT INTO arksa.loot_item_set_entry_options (loot_item_set_entry_option_id, loot_item_set_entry_id, engram_id, weight, sync_sort_key) VALUES (v_new_option_id, v_new_entry_id, v_new_engram_id, v_option.weight, v_option.sync_sort_key);
			END LOOP;
		END LOOP;
	END LOOP;
	
	RETURN v_new_drop_id;
END;
$$;


ALTER FUNCTION arksa.import_loot_drop(p_loot_source_id uuid, p_content_pack_id uuid, p_mask integer) OWNER TO thommcgrath;

--
-- Name: import_spawn_point(uuid, uuid, integer); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.import_spawn_point(p_spawn_point_id uuid, p_content_pack_id uuid, p_mask integer DEFAULT 2147483647) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_spawn_point ark.spawn_points%ROWTYPE;
	v_new_point_id UUID;
	v_spawn_set ark.spawn_point_sets%ROWTYPE;
	v_new_set_id UUID;
	v_entry RECORD;
	v_new_entry_id UUID;
	v_new_creature_id UUID;
	v_limit RECORD;
BEGIN
	SELECT * INTO v_spawn_point FROM ark.spawn_points WHERE object_id = p_spawn_point_id;
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Could not find ArkSE spawn point %', p_spawn_point_id;
	END IF;
	v_new_point_id := public.create_object_id(p_content_pack_id, v_spawn_point.path);
	
	IF EXISTS (SELECT object_id FROM arksa.spawn_points WHERE object_id = v_new_point_id) THEN
		RETURN v_new_point_id;
	END IF;
	
	INSERT INTO arksa.spawn_points (object_id, label, alternate_label, min_version, content_pack_id, tags, path, availability) VALUES (v_new_point_id, v_spawn_point.label, v_spawn_point.alternate_label, GREATEST(20000000, v_spawn_point.min_version), p_content_pack_id, v_spawn_point.tags, v_spawn_point.path, v_spawn_point.availability);
	
	FOR v_spawn_set IN SELECT * FROM ark.spawn_point_sets WHERE spawn_point_id = p_spawn_point_id LOOP
		v_new_set_id := gen_random_uuid();
		INSERT INTO arksa.spawn_point_sets (spawn_point_set_id, spawn_point_id, label, weight, spawn_offset, min_distance_from_players_multiplier, min_distance_from_structures_multiplier, min_distance_from_tamed_dinos_multiplier, spread_radius, water_only_minimum_height, offset_before_multiplier) VALUES (v_new_set_id, v_new_point_id, v_spawn_set.label, v_spawn_set.weight, v_spawn_set.spawn_offset, v_spawn_set.min_distance_from_players_multiplier, v_spawn_set.min_distance_from_structures_multiplier, v_spawn_set.min_distance_from_tamed_dinos_multiplier, v_spawn_set.spread_radius, v_spawn_set.water_only_minimum_height, v_spawn_set.offset_before_multiplier);
		FOR v_entry IN SELECT creatures.path, spawn_point_set_entries.creature_id, spawn_point_set_entries.weight, spawn_point_set_entries.override, spawn_point_set_entries.min_level_multiplier, spawn_point_set_entries.max_level_multiplier, spawn_point_set_entries.min_level_offset, spawn_point_set_entries.max_level_offset, spawn_point_set_entries.spawn_offset FROM ark.spawn_point_set_entries INNER JOIN ark.creatures ON (spawn_point_set_entries.creature_id = creatures.object_id) WHERE spawn_point_set_id = v_spawn_set.spawn_point_set_id LOOP
			v_new_entry_id := gen_random_uuid();
			SELECT object_id INTO v_new_creature_id FROM arksa.creatures WHERE path = v_entry.path;
			IF NOT FOUND THEN
				v_new_creature_id := arksa.import_creature(v_entry.creature_id, p_content_pack_id, p_mask);
			END IF;
			INSERT INTO arksa.spawn_point_set_entries (spawn_point_set_entry_id, spawn_point_set_id, creature_id, weight, override, min_level_multiplier, max_level_multiplier, min_level_offset, max_level_offset, spawn_offset) VALUES (v_new_entry_id, v_new_set_id, v_new_creature_id, v_entry.weight, v_entry.override, v_entry.min_level_multiplier, v_entry.max_level_multiplier, v_entry.min_level_offset, v_entry.max_level_offset, v_entry.spawn_offset);
		END LOOP;
	END LOOP;
	
	FOR v_limit IN SELECT creatures.path, spawn_point_limits.creature_id, spawn_point_limits.max_percentage FROM ark.spawn_point_limits INNER JOIN ark.creatures ON (spawn_point_limits.creature_id = creatures.object_id) WHERE spawn_point_limits.spawn_point_id = p_spawn_point_id LOOP
		SELECT object_id INTO v_new_creature_id FROM arksa.creatures WHERE path = v_limit.path;
		IF NOT FOUND THEN
			v_new_creature_id := arksa.import_creature(v_limit.creaure_id, p_content_pack_id, p_mask);
		END IF;
		INSERT INTO arksa.spawn_point_limits (spawn_point_id, creature_id, max_percentage) VALUES (v_new_point_id, v_new_creature_id, v_limit.max_percentage);
	END LOOP;
	
	RETURN v_new_point_id;
END;
$$;


ALTER FUNCTION arksa.import_spawn_point(p_spawn_point_id uuid, p_content_pack_id uuid, p_mask integer) OWNER TO thommcgrath;

--
-- Name: ini_options_insert_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.ini_options_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM arksa.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.object_id = public.generate_uuid_from_text(LOWER(NEW.content_pack_id::TEXT) || ':' || LOWER(NEW.file::TEXT) || ':' || LOWER(NEW.header) || ':' || LOWER(NEW.key));
	NEW.min_version = GREATEST(NEW.min_version, 20000000);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION arksa.ini_options_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_delete_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.object_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO arksa.deletions (object_id, from_table, label, min_version) VALUES ($1, $2, $3, $4);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION arksa.object_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_insert_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.object_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM arksa.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.min_version = GREATEST(NEW.min_version, 20000000);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION arksa.object_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_update_trigger(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.object_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.min_version = GREATEST(NEW.min_version, 20000000);
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.object_update_trigger() OWNER TO thommcgrath;

--
-- Name: objects_search_sync(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.objects_search_sync() RETURNS trigger
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


ALTER FUNCTION arksa.objects_search_sync() OWNER TO thommcgrath;

--
-- Name: table_to_group(text); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.table_to_group(p_table_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_table_name
	WHEN 'ini_options' THEN
		RETURN 'configOptions';
	WHEN 'loot_drop_icons' THEN
		RETURN 'lootDropIcons';
	WHEN 'loot_drops' THEN
		RETURN 'lootDrops';
	WHEN 'content_packs' THEN
		RETURN 'contentPacks';
	WHEN 'spawn_points' THEN
		RETURN 'spawnPoints';
	ELSE
		RETURN p_table_name;
	END CASE;
END
$$;


ALTER FUNCTION arksa.table_to_group(p_table_name text) OWNER TO thommcgrath;

--
-- Name: templates_json_sync_function(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.templates_json_sync_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.label = NEW.contents->>'Label';
	NEW.object_id = (NEW.contents->>'ID')::UUID;
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.templates_json_sync_function() OWNER TO thommcgrath;

--
-- Name: update_color_last_update(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_color_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM arksa.deletions WHERE object_id = generate_uuid_from_text('color ' || NEW.color_id::text) AND from_table = 'colors';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO arksa.deletions (object_id, from_table, label, min_version, action_time) VALUES (generate_uuid_from_text('color ' || OLD.color_id::text), 'colors', OLD.color_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION arksa.update_color_last_update() OWNER TO thommcgrath;

--
-- Name: update_color_set_last_update(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_color_set_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM arksa.deletions WHERE object_id = NEW.color_set_id AND from_table = 'color_sets';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO arksa.deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.color_set_id, 'color_sets', OLD.label, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION arksa.update_color_set_last_update() OWNER TO thommcgrath;

--
-- Name: update_creature_modified(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_creature_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' OR TG_OP = 'TRUNCATE' OR (TG_OP = 'UPDATE' AND NEW.creature_id != OLD.creature_id) THEN
		UPDATE arksa.creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = OLD.creature_id;
	END IF;
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE arksa.creatures SET last_update = CURRENT_TIMESTAMP WHERE object_id = NEW.creature_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION arksa.update_creature_modified() OWNER TO thommcgrath;

--
-- Name: update_engram_modified(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_engram_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' OR TG_OP = 'TRUNCATE' OR (TG_OP = 'UPDATE' AND NEW.engram_id != OLD.engram_id) THEN
		UPDATE arksa.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = OLD.engram_id;
	END IF;
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE arksa.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = NEW.engram_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION arksa.update_engram_modified() OWNER TO thommcgrath;

--
-- Name: update_engram_timestamp(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_engram_timestamp() RETURNS trigger
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
		UPDATE arksa.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
	END IF;
	IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
		UPDATE arksa.engrams SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION arksa.update_engram_timestamp() OWNER TO thommcgrath;

--
-- Name: update_event_last_update(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_event_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		DELETE FROM arksa.deletions WHERE object_id = NEW.event_id AND from_table = 'events';
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		NEW.last_update = CURRENT_TIMESTAMP;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO arksa.deletions (object_id, from_table, label, min_version, action_time) VALUES (OLD.event_id, 'events', OLD.event_name, 0, CURRENT_TIMESTAMP);
		RETURN OLD;
	END IF;
END;
$$;


ALTER FUNCTION arksa.update_event_last_update() OWNER TO thommcgrath;

--
-- Name: update_event_last_update_from_children(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_event_last_update_from_children() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE arksa.events SET last_update = CURRENT_TIMESTAMP WHERE event_id = NEW.event_id;
	END IF;
	IF TG_OP = 'DELETE' OR (TG_OP = 'UPDATE' AND NEW.event_id != OLD.event_id) THEN
		UPDATE arksa.events SET last_update = CURRENT_TIMESTAMP WHERE event_id = OLD.event_id;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION arksa.update_event_last_update_from_children() OWNER TO thommcgrath;

--
-- Name: update_last_update_column(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_last_update_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.update_last_update_column() OWNER TO thommcgrath;

--
-- Name: update_loot_drop_timestamp(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_loot_drop_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_oldid UUID;
	v_newid UUID;
BEGIN
	IF TG_TABLE_NAME = 'loot_item_sets' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_drop_id;
		END IF;
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_drop_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
		END IF;
	ELSIF TG_TABLE_NAME = 'loot_item_set_entries' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_item_set_id;
		END IF;
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_item_set_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP FROM arksa.loot_item_sets WHERE loot_item_sets.loot_item_set_id = v_oldid AND loot_item_sets.loot_drop_id = loot_drops.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP FROM arksa.loot_item_sets WHERE loot_item_sets.loot_item_set_id = v_newid AND loot_item_sets.loot_drop_id = loot_drops.object_id;
		END IF;
	ELSIF TG_TABLE_NAME = 'loot_item_set_entry_options' THEN
		IF TG_OP = 'DELETE' OR TG_OP = 'UPDATE' THEN
			v_oldid = OLD.loot_item_set_entry_id;
		END IF;
		IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
			v_newid = NEW.loot_item_set_entry_id;
		END IF;
		IF v_oldid IS NOT NULL THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP FROM arksa.loot_item_sets, arksa.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_entry_id = v_oldid AND loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id AND loot_item_sets.loot_drop_id = loot_drops.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.loot_drops SET last_update = CURRENT_TIMESTAMP FROM arksa.loot_item_sets, arksa.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_entry_id = v_newid AND loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id AND loot_item_sets.loot_drop_id = loot_drops.object_id;
		END IF;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION arksa.update_loot_drop_timestamp() OWNER TO thommcgrath;

--
-- Name: update_spawn_point_timestamp(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_spawn_point_timestamp() RETURNS trigger
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
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP FROM arksa.spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_oldid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP FROM arksa.spawn_point_sets WHERE spawn_point_sets.spawn_point_set_id = v_newid AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
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
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP FROM arksa.spawn_point_set_entries, arksa.spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_oldid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP FROM arksa.spawn_point_set_entries, arksa.spawn_point_sets WHERE spawn_point_set_entries.spawn_point_set_entry_id = v_newid AND spawn_point_set_entries.spawn_point_set_id = spawn_point_sets.spawn_point_set_id AND spawn_point_sets.spawn_point_id = spawn_points.object_id;
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
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_oldid;
		END IF;
		IF v_newid IS NOT NULL AND v_newid IS DISTINCT FROM v_oldid THEN
			UPDATE arksa.spawn_points SET last_update = CURRENT_TIMESTAMP WHERE object_id = v_newid;
		END IF;
	END IF;
	IF TG_OP = 'DELETE' THEN
		RETURN OLD;
	ELSE
		RETURN NEW;
	END IF;
END; $$;


ALTER FUNCTION arksa.update_spawn_point_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_module_timestamp(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_support_article_module_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.module_updated := CURRENT_TIMESTAMP;
	UPDATE support_articles SET article_updated = CURRENT_TIMESTAMP WHERE content_markdown LIKE '%[module:' || NEW.module_name || ']%';
	RETURN NEW;
END;
$$;


ALTER FUNCTION arksa.update_support_article_module_timestamp() OWNER TO thommcgrath;

--
-- Name: update_support_article_timestamp(); Type: FUNCTION; Schema: arksa; Owner: thommcgrath
--

CREATE FUNCTION arksa.update_support_article_timestamp() RETURNS trigger
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


ALTER FUNCTION arksa.update_support_article_timestamp() OWNER TO thommcgrath;

--
-- Name: deletions_delete(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.deletions_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM public.deletions WHERE object_id = OLD.object_id;
	RETURN OLD;
END;
$$;


ALTER FUNCTION palworld.deletions_delete() OWNER TO thommcgrath;

--
-- Name: deletions_insert(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.deletions_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version, action_time, tag) VALUES (NEW.object_id, 'Palworld'::public.game_identifier, NEW.from_table, NEW.label, NEW.min_version, NEW.action_time, NEW.tag);
	RETURN NEW;
END;
$$;


ALTER FUNCTION palworld.deletions_insert() OWNER TO thommcgrath;

--
-- Name: generic_update_trigger(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.generic_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$;


ALTER FUNCTION palworld.generic_update_trigger() OWNER TO thommcgrath;

--
-- Name: ini_options_insert_trigger(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.ini_options_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM public.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.object_id = public.generate_uuid_from_text(LOWER(NEW.content_pack_id::TEXT) || ':' || LOWER(NEW.file::TEXT) || ':' || LOWER(NEW.header) || ':' || LOWER(COALESCE(NEW.struct, '')) || ':' || LOWER(NEW.key));
	NEW.min_version = GREATEST(NEW.min_version, 20100000);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION palworld.ini_options_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_delete_trigger(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.object_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, 'Palworld'::public.game_identifier, TG_TABLE_NAME, OLD.label, OLD.min_version;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION palworld.object_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_insert_trigger(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.object_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM public.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.min_version = GREATEST(NEW.min_version, 20100000);
	RETURN NEW;
END;
$_$;


ALTER FUNCTION palworld.object_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_update_trigger(); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.object_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	NEW.min_version = GREATEST(NEW.min_version, 20100000);
	RETURN NEW;
END;
$$;


ALTER FUNCTION palworld.object_update_trigger() OWNER TO thommcgrath;

--
-- Name: table_to_group(text); Type: FUNCTION; Schema: palworld; Owner: thommcgrath
--

CREATE FUNCTION palworld.table_to_group(p_table_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_table_name
	WHEN 'ini_options' THEN
		RETURN 'configOptions';
	ELSE
		RETURN p_table_name;
	END CASE;
END;
$$;


ALTER FUNCTION palworld.table_to_group(p_table_name text) OWNER TO thommcgrath;

--
-- Name: content_packs_delete_trigger(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.content_packs_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	IF OLD.confirmed = TRUE THEN
		EXECUTE 'INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version) VALUES ($1, $2, $3, $4, $5);' USING OLD.content_pack_id, OLD.game_id, 'mods', OLD.name, 10500000;
	END IF;
	RETURN OLD;
END;
$_$;


ALTER FUNCTION public.content_packs_delete_trigger() OWNER TO thommcgrath;

--
-- Name: content_packs_search_sync(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.content_packs_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.content_pack_id, 'mods', 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.content_pack_id, 'mods', 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.confirmed = TRUE THEN
			IF OLD.confirmed = FALSE THEN
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'creatures', 'Save' FROM ark.creatures WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'engrams', 'Save' FROM ark.engrams WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'loot_sources', 'Save' FROM ark.loot_sources WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
				INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'spawn_points', 'Save' FROM ark.spawn_points WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			END IF;
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.content_pack_id, 'mods', 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.confirmed = TRUE THEN
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'creatures', 'Delete' FROM ark.creatures WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'engrams', 'Delete' FROM ark.engrams WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'loot_sources', 'Delete' FROM ark.loot_sources WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) SELECT object_id, 'spawn_points', 'Delete' FROM ark.spawn_points WHERE mod_id = OLD.content_pack_id ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
			INSERT INTO search_sync (object_id, table_name, action) VALUES (NEW.content_pack_id, 'mods', 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION public.content_packs_search_sync() OWNER TO thommcgrath;

--
-- Name: create_object_id(uuid, text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.create_object_id(p_content_pack_id uuid, p_path text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN uuid_generate_v5('82aa4465-85f9-4b9e-8d36-f66164cef0a6', LOWER(p_content_pack_id::TEXT) || ':' || LOWER(p_path));
END;
$$;


ALTER FUNCTION public.create_object_id(p_content_pack_id uuid, p_path text) OWNER TO thommcgrath;

--
-- Name: email_needs_update(uuid); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.email_needs_update(p_email_id uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_alg CITEXT;
BEGIN
	SELECT group_key_alg INTO v_alg FROM public.email_addresses WHERE email_id = p_email_id;
	IF FOUND THEN
		RETURN v_alg != 'uuidv5';
	END IF;
	RETURN FALSE;
END;
$$;


ALTER FUNCTION public.email_needs_update(p_email_id uuid) OWNER TO thommcgrath;

--
-- Name: email_needs_update(public.email); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.email_needs_update(p_address public.email) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_email_id UUID;
BEGIN
	v_email_id := public.uuid_for_email(p_address);
	IF v_email_id IS NULL THEN
		RETURN FALSE;
	END IF;
	RETURN SUBSTRING(v_email_id::TEXT FROM 15 FOR 1) != '5';
END;
$$;


ALTER FUNCTION public.email_needs_update(p_address public.email) OWNER TO thommcgrath;

--
-- Name: enforce_content_pack_owner(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.enforce_content_pack_owner() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	confirmed_count INTEGER := 0;
BEGIN
	IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE' AND NEW.confirmed = TRUE AND OLD.confirmed = FALSE) THEN
		SELECT INTO confirmed_count COUNT(content_pack_id) FROM public.content_packs WHERE confirmed = TRUE AND marketplace = NEW.marketplace AND marketplace_id = NEW.marketplace_id;
		IF confirmed_count > 0 THEN
			RAISE EXCEPTION 'Content pack is already confirmed by another user.';
		END IF;
		IF NEW.confirmed THEN
			DELETE FROM public.content_packs WHERE marketplace = NEW.marketplace AND marketplace_id = NEW.marketplace_id AND content_pack_id != NEW.content_pack_id;
		END IF;
	END IF;
	
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.enforce_content_pack_owner() OWNER TO thommcgrath;

--
-- Name: escape_like_value(text, text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.escape_like_value(p_value text, p_escape text DEFAULT '\'::text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	v_like_value TEXT;
BEGIN
	v_like_value := REPLACE(p_value, p_escape, p_escape || p_escape);
	v_like_value := REPLACE(v_like_value, '_', p_escape || '_');
	v_like_value := REPLACE(v_like_value, '%', p_escape || '%');
	v_like_value := '%' || v_like_value || '%';
	RETURN v_like_value;
END;
$$;


ALTER FUNCTION public.escape_like_value(p_value text, p_escape text) OWNER TO thommcgrath;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.payment_methods (
    code public.citext NOT NULL,
    label public.citext NOT NULL,
    valid_from timestamp with time zone,
    valid_until timestamp with time zone,
    enabled boolean NOT NULL,
    supports_radar boolean NOT NULL,
    sort_order integer DEFAULT 100 NOT NULL,
    supports_subscriptions boolean DEFAULT false NOT NULL
);


ALTER TABLE public.payment_methods OWNER TO thommcgrath;

--
-- Name: find_payment_methods(public.citext, boolean, boolean); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.find_payment_methods(p_currency_code public.citext, p_is_suspect boolean, p_subscription boolean DEFAULT false) RETURNS SETOF public.payment_methods
    LANGUAGE sql
    AS $$
	SELECT payment_methods.* FROM public.payment_methods INNER JOIN public.payment_method_currencies ON (payment_method_currencies.payment_method_code = payment_methods.code) WHERE (supports_subscriptions = TRUE OR supports_subscriptions = p_subscription) AND payment_method_currencies.currency_code = p_currency_code AND payment_methods.enabled = TRUE AND (payment_methods.valid_from IS NULL OR payment_methods.valid_from >= CURRENT_TIMESTAMP) AND (payment_methods.valid_until IS NULL OR payment_methods.valid_until <= CURRENT_TIMESTAMP) AND (p_is_suspect = FALSE OR payment_methods.supports_radar = TRUE) ORDER BY sort_order, label;
$$;


ALTER FUNCTION public.find_payment_methods(p_currency_code public.citext, p_is_suspect boolean, p_subscription boolean) OWNER TO thommcgrath;

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
BEGIN
	RETURN uuid_generate_v5('82aa4465-85f9-4b9e-8d36-f66164cef0a6', p_input);
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
-- Name: hex_to_ui_color(text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.hex_to_ui_color(p_hex text) RETURNS public.ui_color
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE UPPER(p_hex)
	WHEN 'FFFFFF00' THEN
		RETURN 'White';
	WHEN '00FF0000' THEN
		RETURN 'Green';
	WHEN '88C8FF00' THEN
		RETURN 'Blue';
	WHEN 'E6BAFF00' THEN
		RETURN 'Purple';
	WHEN 'FFF02A00' THEN
		RETURN 'Yellow';
	WHEN 'FFBABA00' THEN
		RETURN 'Red';
	WHEN '00FFFF00' THEN
		RETURN 'Cyan';
	WHEN 'FFA50000' THEN
		RETURN 'Orange';
	ELSE
		RETURN 'White';
	END CASE;
END
$$;


ALTER FUNCTION public.hex_to_ui_color(p_hex text) OWNER TO thommcgrath;

--
-- Name: interval_to_iso8601(interval); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.interval_to_iso8601(p_interval interval) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	RETURN TO_CHAR(p_interval, 'PYYYY"Y"MM"M"DD"DT"HH24"H"MI"M"SS"S"');
END;
$$;


ALTER FUNCTION public.interval_to_iso8601(p_interval interval) OWNER TO thommcgrath;

--
-- Name: FUNCTION interval_to_iso8601(p_interval interval); Type: COMMENT; Schema: public; Owner: thommcgrath
--

COMMENT ON FUNCTION public.interval_to_iso8601(p_interval interval) IS 'Converts a PG interval into a PHP interval.';


--
-- Name: legacy_session_delete(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.legacy_session_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM public.access_tokens WHERE access_token_hash = OLD.session_id;
	RETURN OLD;
END;
$$;


ALTER FUNCTION public.legacy_session_delete() OWNER TO thommcgrath;

--
-- Name: legacy_session_insert(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.legacy_session_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.access_tokens (access_token_hash, refresh_token_hash, access_token_encrypted, refresh_token_encrypted, access_token_expiration, refresh_token_expiration, user_id, application_id, remote_ip, remote_country, remote_agent, scopes) VALUES (NEW.session_id, NEW.session_id, NEW.session_id, NEW.session_id, NEW.valid_until, NEW.valid_until, NEW.user_id, (CASE WHEN NEW.remote_agent LIKE 'Beacon/%' THEN '9f823fcf-eb7a-41c0-9e4b-db8ed4396f80' ELSE '12877547-7ad0-466f-a001-77815043c96b' END)::UUID, NEW.remote_ip, NEW.remote_country, NEW.remote_agent, (CASE WHEN NEW.remote_agent LIKE 'Beacon/%' THEN 'common users.private_key:read users:read' ELSE 'apps:create apps:delete apps:read apps:update common users:create users:delete users:read users:update' END));
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.legacy_session_insert() OWNER TO thommcgrath;

--
-- Name: legacy_session_update(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.legacy_session_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE public.access_tokens SET access_token_expiration = NEW.valid_until, refresh_token_expiration = NEW.valid_until, remote_ip = NEW.remote_ip, remote_country = NEW.remote_country, remote_agent = NEW.remote_agent WHERE access_token_hash = NEW.session_id;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.legacy_session_update() OWNER TO thommcgrath;

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
-- Name: policies_after_write(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.policies_after_write() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.policy_revisions (policy_id, revision_number, revision_date, content) VALUES (NEW.policy_id, NEW.current_revision, NEW.last_updated, NEW.content);
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.policies_after_write() OWNER TO thommcgrath;

--
-- Name: policies_before_write(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.policies_before_write() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		NEW.current_revision = 1;
	ELSE
		NEW.current_revision = OLD.current_revision + 1;
	END IF;
	NEW.last_updated = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.policies_before_write() OWNER TO thommcgrath;

--
-- Name: project_role_permissions(public.project_role); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.project_role_permissions(p_role public.project_role) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF p_role = 'Owner' THEN
		RETURN 90;
	ELSIF p_role = 'Admin' THEN
		RETURN 80;
	ELSIF p_role = 'Editor' THEN
		RETURN 70;
	ELSE
		RETURN 10;
	END IF;
END;
$$;


ALTER FUNCTION public.project_role_permissions(p_role public.project_role) OWNER TO thommcgrath;

--
-- Name: projects_search_sync(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.projects_search_sync() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		IF OLD.published = 'Approved' AND OLD.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.project_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN OLD;
	ELSIF TG_OP = 'INSERT' THEN
		IF NEW.published = 'Approved' AND NEW.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.project_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.published = 'Approved' AND NEW.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.project_id, TG_TABLE_NAME, 'Save') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		ELSIF OLD.published = 'Approved' AND OLD.deleted = FALSE THEN
			INSERT INTO search_sync (object_id, table_name, action) VALUES (OLD.project_id, TG_TABLE_NAME, 'Delete') ON CONFLICT (object_id) DO UPDATE SET action = EXCLUDED.action, moment = CURRENT_TIMESTAMP;
		END IF;
		RETURN NEW;
	END IF;
END;
$$;


ALTER FUNCTION public.projects_search_sync() OWNER TO thommcgrath;

--
-- Name: rcon_commands_deleted(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.rcon_commands_deleted() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version) VALUES (OLD.command_id, 'Common', 'rcon_commands', OLD.label, 0) ON CONFLICT (object_id) DO NOTHING;
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.rcon_commands_deleted() OWNER TO thommcgrath;

--
-- Name: rcon_commands_update_modified(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.rcon_commands_update_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP(0);
	DELETE FROM public.deletions WHERE object_id = NEW.command_id;
	IF TG_OP = 'UPDATE' AND NEW.command_id IS DISTINCT FROM OLD.command_id THEN
		INSERT INTO public.deletions (object_id, game_id, from_table, label, min_version) VALUES (OLD.command_id, 'Common', 'rcon_commands', OLD.label, 0) ON CONFLICT (object_id) DO NOTHING;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.rcon_commands_update_modified() OWNER TO thommcgrath;

--
-- Name: rcon_parameters_update_modified(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.rcon_parameters_update_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
		UPDATE public.rcon_commands SET last_update = CURRENT_TIMESTAMP(0) WHERE command_id = NEW.command_id;
	END IF;
	IF TG_OP = 'UPDATE' OR TG_OP = 'DELETE' THEN
		UPDATE public.rcon_commands SET last_update = CURRENT_TIMESTAMP(0) WHERE command_id = OLD.command_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.rcon_parameters_update_modified() OWNER TO thommcgrath;

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
-- Name: ui_color_to_hex(public.ui_color); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.ui_color_to_hex(p_ui_color public.ui_color) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_ui_color
	WHEN 'White' THEN
		RETURN 'FFFFFF00';
	WHEN 'Green' THEN
		RETURN '00FF0000';
	WHEN 'Blue' THEN
		RETURN '88C8FF00';
	WHEN 'Purple' THEN
		RETURN 'E6BAFF00';
	WHEN 'Yellow' THEN
		RETURN 'FFF02A00';
	WHEN 'Red' THEN
		RETURN 'FFBABA00';
	WHEN 'Cyan' THEN
		RETURN '00FFFF00';
	WHEN 'Orange' THEN
		RETURN 'FFA50000';
	ELSE
		RETURN 'FFFFFF00';
	END CASE;
END
$$;


ALTER FUNCTION public.ui_color_to_hex(p_ui_color public.ui_color) OWNER TO thommcgrath;

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
	v_uuid UUID;
BEGIN
	v_uuid := public.uuidv5_for_email(p_address);
	IF EXISTS (SELECT FROM public.email_addresses WHERE email_id = v_uuid) THEN
		RETURN v_uuid;
	END IF;
	
	RETURN public.uuidv4_for_email(p_address);
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
	v_uuidv4 UUID;
	v_uuidv5 UUID;
	v_precision INTEGER;
	v_alg TEXT;
	k_target_precision CONSTANT INTEGER := 4;
	k_target_alg CONSTANT TEXT := 'sha3-512';
BEGIN
	v_uuidv5 := public.uuidv5_for_email(p_address);
	IF EXISTS (SELECT FROM public.email_addresses WHERE email_id = v_uuidv5) THEN
		RETURN v_uuidv5;
	END IF;
	
	v_uuidv4 := public.uuidv4_for_email(p_address);
	IF v_uuidv4 IS NULL THEN
		IF p_create = TRUE THEN
			INSERT INTO public.email_addresses (email_id, group_key_alg) VALUES (v_uuidv5, 'uuidv5');
			RETURN v_uuidv5;
		ELSE
			RETURN NULL;
		END IF;
	ELSE
		UPDATE public.email_addresses SET email_id = v_uuidv5, address = NULL, group_key = NULL, group_key_precision = NULL, group_key_alg = 'uuidv5' WHERE email_id = v_uuidv4;
		RETURN v_uuidv5;
	END IF;
END;
$$;


ALTER FUNCTION public.uuid_for_email(p_address public.email, p_create boolean) OWNER TO thommcgrath;

--
-- Name: uuidv4_for_email(public.email); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.uuidv4_for_email(p_address public.email) RETURNS uuid
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	v_uuid UUID;
	v_group_params TEXT[][] := array[array['sha3-512', '4'], array['md5', '5'], array['md5', '2']];
	i INTEGER;
	v_group_key TEXT;
BEGIN
	FOR i IN ARRAY_LOWER(v_group_params, 1)..ARRAY_UPPER(v_group_params, 1) LOOP
		v_group_key := public.group_key_for_email(p_address, v_group_params[i][2]::INTEGER, v_group_params[i][1]);
		SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key = v_group_key AND CRYPT(LOWER(p_address), address) = address;
		IF FOUND THEN
			RETURN v_uuid;
		END IF;
	END LOOP;
	
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.uuidv4_for_email(p_address public.email) OWNER TO thommcgrath;

--
-- Name: uuidv5_for_email(public.email); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.uuidv5_for_email(p_address public.email) RETURNS uuid
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	RETURN uuid_generate_v5('7fa3e1c6-014a-4832-ad55-9a3fadcd866f', LOWER(TRIM(p_address)));
END;
$$;


ALTER FUNCTION public.uuidv5_for_email(p_address public.email) OWNER TO thommcgrath;

--
-- Name: websearch(text, text); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.websearch(p_field text, p_value text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	RETURN to_tsvector('english', p_field) @@ websearch_to_tsquery('english', p_value) OR p_field ILIKE public.escape_like_value(p_value);
END;
$$;


ALTER FUNCTION public.websearch(p_field text, p_value text) OWNER TO thommcgrath;

--
-- Name: object_delete_trigger(); Type: FUNCTION; Schema: sdtd; Owner: thommcgrath
--

CREATE FUNCTION sdtd.object_delete_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'INSERT INTO public.deletions (object_id, from_table, label, min_version, game_id) VALUES ($1, $2, $3, $4, $5);' USING OLD.object_id, TG_TABLE_NAME, OLD.label, OLD.min_version, '7DaysToDie';
	RETURN OLD;
END;
$_$;


ALTER FUNCTION sdtd.object_delete_trigger() OWNER TO thommcgrath;

--
-- Name: object_insert_trigger(); Type: FUNCTION; Schema: sdtd; Owner: thommcgrath
--

CREATE FUNCTION sdtd.object_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
	EXECUTE 'DELETE FROM public.deletions WHERE object_id = $1;' USING NEW.object_id;
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$_$;


ALTER FUNCTION sdtd.object_insert_trigger() OWNER TO thommcgrath;

--
-- Name: object_update_trigger(); Type: FUNCTION; Schema: sdtd; Owner: thommcgrath
--

CREATE FUNCTION sdtd.object_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sdtd.object_update_trigger() OWNER TO thommcgrath;

--
-- Name: version_to_int(integer, integer, integer, integer); Type: FUNCTION; Schema: sdtd; Owner: thommcgrath
--

CREATE FUNCTION sdtd.version_to_int(p_major integer, p_minor integer, p_bug integer, p_build integer) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	RETURN p_build + (p_bug * 1000) + (p_minor * 100000) + (p_major * 10000000);
END;
$$;


ALTER FUNCTION sdtd.version_to_int(p_major integer, p_minor integer, p_bug integer, p_build integer) OWNER TO thommcgrath;

--
-- Name: before_script_insert(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.before_script_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_hash TEXT;
BEGIN
	INSERT INTO sentinel.script_revisions (script_id, revision_number, code, parameters) VALUES (NEW.script_id, 1, NEW.code, NEW.parameters) RETURNING hash INTO v_hash;
	INSERT INTO sentinel.script_hashes (hash, status) VALUES (v_hash, sentinel.get_script_approval_status(NEW.language, NEW.code)) ON CONFLICT (hash) DO NOTHING;
	NEW.latest_revision = 1;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.before_script_insert() OWNER TO thommcgrath;

--
-- Name: before_script_update(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.before_script_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_hash TEXT;
	v_next_revision INTEGER;
BEGIN
	NEW.date_modified = CURRENT_TIMESTAMP;
	-- If the code has not changed, do not create a new revision and make sure the latest revision number isn't changed.
	IF NEW.code = OLD.code AND NEW.parameters = OLD.parameters THEN
		NEW.latest_revision = OLD.latest_revision;
		RETURN NEW;
	END IF;
	SELECT MAX(revision_number) + 1 INTO v_next_revision FROM sentinel.script_revisions WHERE script_id = NEW.script_id GROUP BY script_id;
	INSERT INTO sentinel.script_revisions (script_id, revision_number, code, parameters) VALUES (NEW.script_id, v_next_revision, NEW.code, NEW.parameters) RETURNING hash INTO v_hash;
	INSERT INTO sentinel.script_hashes (hash, status) VALUES (v_hash, sentinel.get_script_approval_status(NEW.language, NEW.code)) ON CONFLICT (hash) DO NOTHING;
	NEW.latest_revision = v_next_revision;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.before_script_update() OWNER TO thommcgrath;

--
-- Name: check_cluster_groups(uuid); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.check_cluster_groups(p_service_id uuid) RETURNS void
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	v_cluster_group_count INTEGER;
BEGIN
	SELECT COUNT(*) INTO v_cluster_group_count FROM sentinel.group_services INNER JOIN sentinel.groups ON (groups.group_id = group_services.group_id) WHERE group_services.service_id = p_service_id AND groups.is_cluster_group;
	IF v_cluster_group_count > 1 THEN
		RAISE EXCEPTION 'Too many cluster groups for service %.', p_service_id USING HINT = 'A service may only belong to a single group that has cluster features enabled.';
	END IF;
END;
$$;


ALTER FUNCTION sentinel.check_cluster_groups(p_service_id uuid) OWNER TO thommcgrath;

--
-- Name: check_script_test(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.check_script_test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_completed_time TIMESTAMP WITH TIME ZONE;
	v_queue_time TIMESTAMP WITH TIME ZONE;
BEGIN
	SELECT completed_time, queue_time INTO v_completed_time, v_queue_time FROM sentinel.script_tests WHERE user_id = NEW.user_id;
	IF FOUND THEN
		IF v_completed_time IS NULL AND v_queue_time > CURRENT_TIMESTAMP - '60 seconds'::INTERVAL THEN
			RAISE EXCEPTION 'User % already has a test running.', NEW.user_id USING HINT = 'Each user may only run one test may be running at a time.';
		END IF;
		
		NEW.queue_time = GREATEST(v_completed_time + '2 seconds'::INTERVAL, CURRENT_TIMESTAMP);
		DELETE FROM sentinel.script_tests WHERE user_id = NEW.user_id;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.check_script_test() OWNER TO thommcgrath;

--
-- Name: dino_update_trigger(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.dino_update_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.last_update = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.dino_update_trigger() OWNER TO thommcgrath;

--
-- Name: get_player_id(public.citext); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.get_player_id(p_identifier public.citext) RETURNS uuid
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	v_player_id UUID;
	v_provider CITEXT;
BEGIN
	v_provider := sentinel.provider_for_identifier(p_identifier);
	
	IF v_provider IS NOT NULL THEN
		SELECT player_id INTO v_player_id FROM sentinel.player_identifiers WHERE identifier = p_identifier AND provider = v_provider;
		RETURN v_player_id;
	ELSE
		BEGIN
			SELECT player_id INTO v_player_id FROM sentinel.players WHERE player_id = p_identifier::UUID;
			RETURN v_player_id;
		EXCEPTION WHEN OTHERS THEN
			RETURN NULL;
		END;
	END IF;
END;
$$;


ALTER FUNCTION sentinel.get_player_id(p_identifier public.citext) OWNER TO thommcgrath;

--
-- Name: get_player_id(public.citext, boolean); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.get_player_id(p_identifier public.citext, p_create boolean) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_player_id UUID;
	v_provider CITEXT;
	v_player_name CITEXT;
BEGIN
	-- We need to know what kind of identifier this is first
	v_provider := sentinel.provider_for_identifier(p_identifier);
	
	CASE v_provider
	WHEN 'EOS' THEN
		SELECT player_id INTO v_player_id FROM sentinel.player_identifiers WHERE identifier = p_identifier AND provider = v_provider;
		IF FOUND THEN
			RETURN v_player_id;
		END IF;
	ELSE
		-- Assume this is a Sentinel player id
		BEGIN
			SELECT player_id INTO v_player_id FROM sentinel.players WHERE player_id = p_identifier::UUID;
			IF FOUND THEN
				RETURN v_player_id;
			END IF;
		EXCEPTION WHEN OTHERS THEN
			-- No need to do anything here
		END;
		RETURN NULL;
	END CASE;
	
	-- Return null if we should not remember it.
	IF NOT p_create THEN
		RETURN NULL;
	END IF;
	
	-- Create it.
	v_player_id := gen_random_uuid();
	v_player_name := public.generate_username() || ' (Unseen Player)';
	INSERT INTO sentinel.players (player_id, name) VALUES (v_player_id, v_player_name);
	INSERT INTO sentinel.player_identifiers (player_id, provider, identifier, name) VALUES (v_player_id, v_provider, p_identifier, v_player_name);
	RETURN v_player_id;
END;
$$;


ALTER FUNCTION sentinel.get_player_id(p_identifier public.citext, p_create boolean) OWNER TO thommcgrath;

--
-- Name: get_script_approval_status(sentinel.script_language, text); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.get_script_approval_status(p_language sentinel.script_language, p_code text) RETURNS sentinel.script_approval_status
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	IF p_language = 'Simple' THEN
		RETURN 'Approved';
	ELSIF p_code ILIKE ANY('{%beacon.generateRandomBytes%,%beacon.generateUuidV4%,%beacon.generateUuidV5%,%beacon.generateUuidV7%,%beacon.hash%,%beacon.hmac%,%beacon.httpRequest%}') THEN
		RETURN 'Needs Review';
	ELSE
		RETURN 'Probation';
	END IF;
END;
$$;


ALTER FUNCTION sentinel.get_script_approval_status(p_language sentinel.script_language, p_code text) OWNER TO thommcgrath;

--
-- Name: group_services_after_edit(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.group_services_after_edit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_cluster_count INTEGER;
BEGIN
	PERFORM sentinel.check_cluster_groups(NEW.service_id);
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.group_services_after_edit() OWNER TO thommcgrath;

--
-- Name: groups_after_edit(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.groups_after_edit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_group_service RECORD;
BEGIN
	IF NEW.discord_link_code IS NOT NULL AND NEW.discord_guild_id IS NOT NULL THEN
		RAISE EXCEPTION 'One or both of discord_link_code and discord_guild_id must be NULL.';
	END IF;
	IF NEW.discord_guild_id IS NULL AND NEW.discord_chat_channel_id IS NOT NULL THEN
		RAISE EXCEPTION 'discord_chat_channel_id must be NULL if discord_guild_id is NULL.';
	END IF;
	IF NEW.discord_chat_channel_id IS NOT NULL AND NEW.enable_group_chat = FALSE THEN
		RAISE EXCEPTION 'discord_chat_channel_id must be NULL if enable_group_chat is FALSE.';
	END IF;
	
	IF NOT NEW.is_cluster_group THEN
		RETURN NEW;
	END IF;
	
	FOR v_group_service IN SELECT service_id FROM sentinel.group_services WHERE group_id = NEW.group_id LOOP
		PERFORM sentinel.check_cluster_groups(v_group_service.service_id);
	END LOOP;
	
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.groups_after_edit() OWNER TO thommcgrath;

--
-- Name: language_shortcode_to_regconfig(text); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.language_shortcode_to_regconfig(p_shortcode text) RETURNS regconfig
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_shortcode
	WHEN 'ar' THEN
		RETURN 'arabic';
	WHEN 'hy' THEN
		RETURN 'armenian';
	WHEN 'eu' THEN
		RETURN 'basque';
	WHEN 'ca' THEN
		RETURN 'catalan';
	WHEN 'da' THEN
		RETURN 'danish';
	WHEN 'nl' THEN
		RETURN 'dutch';
	WHEN 'fi' THEN
		RETURN 'finnish';
	WHEN 'fr' THEN
		RETURN 'french';
	WHEN 'de' THEN
		RETURN 'german';
	WHEN 'el' THEN
		RETURN 'greek';
	WHEN 'hi' THEN
		RETURN 'hindi';
	WHEN 'hu' THEN
		RETURN 'hungarian';
	WHEN 'id' THEN
		RETURN 'indonesian';
	WHEN 'ga' THEN
		RETURN 'irish';
	WHEN 'it' THEN
		RETURN 'italian';
	WHEN 'lt' THEN
		RETURN 'lithuanian';
	WHEN 'ne' THEN
		RETURN 'nepali';
	WHEN 'no' THEN
		RETURN 'norwegian';
	WHEN 'pt' THEN
		RETURN 'portuguese';
	WHEN 'ro' THEN
		RETURN 'romanian';
	WHEN 'ru' THEN
		RETURN 'russian';
	WHEN 'sr' THEN
		RETURN 'serbian';
	WHEN 'es' THEN
		RETURN 'spanish';
	WHEN 'sv' THEN
		RETURN 'swedish';
	WHEN 'ta' THEN
		RETURN 'tamil';
	WHEN 'tr' THEN
		RETURN 'turkish';
	WHEN 'yi' THEN
		RETURN 'yiddish';
	ELSE
		RETURN 'english';
	END CASE;
END;
$$;


ALTER FUNCTION sentinel.language_shortcode_to_regconfig(p_shortcode text) OWNER TO thommcgrath;

--
-- Name: FUNCTION language_shortcode_to_regconfig(p_shortcode text); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.language_shortcode_to_regconfig(p_shortcode text) IS 'Converts a two-character language code into something PG'' full text search supports.';


--
-- Name: log_level_position(sentinel.log_level); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.log_level_position(p_log_level sentinel.log_level) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
	CASE p_log_level
	WHEN 'Debug' THEN
		RETURN 0;
	WHEN 'Informational' THEN
		RETURN 1;
	WHEN 'Notice' THEN
		RETURN 2;
	WHEN 'Warning' THEN
		RETURN 3;
	WHEN 'Error' THEN
		RETURN 4;
	WHEN 'Critical' THEN
		RETURN 5;
	WHEN 'Alert' THEN
		RETURN 6;
	WHEN 'Emergency' THEN
		RETURN 7;
	ELSE
		RAISE EXCEPTION 'Unknown log level';
	END CASE;
END;
$$;


ALTER FUNCTION sentinel.log_level_position(p_log_level sentinel.log_level) OWNER TO thommcgrath;

--
-- Name: FUNCTION log_level_position(p_log_level sentinel.log_level); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.log_level_position(p_log_level sentinel.log_level) IS 'Provides sorting information for log levels.';


--
-- Name: notify_chat_trigger(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.notify_chat_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.event_name = 'chat' AND ((TG_OP = 'INSERT' AND NEW.analyzer_status = 'Pending') OR (TG_OP = 'UPDATE' AND NEW.analyzer_status = 'Pending' AND OLD.analyzer_status != 'Pending')) THEN
		PERFORM pg_notify('wakeChatProcessor', NULL);
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.notify_chat_trigger() OWNER TO thommcgrath;

--
-- Name: FUNCTION notify_chat_trigger(); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.notify_chat_trigger() IS 'Sends a notification to wake up the chat analyzer when a message is posted.';


--
-- Name: provider_for_identifier(public.citext); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.provider_for_identifier(p_identifier public.citext) RETURNS public.citext
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
	IF p_identifier ~* '^0002[0-9A-F]{28}$' THEN
		RETURN 'EOS';
	ELSE
		RETURN NULL;
	END IF;
END;
$_$;


ALTER FUNCTION sentinel.provider_for_identifier(p_identifier public.citext) OWNER TO thommcgrath;

--
-- Name: purge_service_data(uuid); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.purge_service_data(p_service_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	DELETE FROM sentinel.characters WHERE service_id = p_service_id;
	DELETE FROM sentinel.dinos WHERE service_id = p_service_id;
	DELETE FROM sentinel.service_event_queue WHERE service_id = p_service_id;
	DELETE FROM sentinel.service_logs WHERE service_id = p_service_id;
	DELETE FROM sentinel.tribes WHERE service_id = p_service_id;
END
$$;


ALTER FUNCTION sentinel.purge_service_data(p_service_id uuid) OWNER TO thommcgrath;

--
-- Name: save_player_note_history(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.save_player_note_history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.content != OLD.content THEN
		INSERT INTO sentinel.player_note_edits (note_id, previous_timestamp, previous_content) VALUES (OLD.note_id, OLD.date_modified, OLD.content);
		NEW.date_modified = CURRENT_TIMESTAMP;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION sentinel.save_player_note_history() OWNER TO thommcgrath;

--
-- Name: FUNCTION save_player_note_history(); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.save_player_note_history() IS 'Stores player note edits.';


--
-- Name: set_player_connect_time(uuid, uuid, timestamp with time zone); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.set_player_connect_time(p_player_id uuid, p_service_id uuid, p_connect_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_session_id UUID;
BEGIN
	PERFORM sentinel.set_player_disconnect_time(p_player_id, p_connect_time);
	INSERT INTO sentinel.player_sessions (player_id, service_id, active_times) VALUES (p_player_id, p_service_id, TSTZRANGE(p_connect_time, NULL, '[)')) RETURNING player_session_id INTO v_session_id;
	RETURN v_session_id;
END;
$$;


ALTER FUNCTION sentinel.set_player_connect_time(p_player_id uuid, p_service_id uuid, p_connect_time timestamp with time zone) OWNER TO thommcgrath;

--
-- Name: set_player_disconnect_time(uuid, timestamp with time zone); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.set_player_disconnect_time(p_player_id uuid, p_disconnect_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_session_id UUID;
BEGIN
	SELECT player_session_id INTO v_session_id FROM sentinel.player_sessions WHERE player_id = p_player_id AND UPPER_INF(active_times) = TRUE;
	IF FOUND THEN
		UPDATE sentinel.player_sessions SET active_times = TSTZRANGE(LOWER(active_times), p_disconnect_time, '[)') WHERE player_session_id = v_session_id;
		UPDATE sentinel.characters SET is_active = FALSE WHERE player_id = p_player_id AND is_active = TRUE;
		RETURN v_session_id;
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION sentinel.set_player_disconnect_time(p_player_id uuid, p_disconnect_time timestamp with time zone) OWNER TO thommcgrath;

--
-- Name: track_player_name(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.track_player_name() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF TG_OP = 'INSERT' OR (TG_OP = 'UPDATE' AND OLD.name != NEW.name) THEN
 		INSERT INTO sentinel.player_name_history (player_id, name, change_time) VALUES (NEW.player_id, NEW.name, CURRENT_TIMESTAMP);
 	END IF;
	RETURN NEW;
END
$$;


ALTER FUNCTION sentinel.track_player_name() OWNER TO thommcgrath;

--
-- Name: FUNCTION track_player_name(); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.track_player_name() IS 'Stores player name changes.';


--
-- Name: update_date_modified(); Type: FUNCTION; Schema: sentinel; Owner: thommcgrath
--

CREATE FUNCTION sentinel.update_date_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.date_modified = CURRENT_TIMESTAMP;
	RETURN NEW;
END
$$;


ALTER FUNCTION sentinel.update_date_modified() OWNER TO thommcgrath;

--
-- Name: FUNCTION update_date_modified(); Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON FUNCTION sentinel.update_date_modified() IS 'Updates the date_modified value of the attached table.';


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
    gfi text,
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
    multiplier_min numeric(6,4) DEFAULT 1.0 NOT NULL,
    multiplier_max numeric(6,4) DEFAULT 1.0 NOT NULL,
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
    icon_color public.ui_color DEFAULT 'White'::public.ui_color NOT NULL,
    CONSTRAINT loot_sources_check CHECK ((((sort IS NULL) AND (min_version >= 10303300) AND (modern_sort IS NOT NULL)) OR (sort IS NOT NULL))),
    CONSTRAINT loot_sources_check1 CHECK (((experimental = false) OR (min_version >= 10100202))),
    CONSTRAINT loot_sources_class_string_check1 CHECK ((class_string OPERATOR(public.~~) '%_C'::public.citext))
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


ALTER VIEW ark.blueprints OWNER TO thommcgrath;

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
-- Name: deletions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.deletions (
    object_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    from_table public.citext NOT NULL,
    label public.citext NOT NULL,
    min_version integer NOT NULL,
    action_time timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    tag text
);


ALTER TABLE public.deletions OWNER TO thommcgrath;

--
-- Name: deletions; Type: VIEW; Schema: ark; Owner: thommcgrath
--

CREATE VIEW ark.deletions AS
 SELECT object_id,
    from_table,
    label,
    min_version,
    action_time,
    tag
   FROM public.deletions
  WHERE (game_id = 'Ark'::public.game_identifier);


ALTER VIEW ark.deletions OWNER TO thommcgrath;

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
    uwp_changes jsonb,
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
-- Name: content_packs; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.content_packs (
    content_pack_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    marketplace public.marketplace NOT NULL,
    marketplace_id text NOT NULL,
    user_id uuid NOT NULL,
    name public.citext NOT NULL,
    confirmed boolean DEFAULT false NOT NULL,
    confirmation_code text DEFAULT gen_random_uuid() NOT NULL,
    console_safe boolean DEFAULT false NOT NULL,
    default_enabled boolean DEFAULT false NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    min_version integer DEFAULT 10500000 NOT NULL,
    include_in_deltas boolean DEFAULT false NOT NULL,
    is_official boolean DEFAULT false NOT NULL,
    game_specific jsonb DEFAULT '{}'::jsonb NOT NULL,
    slug text,
    required boolean DEFAULT false NOT NULL
);


ALTER TABLE public.content_packs OWNER TO thommcgrath;

--
-- Name: mods; Type: VIEW; Schema: ark; Owner: thommcgrath
--

CREATE VIEW ark.mods AS
 SELECT content_pack_id AS mod_id,
    (marketplace_id)::bigint AS workshop_id,
    user_id,
    name,
    confirmed,
    confirmation_code,
    NULL::text AS pull_url,
    NULL::text AS last_pull_hash,
    console_safe,
    default_enabled,
    last_update,
    min_version,
    include_in_deltas,
    (game_specific ->> 'tag'::text) AS tag,
    (game_specific ->> 'prefix'::text) AS prefix,
    (game_specific ->> 'map_folder'::text) AS map_folder,
    is_official,
    (marketplace = 'Steam'::public.marketplace) AS is_app
   FROM public.content_packs
  WHERE (game_id = 'Ark'::public.game_identifier);


ALTER VIEW ark.mods OWNER TO thommcgrath;

--
-- Name: mods_legacy; Type: TABLE; Schema: ark; Owner: thommcgrath
--

CREATE TABLE ark.mods_legacy (
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


ALTER TABLE ark.mods_legacy OWNER TO thommcgrath;

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
-- Name: objects; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.objects (
    object_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label public.citext NOT NULL,
    alternate_label public.citext,
    min_version integer DEFAULT 20000000 NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    content_pack_id uuid DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[],
    label_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (label)::text)) STORED,
    alternate_label_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (alternate_label)::text)) STORED
);


ALTER TABLE arksa.objects OWNER TO thommcgrath;

--
-- Name: creatures; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.creatures (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer NOT NULL,
    breedable boolean DEFAULT false NOT NULL,
    incubation_time interval,
    mature_time interval,
    mating_interval_min interval,
    mating_interval_max interval,
    used_stats integer,
    tag public.citext,
    min_base_level integer DEFAULT 1 NOT NULL,
    max_base_level integer DEFAULT 30 NOT NULL,
    CONSTRAINT creatures_check CHECK ((((mating_interval_min IS NULL) AND (mating_interval_max IS NULL)) OR ((mating_interval_min IS NOT NULL) AND (mating_interval_max IS NOT NULL)))),
    CONSTRAINT creatures_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.creatures OWNER TO thommcgrath;

--
-- Name: engrams; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.engrams (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    entry_string public.citext,
    required_points integer,
    required_level integer,
    stack_size integer,
    item_id integer,
    gfi text,
    CONSTRAINT engrams_check CHECK ((((entry_string IS NULL) AND (required_points IS NULL) AND (required_level IS NULL)) OR ((entry_string IS NOT NULL) AND (required_points IS DISTINCT FROM 999) AND (required_level IS DISTINCT FROM 999)))),
    CONSTRAINT engrams_entry_string_check CHECK ((entry_string OPERATOR(public.~) '_C$'::public.citext)),
    CONSTRAINT engrams_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.engrams OWNER TO thommcgrath;

--
-- Name: loot_drops; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.loot_drops (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer NOT NULL,
    multiplier_min numeric(6,4) DEFAULT 1.0 NOT NULL,
    multiplier_max numeric(6,4) DEFAULT 1.0 NOT NULL,
    icon uuid NOT NULL,
    sort_order public.citext NOT NULL,
    experimental boolean DEFAULT false NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    requirements jsonb DEFAULT '{}'::jsonb NOT NULL,
    simple_label public.citext,
    min_item_sets integer NOT NULL,
    max_item_sets integer NOT NULL,
    prevent_duplicates boolean NOT NULL,
    icon_color public.ui_color DEFAULT 'White'::public.ui_color NOT NULL,
    CONSTRAINT loot_drops_class_string_check CHECK ((class_string OPERATOR(public.~~) '%_C'::public.citext)),
    CONSTRAINT loot_drops_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.loot_drops OWNER TO thommcgrath;

--
-- Name: COLUMN loot_drops.simple_label; Type: COMMENT; Schema: arksa; Owner: thommcgrath
--

COMMENT ON COLUMN arksa.loot_drops.simple_label IS 'simple_label is a more ambiguous name that relies on the client to perform disambiguation';


--
-- Name: spawn_points; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_points (
    path public.citext NOT NULL,
    class_string public.citext NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    CONSTRAINT spawn_points_path_check CHECK ((path OPERATOR(public.~~) '/%'::public.citext))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.spawn_points OWNER TO thommcgrath;

--
-- Name: blueprints; Type: VIEW; Schema: arksa; Owner: thommcgrath
--

CREATE VIEW arksa.blueprints AS
 SELECT creatures.object_id,
    creatures.label,
    creatures.label_vector,
    creatures.alternate_label,
    creatures.alternate_label_vector,
    creatures.tableoid,
    creatures.min_version,
    creatures.last_update,
    creatures.content_pack_id,
    creatures.path,
    creatures.class_string,
    creatures.availability,
    creatures.tags
   FROM arksa.creatures
UNION
 SELECT engrams.object_id,
    engrams.label,
    engrams.label_vector,
    engrams.alternate_label,
    engrams.alternate_label_vector,
    engrams.tableoid,
    engrams.min_version,
    engrams.last_update,
    engrams.content_pack_id,
    engrams.path,
    engrams.class_string,
    engrams.availability,
    engrams.tags
   FROM arksa.engrams
UNION
 SELECT loot_drops.object_id,
    loot_drops.label,
    loot_drops.label_vector,
    loot_drops.alternate_label,
    loot_drops.alternate_label_vector,
    loot_drops.tableoid,
    loot_drops.min_version,
    loot_drops.last_update,
    loot_drops.content_pack_id,
    loot_drops.path,
    loot_drops.class_string,
    loot_drops.availability,
    loot_drops.tags
   FROM arksa.loot_drops
UNION
 SELECT spawn_points.object_id,
    spawn_points.label,
    spawn_points.label_vector,
    spawn_points.alternate_label,
    spawn_points.alternate_label_vector,
    spawn_points.tableoid,
    spawn_points.min_version,
    spawn_points.last_update,
    spawn_points.content_pack_id,
    spawn_points.path,
    spawn_points.class_string,
    spawn_points.availability,
    spawn_points.tags
   FROM arksa.spawn_points;


ALTER VIEW arksa.blueprints OWNER TO thommcgrath;

--
-- Name: color_sets; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.color_sets (
    color_set_id uuid NOT NULL,
    label public.citext NOT NULL,
    class_string public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE arksa.color_sets OWNER TO thommcgrath;

--
-- Name: colors; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.colors (
    color_id integer NOT NULL,
    color_name public.citext NOT NULL,
    color_code public.hex NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    color_label public.citext NOT NULL
);


ALTER TABLE arksa.colors OWNER TO thommcgrath;

--
-- Name: content_pack_relationships; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.content_pack_relationships (
    relation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    pack_1 uuid NOT NULL,
    pack_2 uuid NOT NULL
);


ALTER TABLE arksa.content_pack_relationships OWNER TO thommcgrath;

--
-- Name: content_packs; Type: VIEW; Schema: arksa; Owner: thommcgrath
--

CREATE VIEW arksa.content_packs AS
 SELECT content_pack_id,
    marketplace_id,
    user_id,
    name,
    confirmed,
    confirmation_code,
    console_safe,
    default_enabled,
    last_update,
    min_version,
    include_in_deltas,
    is_official
   FROM public.content_packs
  WHERE (game_id = 'ArkSA'::public.game_identifier);


ALTER VIEW arksa.content_packs OWNER TO thommcgrath;

--
-- Name: crafting_costs; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.crafting_costs (
    engram_id uuid NOT NULL,
    ingredient_id uuid NOT NULL,
    quantity integer NOT NULL,
    exact boolean NOT NULL,
    CONSTRAINT crafting_costs_check CHECK ((engram_id IS DISTINCT FROM ingredient_id)),
    CONSTRAINT crafting_costs_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE arksa.crafting_costs OWNER TO thommcgrath;

--
-- Name: creature_engrams; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.creature_engrams (
    relation_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    creature_id uuid NOT NULL,
    engram_id uuid NOT NULL
);


ALTER TABLE arksa.creature_engrams OWNER TO thommcgrath;

--
-- Name: creature_stats; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.creature_stats (
    creature_id uuid NOT NULL,
    stat_index integer NOT NULL,
    base_value numeric(16,6) NOT NULL,
    per_level_wild_multiplier numeric(16,6) NOT NULL,
    per_level_tamed_multiplier numeric(16,6) NOT NULL,
    add_multiplier numeric(16,6) NOT NULL,
    affinity_multiplier numeric(16,6) NOT NULL,
    CONSTRAINT creature_stats_stat_index_check CHECK (((stat_index >= 0) AND (stat_index <= 11)))
);


ALTER TABLE arksa.creature_stats OWNER TO thommcgrath;

--
-- Name: deletions; Type: VIEW; Schema: arksa; Owner: thommcgrath
--

CREATE VIEW arksa.deletions AS
 SELECT object_id,
    from_table,
    label,
    min_version,
    action_time,
    tag
   FROM public.deletions
  WHERE (game_id = 'ArkSA'::public.game_identifier);


ALTER VIEW arksa.deletions OWNER TO thommcgrath;

--
-- Name: engram_stats; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.engram_stats (
    engram_id uuid NOT NULL,
    stat_index integer NOT NULL,
    randomizer_range_override numeric(16,6) NOT NULL,
    randomizer_range_multiplier numeric(16,6) NOT NULL,
    state_modifier_scale numeric(16,6) NOT NULL,
    rating_value_multiplier numeric(16,6) NOT NULL,
    initial_value_constant numeric(16,6) NOT NULL,
    CONSTRAINT engram_stats_stat_index_check CHECK (((stat_index >= 0) AND (stat_index <= 7)))
);


ALTER TABLE arksa.engram_stats OWNER TO thommcgrath;

--
-- Name: event_colors; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.event_colors (
    event_id uuid NOT NULL,
    color_id integer NOT NULL
);


ALTER TABLE arksa.event_colors OWNER TO thommcgrath;

--
-- Name: event_engrams; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.event_engrams (
    event_id uuid NOT NULL,
    object_id uuid NOT NULL
);


ALTER TABLE arksa.event_engrams OWNER TO thommcgrath;

--
-- Name: event_rates; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.event_rates (
    event_id uuid NOT NULL,
    ini_option uuid NOT NULL,
    multiplier numeric(8,4) NOT NULL
);


ALTER TABLE arksa.event_rates OWNER TO thommcgrath;

--
-- Name: events; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.events (
    event_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    event_name public.citext NOT NULL,
    event_code public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE arksa.events OWNER TO thommcgrath;

--
-- Name: game_variables; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.game_variables (
    key text NOT NULL,
    value text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE arksa.game_variables OWNER TO thommcgrath;

--
-- Name: ini_options; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.ini_options (
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
    uwp_changes jsonb,
    CONSTRAINT ini_options_check CHECK ((((nitrado_path IS NULL) AND (nitrado_format IS NULL) AND (nitrado_deploy_style IS NULL)) OR ((nitrado_path IS NOT NULL) AND (nitrado_format IS NOT NULL) AND (nitrado_deploy_style IS NOT NULL)))),
    CONSTRAINT ini_options_check1 CHECK (((file IS DISTINCT FROM 'CommandLineFlag'::public.ini_file) OR ((file = 'CommandLineFlag'::public.ini_file) AND (value_type = 'Boolean'::public.ini_value_type)))),
    CONSTRAINT ini_options_max_allowed_check CHECK (((max_allowed IS NULL) OR (max_allowed >= 1)))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.ini_options OWNER TO thommcgrath;

--
-- Name: loot_drop_icons; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.loot_drop_icons (
    icon_data bytea NOT NULL
)
INHERITS (arksa.objects);


ALTER TABLE arksa.loot_drop_icons OWNER TO thommcgrath;

--
-- Name: loot_item_set_entries; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.loot_item_set_entries (
    loot_item_set_entry_id uuid NOT NULL,
    loot_item_set_id uuid NOT NULL,
    min_quantity integer NOT NULL,
    max_quantity integer NOT NULL,
    min_quality arksa.loot_quality_tier NOT NULL,
    max_quality arksa.loot_quality_tier NOT NULL,
    blueprint_chance numeric(16,6) NOT NULL,
    weight numeric(16,6) NOT NULL,
    single_item_quantity boolean NOT NULL,
    prevent_grinding boolean NOT NULL,
    stat_clamp_multiplier numeric(16,6) NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE arksa.loot_item_set_entries OWNER TO thommcgrath;

--
-- Name: loot_item_set_entry_options; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.loot_item_set_entry_options (
    loot_item_set_entry_option_id uuid NOT NULL,
    loot_item_set_entry_id uuid NOT NULL,
    engram_id uuid NOT NULL,
    weight numeric(16,6) NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE arksa.loot_item_set_entry_options OWNER TO thommcgrath;

--
-- Name: loot_item_sets; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.loot_item_sets (
    loot_item_set_id uuid NOT NULL,
    loot_drop_id uuid NOT NULL,
    label public.citext NOT NULL,
    min_entries integer NOT NULL,
    max_entries integer NOT NULL,
    weight numeric(16,6) NOT NULL,
    prevent_duplicates boolean NOT NULL,
    sync_sort_key text NOT NULL
);


ALTER TABLE arksa.loot_item_sets OWNER TO thommcgrath;

--
-- Name: maps; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.maps (
    map_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    content_pack_id uuid NOT NULL,
    label public.citext NOT NULL,
    difficulty_scale numeric(8,4) NOT NULL,
    mask bigint NOT NULL,
    sort integer NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type arksa.map_type NOT NULL,
    official boolean GENERATED ALWAYS AS ((type = 'Official Canon'::arksa.map_type)) STORED,
    engram_groups integer DEFAULT 10 NOT NULL,
    cycle_scale_multiplier numeric(8,4) DEFAULT 1.0 NOT NULL,
    day_scale_multiplier numeric(8,4) DEFAULT 1.0 NOT NULL,
    night_scale_multiplier numeric(8,4) DEFAULT 1.0 NOT NULL,
    day_start_time integer DEFAULT 18900 NOT NULL,
    day_end_time integer DEFAULT 73400 NOT NULL,
    world_name public.citext NOT NULL,
    ark_identifier text GENERATED ALWAYS AS (public.regexp_replace(world_name, '_WP$'::public.citext, ''::text)) STORED,
    CONSTRAINT maps_mask_check CHECK ((ceiling(log((2)::numeric, (mask)::numeric)) = floor(log((2)::numeric, (mask)::numeric))))
);


ALTER TABLE arksa.maps OWNER TO thommcgrath;

--
-- Name: COLUMN maps.ark_identifier; Type: COMMENT; Schema: arksa; Owner: thommcgrath
--

COMMENT ON COLUMN arksa.maps.ark_identifier IS 'This is a legacy column needed by Beacon 2.0.0 through 2.3.0';


--
-- Name: spawn_point_limits; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_limits (
    spawn_point_id uuid NOT NULL,
    creature_id uuid NOT NULL,
    max_percentage numeric(5,4)
);


ALTER TABLE arksa.spawn_point_limits OWNER TO thommcgrath;

--
-- Name: spawn_point_populations; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_populations (
    population_id uuid NOT NULL,
    spawn_point_id uuid NOT NULL,
    map_id uuid NOT NULL,
    instances_on_map integer NOT NULL,
    max_population integer NOT NULL
);


ALTER TABLE arksa.spawn_point_populations OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entries; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_set_entries (
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


ALTER TABLE arksa.spawn_point_set_entries OWNER TO thommcgrath;

--
-- Name: spawn_point_set_entry_levels; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_set_entry_levels (
    spawn_point_set_entry_level_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_entry_id uuid NOT NULL,
    difficulty numeric(16,6) NOT NULL,
    min_level numeric(16,6) NOT NULL,
    max_level numeric(16,6) NOT NULL
);


ALTER TABLE arksa.spawn_point_set_entry_levels OWNER TO thommcgrath;

--
-- Name: spawn_point_set_replacements; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_set_replacements (
    spawn_point_set_replacement_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    spawn_point_set_id uuid NOT NULL,
    target_creature_id uuid NOT NULL,
    replacement_creature_id uuid NOT NULL,
    weight numeric(16,6) NOT NULL
);


ALTER TABLE arksa.spawn_point_set_replacements OWNER TO thommcgrath;

--
-- Name: spawn_point_sets; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.spawn_point_sets (
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


ALTER TABLE arksa.spawn_point_sets OWNER TO thommcgrath;

--
-- Name: template_selectors; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.template_selectors (
    pattern text NOT NULL,
    language public.citext NOT NULL,
    CONSTRAINT template_selectors_check CHECK (((min_version >= 10600000) OR (language OPERATOR(public.=) 'regex'::public.citext)))
)
INHERITS (arksa.objects);


ALTER TABLE arksa.template_selectors OWNER TO thommcgrath;

--
-- Name: templates; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.templates (
    contents jsonb NOT NULL
)
INHERITS (arksa.objects);


ALTER TABLE arksa.templates OWNER TO thommcgrath;

--
-- Name: traits; Type: TABLE; Schema: arksa; Owner: thommcgrath
--

CREATE TABLE arksa.traits (
    path public.citext NOT NULL,
    max_allowed integer NOT NULL,
    description public.citext NOT NULL,
    name text NOT NULL
)
INHERITS (arksa.objects);


ALTER TABLE arksa.traits OWNER TO thommcgrath;

--
-- Name: content_packs; Type: VIEW; Schema: palworld; Owner: thommcgrath
--

CREATE VIEW palworld.content_packs AS
 SELECT content_pack_id,
    marketplace_id,
    user_id,
    name,
    confirmed,
    confirmation_code,
    console_safe,
    default_enabled,
    last_update,
    min_version,
    include_in_deltas,
    is_official
   FROM public.content_packs
  WHERE (game_id = 'Palworld'::public.game_identifier);


ALTER VIEW palworld.content_packs OWNER TO thommcgrath;

--
-- Name: deletions; Type: VIEW; Schema: palworld; Owner: thommcgrath
--

CREATE VIEW palworld.deletions AS
 SELECT object_id,
    from_table,
    label,
    min_version,
    action_time,
    tag
   FROM public.deletions
  WHERE (game_id = 'Palworld'::public.game_identifier);


ALTER VIEW palworld.deletions OWNER TO thommcgrath;

--
-- Name: game_variables; Type: TABLE; Schema: palworld; Owner: thommcgrath
--

CREATE TABLE palworld.game_variables (
    key text NOT NULL,
    value text NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE palworld.game_variables OWNER TO thommcgrath;

--
-- Name: objects; Type: TABLE; Schema: palworld; Owner: thommcgrath
--

CREATE TABLE palworld.objects (
    object_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label public.citext NOT NULL,
    alternate_label public.citext,
    min_version integer DEFAULT 20000000 NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    content_pack_id uuid DEFAULT '9fcaeedc-c5ac-420f-8066-fee0a00ce96d'::uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[]
);


ALTER TABLE palworld.objects OWNER TO thommcgrath;

--
-- Name: ini_options; Type: TABLE; Schema: palworld; Owner: thommcgrath
--

CREATE TABLE palworld.ini_options (
    native_editor_version integer,
    file palworld.config_file DEFAULT 'PalWorldSettings.ini'::palworld.config_file NOT NULL,
    header public.citext DEFAULT '/Script/Pal.PalGameWorldSettings'::public.citext NOT NULL,
    struct public.citext DEFAULT 'OptionSettings'::public.citext,
    key public.citext NOT NULL,
    value_type public.ini_value_type NOT NULL,
    max_allowed integer DEFAULT 1,
    description text NOT NULL,
    default_value text NOT NULL,
    nitrado_path public.citext,
    nitrado_format public.nitrado_format,
    nitrado_deploy_style public.nitrado_deploy_style,
    ui_group public.citext,
    constraints jsonb,
    custom_sort public.citext,
    CONSTRAINT ini_options_max_allowed_check CHECK (((max_allowed IS NULL) OR (max_allowed >= 1))),
    CONSTRAINT ini_options_nitrado_check CHECK ((((nitrado_path IS NULL) AND (nitrado_format IS NULL) AND (nitrado_deploy_style IS NULL)) OR ((nitrado_path IS NOT NULL) AND (nitrado_format IS NOT NULL) AND (nitrado_deploy_style IS NOT NULL))))
)
INHERITS (palworld.objects);


ALTER TABLE palworld.ini_options OWNER TO thommcgrath;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.access_tokens (
    access_token_hash text NOT NULL,
    refresh_token_hash text NOT NULL,
    access_token_encrypted text NOT NULL,
    refresh_token_encrypted text NOT NULL,
    access_token_expiration timestamp with time zone NOT NULL,
    refresh_token_expiration timestamp with time zone NOT NULL,
    user_id uuid NOT NULL,
    application_id uuid NOT NULL,
    remote_ip inet NOT NULL,
    remote_country text NOT NULL,
    remote_agent text NOT NULL,
    scopes text NOT NULL,
    private_key_encrypted jsonb
);


ALTER TABLE public.access_tokens OWNER TO thommcgrath;

--
-- Name: affiliate_links; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.affiliate_links (
    code public.citext NOT NULL,
    user_id uuid NOT NULL,
    description text NOT NULL,
    destination text NOT NULL,
    revenue_share numeric(4,3) NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    CONSTRAINT affiliate_links_revenue_share_check CHECK (((revenue_share >= (0)::numeric) AND (revenue_share <= (1)::numeric)))
);


ALTER TABLE public.affiliate_links OWNER TO thommcgrath;

--
-- Name: affiliate_products; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.affiliate_products (
    affiliate_id public.citext NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.affiliate_products OWNER TO thommcgrath;

--
-- Name: affiliate_tracking; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.affiliate_tracking (
    track_id uuid DEFAULT gen_random_uuid() NOT NULL,
    code public.citext NOT NULL,
    client_reference_id text NOT NULL,
    click_time timestamp with time zone NOT NULL,
    purchase_id uuid
);


ALTER TABLE public.affiliate_tracking OWNER TO thommcgrath;

--
-- Name: purchases; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchases (
    purchase_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    purchaser_email uuid NOT NULL,
    purchase_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    discount numeric(12,2) NOT NULL,
    tax numeric(12,2) NOT NULL,
    total numeric(12,2) NOT NULL,
    merchant_reference public.citext NOT NULL,
    client_reference_id text,
    refunded boolean DEFAULT false NOT NULL,
    tax_locality text,
    currency public.citext NOT NULL,
    issued boolean DEFAULT false NOT NULL,
    notes text,
    first_used timestamp with time zone,
    conversion_rate numeric(25,15),
    subtotal_usd numeric(12,2),
    discount_usd numeric(12,2),
    tax_usd numeric(12,2),
    total_usd numeric(12,2),
    amount_paid numeric(12,2) NOT NULL,
    amount_paid_usd numeric(12,2),
    date_fulfilled timestamp with time zone,
    metadata jsonb,
    CONSTRAINT purchases_check CHECK ((((conversion_rate IS NULL) AND (subtotal_usd IS NULL) AND (discount_usd IS NULL) AND (tax_usd IS NULL) AND (total_usd IS NULL) AND (amount_paid_usd IS NULL)) OR ((conversion_rate IS NOT NULL) AND (subtotal_usd IS NOT NULL) AND (discount_usd IS NOT NULL) AND (tax_usd IS NOT NULL) AND (total_usd IS NOT NULL) AND (amount_paid_usd IS NOT NULL)))),
    CONSTRAINT purchases_currency_check CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.purchases OWNER TO thommcgrath;

--
-- Name: affiliate_purchases; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.affiliate_purchases AS
 SELECT affiliate_links.code AS affiliate_id,
    purchases.purchase_id,
    purchases.purchase_date,
    purchases.total,
    ((purchases.total * affiliate_links.revenue_share))::numeric(12,2) AS commission
   FROM ((public.purchases
     JOIN public.affiliate_tracking ON ((purchases.client_reference_id = affiliate_tracking.client_reference_id)))
     JOIN public.affiliate_links ON ((affiliate_tracking.code OPERATOR(public.=) affiliate_links.code)));


ALTER VIEW public.affiliate_purchases OWNER TO thommcgrath;

--
-- Name: application_auth_flows; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.application_auth_flows (
    flow_id uuid NOT NULL,
    application_id uuid NOT NULL,
    scopes text NOT NULL,
    callback text NOT NULL,
    state text NOT NULL,
    code_hash text,
    verifier_hash text NOT NULL,
    verifier_hash_algorithm text NOT NULL,
    user_id uuid,
    expiration timestamp with time zone DEFAULT (CURRENT_TIMESTAMP(0) + '00:30:00'::interval) NOT NULL,
    public_key text,
    private_key_encrypted jsonb,
    CONSTRAINT application_auth_flows_check CHECK ((((public_key IS NULL) AND (private_key_encrypted IS NULL)) OR ((public_key IS NOT NULL) AND (private_key_encrypted IS NULL)) OR ((public_key IS NOT NULL) AND (private_key_encrypted IS NOT NULL)))),
    CONSTRAINT application_auth_flows_check1 CHECK ((((code_hash IS NULL) AND (user_id IS NULL)) OR ((code_hash IS NOT NULL) AND (user_id IS NOT NULL))))
);


ALTER TABLE public.application_auth_flows OWNER TO thommcgrath;

--
-- Name: application_callbacks; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.application_callbacks (
    application_id uuid NOT NULL,
    url text NOT NULL
);


ALTER TABLE public.application_callbacks OWNER TO thommcgrath;

--
-- Name: applications; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.applications (
    application_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    secret text,
    name public.citext NOT NULL,
    website text NOT NULL,
    icon_filename text DEFAULT 'default/{{size}}.png'::text NOT NULL,
    scopes text NOT NULL,
    rate_limit integer DEFAULT 50 NOT NULL,
    is_official boolean NOT NULL,
    experience integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.applications OWNER TO thommcgrath;

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
-- Name: content_pack_discovery_results; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.content_pack_discovery_results (
    content_pack_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    marketplace public.marketplace NOT NULL,
    marketplace_id text NOT NULL,
    name public.citext NOT NULL,
    last_update timestamp with time zone NOT NULL,
    min_version integer NOT NULL,
    storage_path text NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    slug text,
    CONSTRAINT content_pack_discovery_results_check CHECK ((content_pack_id = public.generate_uuid_from_text(((('Local '::text || (marketplace)::text) || ': '::text) || marketplace_id))))
);


ALTER TABLE public.content_pack_discovery_results OWNER TO thommcgrath;

--
-- Name: content_packs_combined; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.content_packs_combined AS
 WITH combined_packs AS (
         SELECT content_packs.content_pack_id,
            content_packs.game_id,
            content_packs.marketplace,
            content_packs.marketplace_id,
            content_packs.name,
            content_packs.last_update,
                CASE
                    WHEN ((content_packs.game_id = ANY (ARRAY['Ark'::public.game_identifier, 'ArkSA'::public.game_identifier])) AND ((content_packs.game_specific ->> 'prefix'::text) IS NOT NULL)) THEN 0
                    WHEN (content_packs.user_id = '7fe29603-c3da-4930-9fdd-ae9952f98be8'::uuid) THEN 3
                    ELSE 1
                END AS type,
            content_packs.slug
           FROM public.content_packs
          WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
        UNION
         SELECT content_pack_discovery_results.content_pack_id,
            content_pack_discovery_results.game_id,
            content_pack_discovery_results.marketplace,
            content_pack_discovery_results.marketplace_id,
            content_pack_discovery_results.name,
            content_pack_discovery_results.last_update,
            2 AS type,
            content_pack_discovery_results.slug
           FROM public.content_pack_discovery_results
          WHERE (content_pack_discovery_results.deleted = false)
        )
 SELECT DISTINCT ON ((marketplace || marketplace_id)) content_pack_id,
    game_id,
    marketplace,
    marketplace_id,
    name,
    last_update,
    type,
    slug
   FROM combined_packs
  ORDER BY (marketplace || marketplace_id), type;


ALTER VIEW public.content_packs_combined OWNER TO thommcgrath;

--
-- Name: rcon_commands; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.rcon_commands (
    command_id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_id public.game_identifier NOT NULL,
    name public.citext NOT NULL,
    description public.citext NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.rcon_commands OWNER TO thommcgrath;

--
-- Name: objects; Type: TABLE; Schema: sdtd; Owner: thommcgrath
--

CREATE TABLE sdtd.objects (
    object_id uuid NOT NULL,
    label public.citext NOT NULL,
    min_version integer DEFAULT 10700000 NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content_pack_id uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[] NOT NULL,
    alternate_label public.citext
);


ALTER TABLE sdtd.objects OWNER TO thommcgrath;

--
-- Name: content_update_times; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.content_update_times AS
 SELECT objects.last_update,
    objects.mod_id AS content_pack_id,
    GREATEST(objects.min_version, content_packs.min_version) AS min_version
   FROM (ark.objects
     JOIN public.content_packs ON ((objects.mod_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT deletions.action_time AS last_update,
    NULL::uuid AS content_pack_id,
    deletions.min_version
   FROM public.deletions
UNION
 SELECT max(game_variables.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM ark.game_variables
UNION
 SELECT content_packs.last_update,
    content_packs.content_pack_id,
    content_packs.min_version
   FROM public.content_packs
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT maps.last_update,
    maps.mod_id AS content_pack_id,
    content_packs.min_version
   FROM (ark.maps
     JOIN public.content_packs ON ((maps.mod_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT max(events.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM ark.events
UNION
 SELECT max(colors.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM ark.colors
UNION
 SELECT max(color_sets.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM ark.color_sets
UNION
 SELECT objects.last_update,
    objects.content_pack_id,
    GREATEST(objects.min_version, content_packs.min_version) AS min_version
   FROM (sdtd.objects
     JOIN public.content_packs ON ((objects.content_pack_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT objects.last_update,
    objects.content_pack_id,
    GREATEST(objects.min_version, content_packs.min_version) AS min_version
   FROM (arksa.objects
     JOIN public.content_packs ON ((objects.content_pack_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT max(game_variables.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM arksa.game_variables
UNION
 SELECT maps.last_update,
    maps.content_pack_id,
    content_packs.min_version
   FROM (arksa.maps
     JOIN public.content_packs ON ((maps.content_pack_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT max(events.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM arksa.events
UNION
 SELECT max(colors.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM arksa.colors
UNION
 SELECT max(color_sets.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM arksa.color_sets
UNION
 SELECT objects.last_update,
    objects.content_pack_id,
    GREATEST(objects.min_version, content_packs.min_version) AS min_version
   FROM (palworld.objects
     JOIN public.content_packs ON ((objects.content_pack_id = content_packs.content_pack_id)))
  WHERE ((content_packs.confirmed = true) AND (content_packs.include_in_deltas = true))
UNION
 SELECT max(rcon_commands.last_update) AS last_update,
    NULL::uuid AS content_pack_id,
    0 AS min_version
   FROM public.rcon_commands;


ALTER VIEW public.content_update_times OWNER TO thommcgrath;

--
-- Name: corrupt_files; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.corrupt_files (
    file_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    contents bytea NOT NULL
);


ALTER TABLE public.corrupt_files OWNER TO thommcgrath;

--
-- Name: currencies; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.currencies (
    code public.citext NOT NULL,
    name text NOT NULL,
    usd_conversion_rate numeric(20,10) NOT NULL,
    rounding_multiplier numeric(6,2) DEFAULT 1.00 NOT NULL,
    fee_multiplier numeric(6,2) DEFAULT 1.01 NOT NULL,
    stripe_multiplier integer DEFAULT 100 NOT NULL
);


ALTER TABLE public.currencies OWNER TO thommcgrath;

--
-- Name: device_auth_flows; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.device_auth_flows (
    device_code uuid NOT NULL,
    application_id uuid NOT NULL,
    scopes text NOT NULL,
    verifier_hash text NOT NULL,
    verifier_hash_algorithm text NOT NULL,
    expiration timestamp with time zone DEFAULT (CURRENT_TIMESTAMP + '00:10:00'::interval) NOT NULL,
    public_key text,
    user_id uuid,
    private_key_encrypted jsonb,
    CONSTRAINT device_auth_flows_check CHECK ((((user_id IS NULL) AND (private_key_encrypted IS NULL)) OR ((user_id IS NOT NULL) AND (public_key IS NULL) AND (private_key_encrypted IS NULL)) OR ((user_id IS NOT NULL) AND (public_key IS NOT NULL) AND (private_key_encrypted IS NOT NULL))))
);


ALTER TABLE public.device_auth_flows OWNER TO thommcgrath;

--
-- Name: discord_bots; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.discord_bots (
    bot_id uuid DEFAULT gen_random_uuid() NOT NULL,
    token bytea NOT NULL,
    instance_key text NOT NULL,
    shards integer DEFAULT 1 NOT NULL,
    shards_connected integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.discord_bots OWNER TO thommcgrath;

--
-- Name: discord_channels; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.discord_channels (
    channel_id text NOT NULL,
    guild_id text NOT NULL,
    channel_name public.citext NOT NULL,
    channel_type integer NOT NULL,
    channel_parent_id text
);


ALTER TABLE public.discord_channels OWNER TO thommcgrath;

--
-- Name: discord_guilds; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.discord_guilds (
    guild_id text NOT NULL,
    guild_name public.citext NOT NULL,
    bot_id uuid NOT NULL
);


ALTER TABLE public.discord_guilds OWNER TO thommcgrath;

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
    address text,
    group_key public.hex,
    group_key_precision integer,
    group_key_alg public.citext NOT NULL,
    CONSTRAINT email_addresses_check CHECK ((((group_key_alg OPERATOR(public.=) 'uuidv5'::public.citext) AND (address IS NULL) AND (group_key IS NULL) AND (group_key_precision IS NULL)) OR ((group_key_alg OPERATOR(public.<>) 'uuidv5'::public.citext) AND (address IS NOT NULL) AND (group_key IS NOT NULL) AND (group_key_precision IS NOT NULL))))
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
-- Name: email_verification_codes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.email_verification_codes (
    email_id uuid NOT NULL,
    code_hash text NOT NULL,
    code_encrypted text,
    expiration timestamp with time zone DEFAULT (CURRENT_TIMESTAMP + '04:00:00'::interval) NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    return_uri text
);


ALTER TABLE public.email_verification_codes OWNER TO thommcgrath;

--
-- Name: endpoint_git_hashes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.endpoint_git_hashes (
    branch public.citext NOT NULL,
    hash public.citext NOT NULL
);


ALTER TABLE public.endpoint_git_hashes OWNER TO thommcgrath;

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
-- Name: games; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.games (
    game_id public.game_identifier NOT NULL,
    game_name public.citext NOT NULL,
    marketplace public.marketplace NOT NULL,
    marketplace_id text NOT NULL,
    early_access boolean NOT NULL,
    beacon_major_version integer NOT NULL,
    beacon_minor_version integer NOT NULL,
    public boolean NOT NULL
);


ALTER TABLE public.games OWNER TO thommcgrath;

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
-- Name: gift_code_products; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.gift_code_products (
    code public.citext NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT gift_code_products_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.gift_code_products OWNER TO thommcgrath;

--
-- Name: gift_codes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.gift_codes (
    code public.citext NOT NULL,
    source_purchase_id uuid NOT NULL,
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
-- Name: legacy_sessions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.legacy_sessions (
    session_id public.citext NOT NULL,
    user_id uuid NOT NULL,
    valid_until timestamp with time zone,
    remote_ip inet,
    remote_country text,
    remote_agent text,
    CONSTRAINT sessions_check CHECK ((((remote_ip IS NULL) AND (remote_country IS NULL) AND (remote_agent IS NULL)) OR ((remote_ip IS NOT NULL) AND (remote_country IS NOT NULL) AND (remote_agent IS NOT NULL))))
);


ALTER TABLE public.legacy_sessions OWNER TO thommcgrath;

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
    supported_games public.game_identifier[] NOT NULL,
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


ALTER VIEW public.news OWNER TO thommcgrath;

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
-- Name: payment_method_currencies; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.payment_method_currencies (
    payment_method_code public.citext NOT NULL,
    currency_code public.citext NOT NULL
);


ALTER TABLE public.payment_method_currencies OWNER TO thommcgrath;

--
-- Name: policies; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.policies (
    policy_id uuid DEFAULT gen_random_uuid() NOT NULL,
    lookup_key public.citext NOT NULL,
    title public.citext NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    content text NOT NULL,
    current_revision integer NOT NULL
);


ALTER TABLE public.policies OWNER TO thommcgrath;

--
-- Name: policy_revisions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.policy_revisions (
    revision_id uuid DEFAULT gen_random_uuid() NOT NULL,
    policy_id uuid NOT NULL,
    revision_number integer NOT NULL,
    revision_date timestamp with time zone NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.policy_revisions OWNER TO thommcgrath;

--
-- Name: policy_signatures; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.policy_signatures (
    signature_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    policy_id uuid NOT NULL,
    revision_number integer NOT NULL,
    signature_date timestamp with time zone NOT NULL
);


ALTER TABLE public.policy_signatures OWNER TO thommcgrath;

--
-- Name: policy_signing_requests; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.policy_signing_requests (
    policy_signing_request_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    policy_id uuid NOT NULL,
    expiration timestamp with time zone DEFAULT (CURRENT_TIMESTAMP + '01:00:00'::interval) NOT NULL,
    return_url text NOT NULL,
    challenge text NOT NULL
);


ALTER TABLE public.policy_signing_requests OWNER TO thommcgrath;

--
-- Name: processed_webhooks; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.processed_webhooks (
    event_id uuid NOT NULL,
    date_processed timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.processed_webhooks OWNER TO thommcgrath;

--
-- Name: product_prices; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.product_prices (
    price_id text NOT NULL,
    product_id uuid NOT NULL,
    currency public.citext NOT NULL,
    price numeric(12,2) NOT NULL,
    CONSTRAINT product_prices_currency_check CHECK ((length((currency)::text) = 3))
);


ALTER TABLE public.product_prices OWNER TO thommcgrath;

--
-- Name: products; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.products (
    product_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    product_name text NOT NULL,
    retail_price numeric(12,2) NOT NULL,
    child_seat_count integer DEFAULT 0 NOT NULL,
    updates_length interval,
    flags integer,
    round_to numeric(6,2) DEFAULT 1.0 NOT NULL,
    game_id public.citext NOT NULL,
    tag public.citext NOT NULL,
    active boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    product_type public.product_type NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    monthly_price_id text,
    yearly_price_id text,
    CONSTRAINT products_check CHECK ((((product_type = 'One-Time'::public.product_type) AND (monthly_price_id IS NULL) AND (yearly_price_id IS NULL)) OR ((product_type = 'Subscription'::public.product_type) AND (monthly_price_id IS NOT NULL) AND (yearly_price_id IS NOT NULL)) OR (active = false)))
);


ALTER TABLE public.products OWNER TO thommcgrath;

--
-- Name: project_invites; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.project_invites (
    invite_code public.citext NOT NULL,
    project_id uuid NOT NULL,
    project_password text NOT NULL,
    role public.project_role NOT NULL,
    creator_id uuid NOT NULL,
    creation_date timestamp with time zone NOT NULL,
    expiration_date timestamp with time zone NOT NULL
);


ALTER TABLE public.project_invites OWNER TO thommcgrath;

--
-- Name: project_members; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.project_members (
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role public.project_role NOT NULL,
    encrypted_password text,
    fingerprint text,
    CONSTRAINT project_members_check CHECK ((((encrypted_password IS NULL) AND (fingerprint IS NULL)) OR ((encrypted_password IS NOT NULL) AND (fingerprint IS NOT NULL))))
);


ALTER TABLE public.project_members OWNER TO thommcgrath;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.projects (
    project_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    title public.citext NOT NULL,
    description public.citext NOT NULL,
    console_safe boolean NOT NULL,
    last_update timestamp with time zone NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    download_count integer DEFAULT 0 NOT NULL,
    published public.publish_status DEFAULT 'Private'::public.publish_status NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    game_specific jsonb DEFAULT '{}'::jsonb NOT NULL,
    storage_path text
);


ALTER TABLE public.projects OWNER TO thommcgrath;

--
-- Name: purchase_items; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.purchase_items (
    line_id uuid DEFAULT gen_random_uuid() NOT NULL,
    purchase_id uuid NOT NULL,
    product_id uuid NOT NULL,
    currency public.citext NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    discount numeric(12,2) NOT NULL,
    tax numeric(12,2) NOT NULL,
    line_total numeric(12,2) NOT NULL,
    conversion_rate numeric(25,15),
    unit_price_usd numeric(12,2),
    subtotal_usd numeric(12,2),
    discount_usd numeric(12,2),
    tax_usd numeric(12,2),
    line_total_usd numeric(12,2),
    CONSTRAINT purchase_items_check CHECK ((subtotal = (unit_price * (quantity)::numeric))),
    CONSTRAINT purchase_items_check1 CHECK ((line_total = ((subtotal + tax) - discount))),
    CONSTRAINT purchase_items_check2 CHECK ((((conversion_rate IS NULL) AND (unit_price_usd IS NULL) AND (subtotal_usd IS NULL) AND (discount_usd IS NULL) AND (tax_usd IS NULL) AND (line_total_usd IS NULL)) OR ((conversion_rate IS NOT NULL) AND (unit_price_usd IS NOT NULL) AND (subtotal_usd IS NOT NULL) AND (discount_usd IS NOT NULL) AND (tax_usd IS NOT NULL) AND (line_total_usd IS NOT NULL)))),
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
-- Name: purchased_products; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.purchased_products AS
 SELECT licenses.product_id,
    products.product_name,
    licenses.purchase_id,
    purchases.purchase_date,
    purchases.purchaser_email,
    purchases.client_reference_id,
    licenses.expiration,
    products.flags
   FROM ((public.licenses
     JOIN public.products ON ((licenses.product_id = products.product_id)))
     JOIN public.purchases ON ((licenses.purchase_id = purchases.purchase_id)))
  WHERE (purchases.refunded <> true);


ALTER VIEW public.purchased_products OWNER TO thommcgrath;

--
-- Name: VIEW purchased_products; Type: COMMENT; Schema: public; Owner: thommcgrath
--

COMMENT ON VIEW public.purchased_products IS 'This view combies the most useful parts of the purchases, licenses, and products table to give convenient access to a user''s most recent license info.';


--
-- Name: rcon_parameters; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.rcon_parameters (
    command_id uuid NOT NULL,
    "position" integer NOT NULL,
    name public.citext NOT NULL,
    data_type public.citext NOT NULL,
    description public.citext NOT NULL
);


ALTER TABLE public.rcon_parameters OWNER TO thommcgrath;

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
    NULL::public.game_identifier AS game_id,
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
    NULL::public.game_identifier AS game_id,
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
    content_packs.game_id,
    ''::text AS body,
    ''::text AS preview,
    blueprints.class_string AS meta_content,
    'Object'::text AS type,
    (( SELECT pg_class.relname
           FROM pg_class
          WHERE (pg_class.oid = blueprints.tableoid)))::text AS subtype,
    ((((('/Games/'::text || (content_packs.game_id)::text) || '/Mods/'::text) || content_packs.marketplace_id) || '/'::text) || (blueprints.class_string)::text) AS uri,
    blueprints.min_version,
    99999999 AS max_version,
    blueprints.mod_id
   FROM (ark.blueprints
     JOIN public.content_packs ON ((blueprints.mod_id = content_packs.content_pack_id)))
UNION
 SELECT blueprints.object_id AS id,
    blueprints.label AS title,
    content_packs.game_id,
    ''::text AS body,
    ''::text AS preview,
    blueprints.class_string AS meta_content,
    'Object'::text AS type,
    (( SELECT pg_class.relname
           FROM pg_class
          WHERE (pg_class.oid = blueprints.tableoid)))::text AS subtype,
    ((((('/Games/'::text || (content_packs.game_id)::text) || '/Mods/'::text) || content_packs.marketplace_id) || '/'::text) || (blueprints.class_string)::text) AS uri,
    blueprints.min_version,
    99999999 AS max_version,
    blueprints.content_pack_id AS mod_id
   FROM (arksa.blueprints
     JOIN public.content_packs ON ((blueprints.content_pack_id = content_packs.content_pack_id)))
UNION
 SELECT projects.project_id AS id,
    projects.title,
    projects.game_id,
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
  WHERE ((projects.published = 'Approved'::public.publish_status) AND (projects.deleted = false))
UNION
 SELECT content_packs.content_pack_id AS id,
    content_packs.name AS title,
    content_packs.game_id,
    ''::text AS body,
    ''::text AS preview,
    ''::text AS meta_content,
    'Mod'::text AS type,
    ''::text AS subtype,
    ((('/Games/'::text || (content_packs.game_id)::text) || '/Mods/'::text) || content_packs.marketplace_id) AS uri,
    content_packs.min_version,
    99999999 AS max_version,
    NULL::uuid AS mod_id
   FROM public.content_packs
  WHERE (content_packs.confirmed = true);


ALTER VIEW public.search_contents OWNER TO thommcgrath;

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
-- Name: service_token_aliases; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.service_token_aliases (
    old_service_token_id uuid NOT NULL,
    new_service_token_id uuid NOT NULL
);


ALTER TABLE public.service_token_aliases OWNER TO thommcgrath;

--
-- Name: service_tokens; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.service_tokens (
    token_id uuid NOT NULL,
    user_id uuid NOT NULL,
    provider public.token_provider NOT NULL,
    type public.token_type NOT NULL,
    access_token text NOT NULL,
    refresh_token text,
    access_token_expiration timestamp with time zone,
    refresh_token_expiration timestamp with time zone,
    provider_specific jsonb DEFAULT '{}'::jsonb NOT NULL,
    encryption_key text NOT NULL,
    automatic boolean DEFAULT true,
    needs_replacing boolean DEFAULT false NOT NULL,
    CONSTRAINT service_tokens_check CHECK ((((type = 'OAuth'::public.token_type) AND (refresh_token IS NOT NULL) AND (access_token_expiration IS NOT NULL) AND (refresh_token_expiration IS NOT NULL)) OR ((type = 'Static'::public.token_type) AND (refresh_token IS NULL) AND (access_token_expiration IS NULL) AND (refresh_token_expiration IS NULL))))
);


ALTER TABLE public.service_tokens OWNER TO thommcgrath;

--
-- Name: sessions; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.sessions AS
 SELECT access_token_hash AS session_id,
    user_id,
    access_token_expiration AS valid_until,
    remote_ip,
    remote_country,
    remote_agent
   FROM public.access_tokens;


ALTER VIEW public.sessions OWNER TO thommcgrath;

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
-- Name: subscription_purchases; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.subscription_purchases (
    subscription_purchase_id uuid DEFAULT gen_random_uuid() NOT NULL,
    subscription_id uuid NOT NULL,
    purchase_id uuid NOT NULL
);


ALTER TABLE public.subscription_purchases OWNER TO thommcgrath;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.subscriptions (
    subscription_id uuid DEFAULT gen_random_uuid() NOT NULL,
    stripe_id text NOT NULL,
    product_id uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_expires timestamp with time zone NOT NULL,
    initial_purchase_id uuid NOT NULL,
    last_purchase_id uuid NOT NULL,
    product_quantity integer NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO thommcgrath;

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
   FROM ark.preset_modifiers
UNION
 SELECT template_selectors.object_id,
    template_selectors.label,
    GREATEST(template_selectors.min_version, 20000000) AS min_version,
    template_selectors.last_update,
    'ArkSA'::text AS game_id,
    template_selectors.language,
    template_selectors.pattern AS code
   FROM arksa.template_selectors;


ALTER VIEW public.template_selectors OWNER TO thommcgrath;

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
   FROM ark.presets
UNION
 SELECT templates.object_id,
    templates.label,
    GREATEST(templates.min_version, 20000000) AS min_version,
    templates.last_update,
    'ArkSA'::text AS game_id,
    templates.contents
   FROM arksa.templates;


ALTER VIEW public.templates OWNER TO thommcgrath;

--
-- Name: trusted_devices; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.trusted_devices (
    device_id_hash text NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.trusted_devices OWNER TO thommcgrath;

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
-- Name: user_authenticators; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.user_authenticators (
    authenticator_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    type public.authenticator_type NOT NULL,
    nickname text NOT NULL,
    date_added timestamp with time zone NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.user_authenticators OWNER TO thommcgrath;

--
-- Name: user_backup_codes; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.user_backup_codes (
    user_id uuid NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.user_backup_codes OWNER TO thommcgrath;

--
-- Name: user_challenges; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.user_challenges (
    user_id uuid NOT NULL,
    challenge text NOT NULL
);


ALTER TABLE public.user_challenges OWNER TO thommcgrath;

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
    two_factor_key text,
    username_full public.citext GENERATED ALWAYS AS (
CASE
    WHEN (username IS NULL) THEN NULL::text
    ELSE (((username)::text || '#'::text) || "left"((user_id)::text, 8))
END) STORED,
    stripe_id text,
    CONSTRAINT users_check CHECK ((((email_id IS NULL) AND (username IS NULL) AND (private_key_iterations IS NULL) AND (private_key_salt IS NULL) AND (private_key IS NULL)) OR ((email_id IS NOT NULL) AND (username IS NOT NULL) AND (private_key_iterations IS NOT NULL) AND (private_key_salt IS NOT NULL) AND (private_key IS NOT NULL)))),
    CONSTRAINT users_stripe_id_check CHECK (((stripe_id IS NULL) OR (stripe_id ~~ 'cus_%'::text))),
    CONSTRAINT users_username_check CHECK ((public.strpos(username, '#'::public.citext) = 0))
);


ALTER TABLE public.users OWNER TO thommcgrath;

--
-- Name: services; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.services (
    service_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    game_id public.game_identifier NOT NULL,
    access_key_hash text NOT NULL,
    access_key text NOT NULL,
    is_connected boolean DEFAULT false NOT NULL,
    connection_change_time timestamp with time zone,
    name text NOT NULL,
    nickname text,
    display_name text GENERATED ALWAYS AS (COALESCE(nickname, name)) STORED NOT NULL,
    color public.color DEFAULT 'None'::public.color NOT NULL,
    platform sentinel.game_platform NOT NULL,
    game_specific jsonb DEFAULT '{}'::jsonb NOT NULL,
    game_clock numeric(17,6) DEFAULT 0 NOT NULL,
    current_players integer DEFAULT 0 NOT NULL,
    max_players integer DEFAULT '-1'::integer NOT NULL,
    cluster_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    allow_cluster_id_change boolean DEFAULT true NOT NULL,
    ip_address inet,
    rcon_connected boolean DEFAULT false NOT NULL,
    mini_name public.citext,
    mini_name_display public.citext GENERATED ALWAYS AS (COALESCE((mini_name)::text, nickname, name)) STORED NOT NULL,
    difficulty numeric(16,6) DEFAULT 5.0 NOT NULL,
    connected_to public.citext,
    kick_untracked_players boolean DEFAULT true NOT NULL
);


ALTER TABLE sentinel.services OWNER TO thommcgrath;

--
-- Name: TABLE services; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.services IS 'Also known as a server, services are the starting point for most other functionality.';


--
-- Name: user_subscriptions; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.user_subscriptions AS
 SELECT subscriptions.subscription_id,
    subscriptions.stripe_id,
    subscriptions.product_id,
    subscriptions.date_created,
    subscriptions.date_expires,
    purchases.purchase_id,
    users.user_id,
    users.email_id,
    products.product_name,
    products.game_id,
    products.flags,
        CASE products.game_id
            WHEN 'Sentinel'::public.citext THEN ( SELECT count(*) AS count
               FROM sentinel.services
              WHERE (services.user_id = users.user_id))
            ELSE (0)::bigint
        END AS units_used,
        CASE products.game_id
            WHEN 'Sentinel'::public.citext THEN subscriptions.product_quantity
            ELSE 0
        END AS units_allowed,
    products.metadata
   FROM (((public.subscriptions
     JOIN public.purchases ON ((subscriptions.last_purchase_id = purchases.purchase_id)))
     JOIN public.products ON ((subscriptions.product_id = products.product_id)))
     JOIN public.users ON ((purchases.purchaser_email = users.email_id)));


ALTER VIEW public.user_subscriptions OWNER TO thommcgrath;

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
    header public.hex,
    bucket text NOT NULL
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
-- Name: config_options; Type: TABLE; Schema: sdtd; Owner: thommcgrath
--

CREATE TABLE sdtd.config_options (
    file text DEFAULT 'serverconfig.xml'::text NOT NULL,
    key text NOT NULL,
    value_type sdtd.config_option_value_type NOT NULL,
    max_allowed integer DEFAULT 1,
    description text NOT NULL,
    default_value text NOT NULL,
    native_editor_version integer,
    ui_group public.citext,
    constraints jsonb,
    custom_sort public.citext,
    supported_versions int4range DEFAULT '(,)'::int4range NOT NULL,
    CONSTRAINT config_options_max_allowed_check CHECK (((max_allowed IS NULL) OR (max_allowed >= 1)))
)
INHERITS (sdtd.objects);


ALTER TABLE sdtd.config_options OWNER TO thommcgrath;

--
-- Name: group_bans; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.group_bans (
    group_ban_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    player_id uuid NOT NULL,
    expiration timestamp with time zone,
    issuer_id uuid NOT NULL,
    comments text NOT NULL
);


ALTER TABLE sentinel.group_bans OWNER TO thommcgrath;

--
-- Name: TABLE group_bans; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.group_bans IS 'Bans which apply to every server in the group.';


--
-- Name: group_services; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.group_services (
    group_service_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    service_id uuid NOT NULL,
    permissions_mask bigint DEFAULT 0 NOT NULL,
    CONSTRAINT group_services_permissions_mask_check CHECK (((permissions_mask & (1)::bigint) = 1))
);


ALTER TABLE sentinel.group_services OWNER TO thommcgrath;

--
-- Name: TABLE group_services; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.group_services IS 'Group service members';


--
-- Name: COLUMN group_services.permissions_mask; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON COLUMN sentinel.group_services.permissions_mask IS 'Group user permissions will be masked (binary AND) with this value.';


--
-- Name: service_bans; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_bans (
    service_ban_id uuid DEFAULT gen_random_uuid() NOT NULL,
    service_id uuid NOT NULL,
    player_id uuid NOT NULL,
    expiration timestamp with time zone,
    comments text NOT NULL
);


ALTER TABLE sentinel.service_bans OWNER TO thommcgrath;

--
-- Name: TABLE service_bans; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.service_bans IS 'Bans which apply to only this server.';


--
-- Name: active_bans; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.active_bans AS
 SELECT service_bans.service_id,
    'Service'::text AS source,
    service_bans.service_ban_id AS ban_id,
    service_bans.player_id,
    service_bans.expiration,
    services.user_id AS issuer_id,
    service_bans.comments
   FROM (sentinel.service_bans
     JOIN sentinel.services ON ((service_bans.service_id = services.service_id)))
  WHERE ((service_bans.expiration IS NULL) OR (service_bans.expiration > CURRENT_TIMESTAMP))
UNION
 SELECT group_services.service_id,
    'Group'::text AS source,
    group_bans.group_ban_id AS ban_id,
    group_bans.player_id,
    group_bans.expiration,
    group_bans.issuer_id,
    group_bans.comments
   FROM (sentinel.group_bans
     JOIN sentinel.group_services ON ((group_bans.group_id = group_services.group_id)))
  WHERE ((group_bans.expiration IS NULL) OR (group_bans.expiration > CURRENT_TIMESTAMP));


ALTER VIEW sentinel.active_bans OWNER TO thommcgrath;

--
-- Name: VIEW active_bans; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.active_bans IS 'Non-expired bans resolved by service.';


--
-- Name: player_sessions; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.player_sessions (
    player_session_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid NOT NULL,
    service_id uuid NOT NULL,
    active_times tstzrange NOT NULL,
    CONSTRAINT player_sessions_active_times_check CHECK ((lower_inf(active_times) = false))
);


ALTER TABLE sentinel.player_sessions OWNER TO thommcgrath;

--
-- Name: TABLE player_sessions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.player_sessions IS 'Tracks player activity. Null disconnect time means the player is still connected.';


--
-- Name: players; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.players (
    player_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.citext NOT NULL,
    do_not_track boolean DEFAULT false NOT NULL
);


ALTER TABLE sentinel.players OWNER TO thommcgrath;

--
-- Name: TABLE players; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.players IS 'Basic player information.';


--
-- Name: active_players; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.active_players AS
 SELECT players.player_id,
    players.name AS player_name,
    player_sessions.service_id,
    services.display_name AS service_display_name,
    lower(player_sessions.active_times) AS connected_at,
    (CURRENT_TIMESTAMP - lower(player_sessions.active_times)) AS time_playing
   FROM ((sentinel.player_sessions
     JOIN sentinel.players ON ((player_sessions.player_id = players.player_id)))
     JOIN sentinel.services ON ((player_sessions.service_id = services.service_id)))
  WHERE ((upper_inf(player_sessions.active_times) = true) AND (players.do_not_track = false));


ALTER VIEW sentinel.active_players OWNER TO thommcgrath;

--
-- Name: VIEW active_players; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.active_players IS 'Shows players currently online.';


--
-- Name: group_scripts; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.group_scripts (
    group_script_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    script_id uuid NOT NULL,
    parameter_values jsonb DEFAULT '{}'::jsonb NOT NULL,
    permissions_mask bigint DEFAULT 0 NOT NULL,
    revision_number integer,
    CONSTRAINT group_scripts_parameter_values_check CHECK ((jsonb_typeof(parameter_values) = 'object'::text)),
    CONSTRAINT group_scripts_permissions_mask_check CHECK (((permissions_mask & (1)::bigint) = 1))
);


ALTER TABLE sentinel.group_scripts OWNER TO thommcgrath;

--
-- Name: TABLE group_scripts; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.group_scripts IS 'Scripts assigned to a group.';


--
-- Name: COLUMN group_scripts.permissions_mask; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON COLUMN sentinel.group_scripts.permissions_mask IS 'Group user permissions will be masked (binary AND) with this value.';


--
-- Name: script_hashes; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.script_hashes (
    hash text NOT NULL,
    status sentinel.script_approval_status,
    request_sent boolean DEFAULT false NOT NULL
);


ALTER TABLE sentinel.script_hashes OWNER TO thommcgrath;

--
-- Name: script_revisions; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.script_revisions (
    script_id uuid NOT NULL,
    revision_number integer NOT NULL,
    revision_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    code text NOT NULL,
    parameters text NOT NULL,
    hash text GENERATED ALWAYS AS (encode(public.digest(((code || ':'::text) || parameters), 'sha384'::text), 'base64'::text)) STORED NOT NULL
);


ALTER TABLE sentinel.script_revisions OWNER TO thommcgrath;

--
-- Name: script_approved_revisions; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.script_approved_revisions AS
 SELECT script_revisions.script_id,
    script_revisions.revision_number,
    script_hashes.status
   FROM (sentinel.script_revisions
     JOIN sentinel.script_hashes ON ((script_revisions.hash = script_hashes.hash)))
  WHERE (script_hashes.status = ANY (ARRAY['Probation'::sentinel.script_approval_status, 'Approved'::sentinel.script_approval_status]));


ALTER VIEW sentinel.script_approved_revisions OWNER TO thommcgrath;

--
-- Name: scripts; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.scripts (
    script_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name public.citext NOT NULL,
    context sentinel.event_name NOT NULL,
    parameters jsonb DEFAULT '{}'::jsonb NOT NULL,
    code text NOT NULL,
    language sentinel.script_language NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    latest_revision integer NOT NULL,
    command_keyword public.citext,
    command_arguments jsonb,
    CONSTRAINT scripts_check CHECK ((((command_keyword IS NULL) AND (command_arguments IS NULL)) OR ((context = ANY (ARRAY['serviceScriptRun'::sentinel.event_name, 'slashCommand'::sentinel.event_name])) AND (jsonb_typeof(command_arguments) = 'array'::text)))),
    CONSTRAINT scripts_parameters_check CHECK ((jsonb_typeof(parameters) = 'array'::text))
);


ALTER TABLE sentinel.scripts OWNER TO thommcgrath;

--
-- Name: TABLE scripts; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.scripts IS 'Scipt definitions that can be assigned to servers, groups, or users. Bit 1 / Dec 1.';


--
-- Name: service_scripts; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_scripts (
    service_script_id uuid DEFAULT gen_random_uuid() NOT NULL,
    service_id uuid NOT NULL,
    script_id uuid NOT NULL,
    parameter_values jsonb DEFAULT '{}'::jsonb NOT NULL,
    revision_number integer,
    CONSTRAINT service_scripts_parameter_values_check CHECK ((jsonb_typeof(parameter_values) = 'object'::text))
);


ALTER TABLE sentinel.service_scripts OWNER TO thommcgrath;

--
-- Name: TABLE service_scripts; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.service_scripts IS 'Scripts assigned to a service.';


--
-- Name: active_scripts; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.active_scripts AS
 SELECT service_scripts.service_id,
    scripts.script_id,
    scripts.name,
    scripts.context,
    scripts.language,
    script_revisions.code,
    script_revisions.parameters,
    service_scripts.parameter_values,
    script_revisions.revision_number,
    script_hashes.hash,
    script_hashes.status,
    script_hashes.request_sent AS approval_request_sent,
    scripts.command_keyword,
    scripts.command_arguments
   FROM ((((sentinel.service_scripts
     JOIN sentinel.scripts ON ((service_scripts.script_id = scripts.script_id)))
     JOIN sentinel.script_revisions ON ((scripts.script_id = script_revisions.script_id)))
     JOIN sentinel.script_hashes ON ((script_revisions.hash = script_hashes.hash)))
     JOIN LATERAL ( SELECT max(script_approved_revisions.revision_number) AS best_revision
           FROM sentinel.script_approved_revisions
          WHERE ((script_approved_revisions.script_id = scripts.script_id) AND (script_approved_revisions.revision_number <= COALESCE(service_scripts.revision_number, scripts.latest_revision)))) revisions ON ((script_revisions.revision_number = revisions.best_revision)))
  WHERE (scripts.enabled = true)
UNION
 SELECT group_services.service_id,
    scripts.script_id,
    scripts.name,
    scripts.context,
    scripts.language,
    script_revisions.code,
    script_revisions.parameters,
    group_scripts.parameter_values,
    script_revisions.revision_number,
    script_hashes.hash,
    script_hashes.status,
    script_hashes.request_sent AS approval_request_sent,
    scripts.command_keyword,
    scripts.command_arguments
   FROM (((((sentinel.group_scripts
     JOIN sentinel.group_services ON ((group_services.group_id = group_scripts.group_id)))
     JOIN sentinel.scripts ON ((group_scripts.script_id = scripts.script_id)))
     JOIN sentinel.script_revisions ON ((scripts.script_id = script_revisions.script_id)))
     JOIN sentinel.script_hashes ON ((script_revisions.hash = script_hashes.hash)))
     JOIN LATERAL ( SELECT max(script_approved_revisions.revision_number) AS best_revision
           FROM sentinel.script_approved_revisions
          WHERE ((script_approved_revisions.script_id = scripts.script_id) AND (script_approved_revisions.revision_number <= COALESCE(group_scripts.revision_number, scripts.latest_revision)))) revisions ON ((script_revisions.revision_number = revisions.best_revision)))
  WHERE (scripts.enabled = true);


ALTER VIEW sentinel.active_scripts OWNER TO thommcgrath;

--
-- Name: VIEW active_scripts; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.active_scripts IS 'Enabled scripts resolved by service.';


--
-- Name: buckets; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.buckets (
    bucket_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name public.citext NOT NULL
);


ALTER TABLE sentinel.buckets OWNER TO thommcgrath;

--
-- Name: TABLE buckets; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.buckets IS 'Bucket definitions that can be assigned to servers, groups, or users. Bit 2 / Dec 2. Also used when assigning a script.';


--
-- Name: group_buckets; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.group_buckets (
    group_bucket_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    bucket_id uuid NOT NULL,
    permissions_mask bigint DEFAULT 0 NOT NULL,
    CONSTRAINT group_buckets_permissions_mask_check CHECK (((permissions_mask & (1)::bigint) = 1))
);


ALTER TABLE sentinel.group_buckets OWNER TO thommcgrath;

--
-- Name: TABLE group_buckets; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.group_buckets IS 'buckets assigned to a group.';


--
-- Name: COLUMN group_buckets.permissions_mask; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON COLUMN sentinel.group_buckets.permissions_mask IS 'Group user permissions will be masked (binary AND) with this value.';


--
-- Name: group_users; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.group_users (
    group_user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    user_id uuid NOT NULL,
    permissions bigint DEFAULT 0 NOT NULL,
    CONSTRAINT group_users_permissions_check CHECK (((permissions & (1)::bigint) = 1))
);


ALTER TABLE sentinel.group_users OWNER TO thommcgrath;

--
-- Name: TABLE group_users; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.group_users IS 'Group user members';


--
-- Name: COLUMN group_users.permissions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON COLUMN sentinel.group_users.permissions IS 'Permission bits that are added to the group for the user.';


--
-- Name: groups; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.groups (
    group_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name public.citext NOT NULL,
    color public.color DEFAULT 'None'::public.color NOT NULL,
    enable_group_chat boolean DEFAULT false NOT NULL,
    discord_invite text,
    discord_link_code public.citext,
    discord_guild_id text,
    discord_chat_channel_id text,
    is_cluster_group boolean GENERATED ALWAYS AS ((enable_group_chat OR (discord_invite IS NOT NULL) OR (discord_link_code IS NOT NULL) OR (discord_guild_id IS NOT NULL))) STORED NOT NULL
);


ALTER TABLE sentinel.groups OWNER TO thommcgrath;

--
-- Name: TABLE groups; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.groups IS 'Group definitions';


--
-- Name: bucket_permissions; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.bucket_permissions AS
 SELECT bucket_id,
    user_id,
    bit_or(permissions) AS permissions
   FROM ( SELECT buckets.bucket_id,
            buckets.user_id,
            ('00011111111111111111111111111111111111111111111111111111'::"bit")::bigint AS permissions
           FROM sentinel.buckets
        UNION
         SELECT group_buckets.bucket_id,
            group_users.user_id,
            (group_buckets.permissions_mask & group_users.permissions)
           FROM (sentinel.group_buckets
             JOIN sentinel.group_users ON ((group_buckets.group_id = group_users.group_id)))
        UNION
         SELECT group_buckets.bucket_id,
            groups.user_id,
            group_buckets.permissions_mask
           FROM (sentinel.group_buckets
             JOIN sentinel.groups ON ((group_buckets.group_id = groups.group_id)))) resolved
  GROUP BY bucket_id, user_id;


ALTER VIEW sentinel.bucket_permissions OWNER TO thommcgrath;

--
-- Name: VIEW bucket_permissions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.bucket_permissions IS 'Lists resolved permissions by user for each bucket.';


--
-- Name: bucket_values; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.bucket_values (
    bucket_value_id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id uuid NOT NULL,
    player_id uuid,
    key public.citext NOT NULL,
    value text NOT NULL
);


ALTER TABLE sentinel.bucket_values OWNER TO thommcgrath;

--
-- Name: TABLE bucket_values; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.bucket_values IS 'Key-value store for the buckets';


--
-- Name: characters; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.characters (
    character_id uuid NOT NULL,
    player_id uuid NOT NULL,
    service_id uuid NOT NULL,
    tribe_id uuid NOT NULL,
    specimen_id integer NOT NULL,
    name public.citext NOT NULL,
    name_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (name)::text)) STORED NOT NULL,
    is_active boolean DEFAULT false NOT NULL
);


ALTER TABLE sentinel.characters OWNER TO thommcgrath;

--
-- Name: TABLE characters; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.characters IS 'These are the playable characters inside the game.';


--
-- Name: chat_message_queue; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.chat_message_queue (
    message_id uuid NOT NULL,
    origin_type sentinel.chat_message_origin NOT NULL,
    origin_id text NOT NULL,
    sender_name text NOT NULL,
    sender_info jsonb DEFAULT '{}'::jsonb NOT NULL,
    scope sentinel.chat_message_scope NOT NULL,
    message_content text NOT NULL,
    message_time timestamp with time zone NOT NULL
);


ALTER TABLE sentinel.chat_message_queue OWNER TO thommcgrath;

--
-- Name: dinos; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.dinos (
    dino_id uuid NOT NULL,
    service_id uuid NOT NULL,
    tribe_id uuid,
    dino_number numeric(20,0) NOT NULL,
    visual_dino_number text NOT NULL,
    name public.citext NOT NULL,
    species public.citext NOT NULL,
    species_path public.citext NOT NULL,
    level integer NOT NULL,
    age real NOT NULL,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cryopod_data bytea,
    status sentinel.dino_status DEFAULT 'Deployed'::sentinel.dino_status NOT NULL,
    display_name public.citext GENERATED ALWAYS AS (
CASE
    WHEN (name OPERATOR(public.=) ''::public.citext) THEN species
    ELSE name
END) STORED NOT NULL,
    name_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (
CASE
    WHEN (name OPERATOR(public.=) ''::public.citext) THEN species
    ELSE name
END)::text)) STORED NOT NULL,
    name_tag public.citext DEFAULT ''::public.citext NOT NULL,
    gender sentinel.dino_gender DEFAULT 'None'::sentinel.dino_gender NOT NULL
);


ALTER TABLE sentinel.dinos OWNER TO thommcgrath;

--
-- Name: TABLE dinos; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.dinos IS 'Tamed dinos.';


--
-- Name: group_permissions; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.group_permissions AS
 SELECT group_id,
    user_id,
    bit_or(permissions) AS permissions
   FROM ( SELECT groups.group_id,
            groups.user_id,
            ('00011111111111111111111111111111111111111111111111111111'::"bit")::bigint AS permissions
           FROM sentinel.groups
        UNION
         SELECT group_users.group_id,
            group_users.user_id,
            group_users.permissions
           FROM sentinel.group_users) resolved
  GROUP BY group_id, user_id;


ALTER VIEW sentinel.group_permissions OWNER TO thommcgrath;

--
-- Name: VIEW group_permissions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.group_permissions IS 'Lists resolved permissions by user for each group.';


--
-- Name: ip_address_cache; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.ip_address_cache (
    ip_address inet NOT NULL,
    country_code text NOT NULL,
    continent_code text NOT NULL,
    is_vpn boolean NOT NULL,
    timezone text NOT NULL,
    expiration timestamp with time zone DEFAULT (CURRENT_TIMESTAMP + '30 days'::interval) NOT NULL
);


ALTER TABLE sentinel.ip_address_cache OWNER TO thommcgrath;

--
-- Name: TABLE ip_address_cache; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.ip_address_cache IS 'Caches IP address lookups for performance and usage savings.';


--
-- Name: message_moderation_scores; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.message_moderation_scores (
    score_id uuid DEFAULT gen_random_uuid() NOT NULL,
    original_message text NOT NULL,
    scores jsonb NOT NULL,
    platform sentinel.moderation_platform NOT NULL
);


ALTER TABLE sentinel.message_moderation_scores OWNER TO thommcgrath;

--
-- Name: message_translations; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.message_translations (
    translation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    original_message text NOT NULL,
    original_language text NOT NULL,
    translated_message text NOT NULL,
    translated_language text NOT NULL
);


ALTER TABLE sentinel.message_translations OWNER TO thommcgrath;

--
-- Name: player_identifiers; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.player_identifiers (
    player_identifier_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid NOT NULL,
    provider public.citext NOT NULL,
    identifier public.citext NOT NULL,
    name public.citext NOT NULL
);


ALTER TABLE sentinel.player_identifiers OWNER TO thommcgrath;

--
-- Name: TABLE player_identifiers; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.player_identifiers IS 'For games with cross play, allows players across multiple platforms to be associated together.';


--
-- Name: player_name_history; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.player_name_history (
    history_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid NOT NULL,
    name public.citext NOT NULL,
    name_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (name)::text)) STORED NOT NULL,
    change_time timestamp with time zone NOT NULL
);


ALTER TABLE sentinel.player_name_history OWNER TO thommcgrath;

--
-- Name: TABLE player_name_history; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.player_name_history IS 'Keeps track of changes players make to their names.';


--
-- Name: player_note_edits; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.player_note_edits (
    edit_id uuid DEFAULT gen_random_uuid() NOT NULL,
    note_id uuid NOT NULL,
    previous_timestamp timestamp with time zone NOT NULL,
    previous_content text NOT NULL,
    previous_content_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, previous_content)) STORED NOT NULL
);


ALTER TABLE sentinel.player_note_edits OWNER TO thommcgrath;

--
-- Name: TABLE player_note_edits; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.player_note_edits IS 'Keeps a history of all versions of a player note.';


--
-- Name: player_notes; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.player_notes (
    note_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid NOT NULL,
    user_id uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_modified timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content text NOT NULL,
    content_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, content)) STORED NOT NULL
);


ALTER TABLE sentinel.player_notes OWNER TO thommcgrath;

--
-- Name: TABLE player_notes; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.player_notes IS 'Player notes are comments that can be left on players and viewable by anybody.';


--
-- Name: script_permissions; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.script_permissions AS
 SELECT script_id,
    user_id,
    bit_or(permissions) AS permissions
   FROM ( SELECT scripts.script_id,
            scripts.user_id,
            ('00011111111111111111111111111111111111111111111111111111'::"bit")::bigint AS permissions
           FROM sentinel.scripts
        UNION
         SELECT group_scripts.script_id,
            group_users.user_id,
            (group_scripts.permissions_mask & group_users.permissions)
           FROM (sentinel.group_scripts
             JOIN sentinel.group_users ON ((group_scripts.group_id = group_users.group_id)))
        UNION
         SELECT group_scripts.script_id,
            groups.user_id,
            group_scripts.permissions_mask
           FROM (sentinel.group_scripts
             JOIN sentinel.groups ON ((group_scripts.group_id = groups.group_id)))) resolved
  GROUP BY script_id, user_id;


ALTER VIEW sentinel.script_permissions OWNER TO thommcgrath;

--
-- Name: VIEW script_permissions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.script_permissions IS 'Lists resolved permissions by user for each script.';


--
-- Name: script_tests; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.script_tests (
    request_id uuid DEFAULT gen_random_uuid() NOT NULL,
    script_data jsonb NOT NULL,
    user_id uuid NOT NULL,
    queue_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_time timestamp with time zone,
    output text
);


ALTER TABLE sentinel.script_tests OWNER TO thommcgrath;

--
-- Name: script_webhooks; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.script_webhooks (
    webhook_id uuid DEFAULT gen_random_uuid() NOT NULL,
    script_id uuid NOT NULL,
    user_id uuid NOT NULL,
    purpose text NOT NULL,
    access_key text NOT NULL,
    access_key_hash text NOT NULL
);


ALTER TABLE sentinel.script_webhooks OWNER TO thommcgrath;

--
-- Name: service_event_queue; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_event_queue (
    queue_id uuid DEFAULT gen_random_uuid() NOT NULL,
    service_id uuid NOT NULL,
    cluster_id uuid,
    queue_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    version integer NOT NULL,
    event_data text NOT NULL,
    status sentinel.event_queue_status DEFAULT 'Waiting'::sentinel.event_queue_status NOT NULL
);


ALTER TABLE sentinel.service_event_queue OWNER TO thommcgrath;

--
-- Name: TABLE service_event_queue; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.service_event_queue IS 'Stores events from game servers to be processed by workers.';


--
-- Name: service_languages; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_languages (
    service_id uuid NOT NULL,
    language sentinel.lang_shortcode NOT NULL
);


ALTER TABLE sentinel.service_languages OWNER TO thommcgrath;

--
-- Name: TABLE service_languages; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.service_languages IS 'Determines the languages of processed log messages.';


--
-- Name: service_log_messages; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_log_messages (
    message_id uuid NOT NULL,
    language character(2) NOT NULL,
    message text NOT NULL,
    vector tsvector GENERATED ALWAYS AS (to_tsvector(sentinel.language_shortcode_to_regconfig((language)::text), message)) STORED NOT NULL
);


ALTER TABLE sentinel.service_log_messages OWNER TO thommcgrath;

--
-- Name: TABLE service_log_messages; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.service_log_messages IS 'Processed log messages.';


--
-- Name: service_logs; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.service_logs (
    message_id uuid DEFAULT gen_random_uuid() NOT NULL,
    service_id uuid NOT NULL,
    type sentinel.log_type NOT NULL,
    log_time timestamp with time zone NOT NULL,
    event_name sentinel.event_name NOT NULL,
    level sentinel.log_level DEFAULT 'Informational'::sentinel.log_level NOT NULL,
    analyzer_status sentinel.log_analyzer_status DEFAULT 'Skipped'::sentinel.log_analyzer_status NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    grouping_key text
);


ALTER TABLE sentinel.service_logs OWNER TO thommcgrath;

--
-- Name: service_permissions; Type: VIEW; Schema: sentinel; Owner: thommcgrath
--

CREATE VIEW sentinel.service_permissions AS
 SELECT service_id,
    user_id,
    bit_or(permissions) AS permissions
   FROM ( SELECT services.service_id,
            services.user_id,
            ('00011111111111111111111111111111111111111111111111111111'::"bit")::bigint AS permissions
           FROM sentinel.services
        UNION
         SELECT group_services.service_id,
            group_users.user_id,
            (group_services.permissions_mask & group_users.permissions)
           FROM (sentinel.group_services
             JOIN sentinel.group_users ON ((group_services.group_id = group_users.group_id)))
        UNION
         SELECT group_services.service_id,
            groups.user_id,
            group_services.permissions_mask
           FROM (sentinel.group_services
             JOIN sentinel.groups ON ((group_services.group_id = groups.group_id)))) resolved
  GROUP BY service_id, user_id;


ALTER VIEW sentinel.service_permissions OWNER TO thommcgrath;

--
-- Name: VIEW service_permissions; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON VIEW sentinel.service_permissions IS 'Lists resolved permissions by user for each service.';


--
-- Name: tribe_characters; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.tribe_characters (
    tribe_id uuid NOT NULL,
    character_id uuid NOT NULL
);


ALTER TABLE sentinel.tribe_characters OWNER TO thommcgrath;

--
-- Name: TABLE tribe_characters; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.tribe_characters IS 'Stores tribe character memberships, even after transfer to another server.';


--
-- Name: tribe_dinos; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.tribe_dinos (
    tribe_id uuid NOT NULL,
    dino_id uuid NOT NULL
);


ALTER TABLE sentinel.tribe_dinos OWNER TO thommcgrath;

--
-- Name: TABLE tribe_dinos; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.tribe_dinos IS 'Stores tribe dino memberships, even after transfer to another server.';


--
-- Name: tribes; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.tribes (
    tribe_id uuid NOT NULL,
    service_id uuid NOT NULL,
    tribe_number integer NOT NULL,
    name public.citext NOT NULL,
    name_vector tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, (name)::text)) STORED NOT NULL
);


ALTER TABLE sentinel.tribes OWNER TO thommcgrath;

--
-- Name: TABLE tribes; Type: COMMENT; Schema: sentinel; Owner: thommcgrath
--

COMMENT ON TABLE sentinel.tribes IS 'In-game tribes use to group characters and dinos.';


--
-- Name: watcher_logs; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.watcher_logs (
    message_id uuid NOT NULL,
    message text NOT NULL,
    message_time timestamp with time zone NOT NULL,
    hostname public.citext NOT NULL
);


ALTER TABLE sentinel.watcher_logs OWNER TO thommcgrath;

--
-- Name: watcher_releases; Type: TABLE; Schema: sentinel; Owner: thommcgrath
--

CREATE TABLE sentinel.watcher_releases (
    release_id integer NOT NULL,
    download_url text NOT NULL,
    content_type text NOT NULL
);


ALTER TABLE sentinel.watcher_releases OWNER TO thommcgrath;

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
-- Name: deletions action_time; Type: DEFAULT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.deletions ALTER COLUMN action_time SET DEFAULT CURRENT_TIMESTAMP(0);


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
-- Name: creatures object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures ALTER COLUMN object_id SET DEFAULT NULL;


--
-- Name: creatures min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: creatures last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: creatures content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: creatures tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: deletions action_time; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.deletions ALTER COLUMN action_time SET DEFAULT CURRENT_TIMESTAMP(0);


--
-- Name: engrams object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams ALTER COLUMN object_id SET DEFAULT NULL;


--
-- Name: engrams min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: engrams last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: engrams content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: engrams tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: ini_options object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: ini_options min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: ini_options last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: ini_options content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: ini_options tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_drop_icons object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: loot_drop_icons min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: loot_drop_icons last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_drop_icons content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: loot_drop_icons tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: loot_drops object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops ALTER COLUMN object_id SET DEFAULT NULL;


--
-- Name: loot_drops min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: loot_drops last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: loot_drops content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: loot_drops tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: spawn_points object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points ALTER COLUMN object_id SET DEFAULT NULL;


--
-- Name: spawn_points min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: spawn_points last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: spawn_points content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: spawn_points tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: template_selectors object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: template_selectors min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: template_selectors last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: template_selectors content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: template_selectors tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: templates object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: templates min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: templates last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: templates content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: templates tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: traits object_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: traits min_version; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: traits last_update; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: traits content_pack_id; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits ALTER COLUMN content_pack_id SET DEFAULT 'b32a3d73-9406-56f2-bd8f-936ee0275249'::uuid;


--
-- Name: traits tags; Type: DEFAULT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: ini_options object_id; Type: DEFAULT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options ALTER COLUMN object_id SET DEFAULT public.gen_random_uuid();


--
-- Name: ini_options min_version; Type: DEFAULT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options ALTER COLUMN min_version SET DEFAULT 20000000;


--
-- Name: ini_options last_update; Type: DEFAULT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options ALTER COLUMN last_update SET DEFAULT ('now'::text)::timestamp(0) with time zone;


--
-- Name: ini_options content_pack_id; Type: DEFAULT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options ALTER COLUMN content_pack_id SET DEFAULT '9fcaeedc-c5ac-420f-8066-fee0a00ce96d'::uuid;


--
-- Name: ini_options tags; Type: DEFAULT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: config_options min_version; Type: DEFAULT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.config_options ALTER COLUMN min_version SET DEFAULT 10700000;


--
-- Name: config_options last_update; Type: DEFAULT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.config_options ALTER COLUMN last_update SET DEFAULT CURRENT_TIMESTAMP;


--
-- Name: config_options tags; Type: DEFAULT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.config_options ALTER COLUMN tags SET DEFAULT '{}'::public.citext[];


--
-- Name: color_sets color_sets_class_string_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.color_sets
    ADD CONSTRAINT color_sets_class_string_key UNIQUE (class_string);


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
-- Name: loot_item_set_entries loot_item_set_entries_sort_idx; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_sort_idx UNIQUE (loot_item_set_id, sync_sort_key) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: mods_legacy mods_pkey; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods_legacy
    ADD CONSTRAINT mods_pkey PRIMARY KEY (mod_id);


--
-- Name: mods_legacy mods_prefix_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods_legacy
    ADD CONSTRAINT mods_prefix_key UNIQUE (prefix);


--
-- Name: mods_legacy mods_tag_key; Type: CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods_legacy
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
-- Name: color_sets color_sets_class_string_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.color_sets
    ADD CONSTRAINT color_sets_class_string_key UNIQUE (class_string);


--
-- Name: color_sets color_sets_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.color_sets
    ADD CONSTRAINT color_sets_pkey PRIMARY KEY (color_set_id);


--
-- Name: colors colors_color_name_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.colors
    ADD CONSTRAINT colors_color_name_key UNIQUE (color_name);


--
-- Name: colors colors_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (color_id);


--
-- Name: content_pack_relationships content_pack_relationships_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.content_pack_relationships
    ADD CONSTRAINT content_pack_relationships_pkey PRIMARY KEY (relation_id);


--
-- Name: crafting_costs crafting_costs_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.crafting_costs
    ADD CONSTRAINT crafting_costs_pkey PRIMARY KEY (engram_id, ingredient_id);


--
-- Name: creature_engrams creature_engrams_creature_id_engram_id_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_engram_id_key UNIQUE (creature_id, engram_id);


--
-- Name: creature_engrams creature_engrams_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_engrams
    ADD CONSTRAINT creature_engrams_pkey PRIMARY KEY (relation_id);


--
-- Name: creature_stats creature_stats_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_stats
    ADD CONSTRAINT creature_stats_pkey PRIMARY KEY (creature_id, stat_index);


--
-- Name: creatures creatures_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures
    ADD CONSTRAINT creatures_pkey PRIMARY KEY (object_id);


--
-- Name: engram_stats engram_stats_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engram_stats
    ADD CONSTRAINT engram_stats_pkey PRIMARY KEY (engram_id, stat_index);


--
-- Name: engrams engrams_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams
    ADD CONSTRAINT engrams_pkey PRIMARY KEY (object_id);


--
-- Name: event_colors event_colors_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_colors
    ADD CONSTRAINT event_colors_pkey PRIMARY KEY (event_id, color_id);


--
-- Name: event_rates event_rates_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_rates
    ADD CONSTRAINT event_rates_pkey PRIMARY KEY (event_id, ini_option);


--
-- Name: events events_event_code_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.events
    ADD CONSTRAINT events_event_code_key UNIQUE (event_code);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- Name: game_variables game_variables_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.game_variables
    ADD CONSTRAINT game_variables_pkey PRIMARY KEY (key);


--
-- Name: ini_options ini_options_file_header_key_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options
    ADD CONSTRAINT ini_options_file_header_key_key UNIQUE (file, header, key);


--
-- Name: ini_options ini_options_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options
    ADD CONSTRAINT ini_options_pkey PRIMARY KEY (object_id);


--
-- Name: loot_drop_icons loot_drop_icons_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons
    ADD CONSTRAINT loot_drop_icons_pkey PRIMARY KEY (object_id);


--
-- Name: loot_drops loot_drops_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops
    ADD CONSTRAINT loot_drops_pkey PRIMARY KEY (object_id);


--
-- Name: loot_item_set_entries loot_item_set_entries_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_pkey PRIMARY KEY (loot_item_set_entry_id);


--
-- Name: loot_item_set_entries loot_item_set_entries_sort_idx; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_sort_idx UNIQUE (loot_item_set_id, sync_sort_key) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_pkey PRIMARY KEY (loot_item_set_entry_option_id);


--
-- Name: loot_item_sets loot_item_sets_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_sets
    ADD CONSTRAINT loot_item_sets_pkey PRIMARY KEY (loot_item_set_id);


--
-- Name: maps maps_mask_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.maps
    ADD CONSTRAINT maps_mask_key UNIQUE (mask);


--
-- Name: maps maps_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (map_id);


--
-- Name: maps maps_world_name_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.maps
    ADD CONSTRAINT maps_world_name_key UNIQUE (world_name);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (object_id);


--
-- Name: spawn_point_limits spawn_point_limits_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_pkey PRIMARY KEY (spawn_point_id, creature_id);


--
-- Name: spawn_point_populations spawn_point_populations_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_pkey PRIMARY KEY (population_id);


--
-- Name: spawn_point_set_entries spawn_point_set_entries_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_pkey PRIMARY KEY (spawn_point_set_entry_id);


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_pkey PRIMARY KEY (spawn_point_set_entry_level_id);


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_pkey PRIMARY KEY (spawn_point_set_replacement_id);


--
-- Name: spawn_point_sets spawn_point_sets_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_pkey PRIMARY KEY (spawn_point_set_id);


--
-- Name: spawn_points spawn_points_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points
    ADD CONSTRAINT spawn_points_pkey PRIMARY KEY (object_id);


--
-- Name: template_selectors template_selectors_pattern_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors
    ADD CONSTRAINT template_selectors_pattern_key UNIQUE (pattern);


--
-- Name: template_selectors template_selectors_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors
    ADD CONSTRAINT template_selectors_pkey PRIMARY KEY (object_id);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (object_id);


--
-- Name: traits traits_path_content_pack_id_key; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits
    ADD CONSTRAINT traits_path_content_pack_id_key UNIQUE (path, content_pack_id);


--
-- Name: traits traits_pkey; Type: CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.traits
    ADD CONSTRAINT traits_pkey PRIMARY KEY (object_id);


--
-- Name: game_variables game_variables_pkey; Type: CONSTRAINT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.game_variables
    ADD CONSTRAINT game_variables_pkey PRIMARY KEY (key);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (access_token_hash);


--
-- Name: access_tokens access_tokens_refresh_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_refresh_token_hash_key UNIQUE (refresh_token_hash);


--
-- Name: affiliate_links affiliate_links_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_links
    ADD CONSTRAINT affiliate_links_pkey PRIMARY KEY (code);


--
-- Name: affiliate_products affiliate_products_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_products
    ADD CONSTRAINT affiliate_products_pkey PRIMARY KEY (affiliate_id, product_id);


--
-- Name: affiliate_tracking affiliate_tracking_client_reference_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_tracking
    ADD CONSTRAINT affiliate_tracking_client_reference_id_key UNIQUE (client_reference_id);


--
-- Name: affiliate_tracking affiliate_tracking_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_tracking
    ADD CONSTRAINT affiliate_tracking_pkey PRIMARY KEY (track_id);


--
-- Name: application_auth_flows application_auth_flows_code_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_auth_flows
    ADD CONSTRAINT application_auth_flows_code_hash_key UNIQUE (code_hash);


--
-- Name: application_auth_flows application_auth_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_auth_flows
    ADD CONSTRAINT application_auth_flows_pkey PRIMARY KEY (flow_id);


--
-- Name: application_auth_flows application_auth_flows_verifier_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_auth_flows
    ADD CONSTRAINT application_auth_flows_verifier_hash_key UNIQUE (verifier_hash);


--
-- Name: application_callbacks application_callbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_callbacks
    ADD CONSTRAINT application_callbacks_pkey PRIMARY KEY (application_id, url);


--
-- Name: application_callbacks application_callbacks_url_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_callbacks
    ADD CONSTRAINT application_callbacks_url_key UNIQUE (url);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (application_id);


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
-- Name: content_pack_discovery_results content_pack_discovery_results_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.content_pack_discovery_results
    ADD CONSTRAINT content_pack_discovery_results_pkey PRIMARY KEY (content_pack_id);


--
-- Name: content_packs content_packs_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.content_packs
    ADD CONSTRAINT content_packs_pkey PRIMARY KEY (content_pack_id);


--
-- Name: corrupt_files corrupt_files_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.corrupt_files
    ADD CONSTRAINT corrupt_files_pkey PRIMARY KEY (file_id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (code);


--
-- Name: device_auth_flows device_auth_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.device_auth_flows
    ADD CONSTRAINT device_auth_flows_pkey PRIMARY KEY (device_code);


--
-- Name: device_auth_flows device_auth_flows_verifier_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.device_auth_flows
    ADD CONSTRAINT device_auth_flows_verifier_hash_key UNIQUE (verifier_hash);


--
-- Name: discord_bots discord_bots_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_bots
    ADD CONSTRAINT discord_bots_pkey PRIMARY KEY (bot_id);


--
-- Name: discord_channels discord_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_channels
    ADD CONSTRAINT discord_channels_pkey PRIMARY KEY (channel_id);


--
-- Name: discord_guilds discord_guilds_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_guilds
    ADD CONSTRAINT discord_guilds_pkey PRIMARY KEY (guild_id);


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
-- Name: email_verification_codes email_verification_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification_codes
    ADD CONSTRAINT email_verification_codes_pkey PRIMARY KEY (code_hash);


--
-- Name: email_verification email_verification_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification
    ADD CONSTRAINT email_verification_pkey1 PRIMARY KEY (email_id);


--
-- Name: endpoint_git_hashes endpoint_git_hashes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.endpoint_git_hashes
    ADD CONSTRAINT endpoint_git_hashes_pkey PRIMARY KEY (branch);


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
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: gift_code_products gift_code_products_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_products
    ADD CONSTRAINT gift_code_products_pkey PRIMARY KEY (code, product_id);


--
-- Name: gift_codes gift_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_codes
    ADD CONSTRAINT gift_codes_pkey PRIMARY KEY (code);


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
-- Name: payment_method_currencies payment_method_currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.payment_method_currencies
    ADD CONSTRAINT payment_method_currencies_pkey PRIMARY KEY (payment_method_code, currency_code);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (code);


--
-- Name: policies policies_lookup_key_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_lookup_key_key UNIQUE (lookup_key);


--
-- Name: policies policies_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_pkey PRIMARY KEY (policy_id);


--
-- Name: policy_revisions policy_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_revisions
    ADD CONSTRAINT policy_revisions_pkey PRIMARY KEY (revision_id);


--
-- Name: policy_revisions policy_revisions_policy_id_revision_number_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_revisions
    ADD CONSTRAINT policy_revisions_policy_id_revision_number_key UNIQUE (policy_id, revision_number);


--
-- Name: policy_signatures policy_signatures_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signatures
    ADD CONSTRAINT policy_signatures_pkey PRIMARY KEY (signature_id);


--
-- Name: policy_signatures policy_signatures_user_id_policy_id_revision_number_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signatures
    ADD CONSTRAINT policy_signatures_user_id_policy_id_revision_number_key UNIQUE (user_id, policy_id, revision_number);


--
-- Name: policy_signing_requests policy_signing_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signing_requests
    ADD CONSTRAINT policy_signing_requests_pkey PRIMARY KEY (policy_signing_request_id);


--
-- Name: policy_signing_requests policy_signing_requests_user_id_policy_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signing_requests
    ADD CONSTRAINT policy_signing_requests_user_id_policy_id_key UNIQUE (user_id, policy_id);


--
-- Name: processed_webhooks processed_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.processed_webhooks
    ADD CONSTRAINT processed_webhooks_pkey PRIMARY KEY (event_id);


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
-- Name: project_invites project_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_invites
    ADD CONSTRAINT project_invites_pkey PRIMARY KEY (invite_code);


--
-- Name: project_members project_members_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_pkey PRIMARY KEY (project_id, user_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- Name: projects projects_storage_path_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_storage_path_key UNIQUE (storage_path);


--
-- Name: gift_code_log purchase_code_log_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_log
    ADD CONSTRAINT purchase_code_log_pkey PRIMARY KEY (log_id);


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
-- Name: rcon_commands rcon_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.rcon_commands
    ADD CONSTRAINT rcon_commands_pkey PRIMARY KEY (command_id);


--
-- Name: rcon_parameters rcon_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.rcon_parameters
    ADD CONSTRAINT rcon_parameters_pkey PRIMARY KEY (command_id, "position");


--
-- Name: search_sync search_sync_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.search_sync
    ADD CONSTRAINT search_sync_pkey PRIMARY KEY (object_id);


--
-- Name: service_token_aliases service_token_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.service_token_aliases
    ADD CONSTRAINT service_token_aliases_pkey PRIMARY KEY (old_service_token_id);


--
-- Name: service_tokens service_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.service_tokens
    ADD CONSTRAINT service_tokens_pkey PRIMARY KEY (token_id);


--
-- Name: legacy_sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.legacy_sessions
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
-- Name: subscription_purchases subscription_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscription_purchases
    ADD CONSTRAINT subscription_purchases_pkey PRIMARY KEY (subscription_purchase_id);


--
-- Name: subscription_purchases subscription_purchases_subscription_id_purchase_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscription_purchases
    ADD CONSTRAINT subscription_purchases_subscription_id_purchase_id_key UNIQUE (subscription_id, purchase_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (subscription_id);


--
-- Name: subscriptions subscriptions_stripe_id_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_stripe_id_key UNIQUE (stripe_id);


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
-- Name: trusted_devices trusted_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.trusted_devices
    ADD CONSTRAINT trusted_devices_pkey PRIMARY KEY (device_id_hash);


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
-- Name: user_authenticators user_authenticators_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_authenticators
    ADD CONSTRAINT user_authenticators_pkey PRIMARY KEY (authenticator_id);


--
-- Name: user_backup_codes user_backup_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_backup_codes
    ADD CONSTRAINT user_backup_codes_pkey PRIMARY KEY (user_id, code);


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
-- Name: config_options config_options_file_key_supported_versions_excl; Type: CONSTRAINT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.config_options
    ADD CONSTRAINT config_options_file_key_supported_versions_excl EXCLUDE USING gist (file WITH =, key WITH =, supported_versions WITH &&);


--
-- Name: config_options config_options_pkey; Type: CONSTRAINT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.config_options
    ADD CONSTRAINT config_options_pkey PRIMARY KEY (object_id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (object_id);


--
-- Name: bucket_values bucket_values_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.bucket_values
    ADD CONSTRAINT bucket_values_pkey PRIMARY KEY (bucket_value_id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (bucket_id);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);


--
-- Name: chat_message_queue chat_message_queue_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.chat_message_queue
    ADD CONSTRAINT chat_message_queue_pkey PRIMARY KEY (message_id);


--
-- Name: dinos dinos_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.dinos
    ADD CONSTRAINT dinos_pkey PRIMARY KEY (dino_id);


--
-- Name: group_bans group_bans_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_bans
    ADD CONSTRAINT group_bans_pkey PRIMARY KEY (group_ban_id);


--
-- Name: group_buckets group_buckets_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_buckets
    ADD CONSTRAINT group_buckets_pkey PRIMARY KEY (group_bucket_id);


--
-- Name: group_scripts group_scripts_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_scripts
    ADD CONSTRAINT group_scripts_pkey PRIMARY KEY (group_script_id);


--
-- Name: group_services group_services_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_services
    ADD CONSTRAINT group_services_pkey PRIMARY KEY (group_service_id);


--
-- Name: group_users group_users_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_users
    ADD CONSTRAINT group_users_pkey PRIMARY KEY (group_user_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);


--
-- Name: ip_address_cache ip_address_cache_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.ip_address_cache
    ADD CONSTRAINT ip_address_cache_pkey PRIMARY KEY (ip_address);


--
-- Name: message_moderation_scores message_moderation_scores_original_message_platform_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.message_moderation_scores
    ADD CONSTRAINT message_moderation_scores_original_message_platform_key UNIQUE (original_message, platform);


--
-- Name: message_moderation_scores message_moderation_scores_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.message_moderation_scores
    ADD CONSTRAINT message_moderation_scores_pkey PRIMARY KEY (score_id);


--
-- Name: message_translations message_translations_original_message_translated_language_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.message_translations
    ADD CONSTRAINT message_translations_original_message_translated_language_key UNIQUE (original_message, translated_language);


--
-- Name: message_translations message_translations_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.message_translations
    ADD CONSTRAINT message_translations_pkey PRIMARY KEY (translation_id);


--
-- Name: player_identifiers player_identifiers_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_identifiers
    ADD CONSTRAINT player_identifiers_pkey PRIMARY KEY (player_identifier_id);


--
-- Name: player_identifiers player_identifiers_provider_identifier_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_identifiers
    ADD CONSTRAINT player_identifiers_provider_identifier_key UNIQUE (provider, identifier);


--
-- Name: player_name_history player_name_history_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_name_history
    ADD CONSTRAINT player_name_history_pkey PRIMARY KEY (history_id);


--
-- Name: player_note_edits player_note_edits_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_note_edits
    ADD CONSTRAINT player_note_edits_pkey PRIMARY KEY (edit_id);


--
-- Name: player_notes player_notes_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_notes
    ADD CONSTRAINT player_notes_pkey PRIMARY KEY (note_id);


--
-- Name: player_sessions player_sessions_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_sessions
    ADD CONSTRAINT player_sessions_pkey PRIMARY KEY (player_session_id);


--
-- Name: player_sessions player_sessions_player_id_active_times_excl; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_sessions
    ADD CONSTRAINT player_sessions_player_id_active_times_excl EXCLUDE USING gist (player_id WITH =, active_times WITH &&);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: script_hashes script_hashes_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_hashes
    ADD CONSTRAINT script_hashes_pkey PRIMARY KEY (hash);


--
-- Name: script_revisions script_revisions_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_revisions
    ADD CONSTRAINT script_revisions_pkey PRIMARY KEY (script_id, revision_number);


--
-- Name: script_tests script_tests_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_tests
    ADD CONSTRAINT script_tests_pkey PRIMARY KEY (request_id);


--
-- Name: script_tests script_tests_user_id_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_tests
    ADD CONSTRAINT script_tests_user_id_key UNIQUE (user_id);


--
-- Name: script_webhooks script_webhooks_access_key_hash_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_webhooks
    ADD CONSTRAINT script_webhooks_access_key_hash_key UNIQUE (access_key_hash);


--
-- Name: script_webhooks script_webhooks_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_webhooks
    ADD CONSTRAINT script_webhooks_pkey PRIMARY KEY (webhook_id);


--
-- Name: scripts scripts_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.scripts
    ADD CONSTRAINT scripts_pkey PRIMARY KEY (script_id);


--
-- Name: service_bans service_bans_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_bans
    ADD CONSTRAINT service_bans_pkey PRIMARY KEY (service_ban_id);


--
-- Name: service_event_queue service_event_queue_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_event_queue
    ADD CONSTRAINT service_event_queue_pkey PRIMARY KEY (queue_id);


--
-- Name: service_languages service_languages_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_languages
    ADD CONSTRAINT service_languages_pkey PRIMARY KEY (service_id, language);


--
-- Name: service_log_messages service_log_messages_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_log_messages
    ADD CONSTRAINT service_log_messages_pkey PRIMARY KEY (message_id, language);


--
-- Name: service_logs service_logs_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_logs
    ADD CONSTRAINT service_logs_pkey PRIMARY KEY (message_id);


--
-- Name: service_scripts service_scripts_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_scripts
    ADD CONSTRAINT service_scripts_pkey PRIMARY KEY (service_script_id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: tribe_characters tribe_characters_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_characters
    ADD CONSTRAINT tribe_characters_pkey PRIMARY KEY (tribe_id, character_id);


--
-- Name: tribe_dinos tribe_dinos_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_dinos
    ADD CONSTRAINT tribe_dinos_pkey PRIMARY KEY (tribe_id, dino_id);


--
-- Name: tribes tribes_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribes
    ADD CONSTRAINT tribes_pkey PRIMARY KEY (tribe_id);


--
-- Name: watcher_logs watcher_logs_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.watcher_logs
    ADD CONSTRAINT watcher_logs_pkey PRIMARY KEY (message_id);


--
-- Name: watcher_releases watcher_releases_download_url_key; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.watcher_releases
    ADD CONSTRAINT watcher_releases_download_url_key UNIQUE (download_url);


--
-- Name: watcher_releases watcher_releases_pkey; Type: CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.watcher_releases
    ADD CONSTRAINT watcher_releases_pkey PRIMARY KEY (release_id);


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

CREATE UNIQUE INDEX mods_workshop_id_confirmed_uidx ON ark.mods_legacy USING btree (abs(workshop_id), confirmed) WHERE (confirmed = true);


--
-- Name: mods_workshop_id_user_id_uidx; Type: INDEX; Schema: ark; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_user_id_uidx ON ark.mods_legacy USING btree (abs(workshop_id), user_id);


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
-- Name: content_pack_relationships_pack_1_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX content_pack_relationships_pack_1_idx ON arksa.content_pack_relationships USING btree (pack_1);


--
-- Name: content_pack_relationships_pack_1_pack_2_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX content_pack_relationships_pack_1_pack_2_idx ON arksa.content_pack_relationships USING btree (pack_1, pack_2);


--
-- Name: creatures_class_string_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX creatures_class_string_idx ON arksa.creatures USING btree (class_string);


--
-- Name: creatures_content_pack_id_path_uidx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_content_pack_id_path_uidx ON arksa.creatures USING btree (content_pack_id, path);


--
-- Name: creatures_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX creatures_path_idx ON arksa.creatures USING btree (path);


--
-- Name: engrams_class_string_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX engrams_class_string_idx ON arksa.engrams USING btree (class_string);


--
-- Name: engrams_content_pack_id_path_uidx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_content_pack_id_path_uidx ON arksa.engrams USING btree (content_pack_id, path);


--
-- Name: engrams_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX engrams_path_idx ON arksa.engrams USING btree (path);


--
-- Name: loot_drops_class_string_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_drops_class_string_idx ON arksa.loot_drops USING btree (class_string);


--
-- Name: loot_drops_content_pack_id_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_drops_content_pack_id_path_idx ON arksa.loot_drops USING btree (content_pack_id, path);


--
-- Name: loot_drops_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_drops_path_idx ON arksa.loot_drops USING btree (path);


--
-- Name: loot_drops_sort_order_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_drops_sort_order_idx ON arksa.loot_drops USING btree (sort_order);


--
-- Name: loot_item_set_entries_loot_item_set_id_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_item_set_entries_loot_item_set_id_idx ON arksa.loot_item_set_entries USING btree (loot_item_set_id);


--
-- Name: loot_item_set_entry_options_loot_item_set_entry_id_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_item_set_entry_options_loot_item_set_entry_id_idx ON arksa.loot_item_set_entry_options USING btree (loot_item_set_entry_id);


--
-- Name: loot_item_set_entry_options_sort_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_item_set_entry_options_sort_idx ON arksa.loot_item_set_entry_options USING btree (loot_item_set_entry_id, sync_sort_key);


--
-- Name: loot_item_sets_loot_drop_id_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX loot_item_sets_loot_drop_id_idx ON arksa.loot_item_sets USING btree (loot_drop_id);


--
-- Name: loot_item_sets_sort_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX loot_item_sets_sort_idx ON arksa.loot_item_sets USING btree (loot_drop_id, sync_sort_key);


--
-- Name: maps_type_sort_key; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX maps_type_sort_key ON arksa.maps USING btree (type, sort);


--
-- Name: spawn_point_populations_spawn_point_id_map_id_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_populations_spawn_point_id_map_id_idx ON arksa.spawn_point_populations USING btree (spawn_point_id, map_id);


--
-- Name: spawn_point_set_entry_levels_unique_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_entry_levels_unique_idx ON arksa.spawn_point_set_entry_levels USING btree (spawn_point_set_entry_id, difficulty);


--
-- Name: spawn_point_set_replacements_unique_replacement_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_point_set_replacements_unique_replacement_idx ON arksa.spawn_point_set_replacements USING btree (spawn_point_set_id, target_creature_id, replacement_creature_id);


--
-- Name: spawn_points_class_string_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX spawn_points_class_string_idx ON arksa.spawn_points USING btree (class_string);


--
-- Name: spawn_points_content_pack_id_path_uidx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE UNIQUE INDEX spawn_points_content_pack_id_path_uidx ON arksa.spawn_points USING btree (content_pack_id, path);


--
-- Name: spawn_points_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX spawn_points_path_idx ON arksa.spawn_points USING btree (path);


--
-- Name: traits_path_idx; Type: INDEX; Schema: arksa; Owner: thommcgrath
--

CREATE INDEX traits_path_idx ON arksa.traits USING btree (path);


--
-- Name: ini_options_file_header_struct_key_idx; Type: INDEX; Schema: palworld; Owner: thommcgrath
--

CREATE UNIQUE INDEX ini_options_file_header_struct_key_idx ON palworld.ini_options USING btree (file, header, struct, key);


--
-- Name: access_tokens_application_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX access_tokens_application_id_idx ON public.access_tokens USING btree (application_id);


--
-- Name: access_tokens_refresh_token_expiration_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX access_tokens_refresh_token_expiration_idx ON public.access_tokens USING btree (refresh_token_expiration);


--
-- Name: application_auth_flows_expiration_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX application_auth_flows_expiration_idx ON public.application_auth_flows USING btree (expiration);


--
-- Name: content_pack_discovery_results_marketplace_marketplace_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX content_pack_discovery_results_marketplace_marketplace_id_idx ON public.content_pack_discovery_results USING btree (marketplace, marketplace_id);


--
-- Name: content_packs_marketplace_marketplace_id_confirmed_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX content_packs_marketplace_marketplace_id_confirmed_idx ON public.content_packs USING btree (marketplace, marketplace_id, confirmed) WHERE (confirmed = true);


--
-- Name: content_packs_marketplace_marketplace_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX content_packs_marketplace_marketplace_id_user_id_idx ON public.content_packs USING btree (marketplace, marketplace_id, user_id);


--
-- Name: device_auth_flows_application_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX device_auth_flows_application_id_idx ON public.device_auth_flows USING btree (application_id);


--
-- Name: device_auth_flows_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX device_auth_flows_user_id_idx ON public.device_auth_flows USING btree (user_id);


--
-- Name: device_auth_flows_verifier_hash_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX device_auth_flows_verifier_hash_idx ON public.device_auth_flows USING btree (verifier_hash);


--
-- Name: discord_bots_instance_key_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX discord_bots_instance_key_idx ON public.discord_bots USING btree (instance_key);


--
-- Name: download_signatures_download_id_format_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX download_signatures_download_id_format_idx ON public.download_signatures USING btree (download_id, format);


--
-- Name: email_addresses_group_key_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX email_addresses_group_key_idx ON public.email_addresses USING btree (group_key);


--
-- Name: email_verification_code_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX email_verification_code_idx ON public.email_verification USING btree (code);


--
-- Name: exception_signatures_exception_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX exception_signatures_exception_id_idx ON public.exception_signatures USING btree (exception_id);


--
-- Name: exception_users_exception_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX exception_users_exception_id_user_id_idx ON public.exception_users USING btree (exception_id, user_id);


--
-- Name: games_marketplace_marketplace_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX games_marketplace_marketplace_id_idx ON public.games USING btree (marketplace, marketplace_id);


--
-- Name: imported_obelisk_files_path_version_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX imported_obelisk_files_path_version_uidx ON public.imported_obelisk_files USING btree (path, version);


--
-- Name: oauth_requests_expiration_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX oauth_requests_expiration_idx ON public.oauth_requests USING btree (expiration);


--
-- Name: product_prices_product_id_currency_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX product_prices_product_id_currency_idx ON public.product_prices USING btree (product_id, currency);


--
-- Name: products_least_greatest_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX products_least_greatest_idx ON public.products USING btree (LEAST(monthly_price_id, yearly_price_id), GREATEST(monthly_price_id, yearly_price_id)) NULLS NOT DISTINCT WHERE ((product_type = 'Subscription'::public.product_type) AND (active = true));


--
-- Name: project_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX project_id_idx ON public.project_members USING btree (project_id);


--
-- Name: project_members_project_id_role_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX project_members_project_id_role_idx ON public.project_members USING btree (project_id, role) WHERE (role = 'Owner'::public.project_role);


--
-- Name: project_members_project_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX project_members_project_id_user_id_idx ON public.project_members USING btree (project_id, user_id);


--
-- Name: public_game_id_tag_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX public_game_id_tag_idx ON public.products USING btree (game_id, tag);


--
-- Name: purchases_purchaser_email_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX purchases_purchaser_email_idx ON public.purchases USING btree (purchaser_email);


--
-- Name: rcon_commands_game_id_name_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX rcon_commands_game_id_name_idx ON public.rcon_commands USING btree (game_id, name);


--
-- Name: service_tokens_refresh_token_expiration_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX service_tokens_refresh_token_expiration_idx ON public.service_tokens USING btree (refresh_token_expiration);


--
-- Name: service_tokens_user_id_provider_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX service_tokens_user_id_provider_idx ON public.service_tokens USING btree (user_id, provider);


--
-- Name: stw_applicants_email_id_desired_product_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX stw_applicants_email_id_desired_product_idx ON public.stw_applicants USING btree (email_id, desired_product);


--
-- Name: stw_purchases_original_purchase_id_generated_purchase_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX stw_purchases_original_purchase_id_generated_purchase_id_idx ON public.stw_purchases USING btree (original_purchase_id, generated_purchase_id);


--
-- Name: trusted_devices_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX trusted_devices_user_id_idx ON public.trusted_devices USING btree (user_id);


--
-- Name: update_files_created_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX update_files_created_idx ON public.update_files USING btree (created);


--
-- Name: update_files_unique_completes_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX update_files_unique_completes_idx ON public.update_files USING btree (version) WHERE (type = 'Complete'::public.update_file_type);


--
-- Name: update_files_unique_deltas_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX update_files_unique_deltas_idx ON public.update_files USING btree (created, version) WHERE (type = 'Delta'::public.update_file_type);


--
-- Name: update_files_version_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX update_files_version_idx ON public.update_files USING btree (version);


--
-- Name: user_authenticators_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX user_authenticators_user_id_idx ON public.user_authenticators USING btree (user_id);


--
-- Name: user_backup_codes_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX user_backup_codes_user_id_idx ON public.user_backup_codes USING btree (user_id);


--
-- Name: user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX user_id_idx ON public.project_members USING btree (user_id);


--
-- Name: usercloud_cache_remote_path_hostname_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX usercloud_cache_remote_path_hostname_idx ON public.usercloud_cache USING btree (remote_path, hostname);


--
-- Name: bucket_values_bucket_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX bucket_values_bucket_id_idx ON sentinel.bucket_values USING btree (bucket_id);


--
-- Name: bucket_values_bucket_id_player_id_key_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX bucket_values_bucket_id_player_id_key_idx ON sentinel.bucket_values USING btree (bucket_id, player_id, key) NULLS NOT DISTINCT;


--
-- Name: buckets_bucket_id_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX buckets_bucket_id_user_id_idx ON sentinel.buckets USING btree (bucket_id, user_id);


--
-- Name: buckets_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX buckets_user_id_idx ON sentinel.buckets USING btree (user_id);


--
-- Name: characters_name_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX characters_name_vector_idx ON sentinel.characters USING gin (name_vector);


--
-- Name: characters_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX characters_player_id_idx ON sentinel.characters USING btree (player_id);


--
-- Name: characters_player_id_is_active_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX characters_player_id_is_active_idx ON sentinel.characters USING btree (player_id, is_active) WHERE (is_active = true);


--
-- Name: characters_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX characters_service_id_idx ON sentinel.characters USING btree (service_id);


--
-- Name: characters_service_id_specimen_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX characters_service_id_specimen_id_idx ON sentinel.characters USING btree (service_id, specimen_id);


--
-- Name: dinos_display_name_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX dinos_display_name_idx ON sentinel.dinos USING btree (display_name);


--
-- Name: dinos_name_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX dinos_name_vector_idx ON sentinel.dinos USING gin (name_vector);


--
-- Name: dinos_service_id_dino_number_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX dinos_service_id_dino_number_idx ON sentinel.dinos USING btree (service_id, dino_number);


--
-- Name: dinos_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX dinos_service_id_idx ON sentinel.dinos USING btree (service_id);


--
-- Name: dinos_service_id_visual_dino_number_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX dinos_service_id_visual_dino_number_idx ON sentinel.dinos USING btree (service_id, visual_dino_number);


--
-- Name: dinos_status_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX dinos_status_idx ON sentinel.dinos USING btree (status);


--
-- Name: group_bans_group_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_bans_group_id_idx ON sentinel.group_bans USING btree (group_id);


--
-- Name: group_bans_group_id_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX group_bans_group_id_player_id_idx ON sentinel.group_bans USING btree (group_id, player_id);


--
-- Name: group_bans_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_bans_player_id_idx ON sentinel.group_bans USING btree (player_id);


--
-- Name: group_buckets_bucket_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_buckets_bucket_id_idx ON sentinel.group_buckets USING btree (bucket_id);


--
-- Name: group_buckets_group_id_bucket_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX group_buckets_group_id_bucket_id_idx ON sentinel.group_buckets USING btree (group_id, bucket_id);


--
-- Name: group_buckets_group_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_buckets_group_id_idx ON sentinel.group_buckets USING btree (group_id);


--
-- Name: group_scripts_group_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_scripts_group_id_idx ON sentinel.group_scripts USING btree (group_id);


--
-- Name: group_scripts_group_id_script_id_parameter_values_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX group_scripts_group_id_script_id_parameter_values_idx ON sentinel.group_scripts USING btree (group_id, script_id, md5((parameter_values)::text));


--
-- Name: group_scripts_script_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_scripts_script_id_idx ON sentinel.group_scripts USING btree (script_id);


--
-- Name: group_services_group_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_services_group_id_idx ON sentinel.group_services USING btree (group_id);


--
-- Name: group_services_group_id_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX group_services_group_id_service_id_idx ON sentinel.group_services USING btree (group_id, service_id);


--
-- Name: group_services_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_services_service_id_idx ON sentinel.group_services USING btree (service_id);


--
-- Name: group_users_group_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_users_group_id_idx ON sentinel.group_users USING btree (group_id);


--
-- Name: group_users_group_id_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX group_users_group_id_user_id_idx ON sentinel.group_users USING btree (group_id, user_id);


--
-- Name: group_users_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX group_users_user_id_idx ON sentinel.group_users USING btree (user_id);


--
-- Name: groups_discord_chat_channel_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX groups_discord_chat_channel_id_idx ON sentinel.groups USING btree (discord_chat_channel_id);


--
-- Name: groups_discord_guild_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX groups_discord_guild_id_idx ON sentinel.groups USING btree (discord_guild_id);


--
-- Name: groups_discord_link_code_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX groups_discord_link_code_idx ON sentinel.groups USING btree (discord_link_code);


--
-- Name: groups_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX groups_user_id_idx ON sentinel.groups USING btree (user_id);


--
-- Name: groups_user_id_name_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX groups_user_id_name_idx ON sentinel.groups USING btree (user_id, name);


--
-- Name: message_moderation_scores_original_message_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX message_moderation_scores_original_message_idx ON sentinel.message_moderation_scores USING btree (original_message);


--
-- Name: message_translations_original_message_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX message_translations_original_message_idx ON sentinel.message_translations USING btree (original_message);


--
-- Name: player_identifiers_player_id_provider_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX player_identifiers_player_id_provider_idx ON sentinel.player_identifiers USING btree (player_id, provider);


--
-- Name: player_name_history_name_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_name_history_name_vector_idx ON sentinel.player_name_history USING gin (name_vector);


--
-- Name: player_name_history_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_name_history_player_id_idx ON sentinel.player_name_history USING btree (player_id);


--
-- Name: player_note_edits_note_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_note_edits_note_id_idx ON sentinel.player_note_edits USING btree (note_id);


--
-- Name: player_note_edits_previous_content_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_note_edits_previous_content_vector_idx ON sentinel.player_note_edits USING gin (previous_content_vector);


--
-- Name: player_notes_content_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_notes_content_vector_idx ON sentinel.player_notes USING gin (content_vector);


--
-- Name: player_notes_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX player_notes_player_id_idx ON sentinel.player_notes USING btree (player_id);


--
-- Name: scripts_user_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX scripts_user_id_idx ON sentinel.scripts USING btree (user_id);


--
-- Name: scripts_user_id_name_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX scripts_user_id_name_idx ON sentinel.scripts USING btree (user_id, name);


--
-- Name: service_bans_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_bans_player_id_idx ON sentinel.service_bans USING btree (player_id);


--
-- Name: service_bans_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_bans_service_id_idx ON sentinel.service_bans USING btree (service_id);


--
-- Name: service_bans_service_id_player_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX service_bans_service_id_player_id_idx ON sentinel.service_bans USING btree (service_id, player_id);


--
-- Name: service_event_queue_queue_time_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_event_queue_queue_time_idx ON sentinel.service_event_queue USING btree (queue_time);


--
-- Name: service_event_queue_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_event_queue_service_id_idx ON sentinel.service_event_queue USING btree (service_id);


--
-- Name: service_event_queue_status_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_event_queue_status_idx ON sentinel.service_event_queue USING btree (status);


--
-- Name: service_log_messages_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_log_messages_vector_idx ON sentinel.service_log_messages USING gin (vector);


--
-- Name: service_logs_metadata_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_logs_metadata_idx ON sentinel.service_logs USING gin (((metadata)::text) public.gin_trgm_ops);


--
-- Name: service_logs_service_id_event_name_log_time_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_logs_service_id_event_name_log_time_idx ON sentinel.service_logs USING btree (service_id, event_name, log_time);


--
-- Name: service_scripts_script_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_scripts_script_id_idx ON sentinel.service_scripts USING btree (script_id);


--
-- Name: service_scripts_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX service_scripts_service_id_idx ON sentinel.service_scripts USING btree (service_id);


--
-- Name: service_scripts_service_id_script_id_parameter_values_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX service_scripts_service_id_script_id_parameter_values_idx ON sentinel.service_scripts USING btree (service_id, script_id, md5((parameter_values)::text));


--
-- Name: services_access_key_hash_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX services_access_key_hash_idx ON sentinel.services USING btree (access_key_hash);


--
-- Name: services_cluster_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX services_cluster_id_idx ON sentinel.services USING btree (cluster_id);


--
-- Name: tribe_characters_character_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribe_characters_character_id_idx ON sentinel.tribe_characters USING btree (character_id);


--
-- Name: tribe_characters_tribe_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribe_characters_tribe_id_idx ON sentinel.tribe_characters USING btree (tribe_id);


--
-- Name: tribe_dinos_dino_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribe_dinos_dino_id_idx ON sentinel.tribe_dinos USING btree (dino_id);


--
-- Name: tribe_dinos_tribe_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribe_dinos_tribe_id_idx ON sentinel.tribe_dinos USING btree (tribe_id);


--
-- Name: tribes_name_vector_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribes_name_vector_idx ON sentinel.tribes USING gin (name_vector);


--
-- Name: tribes_service_id_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE INDEX tribes_service_id_idx ON sentinel.tribes USING btree (service_id);


--
-- Name: tribes_service_id_tribe_number_idx; Type: INDEX; Schema: sentinel; Owner: thommcgrath
--

CREATE UNIQUE INDEX tribes_service_id_tribe_number_idx ON sentinel.tribes USING btree (service_id, tribe_number);


--
-- Name: deletions ark_deletions_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ark_deletions_delete_trigger INSTEAD OF DELETE ON ark.deletions FOR EACH ROW EXECUTE FUNCTION ark.deletions_delete();


--
-- Name: deletions ark_deletions_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER ark_deletions_insert_trigger INSTEAD OF INSERT ON ark.deletions FOR EACH ROW EXECUTE FUNCTION ark.deletions_insert();


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

CREATE TRIGGER creatures_search_sync_update_trigger BEFORE UPDATE ON ark.creatures FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


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

CREATE TRIGGER engrams_search_sync_update_trigger BEFORE UPDATE ON ark.engrams FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


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
-- Name: mods legacy_mod_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER legacy_mod_delete_trigger INSTEAD OF DELETE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.legacy_mod_delete();


--
-- Name: mods legacy_mod_insert_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER legacy_mod_insert_trigger INSTEAD OF INSERT ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.legacy_mod_insert();


--
-- Name: mods legacy_mod_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER legacy_mod_update_trigger INSTEAD OF UPDATE ON ark.mods FOR EACH ROW EXECUTE FUNCTION ark.legacy_mod_update();


--
-- Name: loot_item_set_entries loot_item_set_entries_update_ts_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entries_update_ts_delete_trigger BEFORE DELETE ON ark.loot_item_set_entries FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_set_entries loot_item_set_entries_update_ts_write_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entries_update_ts_write_trigger AFTER INSERT OR UPDATE ON ark.loot_item_set_entries FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_update_ts_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entry_options_update_ts_delete_trigger BEFORE DELETE ON ark.loot_item_set_entry_options FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_update_ts_write_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entry_options_update_ts_write_trigger AFTER INSERT OR UPDATE ON ark.loot_item_set_entry_options FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_sets loot_item_sets_update_ts_delete_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_sets_update_ts_delete_trigger BEFORE DELETE ON ark.loot_item_sets FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


--
-- Name: loot_item_sets loot_item_sets_update_ts_write_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER loot_item_sets_update_ts_write_trigger AFTER INSERT OR UPDATE ON ark.loot_item_sets FOR EACH ROW EXECUTE FUNCTION ark.update_loot_source_timestamp();


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

CREATE TRIGGER loot_sources_search_sync_update_trigger BEFORE UPDATE ON ark.loot_sources FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: maps maps_before_update_trigger; Type: TRIGGER; Schema: ark; Owner: thommcgrath
--

CREATE TRIGGER maps_before_update_trigger BEFORE INSERT OR UPDATE ON ark.maps FOR EACH ROW EXECUTE FUNCTION ark.update_last_update_column();


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

CREATE TRIGGER spawn_points_search_sync_update_trigger BEFORE UPDATE ON ark.spawn_points FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.mod_id IS DISTINCT FROM new.mod_id))) EXECUTE FUNCTION ark.objects_search_sync();


--
-- Name: color_sets color_sets_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER color_sets_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.color_sets FOR EACH ROW EXECUTE FUNCTION arksa.update_color_set_last_update();


--
-- Name: colors colors_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER colors_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.colors FOR EACH ROW EXECUTE FUNCTION arksa.update_color_last_update();


--
-- Name: crafting_costs crafting_costs_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER crafting_costs_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.crafting_costs FOR EACH ROW EXECUTE FUNCTION arksa.update_engram_timestamp();


--
-- Name: creature_stats creature_stats_update_creature_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creature_stats_update_creature_trigger AFTER INSERT OR DELETE OR UPDATE ON arksa.creature_stats FOR EACH ROW EXECUTE FUNCTION arksa.update_creature_modified();


--
-- Name: creatures creatures_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON arksa.creatures FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: creatures creatures_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON arksa.creatures FOR EACH ROW EXECUTE FUNCTION arksa.blueprint_insert_trigger();


--
-- Name: creatures creatures_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON arksa.creatures FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: creatures creatures_compute_class_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON arksa.creatures FOR EACH ROW EXECUTE FUNCTION arksa.compute_class_trigger();


--
-- Name: creatures creatures_search_sync_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_search_sync_trigger BEFORE INSERT OR DELETE ON arksa.creatures FOR EACH ROW EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: creatures creatures_search_sync_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER creatures_search_sync_update_trigger BEFORE UPDATE ON arksa.creatures FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.content_pack_id IS DISTINCT FROM new.content_pack_id))) EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: deletions deletions_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER deletions_delete_trigger INSTEAD OF DELETE ON arksa.deletions FOR EACH ROW EXECUTE FUNCTION arksa.deletions_delete();


--
-- Name: deletions deletions_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER deletions_insert_trigger INSTEAD OF INSERT ON arksa.deletions FOR EACH ROW EXECUTE FUNCTION arksa.deletions_insert();


--
-- Name: engram_stats engram_stats_update_creature_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engram_stats_update_creature_trigger AFTER INSERT OR DELETE OR UPDATE ON arksa.engram_stats FOR EACH ROW EXECUTE FUNCTION arksa.update_engram_modified();


--
-- Name: engrams engrams_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON arksa.engrams FOR EACH ROW EXECUTE FUNCTION arksa.engram_delete_trigger();


--
-- Name: engrams engrams_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON arksa.engrams FOR EACH ROW EXECUTE FUNCTION arksa.blueprint_insert_trigger();


--
-- Name: engrams engrams_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON arksa.engrams FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: engrams engrams_compute_class_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON arksa.engrams FOR EACH ROW EXECUTE FUNCTION arksa.compute_class_trigger();


--
-- Name: engrams engrams_search_sync_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_search_sync_trigger BEFORE INSERT OR DELETE ON arksa.engrams FOR EACH ROW EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: engrams engrams_search_sync_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER engrams_search_sync_update_trigger BEFORE UPDATE ON arksa.engrams FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.content_pack_id IS DISTINCT FROM new.content_pack_id))) EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: event_colors event_colors_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER event_colors_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON arksa.event_colors FOR EACH ROW EXECUTE FUNCTION arksa.update_event_last_update_from_children();


--
-- Name: event_engrams event_engrams_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER event_engrams_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON arksa.event_engrams FOR EACH ROW EXECUTE FUNCTION arksa.update_event_last_update_from_children();


--
-- Name: event_rates event_rates_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER event_rates_modified_trigger AFTER INSERT OR DELETE OR UPDATE ON arksa.event_rates FOR EACH ROW EXECUTE FUNCTION arksa.update_event_last_update_from_children();


--
-- Name: events events_modified_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER events_modified_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.events FOR EACH ROW EXECUTE FUNCTION arksa.update_event_last_update();


--
-- Name: game_variables game_variables_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON arksa.game_variables FOR EACH ROW EXECUTE FUNCTION arksa.generic_update_trigger();


--
-- Name: ini_options ini_options_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER ini_options_after_delete_trigger AFTER DELETE ON arksa.ini_options FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: ini_options ini_options_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_insert_trigger BEFORE INSERT ON arksa.ini_options FOR EACH ROW EXECUTE FUNCTION arksa.ini_options_insert_trigger();


--
-- Name: ini_options ini_options_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_update_trigger BEFORE UPDATE ON arksa.ini_options FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: loot_drop_icons loot_drop_icons_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drop_icons_after_delete_trigger AFTER DELETE ON arksa.loot_drop_icons FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: loot_drop_icons loot_drop_icons_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drop_icons_before_insert_trigger BEFORE INSERT ON arksa.loot_drop_icons FOR EACH ROW EXECUTE FUNCTION arksa.object_insert_trigger();


--
-- Name: loot_drop_icons loot_drop_icons_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drop_icons_before_update_trigger BEFORE UPDATE ON arksa.loot_drop_icons FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: loot_drops loot_drops_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_after_delete_trigger AFTER DELETE ON arksa.loot_drops FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: loot_drops loot_drops_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_before_insert_trigger BEFORE INSERT ON arksa.loot_drops FOR EACH ROW EXECUTE FUNCTION arksa.blueprint_insert_trigger();


--
-- Name: loot_drops loot_drops_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_before_update_trigger BEFORE UPDATE ON arksa.loot_drops FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: loot_drops loot_drops_compute_class_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_compute_class_trigger BEFORE INSERT OR UPDATE ON arksa.loot_drops FOR EACH ROW EXECUTE FUNCTION arksa.compute_class_trigger();


--
-- Name: loot_drops loot_drops_search_sync_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_search_sync_trigger BEFORE INSERT OR DELETE ON arksa.loot_drops FOR EACH ROW EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: loot_drops loot_drops_search_sync_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_drops_search_sync_update_trigger BEFORE UPDATE ON arksa.loot_drops FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.content_pack_id IS DISTINCT FROM new.content_pack_id))) EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: loot_item_set_entries loot_item_set_entries_update_ts_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entries_update_ts_delete_trigger BEFORE DELETE ON arksa.loot_item_set_entries FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: loot_item_set_entries loot_item_set_entries_update_ts_write_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entries_update_ts_write_trigger AFTER INSERT OR UPDATE ON arksa.loot_item_set_entries FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_update_ts_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entry_options_update_ts_delete_trigger BEFORE DELETE ON arksa.loot_item_set_entry_options FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_update_ts_write_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_set_entry_options_update_ts_write_trigger AFTER INSERT OR UPDATE ON arksa.loot_item_set_entry_options FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: loot_item_sets loot_item_sets_update_ts_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_sets_update_ts_delete_trigger BEFORE DELETE ON arksa.loot_item_sets FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: loot_item_sets loot_item_sets_update_ts_write_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER loot_item_sets_update_ts_write_trigger AFTER INSERT OR UPDATE ON arksa.loot_item_sets FOR EACH ROW EXECUTE FUNCTION arksa.update_loot_drop_timestamp();


--
-- Name: maps maps_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER maps_before_update_trigger BEFORE INSERT OR UPDATE ON arksa.maps FOR EACH ROW EXECUTE FUNCTION arksa.update_last_update_column();


--
-- Name: spawn_point_limits spawn_point_limits_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_limits_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_limits FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_point_populations spawn_point_populations_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_populations_update_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_populations FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entries spawn_point_set_entries_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entries_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_set_entries FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_entry_levels_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_set_entry_levels FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_set_replacements_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_set_replacements FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_point_sets spawn_point_sets_update_timestamp_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_point_sets_update_timestamp_trigger BEFORE INSERT OR DELETE OR UPDATE ON arksa.spawn_point_sets FOR EACH ROW EXECUTE FUNCTION arksa.update_spawn_point_timestamp();


--
-- Name: spawn_points spawn_points_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_after_delete_trigger AFTER DELETE ON arksa.spawn_points FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: spawn_points spawn_points_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_insert_trigger BEFORE INSERT ON arksa.spawn_points FOR EACH ROW EXECUTE FUNCTION arksa.blueprint_insert_trigger();


--
-- Name: spawn_points spawn_points_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_before_update_trigger BEFORE UPDATE ON arksa.spawn_points FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: spawn_points spawn_points_compute_class_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_compute_class_trigger BEFORE INSERT OR UPDATE ON arksa.spawn_points FOR EACH ROW EXECUTE FUNCTION arksa.compute_class_trigger();


--
-- Name: spawn_points spawn_points_search_sync_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_search_sync_trigger BEFORE INSERT OR DELETE ON arksa.spawn_points FOR EACH ROW EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: spawn_points spawn_points_search_sync_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER spawn_points_search_sync_update_trigger BEFORE UPDATE ON arksa.spawn_points FOR EACH ROW WHEN ((((old.label)::text IS DISTINCT FROM (new.label)::text) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.content_pack_id IS DISTINCT FROM new.content_pack_id))) EXECUTE FUNCTION arksa.objects_search_sync();


--
-- Name: template_selectors template_selectors_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER template_selectors_after_delete_trigger AFTER DELETE ON arksa.template_selectors FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: template_selectors template_selectors_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER template_selectors_before_insert_trigger BEFORE INSERT ON arksa.template_selectors FOR EACH ROW EXECUTE FUNCTION arksa.object_insert_trigger();


--
-- Name: template_selectors template_selectors_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER template_selectors_before_update_trigger BEFORE UPDATE ON arksa.template_selectors FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: templates templates_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER templates_after_delete_trigger AFTER DELETE ON arksa.templates FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: templates templates_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER templates_before_insert_trigger BEFORE INSERT ON arksa.templates FOR EACH ROW EXECUTE FUNCTION arksa.object_insert_trigger();


--
-- Name: templates templates_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER templates_before_update_trigger BEFORE UPDATE ON arksa.templates FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: templates templates_json_sync_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER templates_json_sync_trigger BEFORE INSERT OR UPDATE ON arksa.templates FOR EACH ROW EXECUTE FUNCTION arksa.templates_json_sync_function();


--
-- Name: traits traits_after_delete_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER traits_after_delete_trigger AFTER DELETE ON arksa.traits FOR EACH ROW EXECUTE FUNCTION arksa.object_delete_trigger();


--
-- Name: traits traits_before_insert_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER traits_before_insert_trigger BEFORE INSERT ON arksa.traits FOR EACH ROW EXECUTE FUNCTION arksa.blueprint_insert_trigger();


--
-- Name: traits traits_before_update_trigger; Type: TRIGGER; Schema: arksa; Owner: thommcgrath
--

CREATE TRIGGER traits_before_update_trigger BEFORE UPDATE ON arksa.traits FOR EACH ROW EXECUTE FUNCTION arksa.object_update_trigger();


--
-- Name: deletions deletions_delete_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER deletions_delete_trigger INSTEAD OF DELETE ON palworld.deletions FOR EACH ROW EXECUTE FUNCTION palworld.deletions_delete();


--
-- Name: deletions deletions_inser_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER deletions_inser_trigger INSTEAD OF INSERT ON palworld.deletions FOR EACH ROW EXECUTE FUNCTION palworld.deletions_insert();


--
-- Name: game_variables game_variables_before_update_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON palworld.game_variables FOR EACH ROW EXECUTE FUNCTION palworld.generic_update_trigger();


--
-- Name: ini_options ini_options_after_delete_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER ini_options_after_delete_trigger AFTER DELETE ON palworld.ini_options FOR EACH ROW EXECUTE FUNCTION palworld.object_delete_trigger();


--
-- Name: ini_options ini_options_before_insert_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_insert_trigger BEFORE INSERT ON palworld.ini_options FOR EACH ROW EXECUTE FUNCTION palworld.ini_options_insert_trigger();


--
-- Name: ini_options ini_options_before_update_trigger; Type: TRIGGER; Schema: palworld; Owner: thommcgrath
--

CREATE TRIGGER ini_options_before_update_trigger BEFORE UPDATE ON palworld.ini_options FOR EACH ROW EXECUTE FUNCTION palworld.object_update_trigger();


--
-- Name: client_notices client_notices_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER client_notices_before_update_trigger BEFORE INSERT OR UPDATE ON public.client_notices FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: content_packs content_packs_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER content_packs_after_delete_trigger AFTER DELETE ON public.content_packs FOR EACH ROW EXECUTE FUNCTION public.content_packs_delete_trigger();


--
-- Name: content_packs content_packs_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER content_packs_before_update_trigger BEFORE INSERT OR UPDATE ON public.content_packs FOR EACH ROW EXECUTE FUNCTION public.generic_update_trigger();


--
-- Name: content_packs content_packs_search_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER content_packs_search_sync_trigger BEFORE INSERT OR DELETE ON public.content_packs FOR EACH ROW EXECUTE FUNCTION public.content_packs_search_sync();


--
-- Name: content_packs content_packs_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER content_packs_search_sync_update_trigger BEFORE UPDATE ON public.content_packs FOR EACH ROW WHEN ((((old.name)::text IS DISTINCT FROM (new.name)::text) OR (old.confirmed IS DISTINCT FROM new.confirmed))) EXECUTE FUNCTION public.content_packs_search_sync();


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
-- Name: content_packs enforce_content_pack_owner; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER enforce_content_pack_owner BEFORE INSERT OR UPDATE ON public.content_packs FOR EACH ROW EXECUTE FUNCTION public.enforce_content_pack_owner();


--
-- Name: help_topics help_topics_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER help_topics_before_update_trigger BEFORE INSERT OR UPDATE ON public.help_topics FOR EACH ROW EXECUTE FUNCTION ark.generic_update_trigger();


--
-- Name: blog_articles insert_blog_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER insert_blog_article_timestamp_trigger BEFORE INSERT ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_timestamp();


--
-- Name: sessions legacy_session_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER legacy_session_delete_trigger INSTEAD OF DELETE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.legacy_session_delete();


--
-- Name: sessions legacy_session_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER legacy_session_insert_trigger INSTEAD OF INSERT ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.legacy_session_insert();


--
-- Name: sessions legacy_session_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER legacy_session_update_trigger INSTEAD OF UPDATE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.legacy_session_update();


--
-- Name: policies policies_after_write_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER policies_after_write_trigger AFTER INSERT OR UPDATE ON public.policies FOR EACH ROW EXECUTE FUNCTION public.policies_after_write();


--
-- Name: policies policies_before_write_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER policies_before_write_trigger BEFORE INSERT OR UPDATE ON public.policies FOR EACH ROW EXECUTE FUNCTION public.policies_before_write();


--
-- Name: projects projects_search_sync_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER projects_search_sync_insert_trigger AFTER INSERT ON public.projects FOR EACH ROW EXECUTE FUNCTION public.projects_search_sync();


--
-- Name: projects projects_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER projects_search_sync_update_trigger AFTER UPDATE ON public.projects FOR EACH ROW WHEN ((((old.title)::text IS DISTINCT FROM (new.title)::text) OR ((old.description)::text IS DISTINCT FROM (new.description)::text) OR (old.published IS DISTINCT FROM new.published))) EXECUTE FUNCTION public.projects_search_sync();


--
-- Name: rcon_commands rcon_commands_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER rcon_commands_delete_trigger AFTER DELETE ON public.rcon_commands FOR EACH ROW EXECUTE FUNCTION public.rcon_commands_deleted();


--
-- Name: rcon_commands rcon_commands_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER rcon_commands_update_trigger BEFORE INSERT OR UPDATE ON public.rcon_commands FOR EACH ROW EXECUTE FUNCTION public.rcon_commands_update_modified();


--
-- Name: rcon_parameters rcon_parameters_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER rcon_parameters_update_trigger AFTER INSERT OR DELETE OR UPDATE ON public.rcon_parameters FOR EACH ROW EXECUTE FUNCTION public.rcon_parameters_update_modified();


--
-- Name: support_articles support_articles_search_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_articles_search_sync_trigger BEFORE INSERT OR DELETE ON public.support_articles FOR EACH ROW EXECUTE FUNCTION public.support_articles_search_sync();


--
-- Name: support_articles support_articles_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_articles_search_sync_update_trigger BEFORE UPDATE ON public.support_articles FOR EACH ROW WHEN ((((old.article_slug)::text IS DISTINCT FROM (new.article_slug)::text) OR ((old.subject)::text IS DISTINCT FROM (new.subject)::text) OR ((old.preview)::text IS DISTINCT FROM (new.preview)::text) OR (old.published IS DISTINCT FROM new.published) OR (old.min_version IS DISTINCT FROM new.min_version) OR (old.max_version IS DISTINCT FROM new.max_version))) EXECUTE FUNCTION public.support_articles_search_sync();


--
-- Name: support_videos support_videos_search_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_videos_search_sync_trigger BEFORE INSERT OR DELETE ON public.support_videos FOR EACH ROW EXECUTE FUNCTION public.support_videos_search_sync();


--
-- Name: support_videos support_videos_search_sync_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER support_videos_search_sync_update_trigger BEFORE UPDATE ON public.support_videos FOR EACH ROW WHEN ((((old.video_slug)::text IS DISTINCT FROM (new.video_slug)::text) OR ((old.video_title)::text IS DISTINCT FROM (new.video_title)::text))) EXECUTE FUNCTION public.support_videos_search_sync();


--
-- Name: blog_articles update_blog_article_hash_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_hash_trigger BEFORE INSERT OR UPDATE ON public.blog_articles FOR EACH ROW EXECUTE FUNCTION public.update_blog_article_hash();


--
-- Name: blog_articles update_blog_article_timestamp_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_blog_article_timestamp_trigger BEFORE UPDATE ON public.blog_articles FOR EACH ROW WHEN (((old.content_markdown)::text IS DISTINCT FROM (new.content_markdown)::text)) EXECUTE FUNCTION public.update_blog_article_timestamp();


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
-- Name: config_options after_delete_trigger; Type: TRIGGER; Schema: sdtd; Owner: thommcgrath
--

CREATE TRIGGER after_delete_trigger AFTER DELETE ON sdtd.config_options FOR EACH ROW EXECUTE FUNCTION sdtd.object_delete_trigger();


--
-- Name: config_options before_insert_trigger; Type: TRIGGER; Schema: sdtd; Owner: thommcgrath
--

CREATE TRIGGER before_insert_trigger BEFORE INSERT ON sdtd.config_options FOR EACH ROW EXECUTE FUNCTION sdtd.object_insert_trigger();


--
-- Name: config_options before_update_trigger; Type: TRIGGER; Schema: sdtd; Owner: thommcgrath
--

CREATE TRIGGER before_update_trigger BEFORE UPDATE ON sdtd.config_options FOR EACH ROW EXECUTE FUNCTION sdtd.object_update_trigger();


--
-- Name: script_tests check_user_script_test_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER check_user_script_test_trigger BEFORE INSERT ON sentinel.script_tests FOR EACH ROW EXECUTE FUNCTION sentinel.check_script_test();


--
-- Name: dinos dinos_set_last_update; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER dinos_set_last_update BEFORE UPDATE ON sentinel.dinos FOR EACH ROW EXECUTE FUNCTION sentinel.dino_update_trigger();


--
-- Name: group_services group_services_after_edit_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER group_services_after_edit_trigger AFTER INSERT OR UPDATE ON sentinel.group_services FOR EACH ROW EXECUTE FUNCTION sentinel.group_services_after_edit();


--
-- Name: groups groups_after_edit_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER groups_after_edit_trigger AFTER INSERT OR UPDATE ON sentinel.groups FOR EACH ROW EXECUTE FUNCTION sentinel.groups_after_edit();


--
-- Name: player_notes player_notes_edit_log_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER player_notes_edit_log_trigger BEFORE UPDATE ON sentinel.player_notes FOR EACH ROW EXECUTE FUNCTION sentinel.save_player_note_history();


--
-- Name: scripts scripts_before_insert_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER scripts_before_insert_trigger BEFORE INSERT ON sentinel.scripts FOR EACH ROW EXECUTE FUNCTION sentinel.before_script_insert();


--
-- Name: scripts scripts_before_update_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER scripts_before_update_trigger BEFORE UPDATE ON sentinel.scripts FOR EACH ROW EXECUTE FUNCTION sentinel.before_script_update();


--
-- Name: players track_player_name_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER track_player_name_trigger AFTER INSERT OR UPDATE ON sentinel.players FOR EACH ROW EXECUTE FUNCTION sentinel.track_player_name();


--
-- Name: service_logs wake_chat_thread_trigger; Type: TRIGGER; Schema: sentinel; Owner: thommcgrath
--

CREATE TRIGGER wake_chat_thread_trigger AFTER INSERT OR UPDATE ON sentinel.service_logs FOR EACH ROW EXECUTE FUNCTION sentinel.notify_chat_trigger();


--
-- Name: crafting_costs crafting_costs_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.crafting_costs
    ADD CONSTRAINT crafting_costs_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: crafting_costs crafting_costs_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.crafting_costs
    ADD CONSTRAINT crafting_costs_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT creatures_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT diets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: engrams engrams_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.engrams
    ADD CONSTRAINT engrams_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT ini_options_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entries loot_item_set_entries_loot_item_set_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_loot_item_set_id_fkey FOREIGN KEY (loot_item_set_id) REFERENCES ark.loot_item_sets(loot_item_set_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_engram_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES ark.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT loot_source_icons_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_sources loot_sources_icon_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources
    ADD CONSTRAINT loot_sources_icon_fkey FOREIGN KEY (icon) REFERENCES ark.loot_source_icons(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: loot_sources loot_sources_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.loot_sources
    ADD CONSTRAINT loot_sources_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maps maps_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.maps
    ADD CONSTRAINT maps_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mod_relationships mod_relationships_first_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mod_relationships
    ADD CONSTRAINT mod_relationships_first_mod_id_fkey FOREIGN KEY (first_mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mod_relationships mod_relationships_second_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mod_relationships
    ADD CONSTRAINT mod_relationships_second_mod_id_fkey FOREIGN KEY (second_mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mods_legacy mods_user_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.mods_legacy
    ADD CONSTRAINT mods_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.objects
    ADD CONSTRAINT objects_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: preset_modifiers preset_modifiers_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.preset_modifiers
    ADD CONSTRAINT preset_modifiers_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: presets presets_mod_id_fkey; Type: FK CONSTRAINT; Schema: ark; Owner: thommcgrath
--

ALTER TABLE ONLY ark.presets
    ADD CONSTRAINT presets_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT spawn_points_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_pack_relationships content_pack_relationships_pack_1_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.content_pack_relationships
    ADD CONSTRAINT content_pack_relationships_pack_1_fkey FOREIGN KEY (pack_1) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_pack_relationships content_pack_relationships_pack_2_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.content_pack_relationships
    ADD CONSTRAINT content_pack_relationships_pack_2_fkey FOREIGN KEY (pack_2) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: crafting_costs crafting_costs_engram_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.crafting_costs
    ADD CONSTRAINT crafting_costs_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: crafting_costs crafting_costs_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.crafting_costs
    ADD CONSTRAINT crafting_costs_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creature_engrams creature_engrams_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_engrams
    ADD CONSTRAINT creature_engrams_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creature_engrams creature_engrams_engram_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_engrams
    ADD CONSTRAINT creature_engrams_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creature_stats creature_stats_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creature_stats
    ADD CONSTRAINT creature_stats_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: creatures creatures_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.creatures
    ADD CONSTRAINT creatures_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: engram_stats engram_stats_engram_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engram_stats
    ADD CONSTRAINT engram_stats_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: engrams engrams_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.engrams
    ADD CONSTRAINT engrams_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: event_colors event_colors_color_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_colors
    ADD CONSTRAINT event_colors_color_id_fkey FOREIGN KEY (color_id) REFERENCES arksa.colors(color_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: event_colors event_colors_event_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_colors
    ADD CONSTRAINT event_colors_event_id_fkey FOREIGN KEY (event_id) REFERENCES arksa.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_event_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_engrams
    ADD CONSTRAINT event_engrams_event_id_fkey FOREIGN KEY (event_id) REFERENCES arksa.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_engrams event_engrams_object_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_engrams
    ADD CONSTRAINT event_engrams_object_id_fkey FOREIGN KEY (object_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_event_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_rates
    ADD CONSTRAINT event_rates_event_id_fkey FOREIGN KEY (event_id) REFERENCES arksa.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_rates event_rates_ini_option_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.event_rates
    ADD CONSTRAINT event_rates_ini_option_fkey FOREIGN KEY (ini_option) REFERENCES arksa.ini_options(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ini_options ini_options_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.ini_options
    ADD CONSTRAINT ini_options_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_drop_icons loot_drop_icons_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drop_icons
    ADD CONSTRAINT loot_drop_icons_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_drops loot_drops_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops
    ADD CONSTRAINT loot_drops_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_drops loot_drops_icon_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_drops
    ADD CONSTRAINT loot_drops_icon_fkey FOREIGN KEY (icon) REFERENCES arksa.loot_drop_icons(object_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: loot_item_set_entries loot_item_set_entries_loot_item_set_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entries
    ADD CONSTRAINT loot_item_set_entries_loot_item_set_id_fkey FOREIGN KEY (loot_item_set_id) REFERENCES arksa.loot_item_sets(loot_item_set_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_engram_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_engram_id_fkey FOREIGN KEY (engram_id) REFERENCES arksa.engrams(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_set_entry_options loot_item_set_entry_options_loot_item_set_entry_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_set_entry_options
    ADD CONSTRAINT loot_item_set_entry_options_loot_item_set_entry_id_fkey FOREIGN KEY (loot_item_set_entry_id) REFERENCES arksa.loot_item_set_entries(loot_item_set_entry_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: loot_item_sets loot_item_sets_loot_drop_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.loot_item_sets
    ADD CONSTRAINT loot_item_sets_loot_drop_id_fkey FOREIGN KEY (loot_drop_id) REFERENCES arksa.loot_drops(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maps maps_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.maps
    ADD CONSTRAINT maps_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: objects objects_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.objects
    ADD CONSTRAINT objects_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spawn_point_limits spawn_point_limits_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spawn_point_limits spawn_point_limits_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_limits
    ADD CONSTRAINT spawn_point_limits_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES arksa.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_populations spawn_point_populations_map_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_map_id_fkey FOREIGN KEY (map_id) REFERENCES arksa.maps(map_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_populations spawn_point_populations_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_populations
    ADD CONSTRAINT spawn_point_populations_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES arksa.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spawn_point_set_entries spawn_point_set_entries_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_entries
    ADD CONSTRAINT spawn_point_set_entries_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES arksa.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_entry_levels spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_entry_levels
    ADD CONSTRAINT spawn_point_set_entry_levels_spawn_point_set_entry_id_fkey FOREIGN KEY (spawn_point_set_entry_id) REFERENCES arksa.spawn_point_set_entries(spawn_point_set_entry_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_replacement_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_replacement_creature_id_fkey FOREIGN KEY (replacement_creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_spawn_point_set_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_spawn_point_set_id_fkey FOREIGN KEY (spawn_point_set_id) REFERENCES arksa.spawn_point_sets(spawn_point_set_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_point_set_replacements spawn_point_set_replacements_target_creature_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_set_replacements
    ADD CONSTRAINT spawn_point_set_replacements_target_creature_id_fkey FOREIGN KEY (target_creature_id) REFERENCES arksa.creatures(object_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: spawn_point_sets spawn_point_sets_spawn_point_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_point_sets
    ADD CONSTRAINT spawn_point_sets_spawn_point_id_fkey FOREIGN KEY (spawn_point_id) REFERENCES arksa.spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spawn_points spawn_points_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.spawn_points
    ADD CONSTRAINT spawn_points_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: template_selectors template_selectors_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.template_selectors
    ADD CONSTRAINT template_selectors_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: templates templates_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: arksa; Owner: thommcgrath
--

ALTER TABLE ONLY arksa.templates
    ADD CONSTRAINT templates_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ini_options ini_options_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.ini_options
    ADD CONSTRAINT ini_options_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: objects objects_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: palworld; Owner: thommcgrath
--

ALTER TABLE ONLY palworld.objects
    ADD CONSTRAINT objects_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: access_tokens access_tokens_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: access_tokens access_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: affiliate_links affiliate_links_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_links
    ADD CONSTRAINT affiliate_links_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: affiliate_products affiliate_products_affiliate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_products
    ADD CONSTRAINT affiliate_products_affiliate_id_fkey FOREIGN KEY (affiliate_id) REFERENCES public.affiliate_links(code) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: affiliate_products affiliate_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_products
    ADD CONSTRAINT affiliate_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: affiliate_tracking affiliate_tracking_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_tracking
    ADD CONSTRAINT affiliate_tracking_code_fkey FOREIGN KEY (code) REFERENCES public.affiliate_links(code) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: affiliate_tracking affiliate_tracking_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.affiliate_tracking
    ADD CONSTRAINT affiliate_tracking_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id);


--
-- Name: application_auth_flows application_auth_flows_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_auth_flows
    ADD CONSTRAINT application_auth_flows_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: application_auth_flows application_auth_flows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_auth_flows
    ADD CONSTRAINT application_auth_flows_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: application_callbacks application_callbacks_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.application_callbacks
    ADD CONSTRAINT application_callbacks_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: applications applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: content_packs content_packs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.content_packs
    ADD CONSTRAINT content_packs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: device_auth_flows device_auth_flows_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.device_auth_flows
    ADD CONSTRAINT device_auth_flows_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(application_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: device_auth_flows device_auth_flows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.device_auth_flows
    ADD CONSTRAINT device_auth_flows_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: discord_channels discord_channels_channel_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_channels
    ADD CONSTRAINT discord_channels_channel_parent_id_fkey FOREIGN KEY (channel_parent_id) REFERENCES public.discord_channels(channel_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discord_channels discord_channels_guild_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_channels
    ADD CONSTRAINT discord_channels_guild_id_fkey FOREIGN KEY (guild_id) REFERENCES public.discord_guilds(guild_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: discord_guilds discord_guilds_bot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.discord_guilds
    ADD CONSTRAINT discord_guilds_bot_id_fkey FOREIGN KEY (bot_id) REFERENCES public.discord_bots(bot_id) ON UPDATE CASCADE;


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
-- Name: email_verification_codes email_verification_codes_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.email_verification_codes
    ADD CONSTRAINT email_verification_codes_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE;


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
-- Name: gift_code_products gift_code_products_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_products
    ADD CONSTRAINT gift_code_products_code_fkey FOREIGN KEY (code) REFERENCES public.gift_codes(code) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gift_code_products gift_code_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_products
    ADD CONSTRAINT gift_code_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE;


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
-- Name: payment_method_currencies payment_method_currencies_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.payment_method_currencies
    ADD CONSTRAINT payment_method_currencies_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currencies(code) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payment_method_currencies payment_method_currencies_payment_method_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.payment_method_currencies
    ADD CONSTRAINT payment_method_currencies_payment_method_code_fkey FOREIGN KEY (payment_method_code) REFERENCES public.payment_methods(code) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: policy_revisions policy_revisions_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_revisions
    ADD CONSTRAINT policy_revisions_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(policy_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: policy_signatures policy_signatures_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signatures
    ADD CONSTRAINT policy_signatures_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(policy_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: policy_signatures policy_signatures_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signatures
    ADD CONSTRAINT policy_signatures_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: policy_signing_requests policy_signing_requests_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signing_requests
    ADD CONSTRAINT policy_signing_requests_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(policy_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: policy_signing_requests policy_signing_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.policy_signing_requests
    ADD CONSTRAINT policy_signing_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_prices product_prices_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.product_prices
    ADD CONSTRAINT product_prices_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_invites project_invites_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_invites
    ADD CONSTRAINT project_invites_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: project_invites project_invites_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_invites
    ADD CONSTRAINT project_invites_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: project_members project_members_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: project_members project_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: projects projects_storage_path_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_storage_path_fkey FOREIGN KEY (storage_path) REFERENCES public.usercloud(remote_path) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gift_code_log purchase_code_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.gift_code_log
    ADD CONSTRAINT purchase_code_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: rcon_parameters rcon_parameters_command_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.rcon_parameters
    ADD CONSTRAINT rcon_parameters_command_id_fkey FOREIGN KEY (command_id) REFERENCES public.rcon_commands(command_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: service_tokens service_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.service_tokens
    ADD CONSTRAINT service_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: legacy_sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.legacy_sessions
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
-- Name: subscription_purchases subscription_purchases_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscription_purchases
    ADD CONSTRAINT subscription_purchases_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_purchases subscription_purchases_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscription_purchases
    ADD CONSTRAINT subscription_purchases_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(subscription_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscriptions subscriptions_initial_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_initial_purchase_id_fkey FOREIGN KEY (initial_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscriptions subscriptions_last_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_last_purchase_id_fkey FOREIGN KEY (last_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscriptions subscriptions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE;


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
-- Name: trusted_devices trusted_devices_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.trusted_devices
    ADD CONSTRAINT trusted_devices_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_authenticators user_authenticators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_authenticators
    ADD CONSTRAINT user_authenticators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_backup_codes user_backup_codes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.user_backup_codes
    ADD CONSTRAINT user_backup_codes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


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
-- Name: objects objects_content_pack_id_fkey; Type: FK CONSTRAINT; Schema: sdtd; Owner: thommcgrath
--

ALTER TABLE ONLY sdtd.objects
    ADD CONSTRAINT objects_content_pack_id_fkey FOREIGN KEY (content_pack_id) REFERENCES public.content_packs(content_pack_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bucket_values bucket_values_bucket_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.bucket_values
    ADD CONSTRAINT bucket_values_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES sentinel.buckets(bucket_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bucket_values bucket_values_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.bucket_values
    ADD CONSTRAINT bucket_values_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: buckets buckets_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.buckets
    ADD CONSTRAINT buckets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: characters characters_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.characters
    ADD CONSTRAINT characters_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: characters characters_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.characters
    ADD CONSTRAINT characters_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characters characters_tribe_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.characters
    ADD CONSTRAINT characters_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES sentinel.tribes(tribe_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dinos dinos_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.dinos
    ADD CONSTRAINT dinos_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dinos dinos_tribe_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.dinos
    ADD CONSTRAINT dinos_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES sentinel.tribes(tribe_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_bans group_bans_group_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_bans
    ADD CONSTRAINT group_bans_group_id_fkey FOREIGN KEY (group_id) REFERENCES sentinel.groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_bans group_bans_issuer_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_bans
    ADD CONSTRAINT group_bans_issuer_id_fkey FOREIGN KEY (issuer_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: group_bans group_bans_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_bans
    ADD CONSTRAINT group_bans_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_buckets group_buckets_bucket_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_buckets
    ADD CONSTRAINT group_buckets_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES sentinel.buckets(bucket_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_buckets group_buckets_group_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_buckets
    ADD CONSTRAINT group_buckets_group_id_fkey FOREIGN KEY (group_id) REFERENCES sentinel.groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_scripts group_scripts_group_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_scripts
    ADD CONSTRAINT group_scripts_group_id_fkey FOREIGN KEY (group_id) REFERENCES sentinel.groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_scripts group_scripts_script_id_revision_number_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_scripts
    ADD CONSTRAINT group_scripts_script_id_revision_number_fkey FOREIGN KEY (script_id, revision_number) REFERENCES sentinel.script_revisions(script_id, revision_number) ON UPDATE CASCADE;


--
-- Name: group_services group_services_group_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_services
    ADD CONSTRAINT group_services_group_id_fkey FOREIGN KEY (group_id) REFERENCES sentinel.groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_services group_services_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_services
    ADD CONSTRAINT group_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_users group_users_group_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_users
    ADD CONSTRAINT group_users_group_id_fkey FOREIGN KEY (group_id) REFERENCES sentinel.groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_users group_users_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.group_users
    ADD CONSTRAINT group_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: groups groups_discord_chat_channel_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.groups
    ADD CONSTRAINT groups_discord_chat_channel_id_fkey FOREIGN KEY (discord_chat_channel_id) REFERENCES public.discord_channels(channel_id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: groups groups_discord_guild_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.groups
    ADD CONSTRAINT groups_discord_guild_id_fkey FOREIGN KEY (discord_guild_id) REFERENCES public.discord_guilds(guild_id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: groups groups_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.groups
    ADD CONSTRAINT groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_identifiers player_identifiers_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_identifiers
    ADD CONSTRAINT player_identifiers_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE;


--
-- Name: player_name_history player_name_history_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_name_history
    ADD CONSTRAINT player_name_history_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: player_note_edits player_note_edits_note_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_note_edits
    ADD CONSTRAINT player_note_edits_note_id_fkey FOREIGN KEY (note_id) REFERENCES sentinel.player_notes(note_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_notes player_notes_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_notes
    ADD CONSTRAINT player_notes_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE;


--
-- Name: player_notes player_notes_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_notes
    ADD CONSTRAINT player_notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: player_sessions player_sessions_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_sessions
    ADD CONSTRAINT player_sessions_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: player_sessions player_sessions_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.player_sessions
    ADD CONSTRAINT player_sessions_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: script_revisions script_revisions_hash_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_revisions
    ADD CONSTRAINT script_revisions_hash_fkey FOREIGN KEY (hash) REFERENCES sentinel.script_hashes(hash) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: script_revisions script_revisions_script_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_revisions
    ADD CONSTRAINT script_revisions_script_id_fkey FOREIGN KEY (script_id) REFERENCES sentinel.scripts(script_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: script_tests script_tests_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_tests
    ADD CONSTRAINT script_tests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: script_webhooks script_webhooks_script_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_webhooks
    ADD CONSTRAINT script_webhooks_script_id_fkey FOREIGN KEY (script_id) REFERENCES sentinel.scripts(script_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: script_webhooks script_webhooks_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.script_webhooks
    ADD CONSTRAINT script_webhooks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scripts scripts_script_id_latest_revision_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.scripts
    ADD CONSTRAINT scripts_script_id_latest_revision_fkey FOREIGN KEY (script_id, latest_revision) REFERENCES sentinel.script_revisions(script_id, revision_number) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: scripts scripts_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.scripts
    ADD CONSTRAINT scripts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: service_bans service_bans_player_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_bans
    ADD CONSTRAINT service_bans_player_id_fkey FOREIGN KEY (player_id) REFERENCES sentinel.players(player_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: service_bans service_bans_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_bans
    ADD CONSTRAINT service_bans_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_event_queue service_event_queue_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_event_queue
    ADD CONSTRAINT service_event_queue_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_languages service_languages_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_languages
    ADD CONSTRAINT service_languages_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: service_log_messages service_log_messages_message_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_log_messages
    ADD CONSTRAINT service_log_messages_message_id_fkey FOREIGN KEY (message_id) REFERENCES sentinel.service_logs(message_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: service_logs service_logs_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_logs
    ADD CONSTRAINT service_logs_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: service_scripts service_scripts_script_id_revision_number_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_scripts
    ADD CONSTRAINT service_scripts_script_id_revision_number_fkey FOREIGN KEY (script_id, revision_number) REFERENCES sentinel.script_revisions(script_id, revision_number) ON UPDATE CASCADE;


--
-- Name: service_scripts service_scripts_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.service_scripts
    ADD CONSTRAINT service_scripts_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: services services_user_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.services
    ADD CONSTRAINT services_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: tribe_characters tribe_characters_character_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_characters
    ADD CONSTRAINT tribe_characters_character_id_fkey FOREIGN KEY (character_id) REFERENCES sentinel.characters(character_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tribe_characters tribe_characters_tribe_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_characters
    ADD CONSTRAINT tribe_characters_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES sentinel.tribes(tribe_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tribe_dinos tribe_dinos_dino_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_dinos
    ADD CONSTRAINT tribe_dinos_dino_id_fkey FOREIGN KEY (dino_id) REFERENCES sentinel.dinos(dino_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tribe_dinos tribe_dinos_tribe_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribe_dinos
    ADD CONSTRAINT tribe_dinos_tribe_id_fkey FOREIGN KEY (tribe_id) REFERENCES sentinel.tribes(tribe_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tribes tribes_service_id_fkey; Type: FK CONSTRAINT; Schema: sentinel; Owner: thommcgrath
--

ALTER TABLE ONLY sentinel.tribes
    ADD CONSTRAINT tribes_service_id_fkey FOREIGN KEY (service_id) REFERENCES sentinel.services(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA ark; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA ark TO thezaz_website;
GRANT USAGE ON SCHEMA ark TO beacon_updater;
GRANT USAGE ON SCHEMA ark TO beacon_readonly;


--
-- Name: SCHEMA arksa; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA arksa TO thezaz_website;
GRANT USAGE ON SCHEMA arksa TO beacon_updater;
GRANT USAGE ON SCHEMA arksa TO beacon_readonly;
GRANT USAGE ON SCHEMA arksa TO sentinel_watcher;


--
-- Name: SCHEMA palworld; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA palworld TO thezaz_website;
GRANT USAGE ON SCHEMA palworld TO beacon_updater;
GRANT USAGE ON SCHEMA palworld TO beacon_readonly;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: SCHEMA sdtd; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA sdtd TO thezaz_website;
GRANT USAGE ON SCHEMA sdtd TO beacon_updater;
GRANT USAGE ON SCHEMA sdtd TO beacon_readonly;


--
-- Name: SCHEMA sentinel; Type: ACL; Schema: -; Owner: thommcgrath
--

GRANT USAGE ON SCHEMA sentinel TO thezaz_website;
GRANT USAGE ON SCHEMA sentinel TO beacon_readonly;
GRANT USAGE ON SCHEMA sentinel TO sentinel_watcher;


--
-- Name: TABLE payment_methods; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.payment_methods TO thezaz_website;
GRANT SELECT ON TABLE public.payment_methods TO beacon_readonly;


--
-- Name: TABLE objects; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.objects TO thezaz_website;
GRANT SELECT ON TABLE ark.objects TO beacon_readonly;


--
-- Name: TABLE creatures; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creatures TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creatures TO beacon_updater;
GRANT SELECT ON TABLE ark.creatures TO beacon_readonly;


--
-- Name: TABLE engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.engrams TO beacon_updater;
GRANT SELECT ON TABLE ark.engrams TO beacon_readonly;


--
-- Name: TABLE loot_sources; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_sources TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_sources TO beacon_updater;
GRANT SELECT ON TABLE ark.loot_sources TO beacon_readonly;


--
-- Name: TABLE spawn_points; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_points TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_points TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_points TO beacon_readonly;


--
-- Name: TABLE blueprints; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.blueprints TO thezaz_website;
GRANT SELECT ON TABLE ark.blueprints TO beacon_updater;
GRANT SELECT ON TABLE ark.blueprints TO beacon_readonly;


--
-- Name: TABLE color_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.color_sets TO thezaz_website;
GRANT SELECT ON TABLE ark.color_sets TO beacon_readonly;


--
-- Name: TABLE colors; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.colors TO thezaz_website;
GRANT SELECT ON TABLE ark.colors TO beacon_readonly;


--
-- Name: TABLE crafting_costs; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.crafting_costs TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.crafting_costs TO beacon_updater;
GRANT SELECT ON TABLE ark.crafting_costs TO beacon_readonly;


--
-- Name: TABLE creature_engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_engrams TO beacon_updater;
GRANT SELECT ON TABLE ark.creature_engrams TO beacon_readonly;


--
-- Name: TABLE creature_stats; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_stats TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.creature_stats TO beacon_updater;
GRANT SELECT ON TABLE ark.creature_stats TO beacon_readonly;


--
-- Name: TABLE deletions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.deletions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.deletions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.deletions TO beacon_updater;


--
-- Name: TABLE deletions; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.deletions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE ON TABLE ark.deletions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.deletions TO beacon_updater;


--
-- Name: TABLE diet_contents; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.diet_contents TO thezaz_website;
GRANT SELECT ON TABLE ark.diet_contents TO beacon_readonly;


--
-- Name: TABLE diets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.diets TO thezaz_website;
GRANT SELECT ON TABLE ark.diets TO beacon_readonly;


--
-- Name: TABLE event_colors; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_colors TO thezaz_website;
GRANT SELECT ON TABLE ark.event_colors TO beacon_readonly;


--
-- Name: TABLE event_engrams; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_engrams TO thezaz_website;
GRANT SELECT ON TABLE ark.event_engrams TO beacon_readonly;


--
-- Name: TABLE event_rates; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.event_rates TO thezaz_website;
GRANT SELECT ON TABLE ark.event_rates TO beacon_readonly;


--
-- Name: TABLE events; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.events TO thezaz_website;
GRANT SELECT ON TABLE ark.events TO beacon_readonly;


--
-- Name: TABLE game_variables; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.game_variables TO thezaz_website;
GRANT SELECT ON TABLE ark.game_variables TO beacon_readonly;


--
-- Name: TABLE ini_options; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.ini_options TO thezaz_website;
GRANT SELECT ON TABLE ark.ini_options TO beacon_readonly;


--
-- Name: TABLE loot_item_set_entries; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entries TO beacon_updater;
GRANT SELECT ON TABLE ark.loot_item_set_entries TO beacon_readonly;


--
-- Name: TABLE loot_item_set_entry_options; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entry_options TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_set_entry_options TO beacon_updater;
GRANT SELECT ON TABLE ark.loot_item_set_entry_options TO beacon_readonly;


--
-- Name: TABLE loot_item_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.loot_item_sets TO beacon_updater;
GRANT SELECT ON TABLE ark.loot_item_sets TO beacon_readonly;


--
-- Name: TABLE loot_source_icons; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.loot_source_icons TO thezaz_website;
GRANT SELECT ON TABLE ark.loot_source_icons TO beacon_readonly;


--
-- Name: TABLE maps; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.maps TO thezaz_website;
GRANT SELECT ON TABLE ark.maps TO beacon_updater;
GRANT SELECT ON TABLE ark.maps TO beacon_readonly;


--
-- Name: TABLE mod_relationships; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mod_relationships TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mod_relationships TO beacon_updater;
GRANT SELECT ON TABLE ark.mod_relationships TO beacon_readonly;


--
-- Name: TABLE content_packs; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.content_packs TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.content_packs TO thezaz_website;
GRANT SELECT,INSERT ON TABLE public.content_packs TO beacon_updater;


--
-- Name: TABLE mods; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.mods TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mods TO thezaz_website;
GRANT SELECT ON TABLE ark.mods TO beacon_updater;


--
-- Name: TABLE mods_legacy; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mods_legacy TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.mods_legacy TO beacon_updater;
GRANT SELECT ON TABLE ark.mods_legacy TO beacon_readonly;


--
-- Name: TABLE preset_modifiers; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT ON TABLE ark.preset_modifiers TO thezaz_website;
GRANT SELECT ON TABLE ark.preset_modifiers TO beacon_readonly;


--
-- Name: TABLE presets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.presets TO thezaz_website;
GRANT SELECT ON TABLE ark.presets TO beacon_readonly;


--
-- Name: TABLE spawn_point_limits; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_limits TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_limits TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_limits TO beacon_readonly;


--
-- Name: TABLE spawn_point_populations; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_populations TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_populations TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_populations TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_entries; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entries TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_set_entries TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_entry_levels; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entry_levels TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_entry_levels TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_set_entry_levels TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_replacements; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_replacements TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_set_replacements TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_set_replacements TO beacon_readonly;


--
-- Name: TABLE spawn_point_sets; Type: ACL; Schema: ark; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE ark.spawn_point_sets TO beacon_updater;
GRANT SELECT ON TABLE ark.spawn_point_sets TO beacon_readonly;


--
-- Name: TABLE objects; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.objects TO thezaz_website;
GRANT SELECT ON TABLE arksa.objects TO beacon_readonly;


--
-- Name: TABLE creatures; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creatures TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creatures TO beacon_updater;
GRANT SELECT ON TABLE arksa.creatures TO beacon_readonly;
GRANT SELECT ON TABLE arksa.creatures TO sentinel_watcher;


--
-- Name: TABLE engrams; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.engrams TO beacon_updater;
GRANT SELECT ON TABLE arksa.engrams TO beacon_readonly;
GRANT SELECT ON TABLE arksa.engrams TO sentinel_watcher;


--
-- Name: TABLE loot_drops; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_drops TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_drops TO beacon_updater;
GRANT SELECT ON TABLE arksa.loot_drops TO beacon_readonly;


--
-- Name: TABLE spawn_points; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_points TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_points TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_points TO beacon_readonly;


--
-- Name: TABLE blueprints; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.blueprints TO beacon_readonly;
GRANT SELECT ON TABLE arksa.blueprints TO thezaz_website;


--
-- Name: TABLE color_sets; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.color_sets TO thezaz_website;
GRANT SELECT ON TABLE arksa.color_sets TO beacon_readonly;


--
-- Name: TABLE colors; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.colors TO thezaz_website;
GRANT SELECT ON TABLE arksa.colors TO beacon_readonly;


--
-- Name: TABLE content_pack_relationships; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.content_pack_relationships TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.content_pack_relationships TO beacon_updater;
GRANT SELECT ON TABLE arksa.content_pack_relationships TO beacon_readonly;


--
-- Name: TABLE content_packs; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.content_packs TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.content_packs TO thezaz_website;
GRANT SELECT ON TABLE arksa.content_packs TO beacon_updater;


--
-- Name: TABLE crafting_costs; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.crafting_costs TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.crafting_costs TO beacon_updater;
GRANT SELECT ON TABLE arksa.crafting_costs TO beacon_readonly;


--
-- Name: TABLE creature_engrams; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creature_engrams TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creature_engrams TO beacon_updater;
GRANT SELECT ON TABLE arksa.creature_engrams TO beacon_readonly;


--
-- Name: TABLE creature_stats; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creature_stats TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.creature_stats TO beacon_updater;
GRANT SELECT ON TABLE arksa.creature_stats TO beacon_readonly;


--
-- Name: TABLE deletions; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.deletions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE ON TABLE arksa.deletions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.deletions TO beacon_updater;


--
-- Name: TABLE engram_stats; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.engram_stats TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.engram_stats TO beacon_updater;
GRANT SELECT ON TABLE arksa.engram_stats TO beacon_readonly;


--
-- Name: TABLE event_colors; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.event_colors TO thezaz_website;
GRANT SELECT ON TABLE arksa.event_colors TO beacon_readonly;


--
-- Name: TABLE event_engrams; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.event_engrams TO thezaz_website;
GRANT SELECT ON TABLE arksa.event_engrams TO beacon_readonly;


--
-- Name: TABLE event_rates; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.event_rates TO thezaz_website;
GRANT SELECT ON TABLE arksa.event_rates TO beacon_readonly;


--
-- Name: TABLE events; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.events TO thezaz_website;
GRANT SELECT ON TABLE arksa.events TO beacon_readonly;


--
-- Name: TABLE game_variables; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.game_variables TO thezaz_website;
GRANT SELECT ON TABLE arksa.game_variables TO beacon_readonly;


--
-- Name: TABLE ini_options; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.ini_options TO thezaz_website;
GRANT SELECT ON TABLE arksa.ini_options TO beacon_readonly;


--
-- Name: TABLE loot_drop_icons; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.loot_drop_icons TO thezaz_website;
GRANT SELECT ON TABLE arksa.loot_drop_icons TO beacon_readonly;


--
-- Name: TABLE loot_item_set_entries; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_set_entries TO beacon_updater;
GRANT SELECT ON TABLE arksa.loot_item_set_entries TO beacon_readonly;


--
-- Name: TABLE loot_item_set_entry_options; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_set_entry_options TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_set_entry_options TO beacon_updater;
GRANT SELECT ON TABLE arksa.loot_item_set_entry_options TO beacon_readonly;


--
-- Name: TABLE loot_item_sets; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.loot_item_sets TO beacon_updater;
GRANT SELECT ON TABLE arksa.loot_item_sets TO beacon_readonly;


--
-- Name: TABLE maps; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.maps TO thezaz_website;
GRANT SELECT ON TABLE arksa.maps TO beacon_updater;
GRANT SELECT ON TABLE arksa.maps TO beacon_readonly;


--
-- Name: TABLE spawn_point_limits; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_limits TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_limits TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_limits TO beacon_readonly;


--
-- Name: TABLE spawn_point_populations; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_populations TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_populations TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_populations TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_entries; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_entries TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_entries TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_set_entries TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_entry_levels; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_entry_levels TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_entry_levels TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_set_entry_levels TO beacon_readonly;


--
-- Name: TABLE spawn_point_set_replacements; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_replacements TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_set_replacements TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_set_replacements TO beacon_readonly;


--
-- Name: TABLE spawn_point_sets; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_sets TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.spawn_point_sets TO beacon_updater;
GRANT SELECT ON TABLE arksa.spawn_point_sets TO beacon_readonly;


--
-- Name: TABLE template_selectors; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.template_selectors TO thezaz_website;
GRANT SELECT ON TABLE arksa.template_selectors TO beacon_readonly;


--
-- Name: TABLE templates; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.templates TO thezaz_website;
GRANT SELECT ON TABLE arksa.templates TO beacon_readonly;


--
-- Name: TABLE traits; Type: ACL; Schema: arksa; Owner: thommcgrath
--

GRANT SELECT ON TABLE arksa.traits TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE arksa.traits TO thezaz_website;


--
-- Name: TABLE content_packs; Type: ACL; Schema: palworld; Owner: thommcgrath
--

GRANT SELECT ON TABLE palworld.content_packs TO thezaz_website;
GRANT SELECT ON TABLE palworld.content_packs TO beacon_readonly;


--
-- Name: TABLE deletions; Type: ACL; Schema: palworld; Owner: thommcgrath
--

GRANT SELECT ON TABLE palworld.deletions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE palworld.deletions TO thezaz_website;


--
-- Name: TABLE game_variables; Type: ACL; Schema: palworld; Owner: thommcgrath
--

GRANT SELECT ON TABLE palworld.game_variables TO thezaz_website;
GRANT SELECT ON TABLE palworld.game_variables TO beacon_readonly;


--
-- Name: TABLE objects; Type: ACL; Schema: palworld; Owner: thommcgrath
--

GRANT SELECT ON TABLE palworld.objects TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE palworld.objects TO thezaz_website;


--
-- Name: TABLE ini_options; Type: ACL; Schema: palworld; Owner: thommcgrath
--

GRANT SELECT ON TABLE palworld.ini_options TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE palworld.ini_options TO thezaz_website;


--
-- Name: TABLE access_tokens; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.access_tokens TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.access_tokens TO thezaz_website;


--
-- Name: TABLE affiliate_links; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.affiliate_links TO thezaz_website;
GRANT SELECT ON TABLE public.affiliate_links TO beacon_readonly;


--
-- Name: TABLE affiliate_products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.affiliate_products TO beacon_readonly;
GRANT SELECT ON TABLE public.affiliate_products TO thezaz_website;


--
-- Name: TABLE affiliate_tracking; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.affiliate_tracking TO thezaz_website;
GRANT SELECT ON TABLE public.affiliate_tracking TO beacon_readonly;


--
-- Name: TABLE purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.purchases TO thezaz_website;
GRANT SELECT ON TABLE public.purchases TO beacon_readonly;


--
-- Name: TABLE affiliate_purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.affiliate_purchases TO beacon_readonly;
GRANT SELECT ON TABLE public.affiliate_purchases TO thezaz_website;


--
-- Name: TABLE application_auth_flows; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.application_auth_flows TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.application_auth_flows TO thezaz_website;


--
-- Name: TABLE application_callbacks; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.application_callbacks TO beacon_readonly;
GRANT SELECT,INSERT,DELETE ON TABLE public.application_callbacks TO thezaz_website;


--
-- Name: TABLE applications; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.applications TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.applications TO thezaz_website;


--
-- Name: TABLE blog_articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.blog_articles TO thezaz_website;
GRANT SELECT ON TABLE public.blog_articles TO beacon_readonly;


--
-- Name: TABLE client_notices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.client_notices TO thezaz_website;
GRANT SELECT ON TABLE public.client_notices TO beacon_readonly;


--
-- Name: TABLE content_pack_discovery_results; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.content_pack_discovery_results TO beacon_readonly;
GRANT SELECT,INSERT,UPDATE ON TABLE public.content_pack_discovery_results TO thezaz_website;


--
-- Name: TABLE content_packs_combined; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.content_packs_combined TO beacon_readonly;
GRANT SELECT ON TABLE public.content_packs_combined TO thezaz_website;


--
-- Name: TABLE rcon_commands; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.rcon_commands TO beacon_readonly;
GRANT SELECT ON TABLE public.rcon_commands TO thezaz_website;


--
-- Name: TABLE objects; Type: ACL; Schema: sdtd; Owner: thommcgrath
--

GRANT SELECT ON TABLE sdtd.objects TO beacon_readonly;
GRANT SELECT ON TABLE sdtd.objects TO thezaz_website;


--
-- Name: TABLE content_update_times; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.content_update_times TO beacon_readonly;
GRANT SELECT ON TABLE public.content_update_times TO thezaz_website;


--
-- Name: TABLE corrupt_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.corrupt_files TO thezaz_website;
GRANT SELECT ON TABLE public.corrupt_files TO beacon_readonly;


--
-- Name: TABLE currencies; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.currencies TO beacon_readonly;
GRANT SELECT,UPDATE ON TABLE public.currencies TO thezaz_website;


--
-- Name: TABLE device_auth_flows; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.device_auth_flows TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.device_auth_flows TO thezaz_website;


--
-- Name: TABLE discord_bots; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.discord_bots TO beacon_readonly;
GRANT SELECT ON TABLE public.discord_bots TO thezaz_website;
GRANT SELECT ON TABLE public.discord_bots TO sentinel_watcher;


--
-- Name: COLUMN discord_bots.shards; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT UPDATE(shards) ON TABLE public.discord_bots TO sentinel_watcher;


--
-- Name: COLUMN discord_bots.shards_connected; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT UPDATE(shards_connected) ON TABLE public.discord_bots TO sentinel_watcher;


--
-- Name: TABLE discord_channels; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.discord_channels TO beacon_readonly;
GRANT SELECT ON TABLE public.discord_channels TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.discord_channels TO sentinel_watcher;


--
-- Name: TABLE discord_guilds; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.discord_guilds TO beacon_readonly;
GRANT SELECT ON TABLE public.discord_guilds TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.discord_guilds TO sentinel_watcher;


--
-- Name: TABLE download_signatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.download_signatures TO thezaz_website;
GRANT SELECT ON TABLE public.download_signatures TO beacon_readonly;


--
-- Name: TABLE download_urls; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.download_urls TO thezaz_website;
GRANT SELECT ON TABLE public.download_urls TO beacon_readonly;


--
-- Name: TABLE email_addresses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_addresses TO thezaz_website;
GRANT SELECT ON TABLE public.email_addresses TO beacon_readonly;


--
-- Name: TABLE email_verification; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_verification TO thezaz_website;
GRANT SELECT ON TABLE public.email_verification TO beacon_readonly;


--
-- Name: TABLE email_verification_codes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.email_verification_codes TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.email_verification_codes TO thezaz_website;


--
-- Name: TABLE endpoint_git_hashes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.endpoint_git_hashes TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.endpoint_git_hashes TO thezaz_website;


--
-- Name: TABLE exception_comments; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.exception_comments TO thezaz_website;
GRANT SELECT ON TABLE public.exception_comments TO beacon_readonly;


--
-- Name: TABLE exception_signatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.exception_signatures TO thezaz_website;
GRANT SELECT ON TABLE public.exception_signatures TO beacon_readonly;


--
-- Name: TABLE exception_users; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.exception_users TO thezaz_website;
GRANT SELECT ON TABLE public.exception_users TO beacon_readonly;


--
-- Name: TABLE exceptions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.exceptions TO thezaz_website;
GRANT SELECT ON TABLE public.exceptions TO beacon_readonly;


--
-- Name: TABLE games; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.games TO thezaz_website;
GRANT SELECT ON TABLE public.games TO beacon_readonly;


--
-- Name: TABLE gift_code_log; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.gift_code_log TO thezaz_website;
GRANT SELECT ON TABLE public.gift_code_log TO beacon_readonly;


--
-- Name: TABLE gift_code_products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.gift_code_products TO beacon_readonly;
GRANT SELECT,INSERT ON TABLE public.gift_code_products TO thezaz_website;


--
-- Name: TABLE gift_codes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gift_codes TO thezaz_website;
GRANT SELECT ON TABLE public.gift_codes TO beacon_readonly;


--
-- Name: TABLE help_topics; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.help_topics TO thezaz_website;
GRANT SELECT ON TABLE public.help_topics TO beacon_readonly;


--
-- Name: TABLE imported_obelisk_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.imported_obelisk_files TO beacon_updater;


--
-- Name: TABLE legacy_sessions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.legacy_sessions TO thezaz_website;
GRANT SELECT ON TABLE public.legacy_sessions TO beacon_readonly;


--
-- Name: TABLE licenses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.licenses TO thezaz_website;
GRANT SELECT ON TABLE public.licenses TO beacon_readonly;


--
-- Name: TABLE updates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.updates TO thezaz_website;
GRANT SELECT ON TABLE public.updates TO beacon_readonly;


--
-- Name: TABLE news; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.news TO thezaz_website;
GRANT SELECT ON TABLE public.news TO beacon_readonly;


--
-- Name: TABLE oauth_requests; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE ON TABLE public.oauth_requests TO thezaz_website;
GRANT SELECT ON TABLE public.oauth_requests TO beacon_readonly;


--
-- Name: TABLE oauth_tokens; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.oauth_tokens TO thezaz_website;
GRANT SELECT ON TABLE public.oauth_tokens TO beacon_readonly;


--
-- Name: TABLE payment_method_currencies; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.payment_method_currencies TO thezaz_website;
GRANT SELECT ON TABLE public.payment_method_currencies TO beacon_readonly;


--
-- Name: TABLE policies; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.policies TO beacon_readonly;
GRANT SELECT ON TABLE public.policies TO thezaz_website;


--
-- Name: TABLE policy_revisions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.policy_revisions TO beacon_readonly;
GRANT SELECT ON TABLE public.policy_revisions TO thezaz_website;


--
-- Name: TABLE policy_signatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.policy_signatures TO beacon_readonly;
GRANT SELECT,INSERT ON TABLE public.policy_signatures TO thezaz_website;


--
-- Name: TABLE policy_signing_requests; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.policy_signing_requests TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.policy_signing_requests TO thezaz_website;


--
-- Name: TABLE processed_webhooks; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.processed_webhooks TO beacon_readonly;
GRANT SELECT,INSERT,DELETE ON TABLE public.processed_webhooks TO thezaz_website;


--
-- Name: TABLE product_prices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.product_prices TO thezaz_website;
GRANT SELECT ON TABLE public.product_prices TO beacon_readonly;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.products TO thezaz_website;
GRANT SELECT ON TABLE public.products TO beacon_readonly;


--
-- Name: TABLE project_invites; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.project_invites TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.project_invites TO thezaz_website;


--
-- Name: TABLE project_members; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.project_members TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.project_members TO thezaz_website;


--
-- Name: TABLE projects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.projects TO thezaz_website;
GRANT SELECT ON TABLE public.projects TO beacon_readonly;


--
-- Name: TABLE purchase_items; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.purchase_items TO thezaz_website;
GRANT SELECT ON TABLE public.purchase_items TO beacon_readonly;


--
-- Name: TABLE purchase_items_old; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.purchase_items_old TO thezaz_website;
GRANT SELECT ON TABLE public.purchase_items_old TO beacon_readonly;


--
-- Name: TABLE purchased_products; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.purchased_products TO beacon_readonly;
GRANT SELECT ON TABLE public.purchased_products TO thezaz_website;


--
-- Name: TABLE rcon_parameters; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.rcon_parameters TO beacon_readonly;
GRANT SELECT ON TABLE public.rcon_parameters TO thezaz_website;


--
-- Name: TABLE support_articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_articles TO thezaz_website;
GRANT SELECT ON TABLE public.support_articles TO beacon_readonly;


--
-- Name: TABLE support_videos; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_videos TO thezaz_website;
GRANT SELECT ON TABLE public.support_videos TO beacon_readonly;


--
-- Name: TABLE search_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.search_contents TO beacon_readonly;
GRANT SELECT ON TABLE public.search_contents TO thezaz_website;


--
-- Name: TABLE search_sync; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.search_sync TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.search_sync TO beacon_updater;
GRANT SELECT ON TABLE public.search_sync TO beacon_readonly;


--
-- Name: TABLE service_token_aliases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.service_token_aliases TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.service_token_aliases TO thezaz_website;


--
-- Name: TABLE service_tokens; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.service_tokens TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.service_tokens TO thezaz_website;


--
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.sessions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sessions TO thezaz_website;


--
-- Name: TABLE stw_applicants; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.stw_applicants TO thezaz_website;
GRANT SELECT ON TABLE public.stw_applicants TO beacon_readonly;


--
-- Name: TABLE stw_purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.stw_purchases TO thezaz_website;
GRANT SELECT ON TABLE public.stw_purchases TO beacon_readonly;


--
-- Name: TABLE subscription_purchases; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.subscription_purchases TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subscription_purchases TO thezaz_website;


--
-- Name: TABLE subscriptions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.subscriptions TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subscriptions TO thezaz_website;


--
-- Name: TABLE support_article_groups; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_article_groups TO thezaz_website;
GRANT SELECT ON TABLE public.support_article_groups TO beacon_readonly;


--
-- Name: TABLE support_article_modules; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.support_article_modules TO thezaz_website;
GRANT SELECT ON TABLE public.support_article_modules TO beacon_readonly;


--
-- Name: TABLE support_images; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.support_images TO thezaz_website;
GRANT SELECT ON TABLE public.support_images TO beacon_readonly;


--
-- Name: TABLE support_table_of_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_table_of_contents TO thezaz_website;
GRANT SELECT ON TABLE public.support_table_of_contents TO beacon_readonly;


--
-- Name: TABLE template_selectors; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.template_selectors TO thezaz_website;
GRANT SELECT ON TABLE public.template_selectors TO beacon_readonly;


--
-- Name: TABLE templates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.templates TO thezaz_website;
GRANT SELECT ON TABLE public.templates TO beacon_readonly;


--
-- Name: TABLE trusted_devices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.trusted_devices TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.trusted_devices TO thezaz_website;


--
-- Name: TABLE update_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.update_files TO thezaz_website;
GRANT SELECT ON TABLE public.update_files TO beacon_readonly;


--
-- Name: TABLE user_authenticators; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.user_authenticators TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_authenticators TO thezaz_website;


--
-- Name: TABLE user_backup_codes; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.user_backup_codes TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_backup_codes TO thezaz_website;


--
-- Name: TABLE user_challenges; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.user_challenges TO thezaz_website;
GRANT SELECT ON TABLE public.user_challenges TO beacon_readonly;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO thezaz_website;
GRANT SELECT ON TABLE public.users TO beacon_readonly;


--
-- Name: TABLE services; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.services TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.services TO thezaz_website;
GRANT SELECT,UPDATE ON TABLE sentinel.services TO sentinel_watcher;


--
-- Name: TABLE user_subscriptions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.user_subscriptions TO beacon_readonly;
GRANT SELECT ON TABLE public.user_subscriptions TO thezaz_website;
GRANT SELECT ON TABLE public.user_subscriptions TO sentinel_watcher;


--
-- Name: TABLE usercloud; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud TO thezaz_website;
GRANT SELECT ON TABLE public.usercloud TO beacon_readonly;


--
-- Name: TABLE usercloud_cache; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud_cache TO thezaz_website;
GRANT SELECT ON TABLE public.usercloud_cache TO beacon_readonly;


--
-- Name: TABLE usercloud_queue; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usercloud_queue TO thezaz_website;
GRANT SELECT ON TABLE public.usercloud_queue TO beacon_readonly;


--
-- Name: TABLE wordlist; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.wordlist TO thezaz_website;
GRANT SELECT ON TABLE public.wordlist TO beacon_readonly;
GRANT SELECT ON TABLE public.wordlist TO sentinel_watcher;


--
-- Name: TABLE config_options; Type: ACL; Schema: sdtd; Owner: thommcgrath
--

GRANT SELECT ON TABLE sdtd.config_options TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sdtd.config_options TO thezaz_website;


--
-- Name: TABLE group_bans; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_bans TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_bans TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_bans TO sentinel_watcher;


--
-- Name: TABLE group_services; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_services TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_services TO thezaz_website;
GRANT SELECT ON TABLE sentinel.group_services TO sentinel_watcher;


--
-- Name: TABLE service_bans; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_bans TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_bans TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_bans TO sentinel_watcher;


--
-- Name: TABLE active_bans; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.active_bans TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.active_bans TO thezaz_website;
GRANT SELECT ON TABLE sentinel.active_bans TO sentinel_watcher;


--
-- Name: TABLE player_sessions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.player_sessions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.player_sessions TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.player_sessions TO sentinel_watcher;


--
-- Name: TABLE players; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.players TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.players TO thezaz_website;
GRANT SELECT,INSERT,UPDATE ON TABLE sentinel.players TO sentinel_watcher;


--
-- Name: TABLE active_players; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.active_players TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.active_players TO thezaz_website;
GRANT SELECT ON TABLE sentinel.active_players TO sentinel_watcher;


--
-- Name: TABLE group_scripts; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_scripts TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_scripts TO thezaz_website;
GRANT SELECT ON TABLE sentinel.group_scripts TO sentinel_watcher;


--
-- Name: TABLE script_hashes; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_hashes TO beacon_readonly;
GRANT SELECT,INSERT,UPDATE ON TABLE sentinel.script_hashes TO thezaz_website;
GRANT SELECT,UPDATE ON TABLE sentinel.script_hashes TO sentinel_watcher;


--
-- Name: TABLE script_revisions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_revisions TO beacon_readonly;
GRANT SELECT,INSERT ON TABLE sentinel.script_revisions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.script_revisions TO sentinel_watcher;


--
-- Name: TABLE script_approved_revisions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_approved_revisions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.script_approved_revisions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.script_approved_revisions TO sentinel_watcher;


--
-- Name: TABLE scripts; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.scripts TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.scripts TO thezaz_website;
GRANT SELECT ON TABLE sentinel.scripts TO sentinel_watcher;


--
-- Name: TABLE service_scripts; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_scripts TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_scripts TO thezaz_website;
GRANT SELECT ON TABLE sentinel.service_scripts TO sentinel_watcher;


--
-- Name: TABLE active_scripts; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.active_scripts TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.active_scripts TO thezaz_website;
GRANT SELECT ON TABLE sentinel.active_scripts TO sentinel_watcher;


--
-- Name: TABLE buckets; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.buckets TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.buckets TO thezaz_website;
GRANT SELECT ON TABLE sentinel.buckets TO sentinel_watcher;


--
-- Name: TABLE group_buckets; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_buckets TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_buckets TO thezaz_website;
GRANT SELECT ON TABLE sentinel.group_buckets TO sentinel_watcher;


--
-- Name: TABLE group_users; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_users TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.group_users TO thezaz_website;


--
-- Name: TABLE groups; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.groups TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.groups TO thezaz_website;
GRANT SELECT,UPDATE ON TABLE sentinel.groups TO sentinel_watcher;


--
-- Name: TABLE bucket_permissions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.bucket_permissions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.bucket_permissions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.bucket_permissions TO sentinel_watcher;


--
-- Name: TABLE bucket_values; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.bucket_values TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.bucket_values TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.bucket_values TO sentinel_watcher;


--
-- Name: TABLE characters; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.characters TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.characters TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.characters TO sentinel_watcher;


--
-- Name: TABLE chat_message_queue; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.chat_message_queue TO beacon_readonly;
GRANT SELECT,INSERT ON TABLE sentinel.chat_message_queue TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.chat_message_queue TO sentinel_watcher;


--
-- Name: TABLE dinos; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.dinos TO beacon_readonly;
GRANT SELECT,DELETE,UPDATE ON TABLE sentinel.dinos TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.dinos TO sentinel_watcher;


--
-- Name: TABLE group_permissions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.group_permissions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.group_permissions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.group_permissions TO sentinel_watcher;


--
-- Name: TABLE ip_address_cache; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.ip_address_cache TO sentinel_watcher;


--
-- Name: TABLE message_moderation_scores; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.message_moderation_scores TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.message_moderation_scores TO thezaz_website;
GRANT SELECT,INSERT ON TABLE sentinel.message_moderation_scores TO sentinel_watcher;


--
-- Name: TABLE message_translations; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.message_translations TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.message_translations TO thezaz_website;
GRANT SELECT,INSERT ON TABLE sentinel.message_translations TO sentinel_watcher;


--
-- Name: TABLE player_identifiers; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.player_identifiers TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.player_identifiers TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.player_identifiers TO sentinel_watcher;


--
-- Name: TABLE player_name_history; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.player_name_history TO beacon_readonly;
GRANT SELECT,INSERT ON TABLE sentinel.player_name_history TO thezaz_website;
GRANT SELECT,INSERT,DELETE ON TABLE sentinel.player_name_history TO sentinel_watcher;


--
-- Name: TABLE player_note_edits; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.player_note_edits TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.player_note_edits TO thezaz_website;


--
-- Name: TABLE player_notes; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.player_notes TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.player_notes TO thezaz_website;
GRANT SELECT,INSERT ON TABLE sentinel.player_notes TO sentinel_watcher;


--
-- Name: TABLE script_permissions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_permissions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.script_permissions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.script_permissions TO sentinel_watcher;


--
-- Name: TABLE script_tests; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_tests TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.script_tests TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.script_tests TO sentinel_watcher;


--
-- Name: TABLE script_webhooks; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.script_webhooks TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.script_webhooks TO thezaz_website;


--
-- Name: TABLE service_event_queue; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_event_queue TO sentinel_watcher;
GRANT SELECT,INSERT ON TABLE sentinel.service_event_queue TO thezaz_website;
GRANT SELECT ON TABLE sentinel.service_event_queue TO beacon_readonly;


--
-- Name: TABLE service_languages; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_languages TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_languages TO thezaz_website;
GRANT SELECT ON TABLE sentinel.service_languages TO sentinel_watcher;


--
-- Name: TABLE service_log_messages; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_log_messages TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_log_messages TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_log_messages TO sentinel_watcher;


--
-- Name: TABLE service_logs; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_logs TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_logs TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.service_logs TO sentinel_watcher;


--
-- Name: TABLE service_permissions; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.service_permissions TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.service_permissions TO thezaz_website;
GRANT SELECT ON TABLE sentinel.service_permissions TO sentinel_watcher;


--
-- Name: TABLE tribe_characters; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.tribe_characters TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.tribe_characters TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.tribe_characters TO sentinel_watcher;


--
-- Name: TABLE tribe_dinos; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.tribe_dinos TO beacon_readonly;
GRANT SELECT ON TABLE sentinel.tribe_dinos TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.tribe_dinos TO sentinel_watcher;


--
-- Name: TABLE tribes; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.tribes TO beacon_readonly;
GRANT SELECT,DELETE,UPDATE ON TABLE sentinel.tribes TO thezaz_website;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.tribes TO sentinel_watcher;


--
-- Name: TABLE watcher_logs; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE sentinel.watcher_logs TO sentinel_watcher;
GRANT SELECT,DELETE ON TABLE sentinel.watcher_logs TO thezaz_website;


--
-- Name: TABLE watcher_releases; Type: ACL; Schema: sentinel; Owner: thommcgrath
--

GRANT SELECT ON TABLE sentinel.watcher_releases TO beacon_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sentinel.watcher_releases TO thezaz_website;


--
-- PostgreSQL database dump complete
--

