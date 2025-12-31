-- Query 1:
SELECT booking_id, u.name AS customer_name, v.name AS vehicle_name,
  start_date, end_date, b.status
FROM bookings b 
  JOIN users u ON b.user_id = u.user_id 
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2:
SELECT * FROM vehicles v WHERE NOT EXISTS (
  SELECT * FROM bookings b WHERE b.vehicle_id = v.vehicle_id 
)
ORDER BY v.vehicle_id

-- Query 3:
SELECT * FROM vehicles WHERE status = 'available' AND type = 'car';

-- Query 4:
SELECT v.name AS vehicle_name, COUNT(b.booking_id) AS total_bookings
FROM bookings b
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;