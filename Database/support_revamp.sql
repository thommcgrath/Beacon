CREATE TABLE support_articles (
	article_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	article_slug VARCHAR(20) NOT NULL UNIQUE,
	subject CITEXT NOT NULL,
	content_markdown CITEXT NOT NULL,
	preview CITEXT NOT NULL,
	published BOOLEAN NOT NULL DEFAULT FALSE
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