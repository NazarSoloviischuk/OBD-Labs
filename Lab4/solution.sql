-- ==========================================
-- ЛАБОРАТОРНА РОБОТА №4
-- Студент: Соловійщук Назар (група ІО-45)
-- Тема: Аналітичні SQL-запити (OLAP)
-- ==========================================

-- ЧАСТИНА 1: АГРЕГАЦІЯ ТА ГРУПУВАННЯ (Мінімум 4 запити) [cite: 576]

-- 1. Базова агрегація (COUNT)
-- Підрахувати загальну кількість фізичних копій дисків у системі
SELECT COUNT(*) AS total_disks 
FROM inventory; [cite: 580, 582]

-- 2. Агрегація (AVG, MAX, MIN)
-- Проаналізувати тривалість фільмів: середня, максимальна та мінімальна
SELECT 
    AVG(duration) AS avg_duration,
    MAX(duration) AS max_movie,
    MIN(duration) AS min_movie
FROM movies; [cite: 584]

-- 3. Групування (GROUP BY)
-- Підрахувати кількість копій (дисків) для кожного фільму
SELECT movie_id, COUNT(*) AS copies_count
FROM inventory
GROUP BY movie_id; [cite: 585, 592]

-- 4. Фільтрування груп (HAVING)
-- Знайти клієнтів, які здійснили більше ніж 1 оренду (активні користувачі)
SELECT customer_id, COUNT(*) AS rental_count
FROM rentals
GROUP BY customer_id
HAVING COUNT(*) > 1; [cite: 571, 599]


-- ЧАСТИНА 2: ОБ'ЄДНАННЯ ТАБЛИЦЬ (JOINs) (Мінімум 3 запити) [cite: 576]

-- 5. INNER JOIN
-- Список: Ім'я клієнта, Назва фільму та сума проведеного платежу
SELECT 
    c.first_name || ' ' || c.last_name AS Клієнт, 
    m.title AS Фільм, 
    p.amount AS Сума_оплати
FROM payments p
INNER JOIN rentals r ON p.rental_id = r.rental_id
INNER JOIN customers c ON r.customer_id = c.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN movies m ON i.movie_id = m.movie_id; [cite: 601, 606]

-- 6. LEFT JOIN
-- Показати всі фільми та загальну кількість їх оренд (включаючи ті, що не орендувались)
SELECT 
    m.title, 
    COUNT(r.rental_id) AS rental_count
FROM movies m
LEFT JOIN inventory i ON m.movie_id = i.movie_id
LEFT JOIN rentals r ON i.inventory_id = r.inventory_id
GROUP BY m.title; [cite: 607, 608]

-- 7. CROSS JOIN
-- Матриця всіх можливих комбінацій клієнтів та існуючих жанрів фільмів
SELECT 
    c.first_name, 
    m.genre
FROM customers c
CROSS JOIN (SELECT DISTINCT genre FROM movies) m;


-- ЧАСТИНА 3: ПІДЗАПИТИ (SUBQUERIES) (Мінімум 3 запити) [cite: 576]

-- 8. Підзапит у WHERE (Оператор IN)
-- Знайти імена клієнтів, які мають хоча б один запис про оренду
SELECT first_name, last_name 
FROM customers 
WHERE customer_id IN (
    SELECT DISTINCT customer_id 
    FROM rentals
); [cite: 576]

-- 9. Підзапит у SELECT
-- Вивести назву фільму та кількість його фізичних копій (підрахунок підзапитом)
SELECT 
    title, 
    (SELECT COUNT(*) FROM inventory WHERE inventory.movie_id = movies.movie_id) AS кількість_копій
FROM movies; [cite: 576]

-- 10. Підзапит з агрегацією (WHERE + Scalar Subquery)
-- Знайти фільми, тривалість яких більша за середню тривалість усіх фільмів у базі
SELECT title, duration 
FROM movies 
WHERE duration > (
    SELECT AVG(duration) FROM movies
); [cite: 576]
