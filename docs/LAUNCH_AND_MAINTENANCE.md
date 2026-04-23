# MindHub: Launch and Maintenance Guide

Welcome to the MindHub project! This guide will walk you through the complete process of configuring, launching, and maintaining this Java Spring MVC student wellness platform. 

## 1. Prerequisites Checklist

Before you begin, ensure you have the following installed on your machine:
*   **Java Development Kit (JDK):** Version 17 or higher.
*   **Apache Maven:** Version 3.9.x.
*   **MySQL Community Server:** Version 8.x.
*   **MySQL Workbench:** For database management.
*   **Apache Tomcat:** Version 11.x (This project uses Jakarta EE 11).
*   **IDE (Optional but recommended):** IntelliJ IDEA Ultimate or Eclipse Enterprise.

## 2. Initial Setup (First-Time Only)

### Step 2.1: Database Configuration
1. Open **MySQL Workbench** and connect to your local server (usually using the `root` account).
2. You need to execute two SQL scripts located in the repository:
   *   Navigate to `src/main/resources/schema.sql`. Copy its contents and run it in Workbench. This creates the `mindhub_db` and its tables.
   *   Navigate to `src/main/resources/data.sql`. Copy its contents and run it. This populates the database with sample data (students, admins, professionals).

### Step 2.2: Application Properties
The application needs to know how to connect to your database.
1. Open `src/main/resources/database.properties`.
2. Update the credentials to match your local MySQL server:
   ```properties
   jdbc.driverClassName=com.mysql.cj.jdbc.Driver
   jdbc.url=jdbc:mysql://localhost:3306/mindhub_db?useSSL=false&serverTimezone=UTC
   jdbc.username=root
   jdbc.password=YOUR_MYSQL_PASSWORD
   ```
> [!WARNING]
> Do NOT commit your personal database password to GitHub. If you accidentally change this file, revert the changes before committing, or agree with your team to use a universal password locally (e.g., `root`).

## 3. Launching the Application

### Method A: Using an IDE (Recommended for Development)
*   **IntelliJ IDEA Ultimate:** Add a "Tomcat Server (Local)" Run Configuration. Under the "Deployment" tab, add the `MindHub:war exploded` artifact. Set the Application Context to `/` (Root). Click "Run".
*   **Eclipse:** Add a Server (Tomcat 11), right-click the server, click "Add and Remove", and add the MindHub project. Start the server.

### Method B: Using Terminal and Standalone Tomcat (Production-style)
1. Open your terminal at the root of the project.
2. Build the `.war` (Web Application Resource) file using Maven:
   ```bash
   mvn clean package
   ```
3. A file named `MindHub-1.0-SNAPSHOT.war` will be created inside the `target/` directory.
4. Rename this file to `ROOT.war` (this ensures the app runs at `localhost:8080/` instead of `localhost:8080/MindHub-1.0-SNAPSHOT/`).
5. Copy `ROOT.war` and paste it into your Tomcat's `webapps/` folder (`C:\path\to\tomcat\webapps\`).
6. Start Tomcat by running `C:\path\to\tomcat\bin\startup.bat`.
7. Open your browser and go to `http://localhost:8080/`.

## 4. Maintenance and Troubleshooting

### 4.1. Dealing with Database Changes
If you or a team member adds a new feature that requires a new database table or column:
1. The developer must update the `src/main/resources/schema.sql` file.
2. Once you pull the new changes from GitHub, open MySQL Workbench.
3. Drop the existing database: `DROP SCHEMA mindhub_db;`
4. Re-run the updated `schema.sql` and `data.sql` to get a fresh, synchronized database.

### 4.2. Dependency Issues
If the project fails to compile and complains about missing classes (like `org.springframework...`), your Maven dependencies might be out of sync.
*   Run `mvn clean install` to force Maven to re-download missing dependencies.
*   In your IDE, find the "Reload All Maven Projects" button.

### 4.3. Connection Pooling (DBCP2) Maintenance
The project uses Apache Commons DBCP2 for database connection pooling. This is a robust free solution perfect for student and medium-scale projects. 
*   **If the app becomes slow or freezes under load:** You may need to tune the pool. Open `src/main/java/com/mindhub/config/DatabaseConfig.java` (if applicable) or your XML context, and adjust properties like `MaxTotal` (max active connections) or `MaxWaitMillis`.

### 4.4. Frontend Updates
Since this is a JSP-based project, making changes to HTML/CSS usually doesn't require a full server restart. If you edit a `.jsp` or `.css` file in `src/main/webapp/`, you can usually just refresh your browser. 
*   **Cache issues:** If you update CSS and don't see the changes, perform a "Hard Refresh" in your browser (Ctrl + F5 or Cmd + Shift + R).
