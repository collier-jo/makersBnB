ALTER TABLE pictures
	ADD COLUMN listing_id INTEGER REFERENCES listings (id);
