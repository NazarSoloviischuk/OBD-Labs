-- 1. СТВОРЕННЯ ТАБЛИЦЬ (DDL)

-- Таблиця Фільми [cite: 163, 165-170]
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(100),
    director VARCHAR(255),
    duration INTEGER CHECK (duration > 0) -- Обмеження: тривалість має бути додатною [cite: 33, 45]
);

-- Таблиця Інвентар [cite: 171-176]
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    movie_id INTEGER NOT NULL REFERENCES movies(movie_id), -- Зовнішній ключ на фільм [cite: 31, 174]
    store_id INTEGER NOT NULL,
    condition VARCHAR(50)
);

-- Таблиця Клієнти [cite: 177-185]
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL, -- Унікальність пошти [cite: 183, 207]
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата реєстрації за замовчуванням [cite: 24, 185]
);

-- Таблиця Оренда [cite: 186-193]
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id), -- Зв'язок з клієнтом [cite: 188]
    inventory_id INTEGER NOT NULL REFERENCES inventory(inventory_id), -- Зв'язок з диском [cite: 189]
    rental_date TIMESTAMP NOT NULL,
    return_due_date TIMESTAMP NOT NULL, -- Обов'язкова планова дата [cite: 192, 209]
    return_date TIMESTAMP
);

-- Таблиця Оплата [cite: 194-200]
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    rental_id INTEGER NOT NULL REFERENCES rentals(rental_id), -- Зв'язок з орендою [cite: 197]
    payment_type VARCHAR(50) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0), -- Сума не може бути від'ємною [cite: 33, 199]
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. НАПОВНЕННЯ ДАНИМИ (DML) [cite: 10, 46, 47]

-- Додаємо фільми
INSERT INTO movies (title, release_year, genre, director, duration) VALUES
('Inception', 2010, 'Sci-Fi', 'Christopher Nolan', 148),
('The Godfather', 1972, 'Crime', 'Francis Ford Coppola', 175),
('Pulp Fiction', 1994, 'Crime', 'Quentin Tarantino', 154),
('The Matrix', 1999, 'Sci-Fi', 'Lana Wachowski', 136),
('Interstellar', 2014, 'Sci-Fi', 'Christopher Nolan', 169);

-- Додаємо інвентар
INSERT INTO inventory (movie_id, store_id, condition) VALUES
(1, 1, 'New'),
(1, 1, 'Good'),
(2, 1, 'New'),
(3, 2, 'Fair'),
(4, 2, 'Good');

-- Додаємо клієнтів
INSERT INTO customers (first_name, last_name, phone, email, address) VALUES
('Nazar', 'Solovishchuk', '380991234567', 'nazar@example.com', 'Kyiv, Ukraine'),
('Alice', 'Smith', '380997654321', 'alice@example.com', 'London, UK'),
('Bob', 'Johnson', '380501112233', 'bob@example.com', 'New York, USA');

-- Додаємо записи про оренду [cite: 54]
INSERT INTO rentals (customer_id, inventory_id, rental_date, return_due_date, return_date) VALUES
(1, 1, '2026-03-01 10:00:00', '2026-03-08 10:00:00', '2026-03-07 12:00:00'),
(2, 3, '2026-03-05 14:30:00', '2026-03-12 14:30:00', NULL),
(3, 4, '2026-03-10 09:00:00', '2026-03-17 09:00:00', NULL);

-- Додаємо платежі
INSERT INTO payments (rental_id, payment_type, amount, payment_date) VALUES
(1, 'Rental Fee', 50.00, '2026-03-01 10:05:00'),
(1, 'Late Fee', 5.00, '2026-03-07 12:05:00'),
(2, 'Rental Fee', 45.00, '2026-03-05 14:35:00'),
(3, 'Rental Fee', 60.00, '2026-03-10 09:10:00');

-- ПЕРЕВІРКА ДАНИХ
SELECT * FROM movies;
SELECT * FROM rentals;
