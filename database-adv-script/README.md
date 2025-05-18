## Join Queries

### 1st Query: Description

This query retrieves all bookings with detailed information about the users who made those bookings and the properties that were booked.

### Key Features

- **INNER JOIN Relationship**: Links bookings with their respective users and properties
- **Essential Booking Information**: Includes dates, prices, and booking status
- **User Details**: Provides user identification and contact information
- **Property Context**: Adds property name and location for complete booking context
- **Chronological Order**: Results are sorted by booking start date

### 2nd query: Description
This query retrieves all properties along with their reviews, including properties without any reviews. It also includes information about the property hosts and the reviewers.

### Key Features
- **LEFT JOIN Relationships**: 
1st - Links properties and reviews. Ensuring to return Properties with no reviews
2nd - Connects to hosts (property owners)
3rd - Connects to reviewers (users who left reviews)
- **Property Information**: Includes name, description, price per night and location.
- **Review Details**: Includes rating, comment text and when the review was created.
- **User Context**:  Includes both the property host's information and the reviewer's name.
- **Ordering**: Results are sorted by property name first, then by review date (newest reviews first)

### 3rd Query: Desription
This query uses a FULL OUTER JOIN to retrieve all users and all bookings, including users with no bookings and bookings not linked to any user (which shouldn't exist in a well-maintained database, but the query would show them if they did).

### Key Features
- **FULL OUTER JOIN**: Between the user and booking tables. This returns:
    1.All users with matching bookings
    2.Users who have no bookings (booking columns will be NULL)
    3.Any bookings not linked to a user (user columns will be NULL)
- **Property Information**:LEFT JOIN to the property table to include the property name for each booking
- **Booking Details**: Includes booking Id, start & end date, total price and status.
- **Ordering**:Results are ordered by user's last name, first name, and then booking start date.

## Sub_Queries

### 1st Query :Non-correlated subquery

**Subquery**: Calculates the average rating for each property
**Ordering**: Groups the reviews by property_id
**Filter**: filters all properties with average rating  greater than 4

### 2nd Query: Correlated
**Subquery**:Calculates the average rating for each row in the properties table.References the outer query's current property (`r.property_id = p.property_id`)
**Filter**: Only properties where this average rating exceeds 4.0 are included in the results
The key difference from the previous is that this query evaluates the subquery once for each row in the property table, with the subquery directly referencing the outer query's property.

### 3rd Query: Correlated
Finds users who have made more than 3 bookings.The correlated approach evaluates the user and their booking count together, checking the condition for each user individually.

#### Features
- **Outer Query**: Selects from the `"user"` table  
  Retrieves all columns for each user who meets the condition

- **Correlated Subquery**: Counts bookings for the current user being evaluated  
  References the outer query's `u.user_id` to create the correlation  
  For each user row processed in the outer query, this subquery runs once

- **Filter**: Only includes users with more than 3 bookings  
  The `WHERE` clause compares the count result to 3  
  Only users with booking counts exceeding 3 are returned

- **Correlation**: The subquery depends on the outer query  
  The condition `b.user_id = u.user_id` connects the subquery to the current user row  
  This makes it a correlated subquery since it references values from the outer query

## Aggregations and Window Functions
### Query 1: Total Bookings by Each User
- **Selection**  
  Retrieves user identification details (ID, name, email)  
  Calculates total bookings using `COUNT()`

- **Table Join**  
  `LEFT JOIN` ensures all users are included, even those with zero bookings  
  Joining condition connects users to their respective bookings

- **Aggregation**  
  `GROUP BY` consolidates bookings by user  
  Includes user details in the grouping to maintain data integrity

- **Ordering**  
  Results sorted by booking count in descending order  
  Helps identify most active users first

### Query 2: Ranking Properties by Total Bookings
- **Selection**  
  Retrieves property details  
  Calculates booking count per property  
  Applies two different ranking methods

- **Window Functions**  
  `ROW_NUMBER()`: Assigns sequential numbers (1, 2, 3...) based on booking count  
  `RANK()`: Assigns ranks with ties getting the same rank (1, 1, 3...)  
  Both ordered by booking count (descending)

- **Table Join**  
  `LEFT JOIN` includes all properties regardless of booking status

- **Aggregation**  
  `GROUP BY` consolidates results at the property level  
  Counts the total bookings for each property

- **Comparison**  
  The two ranking methods demonstrate different approaches to ordering  
  `ROW_NUMBER()` ensures each row gets a unique ranking  
  `RANK()` preserves ties and skips ranks accordingly
