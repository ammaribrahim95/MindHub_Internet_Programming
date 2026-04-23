# MindHub Production Operations

To maintain a healthy production environment, we must have visibility into the application's state and gracefully handle errors.

## 1. Structured Logging
Relying on `System.out.println()` or `e.printStackTrace()` is unacceptable in production because it clutters the standard output and makes it impossible to search or filter logs effectively.

### Guidelines:
*   **Logging Framework:** Use **SLF4J** (Simple Logging Facade for Java) backed by **Logback**.
*   **Logger Instantiation:** In every class that requires logging, declare a static logger:
    ```java
    private static final Logger logger = LoggerFactory.getLogger(MyClass.class);
    ```
*   **Log Levels:** Use the correct level for the message:
    *   `ERROR`: For exceptions that prevent a user action from completing (e.g., database failure). Always pass the `Exception` object as the last argument so the stack trace is captured securely. `logger.error("Failed to save progress for user {}", userId, e);`
    *   `WARN`: For unexpected but recoverable situations, or potential security events (e.g., failed login attempt).
    *   `INFO`: For significant lifecycle events (e.g., user registered, application started). Do not use this in loops.
    *   `DEBUG`: For detailed tracking useful during development. This level should be turned off in production via the `logback.xml` configuration.

## 2. Global Error Handling
A user should never see a raw Apache Tomcat 500 stack trace or a generic "White Label Error Page".

### Guidelines:
*   **@ControllerAdvice:** Implement a global exception handler class annotated with `@ControllerAdvice`.
*   **Exception Mapping:** Create specific methods annotated with `@ExceptionHandler(ExceptionClass.class)` to catch different types of errors.
    *   For `ResourceNotFoundException`, return a custom `404.jsp` view.
    *   For generic `Exception` or database errors, log the error using the logger (at `ERROR` level), and return a generic, user-friendly `500.jsp` view (e.g., "Oops, something went wrong on our end.").

## 3. Maven Profiles for Environments
The application needs different configurations when running locally on a developer's machine versus running on a production server.

### Guidelines:
*   **pom.xml Profiles:** Define `<profiles>` in the Maven POM file.
    *   `dev`: The default profile. Might disable caching, enable verbose logging, and point to a local database.
    *   `prod`: Activated during the production build (`mvn clean package -Pprod`). This profile should use production database credentials, enable caching, and set logging levels to `INFO` or `WARN`.
*   **Properties Filtering:** Use Maven's resource filtering feature to replace placeholders in `database.properties` and `logback.xml` based on the active profile.
