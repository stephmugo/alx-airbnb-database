-- query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
sqlSELECT u.user_id, 
       u.first_name,
       u.last_name,
       u.email,
       COUNT(b.booking_id) AS total_bookings
FROM "user" u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC;

-- rank properties based on the total number of bookings they have received
SELECT p.property_id,
       p.name,
       p.location,
       COUNT(b.booking_id) AS booking_count,
       ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_rank,
       RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS standard_rank
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.location
ORDER BY booking_count DESC;