#  ERD Requirements

### Database Specification

#### Entities and Attributes
1. **User**
   - `user_id`: UUID, Primary Key, Indexed
   - `first_name`: VARCHAR, NOT NULL
   - `last_name`: VARCHAR, NOT NULL
   - `email`: VARCHAR, UNIQUE, NOT NULL
   - `password_hash`: VARCHAR, NOT NULL
   - `phone_number`: VARCHAR, NULL
   - `role`: ENUM (guest, host, admin), NOT NULL
   - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

2. **Property**
   - `property_id`: UUID, Primary Key, Indexed
   - `host_id`: UUID, Foreign Key (references `User(user_id)`)
   - `name`: VARCHAR, NOT NULL
   - `description`: TEXT, NOT NULL
   - `location`: VARCHAR, NOT NULL
   - `pricepernight`: DECIMAL, NOT NULL
   - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
   - `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

3. **Booking**
   - `booking_id`: UUID, Primary Key, Indexed
   - `property_id`: UUID, Foreign Key (references `Property(property_id)`)
   - `user_id`: UUID, Foreign Key (references `User(user_id)`)
   - `start_date`: DATE, NOT NULL
   - `end_date`: DATE, NOT NULL
   - `total_price`: DECIMAL, NOT NULL
   - `status`: ENUM (pending, confirmed, canceled), NOT NULL
   - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

4. **Payment**
   - `payment_id`: UUID, Primary Key, Indexed
   - `booking_id`: UUID, Foreign Key (references `Booking(booking_id)`)
   - `amount`: DECIMAL, NOT NULL
   - `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
   - `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

5. **Review**
   - `review_id`: UUID, Primary Key, Indexed
   - `property_id`: UUID, Foreign Key (references `Property(property_id)`)
   - `user_id`: UUID, Foreign Key (references `User(user_id)`)
   - `rating`: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL
   - `comment`: TEXT, NOT NULL
   - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

6. **Message**
   - `message_id`: UUID, Primary Key, Indexed
   - `sender_id`: UUID, Foreign Key (references `User(user_id)`)
   - `recipient_id`: UUID, Foreign Key (references `User(user_id)`)
   - `message_body`: TEXT, NOT NULL
   - `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### Constraints
- **User Table**:
  - Unique constraint on `email`.
  - Non-null constraints on `first_name`, `last_name`, `email`, `password_hash`, `role`.
- **Property Table**:
  - Foreign key constraint on `host_id` (references `User(user_id)`).
  - Non-null constraints on `name`, `description`, `location`, `pricepernight`.
- **Booking Table**:
  - Foreign key constraints on `property_id` (references `Property(property_id)`) and `user_id` (references `User(user_id)`).
  - `status` must be one of `pending`, `confirmed`, or `canceled`.
- **Payment Table**:
  - Foreign key constraint on `booking_id` (references `Booking(booking_id)`).
  - Non-null constraints on `amount`, `payment_method`.
- **Review Table**:
  - Foreign key constraints on `property_id` (references `Property(property_id)`) and `user_id` (references `User(user_id)`).
  - `rating` constrained to values between 1 and 5 (CHECK constraint).
- **Message Table**:
  - Foreign key constraints on `sender_id` and `recipient_id` (both reference `User(user_id)`).
  - Non-null constraint on `message_body`.

#### Indexing
- **Primary Keys**: Automatically indexed (`user_id`, `property_id`, `booking_id`, `payment_id`, `review_id`, `message_id`).
- **Additional Indexes**:
  - `email` in the `User` table.
  - `property_id` in the `Property` and `Booking` tables.
  - `booking_id` in the `Booking` and `Payment` tables.

#### Relationships
- **User to Property**: One-to-Many (a user can own multiple properties; a property has one host).
- **User to Booking**: One-to-Many (a user can make multiple bookings; a booking is made by one user).
- **Property to Booking**: One-to-Many (a property can have multiple bookings; a booking is for one property).
- **Booking to Payment**: One-to-Many (a booking can have multiple payments; a payment is for one booking).
- **User to Review**: One-to-Many (a user can write multiple reviews; a review is written by one user).
- **Property to Review**: One-to-Many (a property can have multiple reviews; a review is for one property).
- **User to Message (Sender)**: One-to-Many (a user can send multiple messages; a message has one sender).
- **User to Message (Recipient)**: One-to-Many (a user can receive multiple messages; a message has one recipient).

### Instructions
1. **Identify Entities and Attributes**:
   - List all entities (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) and their attributes as specified.
2. **Define Relationships**:
   - Specify the relationships between entities based on foreign key constraints (e.g., `User` to `Property` via `host_id`).
3. **Create ER Diagram**:
   - Use Draw.io or a similar tool to create a visual ER diagram.
   - Represent entities as rectangles, listing attributes with data types and constraints.
   - Use crow’s foot notation to depict relationships (e.g., one-to-many).
   - Indicate primary keys, foreign keys, and additional indexes.
   - Ensure constraints (e.g., UNIQUE, NOT NULL, CHECK, ENUM) are clearly noted.
4. **Export Diagram**:
   - Export the ER diagram as a PDF or PNG file named `erd_airbnb.pdf` or `erd_airbnb.png`.
5. **Repository Submission**:
   - Place the ER diagram file in the `ERD/` directory of the `alx-airbnb-database` GitHub repository.
   - Include this `requirements.md` file in the `ERD/` directory.
   - Commit and push the files to the repository.

### Deliverables
- **File**: `erd_airbnb.pdf` or `erd_airbnb.png` (ER diagram).
- **Repository Structure**: