CREATE TABLE game_popularity (
	id SERIAL UNIQUE,
	game TEXT PRIMARY KEY,
	year INT,
	month TEXT,
	avg_players DECIMAL,
	monthly_change DECIMAL,
	max_players INT,
	avg_max_percent TEXT
);

CREATE TABLE game_details (
	id SERIAL UNIQUE,
	game TEXT PRIMARY KEY,
	developer TEXT,
	price_cents DECIMAL,
	description TEXT
);

SELECT * FROM game_popularity;
SELECT * FROM game_details;