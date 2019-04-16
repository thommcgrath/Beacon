--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
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
-- Name: video_host; Type: TYPE; Schema: public; Owner: thommcgrath
--

CREATE TYPE public.video_host AS ENUM (
    'YouTube'
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
-- Name: documents_maintenance_function(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.documents_maintenance_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
			IF NEW.title != OLD.title OR NEW.description != OLD.description OR NEW.map != OLD.map OR NEW.difficulty != OLD.difficulty OR NEW.console_safe != OLD.console_safe THEN
				RAISE EXCEPTION 'Do not change meta properties. Change the contents JSON instead.';
			END IF;
		END IF;
	END IF;
	IF p_update_meta = TRUE THEN
		NEW.map = coalesce((NEW.contents->>'Map')::integer, 1);
		NEW.console_safe = TRUE;
		p_console_safe_known = FALSE;
		IF coalesce((NEW.contents->>'Version')::numeric, 2) = 3 THEN
			NEW.title = coalesce(NEW.contents->'Configs'->'Metadata'->>'Title', 'Untitled Document');
			NEW.description = coalesce(NEW.contents->'Configs'->'Metadata'->>'Description', '');
			NEW.difficulty = coalesce((NEW.contents->'Configs'->'Difficulty'->>'MaxDinoLevel')::numeric, 150) / 30;
			FOR p_rec IN SELECT DISTINCT mods.console_safe FROM (SELECT DISTINCT jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(NEW.contents->'Configs'->'LootDrops'->'Contents')->'ItemSets')->'ItemEntries')->'Items')->>'Path' AS path) AS items LEFT JOIN (engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id)) ON (items.path = engrams.path) LOOP
				NEW.console_safe = NEW.console_safe AND coalesce(p_rec.console_safe, FALSE);
				p_console_safe_known = TRUE;
			END LOOP;
		ELSE
			NEW.title = coalesce(NEW.contents->>'Title', 'Untitled Document');
			NEW.description = coalesce(NEW.contents->>'Description', '');
			NEW.difficulty = coalesce((NEW.contents->>'DifficultyValue')::numeric, 4.0);
			FOR p_rec IN SELECT DISTINCT mods.console_safe FROM (SELECT DISTINCT jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(jsonb_array_elements(NEW.contents->'LootSources')->'ItemSets')->'ItemEntries')->'Items')->>'Path' AS path) AS items LEFT JOIN (engrams INNER JOIN mods ON (engrams.mod_id = mods.mod_id)) ON (items.path = engrams.path) LOOP
				NEW.console_safe = NEW.console_safe AND coalesce(p_rec.console_safe, FALSE);
				p_console_safe_known = TRUE;
			END LOOP;
		END IF;
		IF NOT p_console_safe_known THEN
			NEW.console_safe = FALSE;
		END IF;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.documents_maintenance_function() OWNER TO thommcgrath;

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
BEGIN
	RETURN regexp_replace(TRIM(LEFT(regexp_replace(LOWER(unaccent(p_input)), '[^a-z0-9 \\-]+', ' ', 'gi'), 20)), '\s+', '_', 'g');
END;
$$;


ALTER FUNCTION public.slugify(p_input text) OWNER TO thommcgrath;

--
-- Name: update_support_article_hash(); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.update_support_article_hash() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.article_hash := MD5(NEW.subject || '::' || COALESCE(NEW.content_markdown, '') || '::' || COALESCE(NEW.preview, '') || ARRAY_TO_STRING(NEW.affected_ini_keys, ','));
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_support_article_hash() OWNER TO thommcgrath;

--
-- Name: uuid_for_email(public.email); Type: FUNCTION; Schema: public; Owner: thommcgrath
--

CREATE FUNCTION public.uuid_for_email(p_address public.email) RETURNS uuid
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	v_uuid UUID;
BEGIN
	SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key IN (SELECT DISTINCT ON (emails.group_key_precision) group_keys FROM email_addresses AS emails, LATERAL group_key_for_email(p_address, emails.group_key_precision) AS group_keys) AND CRYPT(LOWER(p_address), email_addresses.address) = email_addresses.address;
	IF FOUND THEN
		RETURN v_uuid;
	ELSE
		RETURN NULL;
	END IF;
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

SET default_with_oids = false;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.articles (
    article_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    publish_time timestamp with time zone DEFAULT now() NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    type public.article_type NOT NULL
);


ALTER TABLE public.articles OWNER TO thommcgrath;

--
-- Name: objects; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.objects (
    object_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label public.citext NOT NULL,
    min_version integer DEFAULT 0 NOT NULL,
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    mod_id uuid DEFAULT '30bbab29-44b2-4f4b-a373-6d4740d9d3b5'::uuid NOT NULL,
    tags public.citext[] DEFAULT '{}'::public.citext[]
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
    sort integer NOT NULL,
    experimental boolean DEFAULT false NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    requirements jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT loot_sources_class_string_check1 CHECK ((class_string OPERATOR(public.~~) '%_C'::public.citext)),
    CONSTRAINT loot_sources_uicolor_check1 CHECK ((uicolor ~* '^[0-9a-fA-F]{8}$'::text))
)
INHERITS (public.objects);


ALTER TABLE public.loot_sources OWNER TO thommcgrath;

--
-- Name: blueprints; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.blueprints AS
 SELECT creatures.object_id,
    creatures.label,
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
    loot_sources.tableoid,
    loot_sources.min_version,
    loot_sources.last_update,
    loot_sources.mod_id,
    loot_sources.path,
    loot_sources.class_string,
    loot_sources.availability,
    loot_sources.tags
   FROM public.loot_sources;


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
    last_update timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone
);


ALTER TABLE public.client_notices OWNER TO thommcgrath;

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
-- Name: computed_engram_availabilities; Type: VIEW; Schema: public; Owner: thommcgrath
--

CREATE VIEW public.computed_engram_availabilities AS
 SELECT engrams.object_id,
    engrams.class_string,
    creatures.availability
   FROM public.creature_engrams,
    public.creatures,
    public.engrams
  WHERE ((creature_engrams.creature_id = creatures.object_id) AND (creature_engrams.engram_id = engrams.object_id));


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
-- Name: documents; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.documents (
    document_id uuid NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    map integer NOT NULL,
    difficulty numeric(8,4) NOT NULL,
    console_safe boolean NOT NULL,
    last_update timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    download_count integer DEFAULT 0 NOT NULL,
    contents jsonb NOT NULL,
    published public.publish_status DEFAULT 'Private'::public.publish_status
);


ALTER TABLE public.documents OWNER TO thommcgrath;

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
    code public.hex NOT NULL
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
-- Name: loot_source_icons; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.loot_source_icons (
    icon_data bytea NOT NULL
)
INHERITS (public.objects);


ALTER TABLE public.loot_source_icons OWNER TO thommcgrath;

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
    console_safe boolean DEFAULT false NOT NULL
);


ALTER TABLE public.mods OWNER TO thommcgrath;

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
    stripe_sku text NOT NULL
);


ALTER TABLE public.products OWNER TO thommcgrath;

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
    refunded boolean DEFAULT false NOT NULL
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
    purchases.client_reference_id
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
    article_slug character varying(20) NOT NULL,
    subject public.citext NOT NULL,
    content_markdown public.citext,
    preview public.citext NOT NULL,
    published boolean DEFAULT false NOT NULL,
    forward_url text,
    article_hash public.hex NOT NULL,
    affected_ini_keys public.citext[] DEFAULT '{}'::public.citext[] NOT NULL,
    CONSTRAINT support_articles_check CHECK (((content_markdown IS NOT NULL) OR (forward_url IS NOT NULL)))
);


ALTER TABLE public.support_articles OWNER TO thommcgrath;

--
-- Name: support_videos; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_videos (
    video_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    video_slug character varying(20) NOT NULL,
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
    ((setweight(to_tsvector((support_articles.subject)::text), 'A'::"char") || ''::tsvector) || setweight(to_tsvector((COALESCE(support_articles.content_markdown, support_articles.preview, ''::public.citext))::text), 'B'::"char")) AS lexemes,
    'Help'::text AS type,
    COALESCE(support_articles.forward_url, ('/help/'::text || (support_articles.article_slug)::text)) AS uri,
    0 AS min_version
   FROM public.support_articles
  WHERE (support_articles.published = true)
UNION
 SELECT support_videos.video_id AS id,
    support_videos.video_title AS title,
    ''::text AS body,
    setweight(to_tsvector((support_videos.video_title)::text), 'A'::"char") AS lexemes,
    'Video'::text AS type,
    ('/videos/'::text || (support_videos.video_slug)::text) AS uri,
    0 AS min_version
   FROM public.support_videos
UNION
 SELECT blueprints.object_id AS id,
    blueprints.label AS title,
    ''::text AS body,
    setweight(to_tsvector((blueprints.label)::text), 'C'::"char") AS lexemes,
    'Object'::text AS type,
    ('/object/'::text || (blueprints.class_string)::text) AS uri,
    blueprints.min_version
   FROM public.blueprints
UNION
 SELECT mods.mod_id AS id,
    mods.name AS title,
    ''::text AS body,
    setweight(to_tsvector(mods.name), 'D'::"char") AS lexemes,
    'Mod'::text AS type,
    ('/mods/'::text || mods.mod_id) AS uri,
    0 AS min_version
   FROM public.mods
  WHERE (mods.confirmed = true)
UNION
 SELECT documents.document_id AS id,
    documents.title,
    documents.description AS body,
    ((setweight(to_tsvector(documents.title), 'C'::"char") || ''::tsvector) || setweight(to_tsvector(documents.description), 'D'::"char")) AS lexemes,
    'Document'::text AS type,
    ('/browse/'::text || documents.document_id) AS uri,
    0 AS min_version
   FROM public.documents
  WHERE (documents.published = 'Approved'::public.publish_status);


ALTER TABLE public.search_contents OWNER TO thommcgrath;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.sessions (
    session_id public.citext NOT NULL,
    user_id uuid NOT NULL,
    valid_until timestamp with time zone
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
-- Name: support_images; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.support_images (
    image_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    image_data bytea NOT NULL,
    image_data_2x bytea,
    image_data_3x bytea,
    content_type public.citext NOT NULL,
    width_points numeric(4,0) NOT NULL,
    height_points numeric(4,0) NOT NULL
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
-- Name: updates; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.updates (
    update_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    build_number integer NOT NULL,
    build_display text NOT NULL,
    notes text NOT NULL,
    mac_url text NOT NULL,
    mac_signature public.citext NOT NULL,
    win_url text NOT NULL,
    win_signature public.citext NOT NULL,
    preview text DEFAULT ''::text NOT NULL,
    stage integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.updates OWNER TO thommcgrath;

--
-- Name: users; Type: TABLE; Schema: public; Owner: thommcgrath
--

CREATE TABLE public.users (
    user_id uuid NOT NULL,
    public_key text NOT NULL,
    private_key public.hex,
    private_key_salt public.hex,
    private_key_iterations integer,
    patreon_id integer,
    is_patreon_supporter boolean DEFAULT false NOT NULL,
    last_api_version text,
    email_id uuid,
    username public.citext,
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
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (article_id);


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
-- Name: creatures creatures_path_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_path_key UNIQUE (path);


--
-- Name: creatures creatures_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.creatures
    ADD CONSTRAINT creatures_pkey PRIMARY KEY (object_id);


--
-- Name: deletions deletions_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.deletions
    ADD CONSTRAINT deletions_pkey PRIMARY KEY (object_id);


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
-- Name: engrams engrams_path_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams
    ADD CONSTRAINT engrams_path_key UNIQUE (path);


--
-- Name: engrams engrams_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.engrams
    ADD CONSTRAINT engrams_pkey PRIMARY KEY (object_id);


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
-- Name: help_topics help_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.help_topics
    ADD CONSTRAINT help_topics_pkey PRIMARY KEY (config_name);


--
-- Name: loot_source_icons loot_source_icons_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_source_icons
    ADD CONSTRAINT loot_source_icons_pkey PRIMARY KEY (object_id);


--
-- Name: loot_sources loot_sources_path_key1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_path_key1 UNIQUE (path);


--
-- Name: loot_sources loot_sources_pkey1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_pkey1 PRIMARY KEY (object_id);


--
-- Name: loot_sources loot_sources_sort_key1; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.loot_sources
    ADD CONSTRAINT loot_sources_sort_key1 UNIQUE (sort);


--
-- Name: mods mods_pkey; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.mods
    ADD CONSTRAINT mods_pkey PRIMARY KEY (mod_id);


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
-- Name: support_articles support_articles_article_hash_key; Type: CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.support_articles
    ADD CONSTRAINT support_articles_article_hash_key UNIQUE (article_hash);


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
-- Name: creatures_classstring_mod_id_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX creatures_classstring_mod_id_uidx ON public.creatures USING btree (class_string, mod_id);


--
-- Name: email_addresses_group_key_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX email_addresses_group_key_idx ON public.email_addresses USING btree (group_key);


--
-- Name: engrams_classstring_mod_id_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX engrams_classstring_mod_id_uidx ON public.engrams USING btree (class_string, mod_id);


--
-- Name: exception_users_exception_id_user_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX exception_users_exception_id_user_id_idx ON public.exception_users USING btree (exception_id, user_id);


--
-- Name: mods_workshop_id_user_id_uidx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX mods_workshop_id_user_id_uidx ON public.mods USING btree (workshop_id, user_id);


--
-- Name: purchases_purchaser_email_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE INDEX purchases_purchaser_email_idx ON public.purchases USING btree (purchaser_email);


--
-- Name: stw_purchases_original_purchase_id_generated_purchase_id_idx; Type: INDEX; Schema: public; Owner: thommcgrath
--

CREATE UNIQUE INDEX stw_purchases_original_purchase_id_generated_purchase_id_idx ON public.stw_purchases USING btree (original_purchase_id, generated_purchase_id);


--
-- Name: client_notices client_notices_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER client_notices_before_update_trigger BEFORE INSERT OR UPDATE ON public.client_notices FOR EACH ROW EXECUTE PROCEDURE public.generic_update_trigger();


--
-- Name: support_articles create_slug_from_article_subject_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER create_slug_from_article_subject_trigger BEFORE INSERT ON public.support_articles FOR EACH ROW WHEN ((new.article_slug IS NULL)) EXECUTE PROCEDURE public.set_slug_from_article_subject();


--
-- Name: support_videos create_slug_from_video_title_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER create_slug_from_video_title_trigger BEFORE INSERT ON public.support_videos FOR EACH ROW WHEN ((new.video_slug IS NULL)) EXECUTE PROCEDURE public.set_slug_from_video_title();


--
-- Name: creatures creatures_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_after_delete_trigger AFTER DELETE ON public.creatures FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: creatures creatures_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_insert_trigger BEFORE INSERT ON public.creatures FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: creatures creatures_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_before_update_trigger BEFORE UPDATE ON public.creatures FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: creatures creatures_compute_class_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER creatures_compute_class_trigger BEFORE INSERT OR UPDATE ON public.creatures FOR EACH ROW EXECUTE PROCEDURE public.compute_class_trigger();


--
-- Name: diets diets_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_after_delete_trigger AFTER DELETE ON public.diets FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: diets diets_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_before_insert_trigger BEFORE INSERT ON public.diets FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: diets diets_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER diets_before_update_trigger BEFORE UPDATE ON public.diets FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: documents documents_maintenance_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER documents_maintenance_trigger BEFORE INSERT OR UPDATE ON public.documents FOR EACH ROW EXECUTE PROCEDURE public.documents_maintenance_function();


--
-- Name: mods enforce_mod_owner; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER enforce_mod_owner BEFORE INSERT OR UPDATE ON public.mods FOR EACH ROW EXECUTE PROCEDURE public.enforce_mod_owner();


--
-- Name: engrams engrams_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_after_delete_trigger AFTER DELETE ON public.engrams FOR EACH ROW EXECUTE PROCEDURE public.engram_delete_trigger();


--
-- Name: engrams engrams_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_insert_trigger BEFORE INSERT ON public.engrams FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: engrams engrams_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_before_update_trigger BEFORE UPDATE ON public.engrams FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: engrams engrams_compute_class_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER engrams_compute_class_trigger BEFORE INSERT OR UPDATE ON public.engrams FOR EACH ROW EXECUTE PROCEDURE public.compute_class_trigger();


--
-- Name: game_variables game_variables_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER game_variables_before_update_trigger BEFORE INSERT OR UPDATE ON public.game_variables FOR EACH ROW EXECUTE PROCEDURE public.generic_update_trigger();


--
-- Name: help_topics help_topics_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER help_topics_before_update_trigger BEFORE INSERT OR UPDATE ON public.help_topics FOR EACH ROW EXECUTE PROCEDURE public.generic_update_trigger();


--
-- Name: loot_source_icons loot_source_icons_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_after_delete_trigger AFTER DELETE ON public.loot_source_icons FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: loot_source_icons loot_source_icons_after_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_after_update_trigger AFTER UPDATE ON public.loot_source_icons FOR EACH ROW EXECUTE PROCEDURE public.loot_source_icons_update_loot_source();


--
-- Name: loot_source_icons loot_source_icons_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_insert_trigger BEFORE INSERT ON public.loot_source_icons FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: loot_source_icons loot_source_icons_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_source_icons_before_update_trigger BEFORE UPDATE ON public.loot_source_icons FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: loot_sources loot_sources_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_after_delete_trigger AFTER DELETE ON public.loot_sources FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: loot_sources loot_sources_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_insert_trigger BEFORE INSERT ON public.loot_sources FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: loot_sources loot_sources_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER loot_sources_before_update_trigger BEFORE UPDATE ON public.loot_sources FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: preset_modifiers preset_modifiers_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_after_delete_trigger AFTER DELETE ON public.preset_modifiers FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_insert_trigger BEFORE INSERT ON public.preset_modifiers FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: preset_modifiers preset_modifiers_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER preset_modifiers_before_update_trigger BEFORE UPDATE ON public.preset_modifiers FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: presets presets_after_delete_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_after_delete_trigger AFTER DELETE ON public.presets FOR EACH ROW EXECUTE PROCEDURE public.object_delete_trigger();


--
-- Name: presets presets_before_insert_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_before_insert_trigger BEFORE INSERT ON public.presets FOR EACH ROW EXECUTE PROCEDURE public.object_insert_trigger();


--
-- Name: presets presets_before_update_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_before_update_trigger BEFORE UPDATE ON public.presets FOR EACH ROW EXECUTE PROCEDURE public.object_update_trigger();


--
-- Name: presets presets_json_sync_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER presets_json_sync_trigger BEFORE INSERT OR UPDATE ON public.presets FOR EACH ROW EXECUTE PROCEDURE public.presets_json_sync_function();


--
-- Name: support_articles update_support_article_hash_trigger; Type: TRIGGER; Schema: public; Owner: thommcgrath
--

CREATE TRIGGER update_support_article_hash_trigger BEFORE INSERT OR UPDATE ON public.support_articles FOR EACH ROW EXECUTE PROCEDURE public.update_support_article_hash();


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
    ADD CONSTRAINT stw_purchases_generated_purchase_id_fkey FOREIGN KEY (generated_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: stw_purchases stw_purchases_original_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.stw_purchases
    ADD CONSTRAINT stw_purchases_original_purchase_id_fkey FOREIGN KEY (original_purchase_id) REFERENCES public.purchases(purchase_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


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
-- Name: users users_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thommcgrath
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: TABLE articles; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.articles TO thezaz_website;


--
-- Name: TABLE objects; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.objects TO thezaz_website;


--
-- Name: TABLE creatures; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creatures TO thezaz_website;


--
-- Name: TABLE engrams; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.engrams TO thezaz_website;


--
-- Name: TABLE loot_sources; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.loot_sources TO thezaz_website;


--
-- Name: TABLE blueprints; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.blueprints TO thezaz_website;


--
-- Name: TABLE client_notices; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.client_notices TO thezaz_website;


--
-- Name: TABLE creature_engrams; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creature_engrams TO thezaz_website;


--
-- Name: TABLE computed_engram_availabilities; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.computed_engram_availabilities TO thezaz_website;


--
-- Name: TABLE corrupt_files; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.corrupt_files TO thezaz_website;


--
-- Name: TABLE deletions; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.deletions TO thezaz_website;


--
-- Name: TABLE diet_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.diet_contents TO thezaz_website;


--
-- Name: TABLE diets; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.diets TO thezaz_website;


--
-- Name: TABLE documents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.documents TO thezaz_website;


--
-- Name: TABLE email_addresses; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE ON TABLE public.email_addresses TO thezaz_website;


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
-- Name: TABLE game_variables; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.game_variables TO thezaz_website;


--
-- Name: TABLE help_topics; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.help_topics TO thezaz_website;


--
-- Name: TABLE loot_source_icons; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.loot_source_icons TO thezaz_website;


--
-- Name: TABLE mods; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.mods TO thezaz_website;


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
-- Name: TABLE support_images; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT ON TABLE public.support_images TO thezaz_website;


--
-- Name: TABLE support_table_of_contents; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.support_table_of_contents TO thezaz_website;


--
-- Name: TABLE updates; Type: ACL; Schema: public; Owner: thommcgrath
--

GRANT SELECT ON TABLE public.updates TO thezaz_website;


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
