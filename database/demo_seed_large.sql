-- =============================================================================
-- COOPERATIVE GIG SERVICES PLATFORM - COMPREHENSIVE PRODUCTION-SAFE DEMO SEED
-- =============================================================================
-- Target Database: MySQL 8.0+ / TiDB / AWS RDS / Render MySQL
-- Safe & Idempotent: Uses INSERT ... SELECT ... WHERE NOT EXISTS
-- Preserves existing production records without destruction or schema changes.
--
-- Dataset Statistics:
--  - Services: 10 Standardized Categories
--  - Customers: 30 Realistic Profiles (including Admin)
--  - Workers: 280 Qualified Artisans (28 per service across 16 Lucknow localities)
--  - Bookings: 120 Realistic Service Requests (PENDING, ACCEPTED, IN_PROGRESS, COMPLETED, CANCELLED)
--  - Disputes: 4 Contextual Disputes (3 RESOLVED, 1 OPEN)
--  - Notifications: 20 System & Booking Alerts
-- =============================================================================

-- =============================================================================
-- 1. SYNCHRONIZE 10 SERVICE CATEGORIES
-- =============================================================================
INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Plumbing', 'Pipe repair, leakage fixing, tap and sanitary fittings by certified plumbers.', '🔧', 249, 199, 150, 150, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Plumbing');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'AC Repair & Maintenance', 'AC servicing, gas leak checks, copper pipe flaring, and PCB diagnostics.', '❄️', 499, 299, 250, 200, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'AC Repair & Maintenance');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Electrical Services', 'Complete wiring, circuit breakers, MCB repair, and fixture installations.', '⚡', 199, 149, 150, 150, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Electrical Services');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Cleaning Services', 'Deep home sanitization, kitchen de-greasing, bathroom scrubbing & floor care.', '🧹', 399, 299, 150, 100, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Cleaning Services');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Carpenter', 'Custom woodwork, hinge fixing, lock replacements, and furniture repair.', '🪚', 349, 249, 180, 150, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Carpenter');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Painting', 'Interior room painting, texture finish, primer base, and waterproof putty.', '🎨', 599, 399, 200, 200, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Painting');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Mason / Construction', 'Skilled masonry, plastering, wall restoration, and floor tile fitting.', '🧱', 450, 300, 200, 150, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Mason / Construction');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Driver', 'Professional verified chauffeurs for local city transit and outstation travel.', '🚗', 350, 250, 120, 100, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Driver');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Cooking Services', 'Nutritious homestyle cooking, meal prep, and event catering.', '🍳', 350, 250, 150, 100, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Cooking Services');

INSERT INTO services (service_name, description, icon, base_price, minimum_charge, hourly_rate, emergency_fee, is_active, created_at)
SELECT 'Laundry', 'Washing, fabric care, steam pressing, and routine wardrobe assistance.', '🧺', 199, 149, 100, 100, 1, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE service_name = 'Laundry');

-- =============================================================================
-- 2. SEED REALISTIC CUSTOMERS (30 Accounts across Lucknow Localities)
-- =============================================================================
INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Federation Administrator', '9876543200', 'admin@sih.gov.in', '$2a$10$K0DCncYJT0XfpkX5Ogvv8eLkpsPHfINu19WXdBi5oaM9x499v5TrG', 'ADMIN', 'Lucknow HQ', 'Cooperative Federation Secretariat, Civil Lines, Lucknow', 26.85, 80.945, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'admin@sih.gov.in');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Aarav Sharma', '9876543212', 'customer@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Gomti Nagar, Lucknow', 'House #402, Sector 4, Gomti Nagar, Lucknow', 26.852, 80.998, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'customer@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Rohit Mehta', '9876510001', 'rohit.mehta@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Gomti Nagar, Lucknow', 'Plot #100, Vibhuti Khand, Gomti Nagar, Lucknow', 26.848, 80.99600000000001, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'rohit.mehta@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Sneha Patel', '9876510002', 'sneha.patel@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Indira Nagar, Lucknow', 'Plot #107, Sector 14, Indira Nagar, Lucknow', 26.881, 80.985, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'sneha.patel@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Vikram Singh', '9876510003', 'vikram.singh@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Aliganj, Lucknow', 'Plot #114, Sector B, Aliganj, Lucknow', 26.891, 80.94099999999999, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'vikram.singh@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Ananya Gupta', '9876510004', 'ananya.gupta@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Hazratganj, Lucknow', 'Plot #121, Park Road, Civil Lines, Hazratganj, Lucknow', 26.852, 80.943, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'ananya.gupta@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Manish Tiwari', '9876510005', 'manish.tiwari@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Mahanagar, Lucknow', 'Plot #128, Gole Market, Mahanagar, Lucknow', 26.876, 80.953, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'manish.tiwari@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Pooja Shukla', '9876510006', 'pooja.shukla@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Alambagh, Lucknow', 'Plot #135, VIP Road, Alambagh, Lucknow', 26.808, 80.90299999999999, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'pooja.shukla@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Rajat Mishra', '9876510007', 'rajat.mishra@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Ashiyana, Lucknow', 'Plot #142, Sector L, LDA Colony, Ashiyana, Lucknow', 26.789, 80.9, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'rajat.mishra@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Deepika Saxena', '9876510008', 'deepika.saxena@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Jankipuram, Lucknow', 'Plot #149, Sector F, Jankipuram Extension, Lucknow', 26.912, 80.945, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'deepika.saxena@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Siddharth Verma', '9876510009', 'siddharth.verma@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Vikas Nagar, Lucknow', 'Plot #156, Sector 8, Vikas Nagar, Lucknow', 26.9, 80.954, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'siddharth.verma@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Neha Dwivedi', '9876510010', 'neha.dwivedi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Rajajipuram, Lucknow', 'Plot #163, Block E, Rajajipuram, Lucknow', 26.855, 80.89, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'neha.dwivedi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Karan Malhotra', '9876510011', 'karan.malhotra@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Charbagh, Lucknow', 'Plot #170, Station Road, Charbagh, Lucknow', 26.828, 80.921, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'karan.malhotra@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Shreya Pandey', '9876510012', 'shreya.pandey@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Chowk, Lucknow', 'Plot #177, Victoria Street, Chowk, Lucknow', 26.866, 80.914, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'shreya.pandey@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Alok Tripathi', '9876510013', 'alok.tripathi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Krishna Nagar, Lucknow', 'Plot #184, Kanpur Road, Krishna Nagar, Lucknow', 26.798, 80.89, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'alok.tripathi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Ritu Agarwal', '9876510014', 'ritu.agarwal@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Sushant Golf City, Lucknow', 'Plot #191, Amar Shaheed Path, Sushant Golf City, Lucknow', 26.784, 81.002, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'ritu.agarwal@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Gaurav Rastogi', '9876510015', 'gaurav.rastogi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Telibagh, Lucknow', 'Plot #198, Raebareli Road, Telibagh, Lucknow', 26.796000000000003, 80.94, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'gaurav.rastogi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Divya Tandon', '9876510016', 'divya.tandon@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Kalyanpur, Lucknow', 'Plot #205, Ring Road, Kalyanpur, Lucknow', 26.910999999999998, 80.97, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'divya.tandon@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Mohit Awasthi', '9876510017', 'mohit.awasthi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Gomti Nagar, Lucknow', 'Plot #212, Vibhuti Khand, Gomti Nagar, Lucknow', 26.85, 80.998, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'mohit.awasthi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Shalini Joshi', '9876510018', 'shalini.joshi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Indira Nagar, Lucknow', 'Plot #219, Sector 14, Indira Nagar, Lucknow', 26.883, 80.987, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'shalini.joshi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Aditya Dubey', '9876510019', 'aditya.dubey@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Aliganj, Lucknow', 'Plot #226, Sector B, Aliganj, Lucknow', 26.892999999999997, 80.937, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'aditya.dubey@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Meera Kapoor', '9876510020', 'meera.kapoor@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Hazratganj, Lucknow', 'Plot #233, Park Road, Civil Lines, Hazratganj, Lucknow', 26.854000000000003, 80.945, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'meera.kapoor@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Vikas Chaturvedi', '9876510021', 'vikas.chaturvedi@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Mahanagar, Lucknow', 'Plot #240, Gole Market, Mahanagar, Lucknow', 26.868, 80.955, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'vikas.chaturvedi@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Kunal Bhardwaj', '9876510022', 'kunal.bhardwaj@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Alambagh, Lucknow', 'Plot #247, VIP Road, Alambagh, Lucknow', 26.810000000000002, 80.899, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'kunal.bhardwaj@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Swati Gautam', '9876510023', 'swati.gautam@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Ashiyana, Lucknow', 'Plot #254, Sector L, LDA Colony, Ashiyana, Lucknow', 26.791, 80.902, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'swati.gautam@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Pawan Sahu', '9876510024', 'pawan.sahu@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Jankipuram, Lucknow', 'Plot #261, Sector F, Jankipuram Extension, Lucknow', 26.913999999999998, 80.94699999999999, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'pawan.sahu@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Nitin Jaiswal', '9876510025', 'nitin.jaiswal@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Vikas Nagar, Lucknow', 'Plot #268, Sector 8, Vikas Nagar, Lucknow', 26.902, 80.95, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'nitin.jaiswal@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Preeti Upadhyay', '9876510026', 'preeti.upadhyay@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Rajajipuram, Lucknow', 'Plot #275, Block E, Rajajipuram, Lucknow', 26.846999999999998, 80.892, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'preeti.upadhyay@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Saurabh Nigam', '9876510027', 'saurabh.nigam@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Charbagh, Lucknow', 'Plot #282, Station Road, Charbagh, Lucknow', 26.830000000000002, 80.923, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'saurabh.nigam@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Anjali Sonkar', '9876510028', 'anjali.sonkar@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Chowk, Lucknow', 'Plot #289, Victoria Street, Chowk, Lucknow', 26.868, 80.91000000000001, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'anjali.sonkar@example.com');

INSERT INTO customers (full_name, phone, email, password, role, location, address, latitude, longitude, created_at)
SELECT 'Jitendra Kashyap', '9876510029', 'jitendra.kashyap@example.com', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'CUSTOMER', 'Krishna Nagar, Lucknow', 'Plot #296, Kanpur Road, Krishna Nagar, Lucknow', 26.799999999999997, 80.892, '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE email = 'jitendra.kashyap@example.com');

-- =============================================================================
-- 3. SEED 280 QUALIFIED WORKERS (28 Workers per Service Category)
-- =============================================================================
INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manoj Rathore', '9876500001', 'manoj.rathore.plumbing1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 5,
  'Indira Nagar, Lucknow', 26.8800, 80.9835, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 5 years of trusted field experience in Indira Nagar.', 4.9,
  23, 39, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manoj.rathore.plumbing1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suresh Prajapati', '9876500002', 'suresh.prajapati.plumbing2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 8,
  'Aliganj, Lucknow', 26.8895, 80.9390, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 8 years of trusted field experience in Aliganj.', 4.7,
  36, 63, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suresh.prajapati.plumbing2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arvind Paswan', '9876500003', 'arvind.paswan.plumbing3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 11,
  'Hazratganj, Lucknow', 26.8500, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 11 years of trusted field experience in Hazratganj.', 4.5,
  49, 87, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arvind.paswan.plumbing3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Divya Saxena', '9876500004', 'divya.saxena.plumbing4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 14,
  'Mahanagar, Lucknow', 26.8735, 80.9560, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 14 years of trusted field experience in Mahanagar.', 4.3,
  62, 111, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'divya.saxena.plumbing4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Satish Joshi', '9876500005', 'satish.joshi.plumbing5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 17,
  'Alambagh, Lucknow', 26.8150, 80.8980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 17 years of trusted field experience in Alambagh.', 5,
  75, 85, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'satish.joshi.plumbing5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Santosh Chaturvedi', '9876500006', 'santosh.chaturvedi.plumbing6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 3,
  'Ashiyana, Lucknow', 26.7955, 80.9005, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 3 years of trusted field experience in Ashiyana.', 4.8,
  13, 34, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'santosh.chaturvedi.plumbing6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vishal Sonkar', '9876500007', 'vishal.sonkar.plumbing7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 6,
  'Jankipuram, Lucknow', 26.9075, 80.9450, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 6 years of trusted field experience in Jankipuram.', 4.6,
  26, 58, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vishal.sonkar.plumbing7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Maya Tiwari', '9876500008', 'maya.tiwari.plumbing8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 9,
  'Vikas Nagar, Lucknow', 26.8950, 80.9535, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 9 years of trusted field experience in Vikas Nagar.', 4.4,
  39, 82, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'maya.tiwari.plumbing8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manish Maurya', '9876500009', 'manish.maurya.plumbing9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 12,
  'Rajajipuram, Lucknow', 26.8495, 80.8950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 12 years of trusted field experience in Rajajipuram.', 4.2,
  52, 106, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manish.maurya.plumbing9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kamlesh Bind', '9876500010', 'kamlesh.bind.plumbing10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 15,
  'Charbagh, Lucknow', 26.8320, 80.9180, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 15 years of trusted field experience in Charbagh.', 4.9,
  65, 80, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kamlesh.bind.plumbing10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Omkar Shukla', '9876500011', 'omkar.shukla.plumbing11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 18,
  'Chowk, Lucknow', 26.8695, 80.9105, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 18 years of trusted field experience in Chowk.', 4.7,
  78, 104, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'omkar.shukla.plumbing11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rashmi Rastogi', '9876500012', 'rashmi.rastogi.plumbing12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 4,
  'Krishna Nagar, Lucknow', 26.8010, 80.8920, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 4 years of trusted field experience in Krishna Nagar.', 4.5,
  16, 53, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rashmi.rastogi.plumbing12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manohar Dixit', '9876500013', 'manohar.dixit.plumbing13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 7,
  'Sushant Golf City, Lucknow', 26.7865, 81.0035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 7 years of trusted field experience in Sushant Golf City.', 4.3,
  29, 77, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manohar.dixit.plumbing13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajesh Nigam', '9876500014', 'rajesh.nigam.plumbing14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 10,
  'Telibagh, Lucknow', 26.7875, 80.9410, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 10 years of trusted field experience in Telibagh.', 5,
  42, 51, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajesh.nigam.plumbing14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manoj Sharma', '9876500015', 'manoj.sharma.plumbing15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 13,
  'Kalyanpur, Lucknow', 26.9120, 80.9690, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 13 years of trusted field experience in Kalyanpur.', 4.8,
  55, 75, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manoj.sharma.plumbing15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepika Arif', '9876500016', 'deepika.arif.plumbing16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 16,
  'Gomti Nagar, Lucknow', 26.8505, 80.9965, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 16 years of trusted field experience in Gomti Nagar.', 4.6,
  68, 99, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepika.arif.plumbing16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arvind Srivastava', '9876500017', 'arvind.srivastava.plumbing17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 2,
  'Indira Nagar, Lucknow', 26.8830, 80.9850, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 2 years of trusted field experience in Indira Nagar.', 4.4,
  81, 123, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arvind.srivastava.plumbing17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Nitin Singh', '9876500018', 'nitin.singh.plumbing18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 5,
  'Aliganj, Lucknow', 26.8925, 80.9405, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 5 years of trusted field experience in Aliganj.', 4.2,
  19, 72, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'nitin.singh.plumbing18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Satish Agarwal', '9876500019', 'satish.agarwal.plumbing19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 8,
  'Hazratganj, Lucknow', 26.8530, 80.9480, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 8 years of trusted field experience in Hazratganj.', 4.9,
  32, 46, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'satish.agarwal.plumbing19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kiran Dubey', '9876500020', 'kiran.dubey.plumbing20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 11,
  'Mahanagar, Lucknow', 26.8765, 80.9500, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 11 years of trusted field experience in Mahanagar.', 4.7,
  45, 70, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kiran.dubey.plumbing20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vishal Upadhyay', '9876500021', 'vishal.upadhyay.plumbing21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 14,
  'Alambagh, Lucknow', 26.8075, 80.8995, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 14 years of trusted field experience in Alambagh.', 4.5,
  58, 94, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vishal.upadhyay.plumbing21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ravi Soni', '9876500022', 'ravi.soni.plumbing22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 17,
  'Ashiyana, Lucknow', 26.7880, 80.9020, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 17 years of trusted field experience in Ashiyana.', 4.3,
  71, 118, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ravi.soni.plumbing22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manish Devi', '9876500023', 'manish.devi.plumbing23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 3,
  'Jankipuram, Lucknow', 26.9105, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 3 years of trusted field experience in Jankipuram.', 5,
  84, 92, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manish.devi.plumbing23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sadhana Kashyap', '9876500024', 'sadhana.kashyap.plumbing24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 6,
  'Vikas Nagar, Lucknow', 26.8980, 80.9550, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 6 years of trusted field experience in Vikas Nagar.', 4.8,
  22, 41, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sadhana.kashyap.plumbing24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Omkar Patel', '9876500025', 'omkar.patel.plumbing25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 9,
  'Rajajipuram, Lucknow', 26.8525, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 9 years of trusted field experience in Rajajipuram.', 4.6,
  35, 65, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'omkar.patel.plumbing25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Hemant Tripathi', '9876500026', 'hemant.tripathi.plumbing26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 12,
  'Charbagh, Lucknow', 26.8350, 80.9195, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 12 years of trusted field experience in Charbagh.', 4.4,
  48, 89, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'hemant.tripathi.plumbing26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manohar Nayan', '9876500027', 'manohar.nayan.plumbing27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 15,
  'Chowk, Lucknow', 26.8725, 80.9120, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 15 years of trusted field experience in Chowk.', 4.2,
  61, 113, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manohar.nayan.plumbing27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Geeta Jaiswal', '9876500028', 'geeta.jaiswal.plumbing28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Plumbing', 18,
  'Krishna Nagar, Lucknow', 26.7935, 80.8935, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Certified master plumbing professional specialized in pipeline installations, leak detection, and sanitary fittings. Over 18 years of trusted field experience in Krishna Nagar.', 4.9,
  74, 87, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'geeta.jaiswal.plumbing28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunil Soni', '9876500029', 'sunil.soni.acrepairmaintenance1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 4,
  'Gomti Nagar, Lucknow', 26.8490, 81.0010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 4 years of trusted field experience in Gomti Nagar.', 4.7,
  12, 36, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunil.soni.acrepairmaintenance1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dharmendra Devi', '9876500030', 'dharmendra.devi.acrepairmaintenance2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 7,
  'Indira Nagar, Lucknow', 26.8815, 80.9820, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 7 years of trusted field experience in Indira Nagar.', 4.5,
  25, 60, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dharmendra.devi.acrepairmaintenance2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ajay Kashyap', '9876500031', 'ajay.kashyap.acrepairmaintenance3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 10,
  'Aliganj, Lucknow', 26.8910, 80.9375, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 10 years of trusted field experience in Aliganj.', 4.3,
  38, 84, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ajay.kashyap.acrepairmaintenance3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radha Patel', '9876500032', 'radha.patel.acrepairmaintenance4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 13,
  'Hazratganj, Lucknow', 26.8515, 80.9450, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 13 years of trusted field experience in Hazratganj.', 5,
  51, 58, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radha.patel.acrepairmaintenance4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Harish Tripathi', '9876500033', 'harish.tripathi.acrepairmaintenance5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 16,
  'Mahanagar, Lucknow', 26.8750, 80.9545, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 16 years of trusted field experience in Mahanagar.', 4.8,
  64, 82, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'harish.tripathi.acrepairmaintenance5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radheshyam Nayan', '9876500034', 'radheshyam.nayan.acrepairmaintenance6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 2,
  'Alambagh, Lucknow', 26.8165, 80.9040, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 2 years of trusted field experience in Alambagh.', 4.6,
  77, 106, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radheshyam.nayan.acrepairmaintenance6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vinod Jaiswal', '9876500035', 'vinod.jaiswal.acrepairmaintenance7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 5,
  'Ashiyana, Lucknow', 26.7865, 80.8990, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 5 years of trusted field experience in Ashiyana.', 4.4,
  15, 55, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vinod.jaiswal.acrepairmaintenance7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rani Gupta', '9876500036', 'rani.gupta.acrepairmaintenance8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 8,
  'Jankipuram, Lucknow', 26.9090, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 8 years of trusted field experience in Jankipuram.', 4.2,
  28, 79, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rani.gupta.acrepairmaintenance8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikas Vishwakarma', '9876500037', 'vikas.vishwakarma.acrepairmaintenance9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 11,
  'Vikas Nagar, Lucknow', 26.8965, 80.9520, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 11 years of trusted field experience in Vikas Nagar.', 4.9,
  41, 53, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikas.vishwakarma.acrepairmaintenance9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kishore Pal', '9876500038', 'kishore.pal.acrepairmaintenance10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 14,
  'Rajajipuram, Lucknow', 26.8510, 80.8935, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 14 years of trusted field experience in Rajajipuram.', 4.7,
  54, 77, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kishore.pal.acrepairmaintenance10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Prashant Mehta', '9876500039', 'prashant.mehta.acrepairmaintenance11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 17,
  'Charbagh, Lucknow', 26.8335, 80.9240, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 17 years of trusted field experience in Charbagh.', 4.5,
  67, 101, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'prashant.mehta.acrepairmaintenance11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunita Pandey', '9876500040', 'sunita.pandey.acrepairmaintenance12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 3,
  'Chowk, Lucknow', 26.8710, 80.9090, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 3 years of trusted field experience in Chowk.', 4.3,
  80, 125, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunita.pandey.acrepairmaintenance12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Devendra Kushwaha', '9876500041', 'devendra.kushwaha.acrepairmaintenance13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 6,
  'Krishna Nagar, Lucknow', 26.8025, 80.8905, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 6 years of trusted field experience in Krishna Nagar.', 5,
  18, 24, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'devendra.kushwaha.acrepairmaintenance13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Amit Sahu', '9876500042', 'amit.sahu.acrepairmaintenance14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 9,
  'Sushant Golf City, Lucknow', 26.7775, 81.0020, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 9 years of trusted field experience in Sushant Golf City.', 4.8,
  31, 48, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'amit.sahu.acrepairmaintenance14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunil Yadav', '9876500043', 'sunil.yadav.acrepairmaintenance15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 12,
  'Telibagh, Lucknow', 26.7890, 80.9395, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 12 years of trusted field experience in Telibagh.', 4.6,
  44, 72, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunil.yadav.acrepairmaintenance15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Meera Mishra', '9876500044', 'meera.mishra.acrepairmaintenance16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 15,
  'Kalyanpur, Lucknow', 26.9135, 80.9750, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 15 years of trusted field experience in Kalyanpur.', 4.4,
  57, 96, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'meera.mishra.acrepairmaintenance16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ajay Rawat', '9876500045', 'ajay.rawat.acrepairmaintenance17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 18,
  'Gomti Nagar, Lucknow', 26.8520, 80.9950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 18 years of trusted field experience in Gomti Nagar.', 4.2,
  70, 120, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ajay.rawat.acrepairmaintenance17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Alok Kanojia', '9876500046', 'alok.kanojia.acrepairmaintenance18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 4,
  'Indira Nagar, Lucknow', 26.8845, 80.9835, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 4 years of trusted field experience in Indira Nagar.', 4.9,
  83, 94, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'alok.kanojia.acrepairmaintenance18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Harish Malhotra', '9876500047', 'harish.malhotra.acrepairmaintenance19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 7,
  'Aliganj, Lucknow', 26.8940, 80.9390, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 7 years of trusted field experience in Aliganj.', 4.7,
  21, 43, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'harish.malhotra.acrepairmaintenance19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Usha Awasthi', '9876500048', 'usha.awasthi.acrepairmaintenance20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 10,
  'Hazratganj, Lucknow', 26.8545, 80.9465, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 10 years of trusted field experience in Hazratganj.', 4.5,
  34, 67, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'usha.awasthi.acrepairmaintenance20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vinod Gautam', '9876500049', 'vinod.gautam.acrepairmaintenance21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 13,
  'Mahanagar, Lucknow', 26.8675, 80.9560, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 13 years of trusted field experience in Mahanagar.', 4.3,
  47, 91, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vinod.gautam.acrepairmaintenance21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pawan Verma', '9876500050', 'pawan.verma.acrepairmaintenance22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 16,
  'Alambagh, Lucknow', 26.8090, 80.8980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 16 years of trusted field experience in Alambagh.', 5,
  60, 65, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pawan.verma.acrepairmaintenance22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikas Chauhan', '9876500051', 'vikas.chauhan.acrepairmaintenance23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 2,
  'Ashiyana, Lucknow', 26.7895, 80.9005, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 2 years of trusted field experience in Ashiyana.', 4.8,
  73, 89, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikas.chauhan.acrepairmaintenance23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jyoti Khan', '9876500052', 'jyoti.khan.acrepairmaintenance24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 5,
  'Jankipuram, Lucknow', 26.9120, 80.9450, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 5 years of trusted field experience in Jankipuram.', 4.6,
  11, 38, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jyoti.khan.acrepairmaintenance24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Prashant Chaurasia', '9876500053', 'prashant.chaurasia.acrepairmaintenance25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 8,
  'Vikas Nagar, Lucknow', 26.8995, 80.9535, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 8 years of trusted field experience in Vikas Nagar.', 4.4,
  24, 62, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'prashant.chaurasia.acrepairmaintenance25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ashok Dwivedi', '9876500054', 'ashok.dwivedi.acrepairmaintenance26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 11,
  'Rajajipuram, Lucknow', 26.8540, 80.8950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 11 years of trusted field experience in Rajajipuram.', 4.2,
  37, 86, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ashok.dwivedi.acrepairmaintenance26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Devendra Tandon', '9876500055', 'devendra.tandon.acrepairmaintenance27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 14,
  'Charbagh, Lucknow', 26.8365, 80.9180, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 14 years of trusted field experience in Charbagh.', 4.9,
  50, 60, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'devendra.tandon.acrepairmaintenance27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neha Bhardwaj', '9876500056', 'neha.bhardwaj.acrepairmaintenance28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'AC Repair & Maintenance', 17,
  'Chowk, Lucknow', 26.8635, 80.9105, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'HVAC technician specialized in split/inverter AC servicing, copper pipe flaring, coil chemical wash, and diagnostics. Over 17 years of trusted field experience in Chowk.', 4.7,
  63, 84, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neha.bhardwaj.acrepairmaintenance28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikram Verma', '9876500057', 'vikram.verma.electricalservices1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 3,
  'Kalyanpur, Lucknow', 26.9120, 80.9720, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 3 years of trusted field experience in Kalyanpur.', 4.5,
  76, 108, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikram.verma.electricalservices1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Imran Chauhan', '9876500058', 'imran.chauhan.electricalservices2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 6,
  'Gomti Nagar, Lucknow', 26.8505, 80.9995, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 6 years of trusted field experience in Gomti Nagar.', 4.3,
  14, 57, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'imran.chauhan.electricalservices2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pankaj Khan', '9876500059', 'pankaj.khan.electricalservices3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 9,
  'Indira Nagar, Lucknow', 26.8830, 80.9880, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 9 years of trusted field experience in Indira Nagar.', 5,
  27, 81, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pankaj.khan.electricalservices3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vandana Chaurasia', '9876500060', 'vandana.chaurasia.electricalservices4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 12,
  'Aliganj, Lucknow', 26.8925, 80.9360, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 12 years of trusted field experience in Aliganj.', 4.8,
  40, 55, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vandana.chaurasia.electricalservices4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dinesh Dwivedi', '9876500061', 'dinesh.dwivedi.electricalservices5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 15,
  'Hazratganj, Lucknow', 26.8530, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 15 years of trusted field experience in Hazratganj.', 4.6,
  53, 79, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dinesh.dwivedi.electricalservices5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pradeep Tandon', '9876500062', 'pradeep.tandon.electricalservices6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 18,
  'Mahanagar, Lucknow', 26.8765, 80.9530, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 18 years of trusted field experience in Mahanagar.', 4.4,
  66, 103, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pradeep.tandon.electricalservices6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arun Bhardwaj', '9876500063', 'arun.bhardwaj.electricalservices7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 4,
  'Alambagh, Lucknow', 26.8075, 80.9025, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 4 years of trusted field experience in Alambagh.', 4.2,
  79, 127, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arun.bhardwaj.electricalservices7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Reena Kumar', '9876500064', 'reena.kumar.electricalservices8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 7,
  'Ashiyana, Lucknow', 26.7880, 80.9050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 7 years of trusted field experience in Ashiyana.', 4.9,
  17, 26, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'reena.kumar.electricalservices8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rahul Rathore', '9876500065', 'rahul.rathore.electricalservices9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 10,
  'Jankipuram, Lucknow', 26.9105, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 10 years of trusted field experience in Jankipuram.', 4.7,
  30, 50, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rahul.rathore.electricalservices9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Lalit Prajapati', '9876500066', 'lalit.prajapati.electricalservices10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 13,
  'Vikas Nagar, Lucknow', 26.8980, 80.9505, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 13 years of trusted field experience in Vikas Nagar.', 4.5,
  43, 74, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'lalit.prajapati.electricalservices10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajan Paswan', '9876500067', 'rajan.paswan.electricalservices11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 16,
  'Rajajipuram, Lucknow', 26.8525, 80.8920, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 16 years of trusted field experience in Rajajipuram.', 4.3,
  56, 98, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajan.paswan.electricalservices11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sneha Saxena', '9876500068', 'sneha.saxena.electricalservices12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 2,
  'Charbagh, Lucknow', 26.8350, 80.9225, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 2 years of trusted field experience in Charbagh.', 5,
  69, 122, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sneha.saxena.electricalservices12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kuldeep Joshi', '9876500069', 'kuldeep.joshi.electricalservices13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 5,
  'Chowk, Lucknow', 26.8725, 80.9150, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 5 years of trusted field experience in Chowk.', 4.8,
  82, 96, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kuldeep.joshi.electricalservices13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sanjay Chaturvedi', '9876500070', 'sanjay.chaturvedi.electricalservices14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 8,
  'Krishna Nagar, Lucknow', 26.7935, 80.8890, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 8 years of trusted field experience in Krishna Nagar.', 4.6,
  20, 45, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sanjay.chaturvedi.electricalservices14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikram Sonkar', '9876500071', 'vikram.sonkar.electricalservices15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 11,
  'Sushant Golf City, Lucknow', 26.7790, 81.0005, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 11 years of trusted field experience in Sushant Golf City.', 4.4,
  33, 69, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikram.sonkar.electricalservices15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pushpa Tiwari', '9876500072', 'pushpa.tiwari.electricalservices16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 14,
  'Telibagh, Lucknow', 26.7905, 80.9380, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 14 years of trusted field experience in Telibagh.', 4.2,
  46, 93, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pushpa.tiwari.electricalservices16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pankaj Maurya', '9876500073', 'pankaj.maurya.electricalservices17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 17,
  'Kalyanpur, Lucknow', 26.9150, 80.9735, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 17 years of trusted field experience in Kalyanpur.', 4.9,
  59, 67, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pankaj.maurya.electricalservices17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Gaurav Bind', '9876500074', 'gaurav.bind.electricalservices18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 3,
  'Gomti Nagar, Lucknow', 26.8535, 81.0010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 3 years of trusted field experience in Gomti Nagar.', 4.7,
  72, 91, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'gaurav.bind.electricalservices18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dinesh Shukla', '9876500075', 'dinesh.shukla.electricalservices19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 6,
  'Indira Nagar, Lucknow', 26.8860, 80.9820, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 6 years of trusted field experience in Indira Nagar.', 4.5,
  10, 40, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dinesh.shukla.electricalservices19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Komal Rastogi', '9876500076', 'komal.rastogi.electricalservices20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 9,
  'Aliganj, Lucknow', 26.8955, 80.9375, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 9 years of trusted field experience in Aliganj.', 4.3,
  23, 64, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'komal.rastogi.electricalservices20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arun Dixit', '9876500077', 'arun.dixit.electricalservices21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 12,
  'Hazratganj, Lucknow', 26.8455, 80.9450, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 12 years of trusted field experience in Hazratganj.', 5,
  36, 88, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arun.dixit.electricalservices21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jagdish Nigam', '9876500078', 'jagdish.nigam.electricalservices22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 15,
  'Mahanagar, Lucknow', 26.8690, 80.9545, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 15 years of trusted field experience in Mahanagar.', 4.8,
  49, 62, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jagdish.nigam.electricalservices22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rahul Sharma', '9876500079', 'rahul.sharma.electricalservices23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 18,
  'Alambagh, Lucknow', 26.8105, 80.9040, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 18 years of trusted field experience in Alambagh.', 4.6,
  62, 86, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rahul.sharma.electricalservices23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pooja Arif', '9876500080', 'pooja.arif.electricalservices24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 4,
  'Ashiyana, Lucknow', 26.7910, 80.8990, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 4 years of trusted field experience in Ashiyana.', 4.4,
  75, 110, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pooja.arif.electricalservices24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajan Srivastava', '9876500081', 'rajan.srivastava.electricalservices25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 7,
  'Jankipuram, Lucknow', 26.9135, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 7 years of trusted field experience in Jankipuram.', 4.2,
  13, 59, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajan.srivastava.electricalservices25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kunal Singh', '9876500082', 'kunal.singh.electricalservices26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 10,
  'Vikas Nagar, Lucknow', 26.9010, 80.9520, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 10 years of trusted field experience in Vikas Nagar.', 4.9,
  26, 33, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kunal.singh.electricalservices26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kuldeep Agarwal', '9876500083', 'kuldeep.agarwal.electricalservices27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 13,
  'Rajajipuram, Lucknow', 26.8555, 80.8935, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 13 years of trusted field experience in Rajajipuram.', 4.7,
  39, 57, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kuldeep.agarwal.electricalservices27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suman Dubey', '9876500084', 'suman.dubey.electricalservices28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Electrical Services', 16,
  'Charbagh, Lucknow', 26.8275, 80.9240, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Licensed wireman skilled in residential circuit breakers, MCB repair, distribution panels, and lighting wiring. Over 16 years of trusted field experience in Charbagh.', 4.5,
  52, 81, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suman.dubey.electricalservices28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pushpa Nigam', '9876500085', 'pushpa.nigam.cleaningservices1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 2,
  'Telibagh, Lucknow', 26.7890, 80.9350, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 2 years of trusted field experience in Telibagh.', 4.3,
  65, 105, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pushpa.nigam.cleaningservices1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Aarti Sharma', '9876500086', 'aarti.sharma.cleaningservices2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 5,
  'Kalyanpur, Lucknow', 26.9135, 80.9705, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 5 years of trusted field experience in Kalyanpur.', 5,
  78, 129, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'aarti.sharma.cleaningservices2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Maya Arif', '9876500087', 'maya.arif.cleaningservices3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 8,
  'Gomti Nagar, Lucknow', 26.8520, 80.9980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 8 years of trusted field experience in Gomti Nagar.', 4.8,
  16, 28, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'maya.arif.cleaningservices3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manju Srivastava', '9876500088', 'manju.srivastava.cleaningservices4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 11,
  'Indira Nagar, Lucknow', 26.8845, 80.9865, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 11 years of trusted field experience in Indira Nagar.', 4.6,
  29, 52, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manju.srivastava.cleaningservices4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Komal Singh', '9876500089', 'komal.singh.cleaningservices5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 14,
  'Aliganj, Lucknow', 26.8940, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 14 years of trusted field experience in Aliganj.', 4.4,
  42, 76, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'komal.singh.cleaningservices5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Mamta Agarwal', '9876500090', 'mamta.agarwal.cleaningservices6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 17,
  'Hazratganj, Lucknow', 26.8545, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 17 years of trusted field experience in Hazratganj.', 4.2,
  55, 100, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'mamta.agarwal.cleaningservices6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rashmi Dubey', '9876500091', 'rashmi.dubey.cleaningservices7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 3,
  'Mahanagar, Lucknow', 26.8675, 80.9515, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 3 years of trusted field experience in Mahanagar.', 4.9,
  68, 74, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rashmi.dubey.cleaningservices7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Archana Upadhyay', '9876500092', 'archana.upadhyay.cleaningservices8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 6,
  'Alambagh, Lucknow', 26.8090, 80.9010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 6 years of trusted field experience in Alambagh.', 4.7,
  81, 98, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'archana.upadhyay.cleaningservices8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pooja Soni', '9876500093', 'pooja.soni.cleaningservices9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 9,
  'Ashiyana, Lucknow', 26.7895, 80.9035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 9 years of trusted field experience in Ashiyana.', 4.5,
  19, 47, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pooja.soni.cleaningservices9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rekha Devi', '9876500094', 'rekha.devi.cleaningservices10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 12,
  'Jankipuram, Lucknow', 26.9120, 80.9480, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 12 years of trusted field experience in Jankipuram.', 4.3,
  32, 71, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rekha.devi.cleaningservices10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepika Kashyap', '9876500095', 'deepika.kashyap.cleaningservices11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 15,
  'Vikas Nagar, Lucknow', 26.8995, 80.9490, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 15 years of trusted field experience in Vikas Nagar.', 5,
  45, 95, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepika.kashyap.cleaningservices11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ritu Patel', '9876500096', 'ritu.patel.cleaningservices12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 18,
  'Rajajipuram, Lucknow', 26.8540, 80.8905, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 18 years of trusted field experience in Rajajipuram.', 4.8,
  58, 69, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ritu.patel.cleaningservices12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suman Tripathi', '9876500097', 'suman.tripathi.cleaningservices13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 4,
  'Charbagh, Lucknow', 26.8365, 80.9210, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 4 years of trusted field experience in Charbagh.', 4.6,
  71, 93, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suman.tripathi.cleaningservices13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radha Nayan', '9876500098', 'radha.nayan.cleaningservices14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 7,
  'Chowk, Lucknow', 26.8635, 80.9135, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 7 years of trusted field experience in Chowk.', 4.4,
  84, 117, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radha.nayan.cleaningservices14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kiran Jaiswal', '9876500099', 'kiran.jaiswal.cleaningservices15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 10,
  'Krishna Nagar, Lucknow', 26.7950, 80.8950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 10 years of trusted field experience in Krishna Nagar.', 4.2,
  22, 66, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kiran.jaiswal.cleaningservices15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Preeti Gupta', '9876500100', 'preeti.gupta.cleaningservices16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 13,
  'Sushant Golf City, Lucknow', 26.7805, 80.9990, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 13 years of trusted field experience in Sushant Golf City.', 4.9,
  35, 40, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'preeti.gupta.cleaningservices16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sarita Vishwakarma', '9876500101', 'sarita.vishwakarma.cleaningservices17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 16,
  'Telibagh, Lucknow', 26.7920, 80.9365, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 16 years of trusted field experience in Telibagh.', 4.7,
  48, 64, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sarita.vishwakarma.cleaningservices17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rani Pal', '9876500102', 'rani.pal.cleaningservices18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 2,
  'Kalyanpur, Lucknow', 26.9165, 80.9720, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 2 years of trusted field experience in Kalyanpur.', 4.5,
  61, 88, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rani.pal.cleaningservices18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sadhana Mehta', '9876500103', 'sadhana.mehta.cleaningservices19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 5,
  'Gomti Nagar, Lucknow', 26.8550, 80.9995, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 5 years of trusted field experience in Gomti Nagar.', 4.3,
  74, 112, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sadhana.mehta.cleaningservices19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Swati Pandey', '9876500104', 'swati.pandey.cleaningservices20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 8,
  'Indira Nagar, Lucknow', 26.8875, 80.9880, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 8 years of trusted field experience in Indira Nagar.', 5,
  12, 61, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'swati.pandey.cleaningservices20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Madhu Kushwaha', '9876500105', 'madhu.kushwaha.cleaningservices21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 11,
  'Aliganj, Lucknow', 26.8865, 80.9360, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 11 years of trusted field experience in Aliganj.', 4.8,
  25, 35, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'madhu.kushwaha.cleaningservices21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunita Sahu', '9876500106', 'sunita.sahu.cleaningservices22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 14,
  'Hazratganj, Lucknow', 26.8470, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 14 years of trusted field experience in Hazratganj.', 4.6,
  38, 59, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunita.sahu.cleaningservices22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Geeta Yadav', '9876500107', 'geeta.yadav.cleaningservices23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 17,
  'Mahanagar, Lucknow', 26.8705, 80.9530, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 17 years of trusted field experience in Mahanagar.', 4.4,
  51, 83, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'geeta.yadav.cleaningservices23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ananya Mishra', '9876500108', 'ananya.mishra.cleaningservices24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 3,
  'Alambagh, Lucknow', 26.8120, 80.9025, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 3 years of trusted field experience in Alambagh.', 4.2,
  64, 107, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ananya.mishra.cleaningservices24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Shreya Rawat', '9876500109', 'shreya.rawat.cleaningservices25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 6,
  'Ashiyana, Lucknow', 26.7925, 80.9050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 6 years of trusted field experience in Ashiyana.', 4.9,
  77, 131, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'shreya.rawat.cleaningservices25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Meera Kanojia', '9876500110', 'meera.kanojia.cleaningservices26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 9,
  'Jankipuram, Lucknow', 26.9150, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 9 years of trusted field experience in Jankipuram.', 4.7,
  15, 30, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'meera.kanojia.cleaningservices26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Shanti Malhotra', '9876500111', 'shanti.malhotra.cleaningservices27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 12,
  'Vikas Nagar, Lucknow', 26.9025, 80.9505, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 12 years of trusted field experience in Vikas Nagar.', 4.5,
  28, 54, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'shanti.malhotra.cleaningservices27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Savita Awasthi', '9876500112', 'savita.awasthi.cleaningservices28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cleaning Services', 15,
  'Rajajipuram, Lucknow', 26.8465, 80.8920, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Sanitization and deep cleaning expert equipped with eco-friendly solutions and motorized scrubbers. Over 15 years of trusted field experience in Rajajipuram.', 4.3,
  41, 78, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'savita.awasthi.cleaningservices28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramesh Sahu', '9876500113', 'ramesh.sahu.carpenter1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 18,
  'Sushant Golf City, Lucknow', 26.7790, 81.0035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 18 years of trusted field experience in Sushant Golf City.', 5,
  54, 102, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramesh.sahu.carpenter1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Babloo Yadav', '9876500114', 'babloo.yadav.carpenter2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 4,
  'Telibagh, Lucknow', 26.7905, 80.9410, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 4 years of trusted field experience in Telibagh.', 4.8,
  67, 76, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'babloo.yadav.carpenter2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sachin Mishra', '9876500115', 'sachin.mishra.carpenter3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 7,
  'Kalyanpur, Lucknow', 26.9150, 80.9690, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 7 years of trusted field experience in Kalyanpur.', 4.6,
  80, 100, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sachin.mishra.carpenter3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sadhana Rawat', '9876500116', 'sadhana.rawat.carpenter4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 10,
  'Gomti Nagar, Lucknow', 26.8535, 80.9965, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 10 years of trusted field experience in Gomti Nagar.', 4.4,
  18, 49, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sadhana.rawat.carpenter4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramakant Kanojia', '9876500117', 'ramakant.kanojia.carpenter5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 13,
  'Indira Nagar, Lucknow', 26.8860, 80.9850, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 13 years of trusted field experience in Indira Nagar.', 4.2,
  31, 73, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramakant.kanojia.carpenter5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kapil Malhotra', '9876500118', 'kapil.malhotra.carpenter6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 16,
  'Aliganj, Lucknow', 26.8955, 80.9405, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 16 years of trusted field experience in Aliganj.', 4.9,
  44, 97, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kapil.malhotra.carpenter6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Tarun Awasthi', '9876500119', 'tarun.awasthi.carpenter7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 2,
  'Hazratganj, Lucknow', 26.8455, 80.9480, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 2 years of trusted field experience in Hazratganj.', 4.7,
  57, 71, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'tarun.awasthi.carpenter7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Geeta Gautam', '9876500120', 'geeta.gautam.carpenter8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 5,
  'Mahanagar, Lucknow', 26.8690, 80.9500, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 5 years of trusted field experience in Mahanagar.', 4.5,
  70, 95, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'geeta.gautam.carpenter8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Chandan Verma', '9876500121', 'chandan.verma.carpenter9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 8,
  'Alambagh, Lucknow', 26.8105, 80.8995, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 8 years of trusted field experience in Alambagh.', 4.3,
  83, 119, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'chandan.verma.carpenter9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neeraj Chauhan', '9876500122', 'neeraj.chauhan.carpenter10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 11,
  'Ashiyana, Lucknow', 26.7910, 80.9020, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 11 years of trusted field experience in Ashiyana.', 5,
  21, 68, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neeraj.chauhan.carpenter10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Umesh Khan', '9876500123', 'umesh.khan.carpenter11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 14,
  'Jankipuram, Lucknow', 26.9135, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 14 years of trusted field experience in Jankipuram.', 4.8,
  34, 42, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'umesh.khan.carpenter11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Shanti Chaurasia', '9876500124', 'shanti.chaurasia.carpenter12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 17,
  'Vikas Nagar, Lucknow', 26.9010, 80.9550, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 17 years of trusted field experience in Vikas Nagar.', 4.6,
  47, 66, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'shanti.chaurasia.carpenter12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sumit Dwivedi', '9876500125', 'sumit.dwivedi.carpenter13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 3,
  'Rajajipuram, Lucknow', 26.8555, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 3 years of trusted field experience in Rajajipuram.', 4.4,
  60, 90, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sumit.dwivedi.carpenter13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepak Tandon', '9876500126', 'deepak.tandon.carpenter14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 6,
  'Charbagh, Lucknow', 26.8275, 80.9195, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 6 years of trusted field experience in Charbagh.', 4.2,
  73, 114, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepak.tandon.carpenter14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramesh Bhardwaj', '9876500127', 'ramesh.bhardwaj.carpenter15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 9,
  'Chowk, Lucknow', 26.8650, 80.9120, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 9 years of trusted field experience in Chowk.', 4.9,
  11, 63, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramesh.bhardwaj.carpenter15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Seema Kumar', '9876500128', 'seema.kumar.carpenter16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 12,
  'Krishna Nagar, Lucknow', 26.7965, 80.8935, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 12 years of trusted field experience in Krishna Nagar.', 4.7,
  24, 37, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'seema.kumar.carpenter16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sachin Rathore', '9876500129', 'sachin.rathore.carpenter17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 15,
  'Sushant Golf City, Lucknow', 26.7820, 81.0050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 15 years of trusted field experience in Sushant Golf City.', 4.5,
  37, 61, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sachin.rathore.carpenter17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sandeep Prajapati', '9876500130', 'sandeep.prajapati.carpenter18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 18,
  'Telibagh, Lucknow', 26.7935, 80.9350, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 18 years of trusted field experience in Telibagh.', 4.3,
  50, 85, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sandeep.prajapati.carpenter18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramakant Paswan', '9876500131', 'ramakant.paswan.carpenter19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 4,
  'Kalyanpur, Lucknow', 26.9180, 80.9705, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 4 years of trusted field experience in Kalyanpur.', 5,
  63, 109, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramakant.paswan.carpenter19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Priya Saxena', '9876500132', 'priya.saxena.carpenter20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 7,
  'Gomti Nagar, Lucknow', 26.8565, 80.9980, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 7 years of trusted field experience in Gomti Nagar.', 4.8,
  76, 83, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'priya.saxena.carpenter20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Tarun Joshi', '9876500133', 'tarun.joshi.carpenter21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 10,
  'Indira Nagar, Lucknow', 26.8785, 80.9865, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 10 years of trusted field experience in Indira Nagar.', 4.6,
  14, 32, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'tarun.joshi.carpenter21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Abhishek Chaturvedi', '9876500134', 'abhishek.chaturvedi.carpenter22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 13,
  'Aliganj, Lucknow', 26.8880, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 13 years of trusted field experience in Aliganj.', 4.4,
  27, 56, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'abhishek.chaturvedi.carpenter22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Chandan Sonkar', '9876500135', 'chandan.sonkar.carpenter23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 16,
  'Hazratganj, Lucknow', 26.8485, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 16 years of trusted field experience in Hazratganj.', 4.2,
  40, 80, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'chandan.sonkar.carpenter23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Divya Tiwari', '9876500136', 'divya.tiwari.carpenter24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 2,
  'Mahanagar, Lucknow', 26.8720, 80.9515, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 2 years of trusted field experience in Mahanagar.', 4.9,
  53, 104, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'divya.tiwari.carpenter24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Umesh Maurya', '9876500137', 'umesh.maurya.carpenter25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 5,
  'Alambagh, Lucknow', 26.8135, 80.9010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 5 years of trusted field experience in Alambagh.', 4.7,
  66, 78, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'umesh.maurya.carpenter25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Girish Bind', '9876500138', 'girish.bind.carpenter26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 8,
  'Ashiyana, Lucknow', 26.7940, 80.9035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 8 years of trusted field experience in Ashiyana.', 4.5,
  79, 102, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'girish.bind.carpenter26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sumit Shukla', '9876500139', 'sumit.shukla.carpenter27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 11,
  'Jankipuram, Lucknow', 26.9165, 80.9480, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 11 years of trusted field experience in Jankipuram.', 4.3,
  17, 51, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sumit.shukla.carpenter27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Maya Rastogi', '9876500140', 'maya.rastogi.carpenter28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Carpenter', 14,
  'Vikas Nagar, Lucknow', 26.8935, 80.9490, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Experienced woodcraft artisan specialized in custom cabinetry, door alignment, lock repair, and furniture polishing. Over 14 years of trusted field experience in Vikas Nagar.', 5,
  30, 75, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'maya.rastogi.carpenter28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suresh Chaturvedi', '9876500141', 'suresh.chaturvedi.painting1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 17,
  'Krishna Nagar, Lucknow', 26.7950, 80.8905, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 17 years of trusted field experience in Krishna Nagar.', 4.8,
  43, 49, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suresh.chaturvedi.painting1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arvind Sonkar', '9876500142', 'arvind.sonkar.painting2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 3,
  'Sushant Golf City, Lucknow', 26.7805, 81.0020, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 3 years of trusted field experience in Sushant Golf City.', 4.6,
  56, 73, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arvind.sonkar.painting2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Nitin Tiwari', '9876500143', 'nitin.tiwari.painting3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 6,
  'Telibagh, Lucknow', 26.7920, 80.9395, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 6 years of trusted field experience in Telibagh.', 4.4,
  69, 97, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'nitin.tiwari.painting3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jyoti Maurya', '9876500144', 'jyoti.maurya.painting4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 9,
  'Kalyanpur, Lucknow', 26.9165, 80.9750, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 9 years of trusted field experience in Kalyanpur.', 4.2,
  82, 121, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jyoti.maurya.painting4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Santosh Bind', '9876500145', 'santosh.bind.painting5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 12,
  'Gomti Nagar, Lucknow', 26.8550, 80.9950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 12 years of trusted field experience in Gomti Nagar.', 4.9,
  20, 70, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'santosh.bind.painting5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vishal Shukla', '9876500146', 'vishal.shukla.painting6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 15,
  'Indira Nagar, Lucknow', 26.8875, 80.9835, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 15 years of trusted field experience in Indira Nagar.', 4.7,
  33, 44, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vishal.shukla.painting6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ravi Rastogi', '9876500147', 'ravi.rastogi.painting7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 18,
  'Aliganj, Lucknow', 26.8865, 80.9390, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 18 years of trusted field experience in Aliganj.', 4.5,
  46, 68, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ravi.rastogi.painting7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neha Dixit', '9876500148', 'neha.dixit.painting8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 4,
  'Hazratganj, Lucknow', 26.8470, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 4 years of trusted field experience in Hazratganj.', 4.3,
  59, 92, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neha.dixit.painting8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kamlesh Nigam', '9876500149', 'kamlesh.nigam.painting9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 7,
  'Mahanagar, Lucknow', 26.8705, 80.9560, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 7 years of trusted field experience in Mahanagar.', 5,
  72, 116, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kamlesh.nigam.painting9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Omkar Sharma', '9876500150', 'omkar.sharma.painting10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 10,
  'Alambagh, Lucknow', 26.8120, 80.8980, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 10 years of trusted field experience in Alambagh.', 4.8,
  10, 15, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'omkar.sharma.painting10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Hemant Arif', '9876500151', 'hemant.arif.painting11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 13,
  'Ashiyana, Lucknow', 26.7925, 80.9005, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 13 years of trusted field experience in Ashiyana.', 4.6,
  23, 39, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'hemant.arif.painting11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Aarti Srivastava', '9876500152', 'aarti.srivastava.painting12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 16,
  'Jankipuram, Lucknow', 26.9150, 80.9450, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 16 years of trusted field experience in Jankipuram.', 4.4,
  36, 63, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'aarti.srivastava.painting12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajesh Singh', '9876500153', 'rajesh.singh.painting13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 2,
  'Vikas Nagar, Lucknow', 26.9025, 80.9535, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 2 years of trusted field experience in Vikas Nagar.', 4.2,
  49, 87, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajesh.singh.painting13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manoj Agarwal', '9876500154', 'manoj.agarwal.painting14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 5,
  'Rajajipuram, Lucknow', 26.8465, 80.8950, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 5 years of trusted field experience in Rajajipuram.', 4.9,
  62, 111, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manoj.agarwal.painting14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suresh Dubey', '9876500155', 'suresh.dubey.painting15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 8,
  'Charbagh, Lucknow', 26.8290, 80.9180, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 8 years of trusted field experience in Charbagh.', 4.7,
  75, 85, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suresh.dubey.painting15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Mamta Upadhyay', '9876500156', 'mamta.upadhyay.painting16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 11,
  'Chowk, Lucknow', 26.8665, 80.9105, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 11 years of trusted field experience in Chowk.', 4.5,
  13, 34, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'mamta.upadhyay.painting16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Nitin Soni', '9876500157', 'nitin.soni.painting17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 14,
  'Krishna Nagar, Lucknow', 26.7980, 80.8920, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 14 years of trusted field experience in Krishna Nagar.', 4.3,
  26, 58, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'nitin.soni.painting17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Satish Devi', '9876500158', 'satish.devi.painting18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 17,
  'Sushant Golf City, Lucknow', 26.7835, 81.0035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 17 years of trusted field experience in Sushant Golf City.', 5,
  39, 82, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'satish.devi.painting18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Santosh Kashyap', '9876500159', 'santosh.kashyap.painting19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 3,
  'Telibagh, Lucknow', 26.7950, 80.9410, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 3 years of trusted field experience in Telibagh.', 4.8,
  52, 106, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'santosh.kashyap.painting19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rekha Patel', '9876500160', 'rekha.patel.painting20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 6,
  'Kalyanpur, Lucknow', 26.9195, 80.9690, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 6 years of trusted field experience in Kalyanpur.', 4.6,
  65, 80, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rekha.patel.painting20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ravi Tripathi', '9876500161', 'ravi.tripathi.painting21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 9,
  'Gomti Nagar, Lucknow', 26.8475, 80.9965, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 9 years of trusted field experience in Gomti Nagar.', 4.4,
  78, 104, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ravi.tripathi.painting21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manish Nayan', '9876500162', 'manish.nayan.painting22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 12,
  'Indira Nagar, Lucknow', 26.8800, 80.9850, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 12 years of trusted field experience in Indira Nagar.', 4.2,
  16, 53, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manish.nayan.painting22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kamlesh Jaiswal', '9876500163', 'kamlesh.jaiswal.painting23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 15,
  'Aliganj, Lucknow', 26.8895, 80.9405, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 15 years of trusted field experience in Aliganj.', 4.9,
  29, 77, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kamlesh.jaiswal.painting23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radha Gupta', '9876500164', 'radha.gupta.painting24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 18,
  'Hazratganj, Lucknow', 26.8500, 80.9480, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 18 years of trusted field experience in Hazratganj.', 4.7,
  42, 51, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radha.gupta.painting24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Hemant Vishwakarma', '9876500165', 'hemant.vishwakarma.painting25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 4,
  'Mahanagar, Lucknow', 26.8735, 80.9500, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 4 years of trusted field experience in Mahanagar.', 4.5,
  55, 75, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'hemant.vishwakarma.painting25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manohar Pal', '9876500166', 'manohar.pal.painting26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 7,
  'Alambagh, Lucknow', 26.8150, 80.8995, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 7 years of trusted field experience in Alambagh.', 4.3,
  68, 99, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manohar.pal.painting26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajesh Mehta', '9876500167', 'rajesh.mehta.painting27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 10,
  'Ashiyana, Lucknow', 26.7955, 80.9020, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 10 years of trusted field experience in Ashiyana.', 5,
  81, 123, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajesh.mehta.painting27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rani Pandey', '9876500168', 'rani.pandey.painting28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Painting', 13,
  'Jankipuram, Lucknow', 26.9075, 80.9465, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Master interior wall decorator skilled in primer base, damp-proof putty, texture finish, and emulsion painting. Over 13 years of trusted field experience in Jankipuram.', 4.8,
  19, 72, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rani.pandey.painting28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dharmendra Nayan', '9876500169', 'dharmendra.nayan.masonconstruction1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 16,
  'Chowk, Lucknow', 26.8650, 80.9150, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 16 years of trusted field experience in Chowk.', 4.6,
  32, 46, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dharmendra.nayan.masonconstruction1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ajay Jaiswal', '9876500170', 'ajay.jaiswal.masonconstruction2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 2,
  'Krishna Nagar, Lucknow', 26.7965, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 2 years of trusted field experience in Krishna Nagar.', 4.4,
  45, 70, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ajay.jaiswal.masonconstruction2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Alok Gupta', '9876500171', 'alok.gupta.masonconstruction3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 5,
  'Sushant Golf City, Lucknow', 26.7820, 81.0005, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 5 years of trusted field experience in Sushant Golf City.', 4.2,
  58, 94, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'alok.gupta.masonconstruction3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pooja Vishwakarma', '9876500172', 'pooja.vishwakarma.masonconstruction4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 8,
  'Telibagh, Lucknow', 26.7935, 80.9380, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 8 years of trusted field experience in Telibagh.', 4.9,
  71, 118, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pooja.vishwakarma.masonconstruction4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radheshyam Pal', '9876500173', 'radheshyam.pal.masonconstruction5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 11,
  'Kalyanpur, Lucknow', 26.9180, 80.9735, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 11 years of trusted field experience in Kalyanpur.', 4.7,
  84, 92, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radheshyam.pal.masonconstruction5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vinod Mehta', '9876500174', 'vinod.mehta.masonconstruction6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 14,
  'Gomti Nagar, Lucknow', 26.8565, 81.0010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 14 years of trusted field experience in Gomti Nagar.', 4.5,
  22, 41, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vinod.mehta.masonconstruction6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pawan Pandey', '9876500175', 'pawan.pandey.masonconstruction7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 17,
  'Indira Nagar, Lucknow', 26.8785, 80.9820, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 17 years of trusted field experience in Indira Nagar.', 4.3,
  35, 65, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pawan.pandey.masonconstruction7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suman Kushwaha', '9876500176', 'suman.kushwaha.masonconstruction8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 3,
  'Aliganj, Lucknow', 26.8880, 80.9375, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 3 years of trusted field experience in Aliganj.', 5,
  48, 89, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suman.kushwaha.masonconstruction8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kishore Sahu', '9876500177', 'kishore.sahu.masonconstruction9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 6,
  'Hazratganj, Lucknow', 26.8485, 80.9450, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 6 years of trusted field experience in Hazratganj.', 4.8,
  61, 113, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kishore.sahu.masonconstruction9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Prashant Yadav', '9876500178', 'prashant.yadav.masonconstruction10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 9,
  'Mahanagar, Lucknow', 26.8720, 80.9545, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 9 years of trusted field experience in Mahanagar.', 4.6,
  74, 87, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'prashant.yadav.masonconstruction10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ashok Mishra', '9876500179', 'ashok.mishra.masonconstruction11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 12,
  'Alambagh, Lucknow', 26.8135, 80.9040, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 12 years of trusted field experience in Alambagh.', 4.4,
  12, 36, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ashok.mishra.masonconstruction11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sarita Rawat', '9876500180', 'sarita.rawat.masonconstruction12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 15,
  'Ashiyana, Lucknow', 26.7940, 80.8990, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 15 years of trusted field experience in Ashiyana.', 4.2,
  25, 60, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sarita.rawat.masonconstruction12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Amit Kanojia', '9876500181', 'amit.kanojia.masonconstruction13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 18,
  'Jankipuram, Lucknow', 26.9165, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 18 years of trusted field experience in Jankipuram.', 4.9,
  38, 84, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'amit.kanojia.masonconstruction13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunil Malhotra', '9876500182', 'sunil.malhotra.masonconstruction14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 4,
  'Vikas Nagar, Lucknow', 26.8935, 80.9520, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 4 years of trusted field experience in Vikas Nagar.', 4.7,
  51, 58, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunil.malhotra.masonconstruction14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dharmendra Awasthi', '9876500183', 'dharmendra.awasthi.masonconstruction15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 7,
  'Rajajipuram, Lucknow', 26.8480, 80.8935, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 7 years of trusted field experience in Rajajipuram.', 4.5,
  64, 82, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dharmendra.awasthi.masonconstruction15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Madhu Gautam', '9876500184', 'madhu.gautam.masonconstruction16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 10,
  'Charbagh, Lucknow', 26.8305, 80.9240, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 10 years of trusted field experience in Charbagh.', 4.3,
  77, 106, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'madhu.gautam.masonconstruction16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Alok Verma', '9876500185', 'alok.verma.masonconstruction17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 13,
  'Chowk, Lucknow', 26.8680, 80.9090, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 13 years of trusted field experience in Chowk.', 5,
  15, 55, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'alok.verma.masonconstruction17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Harish Chauhan', '9876500186', 'harish.chauhan.masonconstruction18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 16,
  'Krishna Nagar, Lucknow', 26.7995, 80.8905, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 16 years of trusted field experience in Krishna Nagar.', 4.8,
  28, 79, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'harish.chauhan.masonconstruction18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radheshyam Khan', '9876500187', 'radheshyam.khan.masonconstruction19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 2,
  'Sushant Golf City, Lucknow', 26.7850, 81.0020, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 2 years of trusted field experience in Sushant Golf City.', 4.6,
  41, 53, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radheshyam.khan.masonconstruction19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Shreya Chaurasia', '9876500188', 'shreya.chaurasia.masonconstruction20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 5,
  'Telibagh, Lucknow', 26.7965, 80.9395, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 5 years of trusted field experience in Telibagh.', 4.4,
  54, 77, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'shreya.chaurasia.masonconstruction20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pawan Dwivedi', '9876500189', 'pawan.dwivedi.masonconstruction21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 8,
  'Kalyanpur, Lucknow', 26.9105, 80.9750, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 8 years of trusted field experience in Kalyanpur.', 4.2,
  67, 101, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pawan.dwivedi.masonconstruction21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikas Tandon', '9876500190', 'vikas.tandon.masonconstruction22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 11,
  'Gomti Nagar, Lucknow', 26.8490, 80.9950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 11 years of trusted field experience in Gomti Nagar.', 4.9,
  80, 125, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikas.tandon.masonconstruction22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kishore Bhardwaj', '9876500191', 'kishore.bhardwaj.masonconstruction23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 14,
  'Indira Nagar, Lucknow', 26.8815, 80.9835, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 14 years of trusted field experience in Indira Nagar.', 4.7,
  18, 24, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kishore.bhardwaj.masonconstruction23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vandana Kumar', '9876500192', 'vandana.kumar.masonconstruction24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 17,
  'Aliganj, Lucknow', 26.8910, 80.9390, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 17 years of trusted field experience in Aliganj.', 4.5,
  31, 48, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vandana.kumar.masonconstruction24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ashok Rathore', '9876500193', 'ashok.rathore.masonconstruction25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 3,
  'Hazratganj, Lucknow', 26.8515, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 3 years of trusted field experience in Hazratganj.', 4.3,
  44, 72, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ashok.rathore.masonconstruction25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Devendra Prajapati', '9876500194', 'devendra.prajapati.masonconstruction26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 6,
  'Mahanagar, Lucknow', 26.8750, 80.9560, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 6 years of trusted field experience in Mahanagar.', 5,
  57, 96, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'devendra.prajapati.masonconstruction26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Amit Paswan', '9876500195', 'amit.paswan.masonconstruction27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 9,
  'Alambagh, Lucknow', 26.8165, 80.8980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 9 years of trusted field experience in Alambagh.', 4.8,
  70, 120, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'amit.paswan.masonconstruction27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Reena Saxena', '9876500196', 'reena.saxena.masonconstruction28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Mason / Construction', 12,
  'Ashiyana, Lucknow', 26.7865, 80.9005, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Structural mason with extensive experience in wall plastering, bricklaying, tile alignment, and repair. Over 12 years of trusted field experience in Ashiyana.', 4.6,
  83, 94, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'reena.saxena.masonconstruction28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Imran Tandon', '9876500197', 'imran.tandon.driver1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 15,
  'Charbagh, Lucknow', 26.8290, 80.9210, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 15 years of trusted field experience in Charbagh.', 4.4,
  21, 43, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'imran.tandon.driver1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pankaj Bhardwaj', '9876500198', 'pankaj.bhardwaj.driver2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 18,
  'Chowk, Lucknow', 26.8665, 80.9135, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 18 years of trusted field experience in Chowk.', 4.2,
  34, 67, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pankaj.bhardwaj.driver2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Gaurav Kumar', '9876500199', 'gaurav.kumar.driver3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 4,
  'Krishna Nagar, Lucknow', 26.7980, 80.8950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 4 years of trusted field experience in Krishna Nagar.', 4.9,
  47, 91, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'gaurav.kumar.driver3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ananya Rathore', '9876500200', 'ananya.rathore.driver4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 7,
  'Sushant Golf City, Lucknow', 26.7835, 80.9990, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 7 years of trusted field experience in Sushant Golf City.', 4.7,
  60, 65, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ananya.rathore.driver4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pradeep Prajapati', '9876500201', 'pradeep.prajapati.driver5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 10,
  'Telibagh, Lucknow', 26.7950, 80.9365, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 10 years of trusted field experience in Telibagh.', 4.5,
  73, 89, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pradeep.prajapati.driver5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Arun Paswan', '9876500202', 'arun.paswan.driver6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 13,
  'Kalyanpur, Lucknow', 26.9195, 80.9720, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 13 years of trusted field experience in Kalyanpur.', 4.3,
  11, 38, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'arun.paswan.driver6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jagdish Saxena', '9876500203', 'jagdish.saxena.driver7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 16,
  'Gomti Nagar, Lucknow', 26.8475, 80.9995, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 16 years of trusted field experience in Gomti Nagar.', 5,
  24, 62, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jagdish.saxena.driver7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Savita Joshi', '9876500204', 'savita.joshi.driver8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 2,
  'Indira Nagar, Lucknow', 26.8800, 80.9880, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 2 years of trusted field experience in Indira Nagar.', 4.8,
  37, 86, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'savita.joshi.driver8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Lalit Chaturvedi', '9876500205', 'lalit.chaturvedi.driver9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 5,
  'Aliganj, Lucknow', 26.8895, 80.9360, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 5 years of trusted field experience in Aliganj.', 4.6,
  50, 60, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'lalit.chaturvedi.driver9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rajan Sonkar', '9876500206', 'rajan.sonkar.driver10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 8,
  'Hazratganj, Lucknow', 26.8500, 80.9435, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 8 years of trusted field experience in Hazratganj.', 4.4,
  63, 84, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rajan.sonkar.driver10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kunal Tiwari', '9876500207', 'kunal.tiwari.driver11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 11,
  'Mahanagar, Lucknow', 26.8735, 80.9530, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 11 years of trusted field experience in Mahanagar.', 4.2,
  76, 108, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kunal.tiwari.driver11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Anjali Maurya', '9876500208', 'anjali.maurya.driver12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 14,
  'Alambagh, Lucknow', 26.8150, 80.9025, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 14 years of trusted field experience in Alambagh.', 4.9,
  14, 57, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'anjali.maurya.driver12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sanjay Bind', '9876500209', 'sanjay.bind.driver13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 17,
  'Ashiyana, Lucknow', 26.7955, 80.9050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 17 years of trusted field experience in Ashiyana.', 4.7,
  27, 81, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sanjay.bind.driver13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Vikram Shukla', '9876500210', 'vikram.shukla.driver14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 3,
  'Jankipuram, Lucknow', 26.9075, 80.9420, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 3 years of trusted field experience in Jankipuram.', 4.5,
  40, 55, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'vikram.shukla.driver14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Imran Rastogi', '9876500211', 'imran.rastogi.driver15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 6,
  'Vikas Nagar, Lucknow', 26.8950, 80.9505, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 6 years of trusted field experience in Vikas Nagar.', 4.3,
  53, 79, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'imran.rastogi.driver15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Anita Dixit', '9876500212', 'anita.dixit.driver16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 9,
  'Rajajipuram, Lucknow', 26.8495, 80.8920, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 9 years of trusted field experience in Rajajipuram.', 5,
  66, 103, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'anita.dixit.driver16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Gaurav Nigam', '9876500213', 'gaurav.nigam.driver17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 12,
  'Charbagh, Lucknow', 26.8320, 80.9225, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 12 years of trusted field experience in Charbagh.', 4.8,
  79, 127, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'gaurav.nigam.driver17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Dinesh Sharma', '9876500214', 'dinesh.sharma.driver18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 15,
  'Chowk, Lucknow', 26.8695, 80.9150, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 15 years of trusted field experience in Chowk.', 4.6,
  17, 26, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'dinesh.sharma.driver18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pradeep Arif', '9876500215', 'pradeep.arif.driver19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 18,
  'Krishna Nagar, Lucknow', 26.8010, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 18 years of trusted field experience in Krishna Nagar.', 4.4,
  30, 50, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pradeep.arif.driver19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kavita Srivastava', '9876500216', 'kavita.srivastava.driver20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 4,
  'Sushant Golf City, Lucknow', 26.7865, 81.0005, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 4 years of trusted field experience in Sushant Golf City.', 4.2,
  43, 74, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kavita.srivastava.driver20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jagdish Singh', '9876500217', 'jagdish.singh.driver21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 7,
  'Telibagh, Lucknow', 26.7875, 80.9380, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 7 years of trusted field experience in Telibagh.', 4.9,
  56, 98, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jagdish.singh.driver21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rahul Agarwal', '9876500218', 'rahul.agarwal.driver22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 10,
  'Kalyanpur, Lucknow', 26.9120, 80.9735, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 10 years of trusted field experience in Kalyanpur.', 4.7,
  69, 122, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rahul.agarwal.driver22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Lalit Dubey', '9876500219', 'lalit.dubey.driver23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 13,
  'Gomti Nagar, Lucknow', 26.8505, 81.0010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 13 years of trusted field experience in Gomti Nagar.', 4.5,
  82, 96, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'lalit.dubey.driver23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manju Upadhyay', '9876500220', 'manju.upadhyay.driver24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 16,
  'Indira Nagar, Lucknow', 26.8830, 80.9820, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 16 years of trusted field experience in Indira Nagar.', 4.3,
  20, 45, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manju.upadhyay.driver24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kunal Soni', '9876500221', 'kunal.soni.driver25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 2,
  'Aliganj, Lucknow', 26.8925, 80.9375, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 2 years of trusted field experience in Aliganj.', 5,
  33, 69, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kunal.soni.driver25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kuldeep Devi', '9876500222', 'kuldeep.devi.driver26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 5,
  'Hazratganj, Lucknow', 26.8530, 80.9450, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 5 years of trusted field experience in Hazratganj.', 4.8,
  46, 93, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kuldeep.devi.driver26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sanjay Kashyap', '9876500223', 'sanjay.kashyap.driver27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 8,
  'Mahanagar, Lucknow', 26.8765, 80.9545, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 8 years of trusted field experience in Mahanagar.', 4.6,
  59, 67, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sanjay.kashyap.driver27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Archana Patel', '9876500224', 'archana.patel.driver28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Driver', 11,
  'Alambagh, Lucknow', 26.8075, 80.9040, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Commercial licensed professional chauffeur with exemplary safety record for local transit and highway drives. Over 11 years of trusted field experience in Alambagh.', 4.4,
  72, 91, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'archana.patel.driver28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Anita Agarwal', '9876500225', 'anita.agarwal.cookingservices1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 14,
  'Rajajipuram, Lucknow', 26.8480, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 14 years of trusted field experience in Rajajipuram.', 4.2,
  10, 40, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'anita.agarwal.cookingservices1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sneha Dubey', '9876500226', 'sneha.dubey.cookingservices2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 17,
  'Charbagh, Lucknow', 26.8305, 80.9195, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 17 years of trusted field experience in Charbagh.', 4.9,
  23, 64, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sneha.dubey.cookingservices2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neha Upadhyay', '9876500227', 'neha.upadhyay.cookingservices3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 3,
  'Chowk, Lucknow', 26.8680, 80.9120, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 3 years of trusted field experience in Chowk.', 4.7,
  36, 88, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neha.upadhyay.cookingservices3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Divya Soni', '9876500228', 'divya.soni.cookingservices4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 6,
  'Krishna Nagar, Lucknow', 26.7995, 80.8935, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 6 years of trusted field experience in Krishna Nagar.', 4.5,
  49, 62, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'divya.soni.cookingservices4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kavita Devi', '9876500229', 'kavita.devi.cookingservices5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 9,
  'Sushant Golf City, Lucknow', 26.7850, 81.0050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 9 years of trusted field experience in Sushant Golf City.', 4.3,
  62, 86, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kavita.devi.cookingservices5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pushpa Kashyap', '9876500230', 'pushpa.kashyap.cookingservices6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 12,
  'Telibagh, Lucknow', 26.7965, 80.9350, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 12 years of trusted field experience in Telibagh.', 5,
  75, 110, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pushpa.kashyap.cookingservices6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Aarti Patel', '9876500231', 'aarti.patel.cookingservices7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 15,
  'Kalyanpur, Lucknow', 26.9105, 80.9705, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 15 years of trusted field experience in Kalyanpur.', 4.8,
  13, 59, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'aarti.patel.cookingservices7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Maya Tripathi', '9876500232', 'maya.tripathi.cookingservices8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 18,
  'Gomti Nagar, Lucknow', 26.8490, 80.9980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 18 years of trusted field experience in Gomti Nagar.', 4.6,
  26, 33, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'maya.tripathi.cookingservices8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Manju Nayan', '9876500233', 'manju.nayan.cookingservices9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 4,
  'Indira Nagar, Lucknow', 26.8815, 80.9865, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 4 years of trusted field experience in Indira Nagar.', 4.4,
  39, 57, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'manju.nayan.cookingservices9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Komal Jaiswal', '9876500234', 'komal.jaiswal.cookingservices10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 7,
  'Aliganj, Lucknow', 26.8910, 80.9420, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 7 years of trusted field experience in Aliganj.', 4.2,
  52, 81, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'komal.jaiswal.cookingservices10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Mamta Gupta', '9876500235', 'mamta.gupta.cookingservices11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 10,
  'Hazratganj, Lucknow', 26.8515, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 10 years of trusted field experience in Hazratganj.', 4.9,
  65, 105, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'mamta.gupta.cookingservices11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rashmi Vishwakarma', '9876500236', 'rashmi.vishwakarma.cookingservices12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 13,
  'Mahanagar, Lucknow', 26.8750, 80.9515, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 13 years of trusted field experience in Mahanagar.', 4.7,
  78, 129, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rashmi.vishwakarma.cookingservices12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Archana Pal', '9876500237', 'archana.pal.cookingservices13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 16,
  'Alambagh, Lucknow', 26.8165, 80.9010, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 16 years of trusted field experience in Alambagh.', 4.5,
  16, 28, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'archana.pal.cookingservices13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Pooja Mehta', '9876500238', 'pooja.mehta.cookingservices14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 2,
  'Ashiyana, Lucknow', 26.7865, 80.9035, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 2 years of trusted field experience in Ashiyana.', 4.3,
  29, 52, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'pooja.mehta.cookingservices14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rekha Pandey', '9876500239', 'rekha.pandey.cookingservices15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 5,
  'Jankipuram, Lucknow', 26.9090, 80.9480, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 5 years of trusted field experience in Jankipuram.', 5,
  42, 76, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rekha.pandey.cookingservices15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepika Kushwaha', '9876500240', 'deepika.kushwaha.cookingservices16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 8,
  'Vikas Nagar, Lucknow', 26.8965, 80.9490, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 8 years of trusted field experience in Vikas Nagar.', 4.8,
  55, 100, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepika.kushwaha.cookingservices16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ritu Sahu', '9876500241', 'ritu.sahu.cookingservices17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 11,
  'Rajajipuram, Lucknow', 26.8510, 80.8905, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 11 years of trusted field experience in Rajajipuram.', 4.6,
  68, 74, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ritu.sahu.cookingservices17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Suman Yadav', '9876500242', 'suman.yadav.cookingservices18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 14,
  'Charbagh, Lucknow', 26.8335, 80.9210, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 14 years of trusted field experience in Charbagh.', 4.4,
  81, 98, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'suman.yadav.cookingservices18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radha Mishra', '9876500243', 'radha.mishra.cookingservices19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 17,
  'Chowk, Lucknow', 26.8710, 80.9135, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 17 years of trusted field experience in Chowk.', 4.2,
  19, 47, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radha.mishra.cookingservices19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kiran Rawat', '9876500244', 'kiran.rawat.cookingservices20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 3,
  'Krishna Nagar, Lucknow', 26.8025, 80.8950, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 3 years of trusted field experience in Krishna Nagar.', 4.9,
  32, 71, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kiran.rawat.cookingservices20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Preeti Kanojia', '9876500245', 'preeti.kanojia.cookingservices21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 6,
  'Sushant Golf City, Lucknow', 26.7775, 80.9990, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 6 years of trusted field experience in Sushant Golf City.', 4.7,
  45, 95, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'preeti.kanojia.cookingservices21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sarita Malhotra', '9876500246', 'sarita.malhotra.cookingservices22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 9,
  'Telibagh, Lucknow', 26.7890, 80.9365, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 9 years of trusted field experience in Telibagh.', 4.5,
  58, 69, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sarita.malhotra.cookingservices22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rani Awasthi', '9876500247', 'rani.awasthi.cookingservices23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 12,
  'Kalyanpur, Lucknow', 26.9135, 80.9720, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 12 years of trusted field experience in Kalyanpur.', 4.3,
  71, 93, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rani.awasthi.cookingservices23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sadhana Gautam', '9876500248', 'sadhana.gautam.cookingservices24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 15,
  'Gomti Nagar, Lucknow', 26.8520, 80.9995, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 15 years of trusted field experience in Gomti Nagar.', 5,
  84, 117, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sadhana.gautam.cookingservices24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Swati Verma', '9876500249', 'swati.verma.cookingservices25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 18,
  'Indira Nagar, Lucknow', 26.8845, 80.9880, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 18 years of trusted field experience in Indira Nagar.', 4.8,
  22, 66, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'swati.verma.cookingservices25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Madhu Chauhan', '9876500250', 'madhu.chauhan.cookingservices26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 4,
  'Aliganj, Lucknow', 26.8940, 80.9360, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 4 years of trusted field experience in Aliganj.', 4.6,
  35, 40, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'madhu.chauhan.cookingservices26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunita Khan', '9876500251', 'sunita.khan.cookingservices27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 7,
  'Hazratganj, Lucknow', 26.8545, 80.9435, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 7 years of trusted field experience in Hazratganj.', 4.4,
  48, 64, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunita.khan.cookingservices27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Geeta Chaurasia', '9876500252', 'geeta.chaurasia.cookingservices28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Cooking Services', 10,
  'Mahanagar, Lucknow', 26.8675, 80.9530, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Home chef skilled in hygienic, balanced North Indian and Awadhi meals for families and events. Over 10 years of trusted field experience in Mahanagar.', 4.2,
  61, 88, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'geeta.chaurasia.cookingservices28@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Babloo Malhotra', '9876500253', 'babloo.malhotra.laundry1@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 13,
  'Vikas Nagar, Lucknow', 26.8950, 80.9535, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 13 years of trusted field experience in Vikas Nagar.', 4.9,
  74, 112, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'babloo.malhotra.laundry1@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sachin Awasthi', '9876500254', 'sachin.awasthi.laundry2@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 16,
  'Rajajipuram, Lucknow', 26.8495, 80.8950, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 16 years of trusted field experience in Rajajipuram.', 4.7,
  12, 61, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sachin.awasthi.laundry2@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sandeep Gautam', '9876500255', 'sandeep.gautam.laundry3@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 2,
  'Charbagh, Lucknow', 26.8320, 80.9180, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 2 years of trusted field experience in Charbagh.', 4.5,
  25, 35, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sandeep.gautam.laundry3@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Radha Verma', '9876500256', 'radha.verma.laundry4@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 5,
  'Chowk, Lucknow', 26.8695, 80.9105, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 5 years of trusted field experience in Chowk.', 4.3,
  38, 59, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'radha.verma.laundry4@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kapil Chauhan', '9876500257', 'kapil.chauhan.laundry5@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 8,
  'Krishna Nagar, Lucknow', 26.8010, 80.8920, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 8 years of trusted field experience in Krishna Nagar.', 5,
  51, 83, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kapil.chauhan.laundry5@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Tarun Khan', '9876500258', 'tarun.khan.laundry6@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 11,
  'Sushant Golf City, Lucknow', 26.7865, 81.0035, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 11 years of trusted field experience in Sushant Golf City.', 4.8,
  64, 107, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'tarun.khan.laundry6@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Abhishek Chaurasia', '9876500259', 'abhishek.chaurasia.laundry7@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 14,
  'Telibagh, Lucknow', 26.7875, 80.9410, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 14 years of trusted field experience in Telibagh.', 4.6,
  77, 131, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'abhishek.chaurasia.laundry7@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Rani Dwivedi', '9876500260', 'rani.dwivedi.laundry8@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 17,
  'Kalyanpur, Lucknow', 26.9120, 80.9690, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 17 years of trusted field experience in Kalyanpur.', 4.4,
  15, 30, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'rani.dwivedi.laundry8@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neeraj Tandon', '9876500261', 'neeraj.tandon.laundry9@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 3,
  'Gomti Nagar, Lucknow', 26.8505, 80.9965, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 3 years of trusted field experience in Gomti Nagar.', 4.2,
  28, 54, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neeraj.tandon.laundry9@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Umesh Bhardwaj', '9876500262', 'umesh.bhardwaj.laundry10@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 6,
  'Indira Nagar, Lucknow', 26.8830, 80.9850, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 6 years of trusted field experience in Indira Nagar.', 4.9,
  41, 78, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'umesh.bhardwaj.laundry10@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Girish Kumar', '9876500263', 'girish.kumar.laundry11@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 9,
  'Aliganj, Lucknow', 26.8925, 80.9405, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 9 years of trusted field experience in Aliganj.', 4.7,
  54, 102, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'girish.kumar.laundry11@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sunita Rathore', '9876500264', 'sunita.rathore.laundry12@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 12,
  'Hazratganj, Lucknow', 26.8530, 80.9480, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 12 years of trusted field experience in Hazratganj.', 4.5,
  67, 76, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sunita.rathore.laundry12@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepak Prajapati', '9876500265', 'deepak.prajapati.laundry13@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 15,
  'Mahanagar, Lucknow', 26.8765, 80.9500, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 15 years of trusted field experience in Mahanagar.', 4.3,
  80, 100, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepak.prajapati.laundry13@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramesh Paswan', '9876500266', 'ramesh.paswan.laundry14@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 18,
  'Alambagh, Lucknow', 26.8075, 80.8995, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 18 years of trusted field experience in Alambagh.', 5,
  18, 49, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramesh.paswan.laundry14@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Babloo Saxena', '9876500267', 'babloo.saxena.laundry15@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 4,
  'Ashiyana, Lucknow', 26.7880, 80.9020, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 4 years of trusted field experience in Ashiyana.', 4.8,
  31, 73, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'babloo.saxena.laundry15@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Meera Joshi', '9876500268', 'meera.joshi.laundry16@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 7,
  'Jankipuram, Lucknow', 26.9105, 80.9465, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 7 years of trusted field experience in Jankipuram.', 4.6,
  44, 97, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'meera.joshi.laundry16@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sandeep Chaturvedi', '9876500269', 'sandeep.chaturvedi.laundry17@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 10,
  'Vikas Nagar, Lucknow', 26.8980, 80.9550, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 10 years of trusted field experience in Vikas Nagar.', 4.4,
  57, 71, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sandeep.chaturvedi.laundry17@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Ramakant Sonkar', '9876500270', 'ramakant.sonkar.laundry18@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 13,
  'Rajajipuram, Lucknow', 26.8525, 80.8890, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 13 years of trusted field experience in Rajajipuram.', 4.2,
  70, 95, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'ramakant.sonkar.laundry18@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Kapil Tiwari', '9876500271', 'kapil.tiwari.laundry19@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 16,
  'Charbagh, Lucknow', 26.8350, 80.9195, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 16 years of trusted field experience in Charbagh.', 4.9,
  83, 119, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'kapil.tiwari.laundry19@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Usha Maurya', '9876500272', 'usha.maurya.laundry20@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 2,
  'Chowk, Lucknow', 26.8725, 80.9120, 15.0, 'VERIFIED',
  'OFFLINE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 2 years of trusted field experience in Chowk.', 4.7,
  21, 68, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'usha.maurya.laundry20@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Abhishek Bind', '9876500273', 'abhishek.bind.laundry21@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 5,
  'Krishna Nagar, Lucknow', 26.7935, 80.8935, 15.0, 'VERIFIED',
  'ON_DUTY', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 5 years of trusted field experience in Krishna Nagar.', 4.5,
  34, 42, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'abhishek.bind.laundry21@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Chandan Shukla', '9876500274', 'chandan.shukla.laundry22@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 8,
  'Sushant Golf City, Lucknow', 26.7790, 81.0050, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 8 years of trusted field experience in Sushant Golf City.', 4.3,
  47, 66, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'chandan.shukla.laundry22@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neeraj Rastogi', '9876500275', 'neeraj.rastogi.laundry23@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 11,
  'Telibagh, Lucknow', 26.7905, 80.9350, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 11 years of trusted field experience in Telibagh.', 5,
  60, 90, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neeraj.rastogi.laundry23@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Jyoti Dixit', '9876500276', 'jyoti.dixit.laundry24@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 14,
  'Kalyanpur, Lucknow', 26.9150, 80.9705, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 14 years of trusted field experience in Kalyanpur.', 4.8,
  73, 114, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'jyoti.dixit.laundry24@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Girish Nigam', '9876500277', 'girish.nigam.laundry25@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 17,
  'Gomti Nagar, Lucknow', 26.8535, 80.9980, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 17 years of trusted field experience in Gomti Nagar.', 4.6,
  11, 63, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'girish.nigam.laundry25@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Sumit Sharma', '9876500278', 'sumit.sharma.laundry26@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 3,
  'Indira Nagar, Lucknow', 26.8860, 80.9865, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 3 years of trusted field experience in Indira Nagar.', 4.4,
  24, 37, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Self', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'sumit.sharma.laundry26@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Deepak Arif', '9876500279', 'deepak.arif.laundry27@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 6,
  'Aliganj, Lucknow', 26.8955, 80.9420, 15.0, 'VERIFIED',
  'AVAILABLE', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 6 years of trusted field experience in Aliganj.', 4.2,
  37, 61, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Verified by Cooperative Federation on-boarding board with background verification cleared.', 'Society', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'deepak.arif.laundry27@cooperativegig.in');

INSERT INTO workers (
  full_name, phone, email, password, skill, experience_years,
  location, latitude, longitude, service_radius_km, status,
  current_availability, profile_photo, bio, average_rating,
  total_ratings, completed_jobs_count, working_days, shift_start_time,
  shift_end_time, verification_notes, invited_by, created_at
)
SELECT
  'Neha Srivastava', '9876500280', 'neha.srivastava.laundry28@cooperativegig.in', '$2a$10$ehaXU3KrtXxnuX/lSoVHLOZHyuFaKoFhMb/PKC5bdw/qZ0QWj4Vc2', 'Laundry', 9,
  'Hazratganj, Lucknow', 26.8455, 80.9420, 15.0, 'PENDING_VERIFICATION',
  'ON_DUTY', NULL, 'Garment care specialist providing doorstep pickup, steam pressing, fabric conditioning, and delicate wear care. Over 9 years of trusted field experience in Hazratganj.', 4.9,
  50, 85, 'Mon, Tue, Wed, Thu, Fri, Sat', '09:00 AM',
  '07:00 PM', 'Submitted Aadhaar card and trade certification; pending physical address check.', 'Cooperative', '2026-09-01 11:00:00'
WHERE NOT EXISTS (SELECT 1 FROM workers WHERE email = 'neha.srivastava.laundry28@cooperativegig.in');

-- =============================================================================
-- 4. SEED 120 REALISTIC SERVICE REQUESTS / BOOKINGS
-- Using Subqueries for Foreign Keys to Guarantee Absolute Referential Integrity
-- =============================================================================
INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen sink faucet water pressure issue and replacement pipe fitting.',
  'Gomti Nagar, Lucknow',
  '2026-09-02',
  'Morning (8:00 AM - 11:00 AM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 11:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'customer@example.com'
  AND w.email = 'manoj.rathore.plumbing1@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen sink faucet water pressure issue and replacement pipe fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Gomti Nagar, Lucknow',
  '2026-09-03',
  'Morning (9:00 AM - 12:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 13:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rohit.mehta@example.com'
  AND w.email = 'dharmendra.devi.acrepairmaintenance2@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Indira Nagar, Lucknow',
  '2026-09-04',
  'Afternoon (1:00 PM - 4:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 15:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'sneha.patel@example.com'
  AND w.email = 'pankaj.khan.electricalservices3@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Aliganj, Lucknow',
  '2026-09-05',
  'Afternoon (2:00 PM - 5:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 17:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikram.singh@example.com'
  AND w.email = 'manju.srivastava.cleaningservices4@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Hazratganj, Lucknow',
  '2026-09-02',
  'Evening (4:00 PM - 7:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 19:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ananya.gupta@example.com'
  AND w.email = 'ramakant.kanojia.carpenter5@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Mahanagar, Lucknow',
  '2026-09-03',
  'Evening (5:00 PM - 8:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 21:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'manish.tiwari@example.com'
  AND w.email = 'vishal.shukla.painting6@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Alambagh, Lucknow',
  '2026-09-04',
  'Morning (8:00 AM - 11:00 AM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 23:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pooja.shukla@example.com'
  AND w.email = 'pawan.pandey.masonconstruction7@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Ashiyana, Lucknow',
  '2026-09-05',
  'Morning (9:00 AM - 12:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 01:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'savita.joshi.driver8@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Jankipuram, Lucknow',
  '2026-09-02',
  'Afternoon (1:00 PM - 4:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 03:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'manju.nayan.cookingservices9@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Vikas Nagar, Lucknow',
  '2026-09-03',
  'Afternoon (2:00 PM - 5:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 05:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'umesh.bhardwaj.laundry10@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Washing machine water inlet pipe installation and drainage fitting.',
  'Rajajipuram, Lucknow',
  '2026-09-04',
  'Evening (4:00 PM - 7:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 07:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'omkar.shukla.plumbing11@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Washing machine water inlet pipe installation and drainage fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Charbagh, Lucknow',
  '2026-09-05',
  'Evening (5:00 PM - 8:00 PM)',
  'PENDING',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'sunita.pandey.acrepairmaintenance12@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main bathroom pipeline pressure inspection and leak arrest.',
  'Aliganj, Lucknow',
  '2026-09-01',
  'Morning (8:00 AM - 11:00 AM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 10:00:00',
  NULL,
  NULL,
  '2026-09-01 07:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikram.singh@example.com'
  AND w.email = 'santosh.chaturvedi.plumbing6@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main bathroom pipeline pressure inspection and leak arrest.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Window AC cooling coil chemical cleaning and compressor check.',
  'Hazratganj, Lucknow',
  '2026-09-01',
  'Morning (9:00 AM - 12:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 09:00:00',
  NULL,
  NULL,
  '2026-09-01 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ananya.gupta@example.com'
  AND w.email = 'vinod.jaiswal.acrepairmaintenance7@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Window AC cooling coil chemical cleaning and compressor check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'LED concealed panel lighting installation in living room.',
  'Mahanagar, Lucknow',
  '2026-09-01',
  'Afternoon (1:00 PM - 4:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 08:00:00',
  NULL,
  NULL,
  '2026-09-01 05:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'manish.tiwari@example.com'
  AND w.email = 'reena.kumar.electricalservices8@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'LED concealed panel lighting installation in living room.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Balcony pressure washing and post-renovation dust cleanup.',
  'Alambagh, Lucknow',
  '2026-09-01',
  'Afternoon (2:00 PM - 5:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 07:00:00',
  NULL,
  NULL,
  '2026-09-01 04:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pooja.shukla@example.com'
  AND w.email = 'pooja.soni.cleaningservices9@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Balcony pressure washing and post-renovation dust cleanup.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Balcony wooden door alignment and heavy safety latch replacement.',
  'Ashiyana, Lucknow',
  '2026-09-01',
  'Evening (4:00 PM - 7:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 06:00:00',
  NULL,
  NULL,
  '2026-09-01 03:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'neeraj.chauhan.carpenter10@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Balcony wooden door alignment and heavy safety latch replacement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Bedroom waterproof putty and anti-fungal emulsion coating.',
  'Jankipuram, Lucknow',
  '2026-09-01',
  'Evening (5:00 PM - 8:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 05:00:00',
  NULL,
  NULL,
  '2026-09-01 02:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'hemant.arif.painting11@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Bedroom waterproof putty and anti-fungal emulsion coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Terrace parapet wall waterproofing and cement mortar finish.',
  'Vikas Nagar, Lucknow',
  '2026-09-01',
  'Morning (8:00 AM - 11:00 AM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 10:00:00',
  NULL,
  NULL,
  '2026-09-01 01:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'sarita.rawat.masonconstruction12@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Terrace parapet wall waterproofing and cement mortar finish.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Corporate transit drive for executive meetings in Hazratganj.',
  'Rajajipuram, Lucknow',
  '2026-09-01',
  'Morning (9:00 AM - 12:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 09:00:00',
  NULL,
  NULL,
  '2026-09-01 00:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'sanjay.bind.driver13@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Corporate transit drive for executive meetings in Hazratganj.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Homestyle lunch box preparation and kitchen sanitization.',
  'Charbagh, Lucknow',
  '2026-09-01',
  'Afternoon (1:00 PM - 4:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 08:00:00',
  NULL,
  NULL,
  '2026-09-01 07:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'pooja.mehta.cookingservices14@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Homestyle lunch box preparation and kitchen sanitization.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Curtains steam pressing and winter woolens fabric care.',
  'Chowk, Lucknow',
  '2026-09-01',
  'Afternoon (2:00 PM - 5:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 07:00:00',
  NULL,
  NULL,
  '2026-09-01 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shreya.pandey@example.com'
  AND w.email = 'babloo.saxena.laundry15@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Curtains steam pressing and winter woolens fabric care.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Under-sink RO water purifier plumbing valve connection repair.',
  'Krishna Nagar, Lucknow',
  '2026-09-02',
  'Evening (4:00 PM - 7:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 06:00:00',
  NULL,
  NULL,
  '2026-09-01 05:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'alok.tripathi@example.com'
  AND w.email = 'deepika.arif.plumbing16@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Under-sink RO water purifier plumbing valve connection repair.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Window AC cooling coil chemical cleaning and compressor check.',
  'Sushant Golf City, Lucknow',
  '2026-09-02',
  'Evening (5:00 PM - 8:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 05:00:00',
  NULL,
  NULL,
  '2026-09-01 04:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ritu.agarwal@example.com'
  AND w.email = 'ajay.rawat.acrepairmaintenance17@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Window AC cooling coil chemical cleaning and compressor check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'LED concealed panel lighting installation in living room.',
  'Telibagh, Lucknow',
  '2026-09-02',
  'Morning (8:00 AM - 11:00 AM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 10:00:00',
  NULL,
  NULL,
  '2026-09-01 03:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'gaurav.rastogi@example.com'
  AND w.email = 'gaurav.bind.electricalservices18@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'LED concealed panel lighting installation in living room.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Balcony pressure washing and post-renovation dust cleanup.',
  'Kalyanpur, Lucknow',
  '2026-09-02',
  'Morning (9:00 AM - 12:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 09:00:00',
  NULL,
  NULL,
  '2026-09-01 02:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'divya.tandon@example.com'
  AND w.email = 'sadhana.mehta.cleaningservices19@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Balcony pressure washing and post-renovation dust cleanup.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Balcony wooden door alignment and heavy safety latch replacement.',
  'Gomti Nagar, Lucknow',
  '2026-09-02',
  'Afternoon (1:00 PM - 4:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 08:00:00',
  NULL,
  NULL,
  '2026-09-01 01:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'mohit.awasthi@example.com'
  AND w.email = 'priya.saxena.carpenter20@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Balcony wooden door alignment and heavy safety latch replacement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Bedroom waterproof putty and anti-fungal emulsion coating.',
  'Indira Nagar, Lucknow',
  '2026-09-02',
  'Afternoon (2:00 PM - 5:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 07:00:00',
  NULL,
  NULL,
  '2026-09-01 00:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shalini.joshi@example.com'
  AND w.email = 'ravi.tripathi.painting21@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Bedroom waterproof putty and anti-fungal emulsion coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Terrace parapet wall waterproofing and cement mortar finish.',
  'Aliganj, Lucknow',
  '2026-09-02',
  'Evening (4:00 PM - 7:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 06:00:00',
  NULL,
  NULL,
  '2026-09-01 07:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'aditya.dubey@example.com'
  AND w.email = 'vikas.tandon.masonconstruction22@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Terrace parapet wall waterproofing and cement mortar finish.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Corporate transit drive for executive meetings in Hazratganj.',
  'Hazratganj, Lucknow',
  '2026-09-02',
  'Evening (5:00 PM - 8:00 PM)',
  'ACCEPTED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 05:00:00',
  NULL,
  NULL,
  '2026-09-01 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'meera.kapoor@example.com'
  AND w.email = 'lalit.dubey.driver23@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Corporate transit drive for executive meetings in Hazratganj.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Overhead tank water float valve replacement and overflow check.',
  'Ashiyana, Lucknow',
  '2026-09-01',
  'Morning (8:00 AM - 11:00 AM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 09:00:00',
  '2026-09-01 10:30:00',
  NULL,
  '2026-09-01 07:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'omkar.shukla.plumbing11@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Overhead tank water float valve replacement and overflow check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'AC indoor unit water leakage inspection and drainage slope fix.',
  'Jankipuram, Lucknow',
  '2026-09-01',
  'Morning (9:00 AM - 12:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 08:00:00',
  '2026-09-01 10:20:00',
  NULL,
  '2026-09-01 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'sunita.pandey.acrepairmaintenance12@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'AC indoor unit water leakage inspection and drainage slope fix.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Geyser power socket overheating repair and 16A switch fitting.',
  'Vikas Nagar, Lucknow',
  '2026-09-01',
  'Afternoon (1:00 PM - 4:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 07:00:00',
  '2026-09-01 10:10:00',
  NULL,
  '2026-09-01 05:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'kuldeep.joshi.electricalservices13@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Geyser power socket overheating repair and 16A switch fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Pre-festival full 3BHK deep sanitization and kitchen floor scrubbing.',
  'Rajajipuram, Lucknow',
  '2026-09-01',
  'Afternoon (2:00 PM - 5:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 06:00:00',
  '2026-09-01 10:00:00',
  NULL,
  '2026-09-01 04:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'radha.nayan.cleaningservices14@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Pre-festival full 3BHK deep sanitization and kitchen floor scrubbing.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wardrobe slider rail repair and lock replacement.',
  'Charbagh, Lucknow',
  '2026-09-01',
  'Evening (4:00 PM - 7:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 05:00:00',
  '2026-09-01 09:50:00',
  NULL,
  '2026-09-01 03:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'ramesh.bhardwaj.carpenter15@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wardrobe slider rail repair and lock replacement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Balcony ceiling weather-guard paint coating against seepage.',
  'Chowk, Lucknow',
  '2026-09-01',
  'Evening (5:00 PM - 8:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 04:00:00',
  '2026-09-01 09:40:00',
  NULL,
  '2026-09-01 02:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shreya.pandey@example.com'
  AND w.email = 'mamta.upadhyay.painting16@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Balcony ceiling weather-guard paint coating against seepage.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen platform granite counter edge support re-cementing.',
  'Krishna Nagar, Lucknow',
  '2026-09-01',
  'Morning (8:00 AM - 11:00 AM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 03:00:00',
  '2026-09-01 09:30:00',
  NULL,
  '2026-09-01 01:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'alok.tripathi@example.com'
  AND w.email = 'alok.verma.masonconstruction17@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen platform granite counter edge support re-cementing.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Weekend round trip chauffeur service to Ayodhya.',
  'Sushant Golf City, Lucknow',
  '2026-09-01',
  'Morning (9:00 AM - 12:00 PM)',
  'IN_PROGRESS',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-09-01 02:00:00',
  '2026-09-01 09:20:00',
  NULL,
  '2026-09-01 00:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ritu.agarwal@example.com'
  AND w.email = 'dinesh.sharma.driver18@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Weekend round trip chauffeur service to Ayodhya.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen sink faucet water pressure issue and replacement pipe fitting.',
  'Indira Nagar, Lucknow',
  '2026-08-31',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-31 08:00:00',
  '2026-08-31 09:00:00',
  '2026-08-31 11:00:00',
  '2026-08-31 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'sneha.patel@example.com'
  AND w.email = 'divya.saxena.plumbing4@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen sink faucet water pressure issue and replacement pipe fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Aliganj, Lucknow',
  '2026-08-30',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-30 08:00:00',
  '2026-08-30 09:00:00',
  '2026-08-30 11:00:00',
  '2026-08-30 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikram.singh@example.com'
  AND w.email = 'harish.tripathi.acrepairmaintenance5@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Hazratganj, Lucknow',
  '2026-08-29',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  299,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-29 08:00:00',
  '2026-08-29 09:00:00',
  '2026-08-29 11:00:00',
  '2026-08-29 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ananya.gupta@example.com'
  AND w.email = 'pradeep.tandon.electricalservices6@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Mahanagar, Lucknow',
  '2026-08-28',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-28 08:00:00',
  '2026-08-28 09:00:00',
  '2026-08-28 11:00:00',
  '2026-08-28 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'manish.tiwari@example.com'
  AND w.email = 'rashmi.dubey.cleaningservices7@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Alambagh, Lucknow',
  '2026-08-27',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-27 08:00:00',
  '2026-08-27 09:00:00',
  '2026-08-27 11:00:00',
  '2026-08-27 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pooja.shukla@example.com'
  AND w.email = 'geeta.gautam.carpenter8@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Ashiyana, Lucknow',
  '2026-08-26',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-26 08:00:00',
  '2026-08-26 09:00:00',
  '2026-08-26 11:00:00',
  '2026-08-26 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'kamlesh.nigam.painting9@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Jankipuram, Lucknow',
  '2026-08-25',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  550,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-25 08:00:00',
  '2026-08-25 09:00:00',
  '2026-08-25 11:00:00',
  '2026-08-25 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'prashant.yadav.masonconstruction10@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Vikas Nagar, Lucknow',
  '2026-08-24',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  500,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-24 08:00:00',
  '2026-08-24 09:00:00',
  '2026-08-24 11:00:00',
  '2026-08-24 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'kunal.tiwari.driver11@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Rajajipuram, Lucknow',
  '2026-08-23',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  350,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-23 08:00:00',
  '2026-08-23 09:00:00',
  '2026-08-23 11:00:00',
  '2026-08-23 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'rashmi.vishwakarma.cookingservices12@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Charbagh, Lucknow',
  '2026-08-22',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-22 08:00:00',
  '2026-08-22 09:00:00',
  '2026-08-22 11:00:00',
  '2026-08-22 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'deepak.prajapati.laundry13@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Washing machine water inlet pipe installation and drainage fitting.',
  'Chowk, Lucknow',
  '2026-08-21',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'RESOLVED',
  'Artisan arrived 45 minutes past scheduled window due to city parade route diversion.',
  'Cooperative coordinator verified traffic delay. Artisan waived emergency surcharge and completed service to satisfaction.',
  349,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-21 08:00:00',
  '2026-08-21 09:00:00',
  '2026-08-21 11:00:00',
  '2026-08-21 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shreya.pandey@example.com'
  AND w.email = 'rajesh.nigam.plumbing14@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Washing machine water inlet pipe installation and drainage fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Krishna Nagar, Lucknow',
  '2026-08-20',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-20 08:00:00',
  '2026-08-20 09:00:00',
  '2026-08-20 11:00:00',
  '2026-08-20 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'alok.tripathi@example.com'
  AND w.email = 'sunil.yadav.acrepairmaintenance15@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Sushant Golf City, Lucknow',
  '2026-08-19',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  199,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-19 08:00:00',
  '2026-08-19 09:00:00',
  '2026-08-19 11:00:00',
  '2026-08-19 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ritu.agarwal@example.com'
  AND w.email = 'pushpa.tiwari.electricalservices16@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Telibagh, Lucknow',
  '2026-08-18',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-18 08:00:00',
  '2026-08-18 09:00:00',
  '2026-08-18 11:00:00',
  '2026-08-18 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'gaurav.rastogi@example.com'
  AND w.email = 'sarita.vishwakarma.cleaningservices17@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Kalyanpur, Lucknow',
  '2026-08-17',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-17 08:00:00',
  '2026-08-17 09:00:00',
  '2026-08-17 11:00:00',
  '2026-08-17 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'divya.tandon@example.com'
  AND w.email = 'sandeep.prajapati.carpenter18@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Gomti Nagar, Lucknow',
  '2026-08-16',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  749,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-16 08:00:00',
  '2026-08-16 09:00:00',
  '2026-08-16 11:00:00',
  '2026-08-16 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'mohit.awasthi@example.com'
  AND w.email = 'santosh.kashyap.painting19@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Indira Nagar, Lucknow',
  '2026-08-15',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-15 08:00:00',
  '2026-08-15 09:00:00',
  '2026-08-15 11:00:00',
  '2026-08-15 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shalini.joshi@example.com'
  AND w.email = 'shreya.chaurasia.masonconstruction20@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Aliganj, Lucknow',
  '2026-08-14',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  400,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-14 08:00:00',
  '2026-08-14 09:00:00',
  '2026-08-14 11:00:00',
  '2026-08-14 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'aditya.dubey@example.com'
  AND w.email = 'jagdish.singh.driver21@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Hazratganj, Lucknow',
  '2026-08-13',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-13 08:00:00',
  '2026-08-13 09:00:00',
  '2026-08-13 11:00:00',
  '2026-08-13 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'meera.kapoor@example.com'
  AND w.email = 'sarita.malhotra.cookingservices22@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Mahanagar, Lucknow',
  '2026-08-12',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-12 08:00:00',
  '2026-08-12 09:00:00',
  '2026-08-12 11:00:00',
  '2026-08-12 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikas.chaturvedi@example.com'
  AND w.email = 'neeraj.rastogi.laundry23@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Overhead tank water float valve replacement and overflow check.',
  'Alambagh, Lucknow',
  '2026-08-11',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-11 08:00:00',
  '2026-08-11 09:00:00',
  '2026-08-11 11:00:00',
  '2026-08-11 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'kunal.bhardwaj@example.com'
  AND w.email = 'sadhana.kashyap.plumbing24@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Overhead tank water float valve replacement and overflow check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Ashiyana, Lucknow',
  '2026-08-10',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-10 08:00:00',
  '2026-08-10 09:00:00',
  '2026-08-10 11:00:00',
  '2026-08-10 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'swati.gautam@example.com'
  AND w.email = 'prashant.chaurasia.acrepairmaintenance25@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Jankipuram, Lucknow',
  '2026-08-09',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  299,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-09 08:00:00',
  '2026-08-09 09:00:00',
  '2026-08-09 11:00:00',
  '2026-08-09 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pawan.sahu@example.com'
  AND w.email = 'kunal.singh.electricalservices26@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Vikas Nagar, Lucknow',
  '2026-08-08',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-08 08:00:00',
  '2026-08-08 09:00:00',
  '2026-08-08 11:00:00',
  '2026-08-08 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'nitin.jaiswal@example.com'
  AND w.email = 'shanti.malhotra.cleaningservices27@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Rajajipuram, Lucknow',
  '2026-08-07',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-07 08:00:00',
  '2026-08-07 09:00:00',
  '2026-08-07 11:00:00',
  '2026-08-07 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'preeti.upadhyay@example.com'
  AND w.email = 'maya.rastogi.carpenter28@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Charbagh, Lucknow',
  '2026-08-06',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'RESOLVED',
  'Minor water drip from drainage pipe after initial cooling cycle.',
  'Technician revisited within 2 hours, re-aligned drainage slope, and confirmed leak-free operation.',
  649,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-06 08:00:00',
  '2026-08-06 09:00:00',
  '2026-08-06 11:00:00',
  '2026-08-06 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'saurabh.nigam@example.com'
  AND w.email = 'suresh.chaturvedi.painting1@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Chowk, Lucknow',
  '2026-08-05',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  550,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-05 08:00:00',
  '2026-08-05 09:00:00',
  '2026-08-05 11:00:00',
  '2026-08-05 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'anjali.sonkar@example.com'
  AND w.email = 'ajay.jaiswal.masonconstruction2@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Krishna Nagar, Lucknow',
  '2026-08-04',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  500,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-04 08:00:00',
  '2026-08-04 09:00:00',
  '2026-08-04 11:00:00',
  '2026-08-04 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'jitendra.kashyap@example.com'
  AND w.email = 'gaurav.kumar.driver3@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Gomti Nagar, Lucknow',
  '2026-08-31',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  350,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-31 08:00:00',
  '2026-08-31 09:00:00',
  '2026-08-31 11:00:00',
  '2026-08-31 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'customer@example.com'
  AND w.email = 'divya.soni.cookingservices4@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Gomti Nagar, Lucknow',
  '2026-08-30',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-30 08:00:00',
  '2026-08-30 09:00:00',
  '2026-08-30 11:00:00',
  '2026-08-30 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rohit.mehta@example.com'
  AND w.email = 'kapil.chauhan.laundry5@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen sink faucet water pressure issue and replacement pipe fitting.',
  'Indira Nagar, Lucknow',
  '2026-08-29',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-29 08:00:00',
  '2026-08-29 09:00:00',
  '2026-08-29 11:00:00',
  '2026-08-29 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'sneha.patel@example.com'
  AND w.email = 'santosh.chaturvedi.plumbing6@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen sink faucet water pressure issue and replacement pipe fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Aliganj, Lucknow',
  '2026-08-28',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-28 08:00:00',
  '2026-08-28 09:00:00',
  '2026-08-28 11:00:00',
  '2026-08-28 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikram.singh@example.com'
  AND w.email = 'vinod.jaiswal.acrepairmaintenance7@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Hazratganj, Lucknow',
  '2026-08-27',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  199,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-27 08:00:00',
  '2026-08-27 09:00:00',
  '2026-08-27 11:00:00',
  '2026-08-27 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ananya.gupta@example.com'
  AND w.email = 'reena.kumar.electricalservices8@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Mahanagar, Lucknow',
  '2026-08-26',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-26 08:00:00',
  '2026-08-26 09:00:00',
  '2026-08-26 11:00:00',
  '2026-08-26 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'manish.tiwari@example.com'
  AND w.email = 'pooja.soni.cleaningservices9@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Alambagh, Lucknow',
  '2026-08-25',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-25 08:00:00',
  '2026-08-25 09:00:00',
  '2026-08-25 11:00:00',
  '2026-08-25 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pooja.shukla@example.com'
  AND w.email = 'neeraj.chauhan.carpenter10@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Ashiyana, Lucknow',
  '2026-08-24',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  749,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-24 08:00:00',
  '2026-08-24 09:00:00',
  '2026-08-24 11:00:00',
  '2026-08-24 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'hemant.arif.painting11@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Jankipuram, Lucknow',
  '2026-08-23',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-23 08:00:00',
  '2026-08-23 09:00:00',
  '2026-08-23 11:00:00',
  '2026-08-23 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'sarita.rawat.masonconstruction12@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Vikas Nagar, Lucknow',
  '2026-08-22',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  400,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-22 08:00:00',
  '2026-08-22 09:00:00',
  '2026-08-22 11:00:00',
  '2026-08-22 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'sanjay.bind.driver13@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Rajajipuram, Lucknow',
  '2026-08-21',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-21 08:00:00',
  '2026-08-21 09:00:00',
  '2026-08-21 11:00:00',
  '2026-08-21 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'pooja.mehta.cookingservices14@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Charbagh, Lucknow',
  '2026-08-20',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-20 08:00:00',
  '2026-08-20 09:00:00',
  '2026-08-20 11:00:00',
  '2026-08-20 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'babloo.saxena.laundry15@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Washing machine water inlet pipe installation and drainage fitting.',
  'Chowk, Lucknow',
  '2026-08-19',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-19 08:00:00',
  '2026-08-19 09:00:00',
  '2026-08-19 11:00:00',
  '2026-08-19 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shreya.pandey@example.com'
  AND w.email = 'deepika.arif.plumbing16@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Washing machine water inlet pipe installation and drainage fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Krishna Nagar, Lucknow',
  '2026-08-18',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-18 08:00:00',
  '2026-08-18 09:00:00',
  '2026-08-18 11:00:00',
  '2026-08-18 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'alok.tripathi@example.com'
  AND w.email = 'ajay.rawat.acrepairmaintenance17@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Sushant Golf City, Lucknow',
  '2026-08-17',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  299,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-17 08:00:00',
  '2026-08-17 09:00:00',
  '2026-08-17 11:00:00',
  '2026-08-17 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ritu.agarwal@example.com'
  AND w.email = 'gaurav.bind.electricalservices18@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Telibagh, Lucknow',
  '2026-08-16',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-16 08:00:00',
  '2026-08-16 09:00:00',
  '2026-08-16 11:00:00',
  '2026-08-16 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'gaurav.rastogi@example.com'
  AND w.email = 'sadhana.mehta.cleaningservices19@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Kalyanpur, Lucknow',
  '2026-08-15',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-15 08:00:00',
  '2026-08-15 09:00:00',
  '2026-08-15 11:00:00',
  '2026-08-15 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'divya.tandon@example.com'
  AND w.email = 'priya.saxena.carpenter20@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Gomti Nagar, Lucknow',
  '2026-08-14',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'RESOLVED',
  'Pricing discrepancy regarding replacement MCB switch unit cost.',
  'Cooperative mediator verified vendor parts invoice. Extra ₹80 refunded to customer wallet.',
  649,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-14 08:00:00',
  '2026-08-14 09:00:00',
  '2026-08-14 11:00:00',
  '2026-08-14 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'mohit.awasthi@example.com'
  AND w.email = 'ravi.tripathi.painting21@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Indira Nagar, Lucknow',
  '2026-08-13',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  550,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-13 08:00:00',
  '2026-08-13 09:00:00',
  '2026-08-13 11:00:00',
  '2026-08-13 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shalini.joshi@example.com'
  AND w.email = 'vikas.tandon.masonconstruction22@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Aliganj, Lucknow',
  '2026-08-12',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  500,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-12 08:00:00',
  '2026-08-12 09:00:00',
  '2026-08-12 11:00:00',
  '2026-08-12 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'aditya.dubey@example.com'
  AND w.email = 'lalit.dubey.driver23@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Hazratganj, Lucknow',
  '2026-08-11',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  350,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-11 08:00:00',
  '2026-08-11 09:00:00',
  '2026-08-11 11:00:00',
  '2026-08-11 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'meera.kapoor@example.com'
  AND w.email = 'sadhana.gautam.cookingservices24@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Mahanagar, Lucknow',
  '2026-08-10',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-10 08:00:00',
  '2026-08-10 09:00:00',
  '2026-08-10 11:00:00',
  '2026-08-10 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikas.chaturvedi@example.com'
  AND w.email = 'girish.nigam.laundry25@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Overhead tank water float valve replacement and overflow check.',
  'Alambagh, Lucknow',
  '2026-08-09',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-09 08:00:00',
  '2026-08-09 09:00:00',
  '2026-08-09 11:00:00',
  '2026-08-09 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'kunal.bhardwaj@example.com'
  AND w.email = 'hemant.tripathi.plumbing26@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Overhead tank water float valve replacement and overflow check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Ashiyana, Lucknow',
  '2026-08-08',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-08 08:00:00',
  '2026-08-08 09:00:00',
  '2026-08-08 11:00:00',
  '2026-08-08 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'swati.gautam@example.com'
  AND w.email = 'devendra.tandon.acrepairmaintenance27@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Jankipuram, Lucknow',
  '2026-08-07',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  199,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-07 08:00:00',
  '2026-08-07 09:00:00',
  '2026-08-07 11:00:00',
  '2026-08-07 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pawan.sahu@example.com'
  AND w.email = 'suman.dubey.electricalservices28@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Vikas Nagar, Lucknow',
  '2026-08-06',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-06 08:00:00',
  '2026-08-06 09:00:00',
  '2026-08-06 11:00:00',
  '2026-08-06 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'nitin.jaiswal@example.com'
  AND w.email = 'pushpa.nigam.cleaningservices1@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Rajajipuram, Lucknow',
  '2026-08-05',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-05 08:00:00',
  '2026-08-05 09:00:00',
  '2026-08-05 11:00:00',
  '2026-08-05 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'preeti.upadhyay@example.com'
  AND w.email = 'babloo.yadav.carpenter2@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Charbagh, Lucknow',
  '2026-08-04',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  749,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-04 08:00:00',
  '2026-08-04 09:00:00',
  '2026-08-04 11:00:00',
  '2026-08-04 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'saurabh.nigam@example.com'
  AND w.email = 'nitin.tiwari.painting3@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Chowk, Lucknow',
  '2026-08-31',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-31 08:00:00',
  '2026-08-31 09:00:00',
  '2026-08-31 11:00:00',
  '2026-08-31 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'anjali.sonkar@example.com'
  AND w.email = 'pooja.vishwakarma.masonconstruction4@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Krishna Nagar, Lucknow',
  '2026-08-30',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  400,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-30 08:00:00',
  '2026-08-30 09:00:00',
  '2026-08-30 11:00:00',
  '2026-08-30 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'jitendra.kashyap@example.com'
  AND w.email = 'pradeep.prajapati.driver5@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Gomti Nagar, Lucknow',
  '2026-08-29',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  450,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-29 08:00:00',
  '2026-08-29 09:00:00',
  '2026-08-29 11:00:00',
  '2026-08-29 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'customer@example.com'
  AND w.email = 'pushpa.kashyap.cookingservices6@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Gomti Nagar, Lucknow',
  '2026-08-28',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-28 08:00:00',
  '2026-08-28 09:00:00',
  '2026-08-28 11:00:00',
  '2026-08-28 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rohit.mehta@example.com'
  AND w.email = 'abhishek.chaurasia.laundry7@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen sink faucet water pressure issue and replacement pipe fitting.',
  'Indira Nagar, Lucknow',
  '2026-08-27',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-27 08:00:00',
  '2026-08-27 09:00:00',
  '2026-08-27 11:00:00',
  '2026-08-27 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'sneha.patel@example.com'
  AND w.email = 'maya.tiwari.plumbing8@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen sink faucet water pressure issue and replacement pipe fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Aliganj, Lucknow',
  '2026-08-26',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-26 08:00:00',
  '2026-08-26 09:00:00',
  '2026-08-26 11:00:00',
  '2026-08-26 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikram.singh@example.com'
  AND w.email = 'vikas.vishwakarma.acrepairmaintenance9@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Hazratganj, Lucknow',
  '2026-08-25',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  299,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-25 08:00:00',
  '2026-08-25 09:00:00',
  '2026-08-25 11:00:00',
  '2026-08-25 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ananya.gupta@example.com'
  AND w.email = 'lalit.prajapati.electricalservices10@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Mahanagar, Lucknow',
  '2026-08-24',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  549,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-24 08:00:00',
  '2026-08-24 09:00:00',
  '2026-08-24 11:00:00',
  '2026-08-24 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'manish.tiwari@example.com'
  AND w.email = 'deepika.kashyap.cleaningservices11@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Wooden dining chair re-gluing and frame reinforcement.',
  'Alambagh, Lucknow',
  '2026-08-23',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Excellent service! The problem was resolved quickly and completely. Great cooperative initiative.',
  '2026-08-23 08:00:00',
  '2026-08-23 09:00:00',
  '2026-08-23 11:00:00',
  '2026-08-23 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'pooja.shukla@example.com'
  AND w.email = 'shanti.chaurasia.carpenter12@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Wooden dining chair re-gluing and frame reinforcement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room accent wall texture painting and primer coating.',
  'Ashiyana, Lucknow',
  '2026-08-22',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.6,
  'Polite demeanor and skilled workmanship. Reasonable pricing directly to the worker.',
  '2026-08-22 08:00:00',
  '2026-08-22 09:00:00',
  '2026-08-22 11:00:00',
  '2026-08-22 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'rajat.mishra@example.com'
  AND w.email = 'rajesh.singh.painting13@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room accent wall texture painting and primer coating.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Main gate boundary wall crack sealing and plaster restoration.',
  'Jankipuram, Lucknow',
  '2026-08-21',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  550,
  4.8,
  'Super efficient service. Explained maintenance tips to avoid recurring issues.',
  '2026-08-21 08:00:00',
  '2026-08-21 09:00:00',
  '2026-08-21 11:00:00',
  '2026-08-21 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'deepika.saxena@example.com'
  AND w.email = 'sunil.malhotra.masonconstruction14@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Main gate boundary wall crack sealing and plaster restoration.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Early morning airport drop from Gomti Nagar to Amausi Airport.',
  'Vikas Nagar, Lucknow',
  '2026-08-20',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  500,
  5,
  'Punctual, professional, and delivered top-notch results. Will definitely book again.',
  '2026-08-20 08:00:00',
  '2026-08-20 09:00:00',
  '2026-08-20 11:00:00',
  '2026-08-20 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'siddharth.verma@example.com'
  AND w.email = 'imran.rastogi.driver15@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Early morning airport drop from Gomti Nagar to Amausi Airport.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Special birthday celebration buffet meal preparation (10 guests).',
  'Rajajipuram, Lucknow',
  '2026-08-19',
  'Afternoon (1:00 PM - 4:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  350,
  4.5,
  'Job completed satisfactorily. Fair rates and verified artisan gave peace of mind.',
  '2026-08-19 08:00:00',
  '2026-08-19 09:00:00',
  '2026-08-19 11:00:00',
  '2026-08-19 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'neha.dwivedi@example.com'
  AND w.email = 'deepika.kushwaha.cookingservices16@cooperativegig.in'
  AND s.service_name = 'Cooking Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Special birthday celebration buffet meal preparation (10 guests).'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Traditional festive ethnic wear steam pressing and packaging.',
  'Charbagh, Lucknow',
  '2026-08-18',
  'Afternoon (2:00 PM - 5:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  249,
  4.9,
  'Outstanding work quality! Did not cut corners and verified everything worked before leaving.',
  '2026-08-18 08:00:00',
  '2026-08-18 09:00:00',
  '2026-08-18 11:00:00',
  '2026-08-18 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'karan.malhotra@example.com'
  AND w.email = 'sandeep.chaturvedi.laundry17@cooperativegig.in'
  AND s.service_name = 'Laundry'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Traditional festive ethnic wear steam pressing and packaging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Washing machine water inlet pipe installation and drainage fitting.',
  'Chowk, Lucknow',
  '2026-08-17',
  'Evening (4:00 PM - 7:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  349,
  5,
  'Prompt response! Fixed the issue within 30 minutes without any mess. Zero platform markup made it very affordable.',
  '2026-08-17 08:00:00',
  '2026-08-17 09:00:00',
  '2026-08-17 11:00:00',
  '2026-08-17 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shreya.pandey@example.com'
  AND w.email = 'nitin.singh.plumbing18@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Washing machine water inlet pipe installation and drainage fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter AC gas top-up and filter steam cleaning.',
  'Krishna Nagar, Lucknow',
  '2026-08-16',
  'Evening (5:00 PM - 8:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  649,
  4.8,
  'Very knowledgeable technician. Thorough inspection and transparent explanation of parts needed.',
  '2026-08-16 08:00:00',
  '2026-08-16 09:00:00',
  '2026-08-16 11:00:00',
  '2026-08-16 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'alok.tripathi@example.com'
  AND w.email = 'harish.malhotra.acrepairmaintenance19@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter AC gas top-up and filter steam cleaning.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Inverter battery wiring connection and circuit load check.',
  'Sushant Golf City, Lucknow',
  '2026-08-15',
  'Morning (8:00 AM - 11:00 AM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  199,
  4.9,
  'Clean work, punctual arrival, and great communication throughout. Highly recommend this cooperative artisan.',
  '2026-08-15 08:00:00',
  '2026-08-15 09:00:00',
  '2026-08-15 11:00:00',
  '2026-08-15 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'ritu.agarwal@example.com'
  AND w.email = 'komal.rastogi.electricalservices20@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Inverter battery wiring connection and circuit load check.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Sofa and upholstery steam shampoo cleaning and dust extraction.',
  'Telibagh, Lucknow',
  '2026-08-14',
  'Morning (9:00 AM - 12:00 PM)',
  'COMPLETED',
  'NONE',
  NULL,
  NULL,
  449,
  4.7,
  'Arrived on time with all necessary tools. Cleaned up the workspace after completing the task.',
  '2026-08-14 08:00:00',
  '2026-08-14 09:00:00',
  '2026-08-14 11:00:00',
  '2026-08-14 06:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'gaurav.rastogi@example.com'
  AND w.email = 'madhu.kushwaha.cleaningservices21@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Sofa and upholstery steam shampoo cleaning and dust extraction.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Bathroom shower mixer cartridge replacement and drainage unclogging.',
  'Telibagh, Lucknow',
  '2026-08-31',
  'Morning (8:00 AM - 11:00 AM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-31 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'gaurav.rastogi@example.com'
  AND w.email = 'vishal.upadhyay.plumbing21@cooperativegig.in'
  AND s.service_name = 'Plumbing'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Bathroom shower mixer cartridge replacement and drainage unclogging.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'PCB capacitor diagnostics and outdoor fan motor bearing servicing.',
  'Kalyanpur, Lucknow',
  '2026-08-30',
  'Morning (9:00 AM - 12:00 PM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-30 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'divya.tandon@example.com'
  AND w.email = 'pawan.verma.acrepairmaintenance22@cooperativegig.in'
  AND s.service_name = 'AC Repair & Maintenance'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'PCB capacitor diagnostics and outdoor fan motor bearing servicing.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Switchboard sparking and ceiling fan regulator replacement.',
  'Gomti Nagar, Lucknow',
  '2026-08-29',
  'Afternoon (1:00 PM - 4:00 PM)',
  'CANCELLED',
  'OPEN',
  'Customer requested emergency reschedule due to unexpected travel; requested slot re-booking without cancellation fee.',
  'Under active cooperative mediation: rescheduling slot for upcoming weekend.',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-29 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'mohit.awasthi@example.com'
  AND w.email = 'rahul.sharma.electricalservices23@cooperativegig.in'
  AND s.service_name = 'Electrical Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Switchboard sparking and ceiling fan regulator replacement.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Kitchen grease removal and chimney steam degreasing.',
  'Indira Nagar, Lucknow',
  '2026-08-28',
  'Afternoon (2:00 PM - 5:00 PM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-28 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'shalini.joshi@example.com'
  AND w.email = 'ananya.mishra.cleaningservices24@cooperativegig.in'
  AND s.service_name = 'Cleaning Services'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Kitchen grease removal and chimney steam degreasing.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Modular kitchen hydraulic hinge adjustment and cabinet handle fitting.',
  'Aliganj, Lucknow',
  '2026-08-27',
  'Evening (4:00 PM - 7:00 PM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-27 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'aditya.dubey@example.com'
  AND w.email = 'umesh.maurya.carpenter25@cooperativegig.in'
  AND s.service_name = 'Carpenter'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Modular kitchen hydraulic hinge adjustment and cabinet handle fitting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Interior door enamel paint touch-up and frame repainting.',
  'Hazratganj, Lucknow',
  '2026-08-26',
  'Evening (5:00 PM - 8:00 PM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-26 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'meera.kapoor@example.com'
  AND w.email = 'manohar.pal.painting26@cooperativegig.in'
  AND s.service_name = 'Painting'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Interior door enamel paint touch-up and frame repainting.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Living room vitrified floor tile grout repair and polish.',
  'Mahanagar, Lucknow',
  '2026-08-25',
  'Morning (8:00 AM - 11:00 AM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-25 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'vikas.chaturvedi@example.com'
  AND w.email = 'amit.paswan.masonconstruction27@cooperativegig.in'
  AND s.service_name = 'Mason / Construction'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Living room vitrified floor tile grout repair and polish.'
  )
LIMIT 1;

INSERT INTO service_requests (
  customer_id, worker_id, service_id, description, location,
  preferred_date, preferred_time, status, dispute_status,
  dispute_reason, dispute_resolution, amount_paid, rating,
  review_notes, accepted_at, started_at, completed_at, created_at
)
SELECT
  c.customer_id,
  w.worker_id,
  s.service_id,
  'Outstation transit drive from Lucknow to Kanpur round trip.',
  'Alambagh, Lucknow',
  '2026-08-24',
  'Morning (9:00 AM - 12:00 PM)',
  'CANCELLED',
  'NONE',
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  '2026-08-24 09:00:00'
FROM customers c
CROSS JOIN workers w
CROSS JOIN services s
WHERE c.email = 'kunal.bhardwaj@example.com'
  AND w.email = 'archana.patel.driver28@cooperativegig.in'
  AND s.service_name = 'Driver'
  AND NOT EXISTS (
    SELECT 1 FROM service_requests sr
    WHERE sr.customer_id = c.customer_id
      AND sr.worker_id = w.worker_id
      AND sr.description = 'Outstation transit drive from Lucknow to Kanpur round trip.'
  )
LIMIT 1;

-- =============================================================================
-- 5. SEED NOTIFICATIONS (20 Contextual System & Booking Alerts)
-- =============================================================================
INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Booking Confirmed #BK-1001', 'Your service request has been confirmed with your assigned cooperative artisan.', 'BOOKING', 0, '2026-09-01 10:00:00'
FROM customers c WHERE c.email = 'customer@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Booking Confirmed #BK-1001' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'New Job Assigned #BK-1001', 'New residential service request assigned in Gomti Nagar, Lucknow.', 'BOOKING', 0, '2026-09-01 10:00:00'
FROM workers w WHERE w.email = 'manoj.rathore.plumbing1@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'New Job Assigned #BK-1001' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Artisan On The Way #BK-1015', 'Your verified technician is en route to your address.', 'BOOKING', 1, '2026-09-01 08:00:00'
FROM customers c WHERE c.email = 'rohit.mehta@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Artisan On The Way #BK-1015' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Service Completed #BK-1038', 'Your AC servicing job has been completed. Thank you for choosing Cooperative Gig!', 'BOOKING', 1, '2026-08-31 11:00:00'
FROM customers c WHERE c.email = 'sneha.patel@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Service Completed #BK-1038' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'Direct Payout Credited', 'Full service earnings of ₹499 credited with 0% platform commission deduction.', 'SYSTEM', 0, '2026-08-31 11:00:00'
FROM workers w WHERE w.email = 'satish.joshi.plumbing5@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'Direct Payout Credited' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'ADMIN', c.customer_id, 'New Worker Verification Queue', 'New worker submitted trade certificates for verification review.', 'SYSTEM', 0, '2026-09-01 05:00:00'
FROM customers c WHERE c.email = 'admin@sih.gov.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'ADMIN' AND title = 'New Worker Verification Queue')
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'ADMIN', c.customer_id, 'Dispute Mediation Request', 'Open dispute registered for booking reschedule. Awaiting mediator slot confirmation.', 'DISPUTE', 0, '2026-08-31 23:00:00'
FROM customers c WHERE c.email = 'admin@sih.gov.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'ADMIN' AND title = 'Dispute Mediation Request')
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Dispute Resolved', 'Your service billing review has been resolved amicably by the cooperative mediator.', 'DISPUTE', 1, '2026-08-30 11:00:00'
FROM customers c WHERE c.email = 'vikram.singh@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Dispute Resolved' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, '5-Star Review Received', 'Customer left a 5-star rating and positive review for chauffeur service.', 'BOOKING', 0, '2026-08-30 23:00:00'
FROM workers w WHERE w.email = 'manish.maurya.plumbing9@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = '5-Star Review Received' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Service Reminder', 'Your scheduled carpentry service is confirmed for tomorrow morning.', 'BOOKING', 0, '2026-09-01 09:00:00'
FROM customers c WHERE c.email = 'ananya.gupta@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Service Reminder' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'Shift Schedule Update', 'Your weekly working availability (Mon-Sat, 9AM-7PM) is active in Aliganj sector.', 'AVAILABILITY', 1, '2026-08-29 11:00:00'
FROM workers w WHERE w.email = 'manohar.dixit.plumbing13@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'Shift Schedule Update' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Invoice Generated #INV-1045', 'Official GST-exempt cooperative service invoice #INV-1045 is ready for download.', 'BOOKING', 1, '2026-08-31 17:00:00'
FROM customers c WHERE c.email = 'manish.tiwari@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Invoice Generated #INV-1045' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'ADMIN', c.customer_id, 'Peak Demand Alert', 'High demand detected in Aliganj & Gomti Nagar for Electrical & AC Repair services.', 'SYSTEM', 0, '2026-09-01 07:00:00'
FROM customers c WHERE c.email = 'admin@sih.gov.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'ADMIN' AND title = 'Peak Demand Alert')
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'Safety & Quality Badge Earned', 'Congratulations! You achieved 50+ completed jobs with a 4.8+ rating.', 'SYSTEM', 0, '2026-08-28 11:00:00'
FROM workers w WHERE w.email = 'arvind.srivastava.plumbing17@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'Safety & Quality Badge Earned' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Booking Confirmed #BK-1082', 'Your home deep sanitization booking is confirmed for this weekend.', 'BOOKING', 0, '2026-09-01 03:00:00'
FROM customers c WHERE c.email = 'pooja.shukla@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Booking Confirmed #BK-1082' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'Direct Payout Credited', '₹350 credited for cooking service with 0% middleman fees.', 'SYSTEM', 1, '2026-08-31 05:00:00'
FROM workers w WHERE w.email = 'vishal.upadhyay.plumbing21@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'Direct Payout Credited' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Artisan Assigned', 'Master painter assigned to your living room texture painting request.', 'BOOKING', 1, '2026-09-01 01:00:00'
FROM customers c WHERE c.email = 'rajat.mishra@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Artisan Assigned' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'WORKER', w.worker_id, 'New Customer Request', 'New masonry restoration request in Ashiyana sector.', 'BOOKING', 0, '2026-09-01 06:00:00'
FROM workers w WHERE w.email = 'omkar.patel.plumbing25@cooperativegig.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'WORKER' AND title = 'New Customer Request' AND recipient_id = w.worker_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'CUSTOMER', c.customer_id, 'Service Completed #BK-1110', 'Your laundry steam pressing order has been delivered and completed.', 'BOOKING', 1, '2026-08-30 19:00:00'
FROM customers c WHERE c.email = 'deepika.saxena@example.com'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'CUSTOMER' AND title = 'Service Completed #BK-1110' AND recipient_id = c.customer_id)
LIMIT 1;

INSERT INTO notifications (recipient_type, recipient_id, title, message, type, is_read, created_at)
SELECT 'ADMIN', c.customer_id, 'Monthly Cooperative Audit', 'Zero middleman deductions verified across all 120+ community service orders.', 'SYSTEM', 0, '2026-08-31 11:00:00'
FROM customers c WHERE c.email = 'admin@sih.gov.in'
AND NOT EXISTS (SELECT 1 FROM notifications WHERE recipient_type = 'ADMIN' AND title = 'Monthly Cooperative Audit')
LIMIT 1;

-- =============================================================================
-- VERIFICATION & INSPECTION QUERIES
-- =============================================================================

-- 1. Table Record Counts
SELECT 'services' AS table_name, COUNT(*) AS total_records FROM services
UNION ALL
SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'workers' AS table_name, COUNT(*) AS total_records FROM workers
UNION ALL
SELECT 'service_requests' AS table_name, COUNT(*) AS total_records FROM service_requests
UNION ALL
SELECT 'notifications' AS table_name, COUNT(*) AS total_records FROM notifications;

-- 2. Workers Distribution by Skill / Trade Category (Target: ~28 per service)
SELECT 
    skill AS service_trade,
    COUNT(*) AS total_workers,
    SUM(CASE WHEN status = 'VERIFIED' THEN 1 ELSE 0 END) AS verified_workers,
    SUM(CASE WHEN status = 'PENDING_VERIFICATION' THEN 1 ELSE 0 END) AS pending_workers,
    ROUND(AVG(average_rating), 2) AS avg_rating,
    ROUND(AVG(experience_years), 1) AS avg_experience_years
FROM workers
GROUP BY skill
ORDER BY total_workers DESC;

-- 3. Bookings Distribution by Status (Target: 120 Total)
SELECT 
    status AS booking_status,
    COUNT(*) AS count,
    ROUND(SUM(COALESCE(amount_paid, 0)), 2) AS total_gross_payout,
    ROUND(AVG(COALESCE(rating, 0)), 2) AS avg_rating
FROM service_requests
GROUP BY status
ORDER BY count DESC;

-- 4. Dispute Overview
SELECT 
    dispute_status,
    COUNT(*) AS total_disputes,
    GROUP_CONCAT(DISTINCT location SEPARATOR '; ') AS affected_localities
FROM service_requests
WHERE dispute_status != 'NONE'
GROUP BY dispute_status;

-- 5. Geographic Distribution of Workers across Lucknow Localities
SELECT 
    location AS lucknow_locality,
    COUNT(*) AS total_workers,
    COUNT(DISTINCT skill) AS distinct_trades_available
FROM workers
GROUP BY location
ORDER BY total_workers DESC;
