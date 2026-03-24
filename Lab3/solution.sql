-- ==========================================
-- ЛАБОРАТОРНА РОБОТА №3
-- Студент: Соловійщук Назар (група ІО-45)
-- Тема: Маніпулювання даними SQL (OLTP)
-- ==========================================

-- 1. SELECT (Вибірка даних)
-- Пошук фільмів у жанрі Sci-Fi
SELECT title, director FROM movies WHERE genre = 'Sci-Fi'; [cite: 219, 227]

-- Складний запит: список оренд з іменами клієнтів та назвами фільмів
SELECT 
    c.first_name || ' ' || c.last_name AS Клієнт,
    m.title AS Фільм,
    r.rental_date AS Дата_видачі
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN movies m ON i.movie_id = m.movie_id; [cite: 229]

-- 2. INSERT (Додавання нових записів)
-- Реєстрація нового клієнта
INSERT INTO customers (first_name, last_name, phone, email, address) 
VALUES ('Tony', 'Stark', '380679998877', 'ironman@stark.com', 'Malibu, USA'); [cite: 220, 232]

-- 3. UPDATE (Оновлення даних)
-- Зміна номера телефону клієнта
UPDATE customers 
SET phone = '380671112233' 
WHERE first_name = 'Nazar' AND last_name = 'Solovishchuk'; [cite: 221, 235]

-- Фіксація повернення фільму
UPDATE rentals 
SET return_date = CURRENT_TIMESTAMP 
WHERE rental_id = 1; [cite: 238]

-- 4. DELETE (Видалення даних)
-- Видалення помилкового платежу
DELETE FROM payments WHERE payment_id = 4; [cite: 222, 241]

-- Послідовне видалення клієнта (враховуючи цілісність даних)
DELETE FROM rentals WHERE customer_id = 4;
DELETE FROM customers WHERE email = 'ironman@stark.com'; [cite: 242, 254]

-- Перевірка видалення
SELECT * FROM customers WHERE last_name = 'Stark'; [cite: 244]
