CREATE OR REPLACE FUNCTION slugify(p_input TEXT) RETURNS TEXT AS $$
BEGIN
	RETURN regexp_replace(TRIM(LEFT(regexp_replace(LOWER(unaccent(p_input)), '[^a-z0-9 \\-]+', ' ', 'gi'), 20)), '\s+', '_', 'g');
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE OR REPLACE FUNCTION update_support_article_hash() RETURNS TRIGGER AS $$
BEGIN
	NEW.article_hash := MD5(NEW.subject || '::' || COALESCE(NEW.content_markdown, '') || '::' || COALESCE(NEW.preview, ''));
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TABLE support_articles (
	article_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	article_slug VARCHAR(20) NOT NULL UNIQUE,
	subject CITEXT NOT NULL,
	content_markdown CITEXT,
	preview CITEXT NOT NULL,
	published BOOLEAN NOT NULL DEFAULT FALSE,
	forward_url TEXT,
	article_hash HEX NOT NULL UNIQUE,
	CHECK (content_markdown IS NOT NULL OR forward_url IS NOT NULL)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON support_articles TO thezaz_website;
CREATE TRIGGER "update_support_article_hash_trigger" BEFORE UPDATE OR INSERT ON support_articles FOR EACH ROW EXECUTE PROCEDURE update_support_article_hash();

CREATE TABLE support_images (
	image_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	image_data BYTEA NOT NULL,
	image_data_2x BYTEA,
	image_data_3x BYTEA,
	content_type CITEXT NOT NULL,
	width_points NUMERIC(4,0) NOT NULL,
	height_points NUMERIC(4,0) NOT NULL
);
GRANT SELECT, INSERT ON support_images TO thezaz_website;

CREATE TABLE support_article_groups (
	group_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	group_name CITEXT NOT NULL,
	sort_order INTEGER
);
GRANT SELECT, INSERT, UPDATE, DELETE ON support_article_groups TO thezaz_website;

CREATE TABLE support_table_of_contents (
	record_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	article_id UUID NOT NULL UNIQUE REFERENCES support_articles(article_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	group_id UUID NOT NULL REFERENCES support_article_groups(group_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED,
	sort_order INTEGER
);
GRANT SELECT, INSERT, UPDATE, DELETE ON support_table_of_contents TO thezaz_website;

CREATE TYPE video_host AS ENUM ('YouTube');
CREATE TABLE support_videos (
	video_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	video_slug VARCHAR(20) NOT NULL UNIQUE,
	video_title CITEXT NOT NULL,
	host video_host NOT NULL,
	host_video_id TEXT NOT NULL,
	UNIQUE(host, host_video_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON support_videos TO thezaz_website;

CREATE FUNCTION set_slug_from_article_subject() RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
	NEW.article_slug := slugify(NEW.subject);
	RETURN NEW;
END $$;
CREATE TRIGGER "create_slug_from_article_subject_trigger" BEFORE INSERT ON support_articles FOR EACH ROW WHEN (NEW.article_slug IS NULL) EXECUTE PROCEDURE set_slug_from_article_subject();

CREATE FUNCTION set_slug_from_video_title() RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
	NEW.video_slug := slugify(NEW.video_title);
	RETURN NEW;
END $$;
CREATE TRIGGER "create_slug_from_video_title_trigger" BEFORE INSERT ON support_videos FOR EACH ROW WHEN (NEW.video_slug IS NULL) EXECUTE PROCEDURE set_slug_from_video_title();

CREATE OR REPLACE VIEW "public"."search_contents" AS SELECT support_articles.article_id AS id,
    support_articles.subject AS title,
    COALESCE(support_articles.content_markdown, support_articles.preview, '') AS body,
    (setweight(to_tsvector(support_articles.subject), 'A'::"char") || ''::tsvector) || setweight(to_tsvector(COALESCE(support_articles.content_markdown, support_articles.preview, '')), 'B'::"char") AS lexemes,
    'Help'::text AS type,
    COALESCE(support_articles.forward_url, '/help/'::text || support_articles.article_slug) AS uri,
    0 AS min_version
   FROM support_articles WHERE support_articles.published = TRUE
UNION
 SELECT support_videos.video_id AS id,
    support_videos.video_title AS title,
    ''::text AS body,
    setweight(to_tsvector(support_videos.video_title), 'A'::"char") AS lexemes,
    'Video'::text AS type,
    '/videos/'::text || support_videos.video_slug AS uri,
    0 AS min_version
   FROM support_videos
UNION
 SELECT blueprints.object_id AS id,
    blueprints.label AS title,
    ''::text AS body,
    setweight(to_tsvector(blueprints.label::text), 'C'::"char") AS lexemes,
    'Object'::text AS type,
    '/object/'::text || blueprints.class_string::text AS uri,
    blueprints.min_version
   FROM blueprints
UNION
 SELECT mods.mod_id AS id,
    mods.name AS title,
    ''::text AS body,
    setweight(to_tsvector(mods.name), 'D'::"char") AS lexemes,
    'Mod'::text AS type,
    '/mods/'::text || mods.mod_id AS uri,
    0 AS min_version
   FROM mods
  WHERE mods.confirmed = true
UNION
 SELECT documents.document_id AS id,
    documents.title,
    documents.description AS body,
    (setweight(to_tsvector(documents.title), 'C'::"char") || ''::tsvector) || setweight(to_tsvector(documents.description), 'D'::"char") AS lexemes,
    'Document'::text AS type,
    '/browse/'::text || documents.document_id AS uri,
    0 AS min_version
   FROM documents
  WHERE documents.published = 'Approved'::publish_status;
  
INSERT INTO support_videos (video_slug, video_title, host, host_video_id) VALUES ('introduction_to_loot', 'Introduction to Loot Drops with Beacon', 'YouTube', 'NPyOk9R3Ra0');
  
INSERT INTO support_articles (subject, content_markdown, preview) SELECT title AS subject, body AS content_markdown, '' AS preview FROM articles WHERE type = 'Help';