TRUNCATE TABLE users RESTART IDENTITY CASCADE; 


INSERT INTO users (name, email) VALUES ('John Lennon', 'jl@beatles.com');
INSERT INTO users (name, email) VALUES ('Paul McCartney', 'pm@beatles.com');