ALTER TABLE exceptions RENAME TO exceptions_legacy;
ALTER TABLE exception_comments RENAME TO exception_comments_legacy;
GRANT SELECT ON TABLE exception_comments_legacy TO thezaz_website;

CREATE TABLE exceptions (
	exception_id UUID NOT NULL PRIMARY KEY,
	min_reported_build INTEGER NOT NULL,
	max_reported_build INTEGER NOT NULL,
	location TEXT NOT NULL,
	exception_class TEXT NOT NULL,
	reason TEXT NOT NULL,
	trace TEXT NOT NULL,
	solution_build INTEGER,
	solution_comments TEXT,
	CHECK (solution_build IS NULL OR solution_build > max_reported_build)
);
GRANT SELECT, INSERT, UPDATE ON exceptions TO thezaz_website;

CREATE TABLE exception_signatures (
	client_hash HEX NOT NULL,
	client_build INTEGER NOT NULL,
	exception_id UUID NOT NULL REFERENCES exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED ,
	trace TEXT NOT NULL,
	PRIMARY KEY (client_hash, client_build)
);
GRANT SELECT, INSERT ON exception_signatures TO thezaz_website;

CREATE TABLE exception_comments (
	comment_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
	exception_id UUID NOT NULL REFERENCES exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE,
	comments TEXT NOT NULL,
	user_id UUID REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
GRANT SELECT, INSERT ON exception_comments TO thezaz_website;

CREATE TABLE exception_users (
	exception_id UUID NOT NULL REFERENCES exceptions(exception_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	user_id UUID NOT NULL REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);
GRANT SELECT, INSERT ON exception_users TO thezaz_website;