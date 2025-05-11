# Normalization Steps

---

## Step 1: Verify 1NF

### Check for Atomic Attributes:
- All attributes are atomic (e.g., `UUID`, `VARCHAR`, `DECIMAL`, `DATE`, `ENUM`).
- No multi-valued attributes or repeating groups (e.g., no lists of phone numbers).

### Primary Keys:
- Each table has a single-column primary key (e.g., `user_id`, `property_id`).

**✅ Result:** The schema is in **1NF**.

---

## Step 2: Verify 2NF

### Composite Keys:
- All tables have single-column primary keys (`UUID`s), so no composite keys exist.

### Partial Dependencies:
- Since there are no composite keys, partial dependencies are not applicable.

**✅ Result:** The schema is in **2NF** because all non-key attributes depend on the entire primary key.

---

## Step 3: Verify 3NF

### Transitive Dependencies:

#### User:
- All non-key attributes (`first_name`, `last_name`, `email`, etc.) depend on `user_id`.
- No transitive dependencies (e.g., `email` does not depend on `first_name`).

#### Property:
- Non-key attributes (`host_id`, `name`, `location`, etc.) depend on `property_id`.
- `host_id` is a foreign key, not a transitive dependency.

#### Booking:
- Non-key attributes (`property_id`, `user_id`, `total_price`, etc.) depend on `booking_id`.
- `total_price` is a snapshot (not derived from `Property.pricepernight`), so no transitive dependency.

#### Payment:
- Non-key attributes (`booking_id`, `amount`, etc.) depend on `payment_id`.
- `amount` is specific to the payment, not derived from `Booking.total_price`.

#### Review:
- Non-key attributes (`property_id`, `user_id`, `rating`, etc.) depend on `review_id`.
- No transitive dependencies.

#### Message:
- Non-key attributes (`sender_id`, `recipient_id`, `message_body`, etc.) depend on `message_id`.
- No transitive dependencies.

**✅ Result:** The schema is in **3NF**.
