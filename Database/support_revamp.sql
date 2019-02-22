CREATE OR REPLACE FUNCTION slugify(p_input TEXT) RETURNS TEXT AS $$
BEGIN
	RETURN regexp_replace(TRIM(LEFT(regexp_replace(LOWER(unaccent(p_input)), '[^a-z0-9 \\-]+', ' ', 'gi'), 20)), '\s+', '_', 'g');
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE TABLE support_articles (
	article_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	article_slug VARCHAR(20) NOT NULL UNIQUE,
	subject CITEXT NOT NULL,
	content_markdown CITEXT,
	preview CITEXT NOT NULL,
	published BOOLEAN NOT NULL DEFAULT FALSE,
	forward_url TEXT,
	CHECK (content_markdown IS NOT NULL OR forward_url IS NOT NULL)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON support_articles TO thezaz_website;

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