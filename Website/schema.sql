CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION "pgcrypto";
CREATE EXTENSION "citext";

CREATE TABLE "updates" (
	"update_id" UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	"build_number" INTEGER NOT NULL UNIQUE,
	"build_display" TEXT NOT NULL,
	"notes" TEXT NOT NULL,
	"mac_url" TEXT NOT NULL,
	"mac_signature" CITEXT NOT NULL,
	"win_url" TEXT NOT NULL,
	"win_signature" CITEXT NOT NULL
);
GRANT SELECT ON TABLE "updates" TO "thezaz_website";

CREATE TABLE "users" (
	"user_id" UUID NOT NULL PRIMARY KEY,
	"public_key" TEXT NOT NULL
);
GRANT SELECT, INSERT ON TABLE "users" TO "thezaz_website";

CREATE TABLE "documents" (
	"document_id" UUID NOT NULL PRIMARY KEY,
	"user_id" UUID NOT NULL REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE,
	"title" TEXT NOT NULL,
	"description" TEXT NOT NULL,
	"revision" INTEGER NOT NULL DEFAULT 1,
	"last_update" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	"download_count" INTEGER NOT NULL DEFAULT 0,
	"contents" TEXT NOT NULL,
	"contents_hash" CITEXT NOT NULL
);
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE "documents" TO "thezaz_website";

CREATE TYPE "loot_source_kind" AS ENUM (
	'Standard',
	'Bonus',
	'Cave',
	'Sea'
);

CREATE TABLE "loot_sources" (
	"classstring" CITEXT NOT NULL,
	"label" CITEXT NOT NULL,
	"kind" "loot_source_kind" NOT NULL,
	"engram_mask" INTEGER NOT NULL,
	"multiplier_min" NUMERIC(6,4) NOT NULL,
	"multiplier_max" NUMERIC(6,4) NOT NULL
);
GRANT SELECT ON TABLE "loot_sources" TO "thezaz_website";

CREATE TABLE "engrams" (
	"classstring" CITEXT NOT NULL,
	"label" CITEXT NOT NULL,
	"availability" INTEGER NOT NULL DEFAULT 0,
	"can_blueprint" BOOLEAN NOT NULL DEFAULT TRUE,
	CHECK ("classstring" LIKE '%_C')
);
GRANT SELECT ON TABLE "engrams" TO "thezaz_website";
