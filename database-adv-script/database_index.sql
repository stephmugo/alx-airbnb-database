-- User table indexes
CREATE INDEX idx_user_role ON "user" (role);
CREATE INDEX idx_user_created_at ON "user" (created_at);

-- Property table indexes
CREATE INDEX idx_property_host_id ON property (host_id);
CREATE INDEX idx_property_location ON property (location);
CREATE INDEX idx_property_price ON property (pricepernight);
CREATE INDEX idx_property_location_price ON property (location, pricepernight);

-- Booking table indexes
CREATE INDEX idx_booking_user_id ON booking (user_id);
CREATE INDEX idx_booking_status ON booking (status);
CREATE INDEX idx_booking_dates ON booking (start_date, end_date);
CREATE INDEX idx_booking_property_dates ON booking (property_id, start_date, end_date);