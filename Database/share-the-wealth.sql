CREATE TABLE stw_purchases (
	stw_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	original_purchase_id UUID NOT NULL REFERENCES purchases(purchase_id) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED,
	generated_purchase_id UUID REFERENCES purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT
);
GRANT SELECT, UPDATE, INSERT ON stw_purchases TO thezaz_website;

CREATE TABLE stw_applicants (
	applicant_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	encrypted_email TEXT,
	email_id UUID NOT NULL UNIQUE REFERENCES email_addresses(email_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	generated_purchase_id UUID REFERENCES purchases(purchase_id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
	CHECK ((encrypted_email IS NOT NULL AND generated_purchase_id IS NULL) OR (encrypted_email IS NULL AND generated_purchase_id IS NOT NULL))
);
GRANT SELECT, UPDATE, INSERT ON stw_applicants TO thezaz_website;