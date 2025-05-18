-- Query to find all properties where average rating is greater thean 4.0
-- Using a non-correlated sub-query
SELECT p.*
FROM property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- Using a correlated sub-query
SELECT p.*
FROM property p
WHERE 4.0 < (
    SELECT AVG(r.rating)
    FROM review r
    WHERE r.property_id = p.property_id
);

-- Correlataed sub-query to find users who have made more than 3 bookings
SELECT u.*
FROM "user" u
WHERE (
    SELECT COUNT(*)
    FROM booking b
    WHERE b.user_id = u.user_id
) > 3;