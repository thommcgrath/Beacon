-- dump data from old database
COPY (SELECT user_id, public_key FROM users) TO '/srv/beacon/users.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT document_id, user_id, last_update, revision, download_count, contents FROM documents) TO '/srv/beacon/documents.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT update_id, build_number, build_display, notes, mac_url, mac_signature, win_url, win_signature FROM updates) TO '/srv/beacon/updates.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT mod_id, workshop_id, user_id, name, confirmed, confirmation_code, pull_url, last_pull_hash FROM mods) TO '/srv/beacon/mods.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT contents FROM presets) TO '/srv/beacon/presets.csv' WITH (FORMAT csv, HEADER);

-- import into new database, loot_sources and engrams must be prepared ahead of time, since there is no direct translation path, and articles since they just don't exist in the old database
COPY users (user_id, public_key) FROM '/srv/beacon/users.csv' WITH (FORMAT csv, HEADER);
COPY documents (document_id, user_id, last_update, revision, download_count, contents) FROM '/srv/beacon/documents.csv' WITH (FORMAT csv, HEADER);
COPY updates (update_id, build_number, build_display, notes, mac_url, mac_signature, win_url, win_signature) FROM '/srv/beacon/updates.csv' WITH (FORMAT csv, HEADER);
COPY mods (mod_id, workshop_id, user_id, name, confirmed, confirmation_code, pull_url, last_pull_hash) FROM '/srv/beacon/mods.csv' WITH (FORMAT csv, HEADER);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('30bbab29-44b2-4f4b-a373-6d4740d9d3b5', -346110, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Ark Prime', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('55dd6a68-7041-46aa-9405-9adc5ae1825f', -512540, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Scorched Earth', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('38b6b5ae-1a60-4f2f-9bc6-9a23620b56d8', -708770, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Aberration', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('4dd9a0a5-add5-439c-9e80-103c6197d620', -473850, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'The Center', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('d23706bb-9875-46f4-b2aa-c137516aa65f', -642250, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Ragnarok', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('68d1be8b-a66e-41a2-b0b4-cb2a724fc80b', -508150, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Primitive+', TRUE, TRUE);
INSERT INTO mods (mod_id, workshop_id, user_id, name, confirmed, console_safe) VALUES ('397741a2-b35c-46a0-8cb0-1b61ff7d3d29', 731604991, '84aa7e0b-ecca-4a64-96dc-e11c032fd573', 'Structures Plus', TRUE, FALSE);
COPY presets (contents) FROM '/srv/beacon/presets.csv' WITH (FORMAT csv, HEADER);
COPY loot_sources (object_id, label, min_version, last_update, mod_id, path, class_string, availability, kind, multiplier_min, multiplier_max, uicolor, icon, sort, required_item_sets) FROM '/srv/beacon/loot_sources.csv' WITH (FORMAT csv, HEADER);
COPY engrams (object_id, label, min_version, last_update, mod_id, path, class_string, availability, can_blueprint) FROM '/srv/beacon/engrams.csv' WITH (FORMAT csv, HEADER);
COPY articles (article_id, publish_time, last_update, title, body, type) FROM '/srv/beacon/articles.csv' WITH (FORMAT csv, HEADER);