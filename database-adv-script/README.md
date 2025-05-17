### Join Queries

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

