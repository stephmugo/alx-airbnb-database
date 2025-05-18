-- Create a partitioned version of the Booking table
CREATE TABLE booking_partitioned (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Create partitions by quarter (assuming 2 years of data)
CREATE TABLE booking_q1_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE booking_q2_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE booking_q3_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE booking_q4_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

CREATE TABLE booking_q1_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE booking_q2_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE booking_q3_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE booking_q4_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- Create a default partition for any data outside the specified ranges
CREATE TABLE booking_default PARTITION OF booking_partitioned DEFAULT;

-- Create foreign key constraints on individual partitions
-- Note: PostgreSQL doesn't allow foreign keys on partitioned tables directly
ALTER TABLE booking_q1_2024 ADD CONSTRAINT fk_booking_q1_2024_property
    FOREIGN KEY (property_id) REFERENCES property(property_id);
ALTER TABLE booking_q1_2024 ADD CONSTRAINT fk_booking_q1_2024_user
    FOREIGN KEY (user_id) REFERENCES "user"(user_id);

ALTER TABLE booking_q2_2024 ADD CONSTRAINT fk_booking_q2_2024_property
    FOREIGN KEY (property_id) REFERENCES property(property_id);
ALTER TABLE booking_q2_2024 ADD CONSTRAINT fk_booking_q2_2024_user
    FOREIGN KEY (user_id) REFERENCES "user"(user_id);



-- Create indexes on each partition
CREATE INDEX idx_booking_q1_2024_property_id ON booking_q1_2024(property_id);
CREATE INDEX idx_booking_q1_2024_user_id ON booking_q1_2024(user_id);
CREATE INDEX idx_booking_q1_2024_status ON booking_q1_2024(status);
CREATE INDEX idx_booking_q1_2024_dates ON booking_q1_2024(start_date, end_date);

CREATE INDEX idx_booking_q2_2024_property_id ON booking_q2_2024(property_id);
CREATE INDEX idx_booking_q2_2024_user_id ON booking_q2_2024(user_id);
CREATE INDEX idx_booking_q2_2024_status ON booking_q2_2024(status);
CREATE INDEX idx_booking_q2_2024_dates ON booking_q2_2024(start_date, end_date);

-- Migrate data from the original table to the partitioned table
INSERT INTO booking_partitioned
SELECT * FROM booking;

-- Analyze the tables for the query planner
ANALYZE booking_partitioned;
ANALYZE booking_q1_2024;
ANALYZE booking_q2_2024;
ANALYZE booking_q3_2024;
ANALYZE booking_q4_2024;
ANALYZE booking_q1_2025;
ANALYZE booking_q2_2025;
ANALYZE booking_q3_2025;
ANALYZE booking_q4_2025;
ANALYZE booking_default;

-- Test query performance - Sample query to test partition pruning
EXPLAIN ANALYZE
SELECT b.booking_id, b.property_id, b.user_id, b.start_date, b.end_date, b.total_price, b.status
FROM booking_partitioned b
WHERE b.start_date BETWEEN '2024-04-15' AND '2024-05-15';

-- Compare with original table performance
EXPLAIN ANALYZE
SELECT b.booking_id, b.property_id, b.user_id, b.start_date, b.end_date, b.total_price, b.status
FROM booking b
WHERE b.start_date BETWEEN '2024-04-15' AND '2024-05-15';

-- Test query for booking in a specific quarter
EXPLAIN ANALYZE
SELECT b.booking_id, b.property_id, b.user_id, p.name, p.location, 
       u.first_name, u.last_name, b.start_date, b.end_date, b.total_price
FROM booking_partitioned b
JOIN property p ON b.property_id = p.property_id
JOIN "user" u ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2024-07-01' AND '2024-09-30'
AND b.status = 'confirmed';

-- Test query across multiple quarters
EXPLAIN ANALYZE
SELECT COUNT(*), SUM(total_price)
FROM booking_partitioned
WHERE start_date BETWEEN '2024-03-01' AND '2024-08-31'
GROUP BY DATE_TRUNC('month', start_date);
