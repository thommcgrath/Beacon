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
GRANT SELECT, UPDATE, INSERT, DELETE ON stw_applicants TO thezaz_website;

DROP VIEW purchased_products;
ALTER TABLE purchase_items RENAME TO purchase_items_old;
CREATE TABLE purchase_items (
	line_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	purchase_id UUID NOT NULL REFERENCES purchases(purchase_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	product_id UUID NOT NULL REFERENCES products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	retail_price NUMERIC(6,2) NOT NULL,
	discount NUMERIC(6,2) NOT NULL,
	quantity NUMERIC(6,0) NOT NULL,
	line_total NUMERIC(6,2) NOT NULL
);
GRANT SELECT, INSERT ON purchase_items TO thezaz_website;
INSERT INTO purchase_items (line_id, purchase_id, product_id, retail_price, discount, quantity, line_total) SELECT line_id, purchase_id, product_id, retail_price, discount, 1 AS quantity, line_total FROM purchase_items_old;
DROP TABLE purchase_items_old;
CREATE VIEW purchased_products AS SELECT products.product_id, products.product_name, purchases.purchaser_email FROM purchases INNER JOIN (purchase_items INNER JOIN products ON (purchase_items.product_id = products.product_id)) ON (purchase_items.purchase_id = purchases.purchase_id);
GRANT SELECT ON purchased_products TO thezaz_website;