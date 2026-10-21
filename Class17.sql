-- ejercicio 1

SELECT * FROM address
WHERE postal_code IN ('35200', '52137', '17886');

SELECT * FROM address
WHERE postal_code NOT IN ('35200', '52137', '17886');

SELECT a.address, a.postal_code, c.city, co.country FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code IN ('35200', '52137', '17886');

EXPLAIN ANALYZE
SELECT * FROM address
WHERE postal_code IN ('35200', '52137', '17886');

CREATE INDEX idx_address_postal_code
ON address(postal_code);

EXPLAIN ANALYZE
SELECT * FROM address
WHERE postal_code IN ('35200', '52137', '17886');

-- El índice sobre postal_code puede mejorar el rendimiento de las consultas que buscan códigos postales específicos. 
-- Antes de crearlo, MySQL puede tener que recorrer toda la tabla para encontrar los registros. 
-- Después de crearlo, puede utilizar el índice para localizar los valores de forma más eficiente.

-- ejercicio 2
SELECT * FROM actor
WHERE first_name = 'PENELOPE';

SELECT * FROM actor
WHERE last_name = 'GUINESS';

SHOW INDEX FROM actor;

EXPLAIN
SELECT * FROM actor
WHERE first_name = 'PENELOPE';

EXPLAIN
SELECT * FROM actor
WHERE last_name = 'GUINESS';

-- Las consultas pueden tener distintos tiempos de ejecución porque las columnas tienen índices diferentes y la cantidad de registros encontrados puede variar.
-- La columna first_name tiene su propio índice, por lo que MySQL puede utilizarlo para buscar actores por nombre.
-- La columna last_name es la primera columna de un índice compuesto por last_name y first_name. Por eso, MySQL puede utilizar ese índice para buscar por apellido o por apellido y nombre juntos.

-- ejercicio 3
SELECT film_id, title, description FROM film
WHERE description LIKE '%robot%';

SELECT film_id, title, description FROM film_text
WHERE MATCH(title, description)
AGAINST('robot');

SHOW INDEX FROM film_text;

---- Los resultados pueden ser diferentes porque LIKE busca secuencias de caracteres, mientras que MATCH ... AGAINST 
-- utiliza reglas específicas de búsqueda por palabras.

