# 🚀 Nexus - Deployment & Setup Guide

## 📋 Prerequisites

### Required Software:
- **Java Development Kit (JDK):** Version 21 or higher
- **Apache Maven:** Version 3.8+ (for building)
- **MySQL Server:** Version 8.0+
- **Apache Tomcat:** Version 10.1+ (or compatible Jakarta EE 10 server)
- **Git:** For version control

### Development Tools (Recommended):
- **IDE:** IntelliJ IDEA Ultimate / Eclipse IDE for Enterprise Java
- **Database Tool:** MySQL Workbench / DBeaver
- **API Testing:** Postman / Insomnia
- **Browser:** Chrome, Firefox, or Edge (latest versions)

---

## 🗄️ Database Setup

### Step 1: Create Database
```sql
-- Create database
CREATE DATABASE IF NOT EXISTS nexus_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use database
USE nexus_db;
```

### Step 2: Create Tables
```sql
-- Civilian Registration Table
CREATE TABLE civilian_registration (
    reg_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    national_id VARCHAR(50) UNIQUE,
    address TEXT,
    date_of_birth DATE,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Police Registration Table
CREATE TABLE police_registration (
    reg_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    badge_number VARCHAR(50) UNIQUE,
    rank_details VARCHAR(100),
    station_id INT,
    station_name VARCHAR(100),
    station_address TEXT,
    password VARCHAR(255) NOT NULL,
    approval_status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Admin Registration Table
CREATE TABLE admin_registration (
    reg_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    approval_status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Police Station Table
CREATE TABLE police_station (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(100) NOT NULL,
    station_code VARCHAR(20) UNIQUE,
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Complaint Table
CREATE TABLE complaint (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    civilian_id INT NOT NULL,
    complaint_type VARCHAR(100) NOT NULL,
    urgency_level VARCHAR(20) DEFAULT 'MEDIUM',
    description TEXT NOT NULL,
    location_of_incident VARCHAR(255),
    date_of_incident DATE,
    time_of_incident TIME,
    status VARCHAR(50) DEFAULT 'PENDING',
    assigned_officer_id INT,
    nearest_station_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (civilian_id) REFERENCES civilian_registration(reg_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_officer_id) REFERENCES police_registration(reg_id) ON DELETE SET NULL,
    FOREIGN KEY (nearest_station_id) REFERENCES police_station(station_id) ON DELETE SET NULL
);

-- Activity/System Logs Table
CREATE TABLE activity_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    user_type VARCHAR(20),
    action VARCHAR(100),
    description TEXT,
    ip_address VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Step 3: Insert Sample Data (Optional)
```sql
-- Insert Sample Police Stations
INSERT INTO police_station (station_name, station_code, address, city, state, pincode, phone, email, latitude, longitude) VALUES
('Central Police Station', 'CPS001', '123 Main Street', 'Metropolis', 'State', '100001', '+1-555-0100', 'central@police.gov', 40.7128, -74.0060),
('North Division', 'NPD002', '456 North Avenue', 'Metropolis', 'State', '100002', '+1-555-0200', 'north@police.gov', 40.7589, -73.9851),
('South District', 'SPD003', '789 South Boulevard', 'Metropolis', 'State', '100003', '+1-555-0300', 'south@police.gov', 40.7306, -73.9352);

-- Insert Sample Admin (Password: Admin@123)
INSERT INTO admin_registration (full_name, email, phone, department, password, approval_status) VALUES
('System Administrator', 'admin@nexus.gov', '+1-555-0001', 'Administration', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'APPROVED');

-- Note: Password is hashed using SHA-256. Use PasswordUtil.hashPassword() in your application.
```

### Step 4: Create Database User
```sql
-- Create dedicated database user
CREATE USER 'nexus_user'@'localhost' IDENTIFIED BY 'YourSecurePassword123!';

-- Grant privileges
GRANT ALL PRIVILEGES ON nexus_db.* TO 'nexus_user'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;
```

---

## ⚙️ Application Configuration

### Step 1: Update Database Connection

Edit `src/main/java/org/example/nexus/util/DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/nexus_db";
private static final String USER = "nexus_user";
private static final String PASSWORD = "YourSecurePassword123!";
```

### Step 2: Update Persistence Configuration

Edit `src/main/resources/META-INF/persistence.xml`:

```xml
<property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/nexus_db"/>
<property name="jakarta.persistence.jdbc.user" value="nexus_user"/>
<property name="jakarta.persistence.jdbc.password" value="YourSecurePassword123!"/>
```

### Step 3: Configure Email Settings (Optional)

Edit `src/main/java/org/example/nexus/util/EmailUtil.java`:

```java
private static final String SMTP_HOST = "smtp.gmail.com";
private static final String SMTP_PORT = "587";
private static final String EMAIL_FROM = "noreply@nexus.gov";
private static final String EMAIL_PASSWORD = "your-email-password";
```

---

## 🏗️ Building the Application

### Step 1: Clone Repository
```bash
git clone <repository-url>
cd SentinelX
```

### Step 2: Install Dependencies
```bash
mvn clean install
```

### Step 3: Build WAR File
```bash
mvn clean package
```

The WAR file will be generated at: `target/Future_Developers_LMS-1.0-SNAPSHOT.war`

---

## 🚀 Deployment to Tomcat

### Method 1: Manual Deployment

1. **Stop Tomcat Server:**
```bash
# Windows
shutdown.bat

# Linux/Mac
./shutdown.sh
```

2. **Copy WAR File:**
```bash
cp target/Future_Developers_LMS-1.0-SNAPSHOT.war /path/to/tomcat/webapps/nexus.war
```

3. **Start Tomcat Server:**
```bash
# Windows
startup.bat

# Linux/Mac
./startup.sh
```

4. **Access Application:**
```
http://localhost:8080/nexus/
```

### Method 2: Tomcat Manager Deployment

1. Access Tomcat Manager:
```
http://localhost:8080/manager/html
```

2. Login with Tomcat credentials

3. Scroll to "WAR file to deploy"

4. Click "Choose File" and select your WAR file

5. Click "Deploy"

### Method 3: IDE Deployment

**IntelliJ IDEA:**
1. Go to Run → Edit Configurations
2. Click + → Tomcat Server → Local
3. Configure Tomcat home directory
4. In Deployment tab, add artifact
5. Click Run

**Eclipse:**
1. Right-click project → Run As → Run on Server
2. Select Tomcat server
3. Click Finish

---

## 🧪 Testing the Deployment

### Step 1: Verify Home Page
```
http://localhost:8080/nexus/
```
Should display the Nexus landing page.

### Step 2: Test Login
```
http://localhost:8080/nexus/views/auth/login.jsp
```

**Test Accounts:**
- **Admin:** admin@nexus.gov / Admin@123
- **Civilian:** (Register new account)
- **Police:** (Register and wait for admin approval)

### Step 3: Check Error Handling
```
http://localhost:8080/nexus/nonexistent-page
```
Should redirect to custom 404 page.

### Step 4: Test Database Connection
Check Tomcat logs for database connection messages:
```bash
tail -f /path/to/tomcat/logs/catalina.out
```

---

## 🔒 Security Configuration

### Step 1: SSL/TLS Setup (Production)

Edit `$TOMCAT_HOME/conf/server.xml`:

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/keystore.jks"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

### Step 2: Configure Authentication Realm

Add to `context.xml`:

```xml
<Realm className="org.apache.catalina.realm.JDBCRealm"
       driverName="com.mysql.cj.jdbc.Driver"
       connectionURL="jdbc:mysql://localhost:3306/nexus_db"
       connectionName="nexus_user"
       connectionPassword="YourSecurePassword123!"
       userTable="admin_registration"
       userNameCol="email"
       userCredCol="password"
       userRoleTable="admin_registration"
       roleNameCol="approval_status"/>
```

### Step 3: Environment Variables (Production)

Create `.env` file:
```bash
DB_URL=jdbc:mysql://localhost:3306/nexus_db
DB_USER=nexus_user
DB_PASSWORD=YourSecurePassword123!
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
EMAIL_FROM=noreply@nexus.gov
EMAIL_PASSWORD=your-email-password
```

---

## 📊 Performance Tuning

### Tomcat Configuration

Edit `$TOMCAT_HOME/conf/server.xml`:

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           maxThreads="200"
           minSpareThreads="10"
           maxConnections="10000"
           acceptCount="100"
           compression="on"
           compressionMinSize="2048"
           compressibleMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"/>
```

### JVM Options

Edit `$TOMCAT_HOME/bin/setenv.sh` (Linux/Mac) or `setenv.bat` (Windows):

```bash
export CATALINA_OPTS="$CATALINA_OPTS -Xms512m"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx2048m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UseG1GC"
export CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8"
```

### Database Connection Pooling

Update `DBConnection.java` to use HikariCP:

```java
HikariConfig config = new HikariConfig();
config.setJdbcUrl("jdbc:mysql://localhost:3306/nexus_db");
config.setUsername("nexus_user");
config.setPassword("YourSecurePassword123!");
config.setMaximumPoolSize(10);
config.setMinimumIdle(2);
config.setConnectionTimeout(30000);

HikariDataSource ds = new HikariDataSource(config);
```

---

## 📝 Logging Configuration

### Log4j2 Configuration

Create `src/main/resources/log4j2.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
        <File name="File" fileName="logs/nexus.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </File>
    </Appenders>
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="File"/>
        </Root>
    </Loggers>
</Configuration>
```

---

## 🐛 Troubleshooting

### Issue: Application not deploying
**Solution:**
1. Check Tomcat logs: `tail -f logs/catalina.out`
2. Verify Java version: `java -version` (should be 21+)
3. Check  WAR file integrity
4. Clear Tomcat work directory

### Issue: Database connection errors
**Solution:**
1. Verify MySQL is running: `systemctl status mysql`
2. Test connection: `mysql -u nexus_user -p nexus_db`
3. Check firewall rules
4. Verify credentials in code

### Issue: 404 errors for all pages
**Solution:**
1. Check context path in URLs
2. Verify servlet mappings in `web.xml`
3. Check @WebServlet annotations
4. Clear browser cache

### Issue: CSS/JS not loading
**Solution:**
1. Check file paths in JSP files
2. Use correct context path: `${pageContext.request.contextPath}`
3. Clear browser cache
4. Check file permissions

---

## 📦 Backup & Restore

### Database Backup
```bash
# Backup
mysqldump -u nexus_user -p nexus_db > nexus_backup_$(date +%Y%m%d).sql

# Restore
mysql -u nexus_user -p nexus_db < nexus_backup_20260206.sql
```

### Application Backup
```bash
# Backup WAR and config
tar -czf nexus_app_backup_$(date +%Y%m%d).tar.gz \
  target/*.war \
  src/main/resources/META-INF/persistence.xml \
  src/main/java/org/example/nexus/util/DBConnection.java
```

---

## 🔄 Updates & Maintenance

### Regular Maintenance Tasks:
- [ ] Update dependencies monthly: `mvn versions:display-dependency-updates`
- [ ] Review security patches
- [ ] Backup database weekly
- [ ] Monitor log files for errors
- [ ] Check disk space usage
- [ ] Review user feedback and issues

### Updating Application:
```bash
# Pull latest changes
git pull origin main

# Rebuild
mvn clean package

# Deploy new version
cp target/Future_Developers_LMS-1.0-SNAPSHOT.war /path/to/tomcat/webapps/nexus.war

# Restart Tomcat
./shutdown.sh && ./startup.sh
```

---

## 📞 Support

### Resources:
- **Project Documentation:** `/docs`
- **API Documentation:** `/api-docs` (if available)
- **Issue Tracker:** GitHub Issues
- **Email:** support@nexus.gov

### Emergency Contacts:
- **Database Admin:** dba@nexus.gov
- **System Admin:** sysadmin@nexus.gov
- **Security Team:** security@nexus.gov

---

**Last Updated:** February 6, 2026
**Version:** 1.0-SNAPSHOT
