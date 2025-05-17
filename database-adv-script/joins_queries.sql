
-- 1st Query to retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.name AS property_name,
    p.location AS property_location
FROM 
    booking b
INNER JOIN 
    "user" u ON b.user_id = u.user_id
INNER JOIN
    property p ON b.property_id = p.property_id
ORDER BY 
    b.start_date;

-- 2nd Query to retrieve all properties and their reviews (including properties with no reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    h.user_id AS host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
LEFT JOIN 
    "user" h ON p.host_id = h.user_id
LEFT JOIN 
    "user" u ON r.user_id = u.user_id
ORDER BY 
    p.name,
    r.created_at DESC;

-- Query to retrieve all users and all bookings using FULL OUTER JOIN
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name AS property_name
FROM 
    "user" u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
ORDER BY 
    u.last_name,
    u.first_name,
    b.start_date;