-- 1. Створюємо таблицю-довідник для жанрів
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Наповнюємо її унікальними жанрами з твоєї таблиці movies
INSERT INTO genres (genre_name) 
SELECT DISTINCT genre FROM movies;

-- 3. Додаємо нове поле для зв'язку в таблицю movies
ALTER TABLE movies ADD COLUMN genre_id INTEGER;

-- 4. Оновлюємо id жанрів у таблиці movies на основі назв
UPDATE movies m
SET genre_id = g.genre_id
FROM genres g
WHERE m.genre = g.genre_name;

-- 5. Видаляємо старе текстове поле і ставимо обмеження
ALTER TABLE movies DROP COLUMN genre;
ALTER TABLE movies ALTER COLUMN genre_id SET NOT NULL;
ALTER TABLE movies ADD CONSTRAINT fk_movie_genre 
FOREIGN KEY (genre_id) REFERENCES genres(genre_id);
