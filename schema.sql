CREATE TABLE game_data (
	id INT PRIMARY KEY,
	game TEXT,
	year INT,
	month TEXT,
	avg_players DECIMAL,
	monthly_change DECIMAL,
	max_players INT,
	avg_max_percent TEXT,
	developer TEXT,
	price_cents DECIMAL,
	description TEXT
);

SELECT * FROM game_data;