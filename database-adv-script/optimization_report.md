# Query Refactoring for Performance Improvement

## Initial Query Analysis

The initial query in `performance.sql` retrieves all booking details along with related user, property, host, and payment information. This query has several performance concerns:

1. **Multiple JOINs**: Four joins (three inner joins and one left join) which can be expensive
2. **Excessive Column Selection**: Selecting all columns from multiple tables
3. **Lack of Filtering**: No WHERE clause to limit the result set
4. **Sorting on Non-Indexed Column**: ORDER BY on booking.created_at without optimized index


## Refactored Query Strategy

### 1. Added Missing Indexes

```sql
-- Add missing indexes for JOIN operations
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON booking (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_property_host_id ON property (host_id);
```

### 2. Paginated Query Approach

```sql
-- Refactored query with pagination and filtering
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
    
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name
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
WHERE 
    b.created_at > CURRENT_DATE - INTERVAL '30 days'
ORDER BY 
    b.created_at DESC
LIMIT 100 OFFSET 0;
```

### 3. Query for Specific Booking Details (When Needed)

```sql
-- Targeted query for specific booking details
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
WHERE 
    b.booking_id = '00000000-0000-0000-0000-000000000000'::uuid;
```

## Performance Improvements

### Optimizations Implemented:

1. **Added Critical Indexes**:
   - Added index on `booking.created_at` for more efficient sorting
   - Added index on `property.host_id` to improve join performance

2. **Reduced Column Selection**:
   - Removed unnecessary columns like full descriptions from the main query
   - Kept only essential fields needed for display in the paginated view

3. **Added Filtering**:
   - Limited results to recent bookings (last 30 days)
   - Added LIMIT/OFFSET for pagination

4. **Split Query Strategy**:
   - Main query for listing bookings (paginated, fewer columns)
   - Detailed query for specific booking details (only when needed)

### Expected Performance Improvement

The refactored approach should show significant improvements:

1. **Query Processing Time**: Reduced by approximately 70-80% for the main listing query
2. **Memory Usage**: Decreased by limiting result sets and selecting fewer columns
3. **Database Load**: Distributed by implementing pagination
4. **Index Utilization**: Improved by adding targeted indexes for common operations

### Comparison (Hypothetical EXPLAIN)

**Before**:
- Cost: 987.38..994.10
- Sequential scans across multiple tables
- High memory usage for sorting and joining large datasets

**After**:
- Cost: 215.32..246.15 (estimated ~75% reduction)
- Index scans replacing sequential scans
- Reduced row count through filtering and pagination

## Implementation Recommendations

1. **Implement API Pagination**:
   - Frontend should request data in chunks
   - API endpoints should support pagination parameters

2. **Consider Materialized Views**:
   - For frequently accessed reporting data
   - Refresh on a schedule rather than calculating on demand

3. **Monitor Query Performance**:
   - Use pg_stat_statements to track query performance
   - Set up alerts for slow-running queries

4. **Further Optimizations**:
   - Consider partitioning the booking table by date for very large datasets
   - Implement connection pooling if experiencing connection bottlenecks
