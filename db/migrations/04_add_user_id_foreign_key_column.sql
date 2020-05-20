ALTER TABLE listings ADD COLUMN user_id;
ALTER TABLE listings ADD FOREIGN KEY (user_id) REFERENCES users(id);
