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
