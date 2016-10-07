CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION "pgcrypto";

CREATE TABLE "updates" (
	"update_id" UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	"build_number" INTEGER NOT NULL UNIQUE,
	"build_display" TEXT NOT NULL,
	"notes" TEXT NOT NULL,
	"mac_url" TEXT NOT NULL,
	"mac_signature" TEXT NOT NULL,
	"win_url" TEXT NOT NULL,
	"win_signature" TEXT NOT NULL
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
	"contents_hash" TEXT NOT NULL
);
GRANT SELECT, INSERT, UPDATE ON TABLE "documents" TO "thezaz_website";
