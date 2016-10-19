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
	"multiplier_max" NUMERIC(6,4) NOT NULL,
	"last_update" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0),
	"uicolor" TEXT NOT NULL CHECK ("uicolor" ~* '^[0-9a-fA-F]{8}$')
);
GRANT SELECT ON TABLE "loot_sources" TO "thezaz_website";

CREATE TABLE "engrams" (
	"classstring" CITEXT NOT NULL,
	"label" CITEXT NOT NULL,
	"availability" INTEGER NOT NULL DEFAULT 0,
	"can_blueprint" BOOLEAN NOT NULL DEFAULT TRUE,
	"last_update" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0),
	CHECK ("classstring" LIKE '%_C')
);
GRANT SELECT ON TABLE "engrams" TO "thezaz_website";

CREATE TABLE "deletions" (
	"deletion_id" UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	"table" CITEXT NOT NULL,
	"classstring" CITEXT NOT NULL,
	"time" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(0)
);
CREATE UNIQUE INDEX "deletions_table_classstring_idx" ON "deletions"("table", "classstring");
GRANT SELECT ON TABLE "deletions" TO "thezaz_website";

DROP TRIGGER IF EXISTS "engrams_before_insert_trigger" ON "engrams";
DROP TRIGGER IF EXISTS "engrams_before_update_trigger" ON "engrams";
DROP TRIGGER IF EXISTS "engrams_after_delete_trigger" ON "engrams";

DROP TRIGGER IF EXISTS "loot_sources_before_insert_trigger" ON "loot_sources";
DROP TRIGGER IF EXISTS "loot_sources_before_update_trigger" ON "loot_sources";
DROP TRIGGER IF EXISTS "loot_sources_after_delete_trigger" ON "loot_sources";

CREATE OR REPLACE FUNCTION "cache_insert_trigger" () RETURNS TRIGGER AS $$
BEGIN
	DELETE FROM "deletions" WHERE "table" = "TG_TABLE_NAME" AND "classstring" = NEW."classstring";
	NEW."last_update" = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "cache_update_trigger" () RETURNS TRIGGER AS $$
BEGIN
	IF OLD."classstring" != NEW."classstring" THEN
		DELETE FROM "deletions" WHERE "table" = "TG_TABLE_NAME" AND "classstring" = NEW."classstring";
		INSERT INTO "deletions" ("table", "classstring") VALUES ("TG_TABLE_NAME", OLD."classstring");
	END IF;
	NEW."last_update" = CURRENT_TIMESTAMP(0);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "cache_delete_trigger" () RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO "deletions" ("table", "classstring") VALUES ("TG_TABLE_NAME", OLD."classstring");
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "engrams_before_insert_trigger" BEFORE INSERT ON "engrams" FOR EACH ROW EXECUTE PROCEDURE "cache_insert_trigger"();
CREATE TRIGGER "engrams_before_update_trigger" BEFORE UPDATE ON "engrams" FOR EACH ROW EXECUTE PROCEDURE "cache_update_trigger"();
CREATE TRIGGER "engrams_after_delete_trigger" AFTER DELETE ON "engrams" FOR EACH ROW EXECUTE PROCEDURE "cache_delete_trigger"();

CREATE TRIGGER "loot_sources_before_insert_trigger" BEFORE INSERT ON "loot_sources" FOR EACH ROW EXECUTE PROCEDURE "cache_insert_trigger"();
CREATE TRIGGER "loot_sources_before_update_trigger" BEFORE UPDATE ON "loot_sources" FOR EACH ROW EXECUTE PROCEDURE "cache_update_trigger"();
CREATE TRIGGER "loot_sources_after_delete_trigger" AFTER DELETE ON "loot_sources" FOR EACH ROW EXECUTE PROCEDURE "cache_delete_trigger"();
