# MindHub - Student Wellness Platform

MindHub is a comprehensive mental health and wellness web application designed specifically for university students. Built using a robust Java Spring MVC architecture, this platform provides students with tools for mood tracking, self-assessment, peer support, gamification, and professional counseling.

## 🛠️ Technology Stack
- **Backend:** Java 17+, Spring MVC 6.1.x, Spring JDBC
- **Frontend:** JSP, JSTL (Jakarta EE), Custom CSS (Stitch UI Dark Theme), Vanilla JavaScript
- **Database:** MySQL 8.x
- **Build Tool:** Apache Maven 3.9+
- **Deployment:** Apache Tomcat 11
- **Connection Pooling:** Apache Commons DBCP2

---

## 👥 Team Workflow & Database Synchronization

To ensure all team members have the exact same database structure and sample data, we are using a **Git-based synchronization strategy**. Please follow these steps carefully.

### Prerequisites
1. **MySQL Community Server** (Installed locally on port 3306)
2. **MySQL Workbench** (Do *not* use SQL Server Management Studio for this project, as we are strictly using MySQL to meet the course requirements).

### Step 1: Initial Database Setup (Do this once)
1. Open MySQL Workbench and connect to your local MySQL server (usually `root` user).
2. Open the file `src/main/resources/schema.sql`. Execute the entire script. This will create the `mindhub_db` schema and all 13 required tables.
3. Open the file `src/main/resources/data.sql`. Execute the entire script. This will populate your database with sample users, content, assessments, and professionals.

### Step 2: Configure Database Credentials
1. Open `src/main/resources/database.properties`.
2. Update the `jdbc.username` and `jdbc.password` to match your local MySQL installation.
   ```properties
   jdbc.username=root
   jdbc.password=your_mysql_password
   ```
3. **DO NOT commit `database.properties` if you change it to your personal password**, or coordinate with your team to use the same local root password (e.g., `root` or `admin`).

### Step 3: Keeping Synchronized
Whenever a team member needs to change the database structure (add a column, create a table):
1. They must update `schema.sql` and commit it to GitHub.
2. Other team members will pull the changes, drop their local `mindhub_db` schema in MySQL Workbench, and re-run the updated `schema.sql` and `data.sql` to stay synced.

---

## 🚀 Running the Application Local

### Option 1: Running in IntelliJ IDEA / Eclipse
1. Open the project in your IDE.
2. Ensure your IDE is configured with a Tomcat Server (Tomcat 11 recommended).
3. Add the `MindHub` artifact (WAR exploded) to the Tomcat deployment.
4. Set the Application Context to `/` (Root).
5. Click **Run**. The app will be available at `http://localhost:8080/`.

### Option 2: Deploying the WAR file manually
1. Open a terminal in the project root directory.
2. Run Maven to build the project:
   ```bash
   mvn clean package
   ```
3. This will generate `MindHub-1.0-SNAPSHOT.war` inside the `/target` directory.
4. Rename this file to `ROOT.war`.
5. Copy `ROOT.war` into the `webapps` folder of your Apache Tomcat installation.
6. Start Tomcat (`bin/startup.bat` on Windows).
7. Access the application at `http://localhost:8080/`.

---

## 🔑 Default Test Accounts
Use these accounts to test the application (seeded from `data.sql`):

**Student Account:**
- Email: `ammar@student.utm.my`
- Password: `password123`

**Admin Account:**
- Email: `admin@mindhub.edu.my`
- Password: `admin`

---

## 📁 Project Structure Highlights
- **`src/main/java/com/mindhub/model`**: Database entities (POJOs).
- **`src/main/java/com/mindhub/dao`**: Database operations using `JdbcTemplate`.
- **`src/main/java/com/mindhub/service`**: Business logic.
- **`src/main/java/com/mindhub/controller`**: Request routing and view management.
- **`src/main/webapp/WEB-INF/views`**: All JSP files (the UI layer).
- **`src/main/webapp/css/mindhub.css`**: Global design system based on the Stitch UI templates.
