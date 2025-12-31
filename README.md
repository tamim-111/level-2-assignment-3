# B6A3: Vehicle rental system DB with ERD
### Introduction
This project implements a Vehicle Rental System database using PostgreSQL. It includes tables for users, vehicles, and bookings, with relationships modeled via an ERD. The system allows tracking of vehicle availability, customer bookings, and booking statuses.

### Links:

- Repository:
- ERD link:
- Viva video link:


### Query 1: JOIN

**Requirement:** Retrieve booking information along with Customer name and Vehicle name.

**Query:**

```sql
SELECT booking_id, u.name AS customer_name, v.name AS vehicle_name,
  start_date, end_date, b.status
FROM bookings b 
  JOIN users u ON b.user_id = u.user_id 
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

**Output**:
| booking_id | customer_name | vehicle_name   | start_date | end_date   | status    |
| :--------- | :------------ | :------------- | :--------- | :--------- | :-------- |
| 1          | Alice         | Honda Civic    | 2023-10-01 | 2023-10-05 | completed |
| 2          | Alice         | Honda Civic    | 2023-11-01 | 2023-11-03 | completed |
| 3          | Charlie       | Honda Civic    | 2023-12-01 | 2023-12-02 | confirmed |
| 4          | Alice         | Toyota Corolla | 2023-12-10 | 2023-12-12 | pending   |

---

### Query 2: EXISTS

**Requirement:** Find all vehicles that have never been booked.

**Query:**

```sql
SELECT * FROM vehicles v WHERE NOT EXISTS (
  SELECT * FROM bookings b WHERE b.vehicle_id = v.vehicle_id 
)
ORDER BY v.vehicle_id
```

**Output**:
| vehicle_id | name       | type  | model | registration_number | rental_price | status      |
| :--------- | :--------- | :---- | :---- | :------------------ | :----------- | :---------- |
| 3          | Yamaha R15 | bike  | 2023  | GHI-789             | 30           | available   |
| 4          | Ford F-150 | truck | 2020  | JKL-012             | 100          | maintenance |

---

### Query 3: WHERE

**Requirement:** Retrieve all available vehicles of a specific type (e.g. cars).

**Query:**

```sql
SELECT * FROM vehicles WHERE status = 'available' AND type = 'car';
```

**Expected Output**:
| vehicle_id | name           | type | model | registration_number | rental_price | status    |
| :--------- | :------------- | :--- | :---- | :------------------ | :----------- | :-------- |
| 1          | Toyota Corolla | car  | 2022  | ABC-123             | 50           | available |

---

### Query 4: GROUP BY and HAVING

**Requirement:** Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

**Query:**

```sql
SELECT v.name AS vehicle_name, COUNT(b.booking_id) AS total_bookings
FROM bookings b
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
```

**Expected Output**:
| vehicle_name | total_bookings |
| :----------- | :------------- |
| Honda Civic  | 3              |