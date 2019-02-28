ALTER TABLE email_addresses ADD COLUMN group_key_precision INTEGER;
UPDATE email_addresses SET group_key_precision = 2;
ALTER TABLE email_addresses ALTER COLUMN group_key_precision SET NOT NULL;

DROP FUNCTION group_key_for_email(email);
CREATE OR REPLACE FUNCTION group_key_for_email(p_address email, p_precision INTEGER) RETURNS hex AS $$
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
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE OR REPLACE FUNCTION uuid_for_email(p_address email) RETURNS UUID AS $$
DECLARE
	v_uuid UUID;
BEGIN
	SELECT email_id INTO v_uuid FROM email_addresses WHERE group_key = group_key_for_email(p_address, email_addresses.group_key_precision) AND CRYPT(LOWER(p_address), address) = address;
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
$$ LANGUAGE 'plpgsql' VOLATILE;