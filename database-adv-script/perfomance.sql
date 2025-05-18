-- Initial Query for Getting All Booking Details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    "user" host ON p.host_id = host.user_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;

-- Analyze the query performance
EXPLAIN ANALYZE 
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at AS property_created_at,
    
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    "user" host ON p.host_id = host.user_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.created_at DESC;

