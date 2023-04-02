-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

 -- replace with your own table name.
TRUNCATE TABLE albums RESTART IDENTITY; 
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Bossanova', '1999', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '2001', '1');