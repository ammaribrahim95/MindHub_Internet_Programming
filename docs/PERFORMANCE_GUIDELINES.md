# MindHub Performance Guidelines

To transition this application from a prototype ("vibe-coded") to a production-ready system, we must enforce strict performance standards. Refer to this document whenever adding new features or refactoring existing ones.

## 1. Database Connection Pooling
The application utilizes **Apache Commons DBCP2** for managing database connections. This is suitable for our needs but must be configured correctly.

### Guidelines:
*   **Never create raw JDBC connections manually** using `DriverManager.getConnection()`. Always rely on the injected `DataSource` or `JdbcTemplate` provided by Spring.
*   **Configuration:** The `BasicDataSource` should be configured with appropriate limits to prevent exhausting database resources or thread starvation.
    *   `maxTotal`: Set to a reasonable number (e.g., 20-50 for a small server) to handle concurrent users.
    *   `maxIdle`: Should usually match `maxTotal` to prevent unnecessary connection destruction and recreation.
    *   `maxWaitMillis`: Must have a timeout (e.g., 10000ms) so requests fail gracefully rather than hanging indefinitely if the pool is exhausted.

## 2. Data Access & Query Optimization
Because we use Spring `JdbcTemplate` rather than an ORM like Hibernate, we have direct control over SQL. This is a performance advantage if used correctly.

### Guidelines:
*   **The N+1 Query Problem:** Avoid executing a SQL query inside a loop. For example, if you fetch 100 forum posts, do NOT write a `for` loop that runs 100 separate queries to fetch the author for each post. Instead, use a `JOIN` in your original SQL query to fetch the post and the user data simultaneously.
*   **Read-Only Transactions:** When a Service method only retrieves data (e.g., `getAssessment()`), annotate it with `@Transactional(readOnly = true)`. This allows the underlying database driver to apply performance optimizations.
*   **Pagination:** Never fetch an entire table into memory. For entities like Forum Posts or User Progress logs, always implement SQL `LIMIT` and `OFFSET` to paginate results.

## 3. View Layer (JSP) Optimization
The JSP engine can be a bottleneck if not managed properly.

### Guidelines:
*   **Static vs. Dynamic Includes:** 
    *   For static elements that do not change (like simple HTML headers or footers), use the compile-time directive: `<%@ include file="header.jsp" %>`. This compiles the files together once.
    *   Only use the runtime `<jsp:include page="..." />` if the included page needs to execute its own logic dynamically on every request.
*   **Keep Logic Out of JSPs:** JSPs should only render data. Do not perform complex calculations, database calls, or heavy string manipulations inside `<% ... %>` scriptlets or JSTL tags. Prepare all data in the Spring Controller and pass it via the `Model`.

## 4. Caching Strategy
For data that is frequently accessed but rarely changed, caching is essential.

### Guidelines:
*   **Lookup Tables:** Data such as "Assessment Questions" or "Badges" should be loaded into memory once on application startup or cached using Spring's `@Cacheable` annotation, rather than querying the database on every page load.
*   **Asset Minification (Future Enhancement):** Consider integrating a Maven plugin (like `wro4j` or `frontend-maven-plugin`) to automatically minify and concatenate CSS and JavaScript files during the build process to reduce HTTP request overhead.
