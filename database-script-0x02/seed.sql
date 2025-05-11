-- Insert sample data into User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '123-456-7890', 'guest', '2025-05-01 10:00:00'),
('550e8400-e29b-41d4-a716-446655440001', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '234-567-8901', 'host', '2025-05-01 11:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_3', '345-678-9012', 'guest', '2025-05-02 12:00:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Bob', 'Brown', 'bob.brown@example.com', 'hashed_password_4', '456-789-0123', 'host', '2025-05-02 13:00:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Davis', 'emma.davis@example.com', 'hashed_password_5', '567-890-1234', 'admin', '2025-05-03 14:00:00');

-- Insert sample data into Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('660e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'A cozy apartment in the heart of the city.', '123 Main St, New York, NY', 120.00, '2025-05-03 09:00:00', '2025-05-03 09:00:00'),
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Beachfront Villa', 'Luxurious villa with ocean views.', '456 Ocean Dr, Miami, FL', 250.00, '2025-05-03 10:00:00', '2025-05-03 10:00:00'),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'Mountain Cabin', 'Rustic cabin in the mountains.', '789 Pine Rd, Denver, CO', 150.00, '2025-05-04 11:00:00', '2025-05-04 11:00:00'),
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 'Urban Loft', 'Modern loft in a vibrant neighborhood.', '101 City Ave, Chicago, IL', 180.00, '2025-05-04 12:00:00', '2025-05-04 12:00:00');

-- Insert sample data into Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('770e8400-e29b-41d4-a716-446655440000', '660e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', '2025-06-01', '2025-06-03', 240.00, 'confirmed', '2025-05-05 08:00:00'),
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '2025-06-10', '2025-06-15', 1250.00, 'pending', '2025-05-05 09:00:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', '2025-07-01', '2025-07-04', 450.00, 'confirmed', '2025-05-06 10:00:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '2025-07-15', '2025-07-17', 360.00, 'canceled', '2025-05-06 11:00:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440002', '2025-08-01', '2025-08-05', 480.00, 'confirmed', '2025-05-07 12:00:00'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', '2025-08-10', '2025-08-12', 300.00, 'pending', '2025-05-07 13:00:00');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('880e8400-e29b-41d4-a716-446655440000', '770e8400-e29b-41d4-a716-446655440000', 240.00, '2025-05-05 08:30:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 625.00, '2025-05-05 09:30:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 450.00, '2025-05-06 10:30:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440004', 240.00, '2025-05-07 12:30:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 240.00, '2025-05-07 12:45:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 150.00, '2025-05-07 13:30:00', 'stripe');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('990e8400-e29b-41d4-a716-446655440000', '660e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', 4, 'Great location, very clean!', '2025-06-04 09:00:00'),
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', 5, 'Amazing cabin, perfect getaway.', '2025-07-05 10:00:00'),
('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440002', 3, 'Good stay, but parking was limited.', '2025-08-06 11:00:00'),
('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 5, 'Stunning views, highly recommend!', '2025-06-16 12:00:00');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('aa0e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'Is the apartment available for June 1-3?', '2025-05-04 08:00:00'),
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'Yes, it’s available. Please confirm your booking.', '2025-05-04 08:30:00'),
('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'Can I bring pets to the loft?', '2025-05-05 09:00:00'),
('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Sorry, no pets allowed in the loft.', '2025-05-05 09:30:00');