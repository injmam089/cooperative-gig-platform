-- ==========================================================
-- SIH Hackathon: Cooperative Gig Services Platform
-- Database: sih_db
-- Tables: workers, customers, services, service_requests
-- ==========================================================

-- 1. Create database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS sih_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE sih_db;

-- ==========================================================
-- 2. WORKERS TABLE (Existing - Preserved)
-- ==========================================================
CREATE TABLE IF NOT EXISTS workers (
    worker_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    skill VARCHAR(100) NOT NULL,
    experience_years INT NOT NULL,
    location VARCHAR(150) NOT NULL,
    invited_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================================
-- 3. CUSTOMERS TABLE (New)
-- ==========================================================
CREATE TABLE IF NOT EXISTS customers (
    customer_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(150) NOT NULL,
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================================
-- 4. SERVICES TABLE (New)
-- ==========================================================
CREATE TABLE IF NOT EXISTS services (
    service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(50) DEFAULT '🛠️',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================================
-- 5. SERVICE REQUESTS TABLE (New)
-- ==========================================================
CREATE TABLE IF NOT EXISTS service_requests (
    request_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    worker_id BIGINT NOT NULL,
    service_id BIGINT NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200) NOT NULL,
    preferred_date VARCHAR(50) NOT NULL,
    preferred_time VARCHAR(50) NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_req_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_req_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id) ON DELETE CASCADE,
    CONSTRAINT fk_req_service FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================================================
-- 6. SEED DATA FOR SERVICES (The 10 Required Marketplace Services)
-- ==========================================================
INSERT INTO services (service_name, description, icon)
SELECT * FROM (
    SELECT 'Plumbing' AS service_name, 'Pipe repair, leakage fixing, tap and fitting work by certified plumbers' AS description, '🔧' AS icon UNION ALL
    SELECT 'AC Repair & Maintenance', 'AC servicing, installation, component repair, and gas checking' AS description, '❄️' AS icon UNION ALL
    SELECT 'Cooking Services', 'Nutritious home cooking, customized meal preparation, and event catering' AS description, '🍳' AS icon UNION ALL
    SELECT 'Driver', 'Professional personal drivers for daily commute, local transit, and outstation trips' AS description, '🚗' AS icon UNION ALL
    SELECT 'Electrical Services', 'Complete home wiring, switch/socket repair, and appliance electrical installation' AS description, '⚡' AS icon UNION ALL
    SELECT 'Cleaning Services', 'Deep home cleaning, kitchen sanitization, bathroom scrubbing, and floor care' AS description, '🧹' AS icon UNION ALL
    SELECT 'Carpenter', 'Custom woodwork, furniture repair, installation, and wooden fixture maintenance' AS description, '🪚' AS icon UNION ALL
    SELECT 'Painting', 'Interior room painting, complete house painting, texture design, and wall crack repair' AS description, '🎨' AS icon UNION ALL
    SELECT 'Mason / Construction', 'Skilled masonry, brickwork, plastering, wall renovation, and minor construction' AS description, '🧱' AS icon UNION ALL
    SELECT 'Laundry', 'Washing, fabric care, steam ironing, and routine laundry assistance' AS description, '🧺' AS icon
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM services WHERE services.service_name = tmp.service_name);
