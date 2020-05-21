ALTER TABLE listings ADD COLUMN user_id INT;
ALTER TABLE listings ADD FOREIGN KEY (user_id) REFERENCES users(id);
