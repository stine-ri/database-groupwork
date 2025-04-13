-- Admin user (full access, local only)
CREATE USER IF NOT EXISTS '{{DB_ADMIN_USER}}'@'localhost' 
IDENTIFIED WITH mysql_native_password BY '{{DB_ADMIN_PASSWORD}}'
WITH MAX_QUERIES_PER_HOUR 1000
PASSWORD EXPIRE INTERVAL 90 DAY;

-- Application user (remote access, limited writes)
CREATE USER IF NOT EXISTS '{{DB_APP_USER}}'@'%' 
IDENTIFIED WITH mysql_native_password BY '{{DB_APP_PASSWORD}}'
WITH MAX_USER_CONNECTIONS 50;

-- Read-only analyst user (for reporting)
CREATE USER IF NOT EXISTS '{{DB_ANALYST_USER}}'@'10.0.%' 
IDENTIFIED WITH mysql_native_password BY '{{DB_ANALYST_PASSWORD}}';

-- Grant permissions
GRANT ALL PRIVILEGES ON bookstore.* TO '{{DB_ADMIN_USER}}'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO '{{DB_APP_USER}}'@'%';
GRANT SELECT ON bookstore.* TO '{{DB_ANALYST_USER}}'@'10.0.%';

-- Revoke dangerous defaults
REVOKE DROP, CREATE USER, FILE, SHUTDOWN ON *.* FROM '{{DB_APP_USER}}'@'%';

FLUSH PRIVILEGES;
