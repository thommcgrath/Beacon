BEGIN TRANSACTION;

CREATE TABLE wordlist (
    word CITEXT PRIMARY KEY,
    isadjective BOOLEAN NOT NULL DEFAULT FALSE,
    isnoun BOOLEAN NOT NULL DEFAULT FALSE,
    issuffix BOOLEAN NOT NULL DEFAULT FALSE
);
GRANT SELECT ON TABLE wordlist TO thezaz_website;
COPY wordlist FROM '/var/lib/pgsql/wordlist.csv' CSV;

CREATE OR REPLACE FUNCTION generate_username() RETURNS TEXT AS $$
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
$$ LANGUAGE 'plpgsql' VOLATILE;

CREATE TABLE email_addresses (
	email_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	address TEXT NOT NULL,
	group_key hex NOT NULL
);
GRANT SELECT, INSERT ON TABLE email_addresses TO thezaz_website;

CREATE OR REPLACE FUNCTION group_key_for_email(p_address email) RETURNS hex AS $$
DECLARE
	v_user TEXT;
	v_domain TEXT;
	v_kvalue TEXT;
BEGIN
	v_user := SUBSTRING(p_address, '^([^@]+)@.+$');
	v_domain := SUBSTRING(p_address, '^[^@]+@(.+)$');
	
	IF LENGTH(v_user) <= 2 THEN
		v_kvalue := '@' || v_domain;
	ELSE
		v_kvalue := SUBSTRING(v_user, 1, 2) || '*@' || v_domain;
	END IF;
	
	RETURN MD5(LOWER(v_kvalue));
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE OR REPLACE FUNCTION uuid_for_email(p_address email) RETURNS UUID AS $$
DECLARE
	v_uuid UUID;
BEGIN
	SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key = group_key_for_email(p_address) AND CRYPT(LOWER(p_address), address) = address;
	IF FOUND THEN
		RETURN v_uuid;
	ELSE
		RETURN NULL;
	END IF;
END;
$$ LANGUAGE 'plpgsql' STABLE;

CREATE OR REPLACE FUNCTION uuid_for_email(p_address email, p_create BOOLEAN) RETURNS UUID AS $$
DECLARE
	v_uuid UUID;
BEGIN
	v_uuid := uuid_for_email(p_address);
	IF v_uuid IS NULL AND p_create = TRUE THEN
		INSERT INTO email_addresses (address, group_key) VALUES (CRYPT(LOWER(p_address), GEN_SALT('bf')), group_key_for_email(p_address)) RETURNING email_id INTO v_uuid;
	END IF;
	RETURN v_uuid;
END;
$$ LANGUAGE 'plpgsql' VOLATILE;

ALTER TABLE users DROP CONSTRAINT users_check, ADD COLUMN email_id UUID UNIQUE REFERENCES email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT, ADD COLUMN username CITEXT;
UPDATE users SET email_id = uuid_for_email(login_key, TRUE), username = generate_username() WHERE login_key IS NOT NULL;
ALTER TABLE users DROP COLUMN login_key, ADD CONSTRAINT users_check CHECK ((email_id IS NULL AND username IS NULL AND private_key_iterations IS NULL AND private_key_salt IS NULL AND private_key IS NULL) OR (email_id IS NOT NULL AND username IS NOT NULL AND private_key_iterations IS NOT NULL AND private_key_salt IS NOT NULL AND private_key IS NOT NULL));

ALTER TABLE email_verification RENAME TO email_verification_old;
CREATE TABLE email_verification (
	email_id UUID NOT NULL PRIMARY KEY REFERENCES email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE,
	code hex NOT NULL
);
GRANT SELECT, INSERT, UPDATE, DELETE ON email_verification TO thezaz_website;
INSERT INTO email_verification (email_id, code) SELECT uuid_for_email(email, TRUE), code FROM email_verification_old;
DROP TABLE email_verification_old;

CREATE TABLE products (
	product_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	product_name TEXT NOT NULL,
	retail_price NUMERIC(6,2) NOT NULL,
	stripe_sku TEXT NOT NULL UNIQUE
);
GRANT SELECT ON products TO thezaz_website;
INSERT INTO products(product_id, product_name, retail_price, stripe_sku) VALUES ('972f9fc5-ad64-4f9c-940d-47062e705cc5', 'Omni', 10, 'sku_E5V8BaWFlmvLGG');

CREATE TABLE purchases (
	purchase_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	purchaser_email UUID NOT NULL REFERENCES email_addresses(email_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	purchase_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	subtotal NUMERIC(6,2) NOT NULL,
	discount NUMERIC(6,2) NOT NULL,
	tax NUMERIC(6,2) NOT NULL,
	total_paid NUMERIC(6,2) NOT NULL,
	merchant_reference CITEXT NOT NULL UNIQUE,
	client_reference_id TEXT
);
CREATE INDEX purchases_purchaser_email_idx ON purchases(purchaser_email);
GRANT SELECT, INSERT ON purchases TO thezaz_website;

CREATE TABLE purchase_items (
	line_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	purchase_id UUID NOT NULL REFERENCES purchases(purchase_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	product_id UUID NOT NULL REFERENCES products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	retail_price NUMERIC(6,2) NOT NULL,
	discount NUMERIC(6,2) NOT NULL,
	line_total NUMERIC(6,2) NOT NULL
);
GRANT SELECT, INSERT ON purchase_items TO thezaz_website;

CREATE VIEW purchased_products AS SELECT products.product_id, products.product_name, purchases.purchaser_email FROM purchases INNER JOIN (purchase_items INNER JOIN products ON (purchase_items.product_id = products.product_id)) ON (purchase_items.purchase_id = purchases.purchase_id);
GRANT SELECT ON purchased_products TO thezaz_website;

CREATE OR REPLACE VIEW blueprints AS (SELECT object_id, label, tableoid, min_version, last_update, mod_id, path, class_string, availability FROM creatures) UNION (SELECT object_id, label, tableoid, min_version, last_update, mod_id, path, class_string, availability FROM engrams) UNION (SELECT object_id, label, tableoid, min_version, last_update, mod_id, path, class_string, availability FROM loot_sources);
GRANT SELECT ON TABLE blueprints TO thezaz_website;

CREATE OR REPLACE VIEW search_contents AS (SELECT article_id AS id, title, body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(body), 'B') AS lexemes, 'Article' AS type, '/read/' || article_id AS uri FROM articles) UNION (SELECT object_id AS id, label AS title, '' AS body, setweight(to_tsvector(label), 'A') AS lexemes, 'Object' AS type, '/object/' || class_string AS uri FROM blueprints) UNION (SELECT mod_id AS id, name AS title, '' AS body, setweight(to_tsvector(name), 'C') AS lexemes, 'Mod' AS type, '/mods/info.php?mod_id=' || mod_id AS uri FROM mods WHERE confirmed = TRUE) UNION (SELECT document_id, title, description AS body, setweight(to_tsvector(title), 'A') || ' ' || setweight(to_tsvector(description), 'B') AS lexemes, 'Document' AS type, '/browse/view.php?document_id=' || document_id AS uri FROM documents WHERE published = 'Approved');
GRANT SELECT ON TABLE search_contents TO thezaz_website;

COMMIT;