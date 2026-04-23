# MindHub Security Guidelines

Security is paramount for a student wellness application containing sensitive mental health data. Every developer must adhere to these standards.

## 1. Authentication and Authorization
We utilize custom interceptors (`AuthInterceptor`, `AdminInterceptor`) for access control.

### Guidelines:
*   **Password Storage:** Passwords must **never** be stored in plain text. Any new registration or password reset logic must use a secure hashing algorithm, specifically `BCryptPasswordEncoder`. When validating logins, use the `matches()` method of the encoder.
*   **Session Management:**
    *   Do not store sensitive or excessive data in the `HttpSession`. Store only minimal identifiers (like `userId` and `role`).
    *   Upon successful login, ensure the session is renewed to prevent Session Fixation attacks (invalidate the old session and copy attributes to a new one, though Spring Security usually handles this, we must ensure our custom implementation does it if we aren't using Spring Security).
*   **Route Protection:** Every controller mapping (URL) must be evaluated for required permissions. Use the `AdminInterceptor` to protect administrative routes. Never assume a route is safe just because there is no UI link to it.

## 2. Input Validation
Never trust data coming from the user (forms, URL parameters, headers).

### Guidelines:
*   **Controller Validation:** Use Spring's `@Valid` annotation and JSR-380 (`javax.validation` or `jakarta.validation`) annotations (like `@NotNull`, `@Size`, `@Email`) on your model objects.
*   **SQL Injection Prevention:** Because we use `JdbcTemplate`, SQL injection is largely mitigated if we use parameterized queries. **Never** concatenate strings to build SQL queries.
    *   *Bad:* `jdbcTemplate.query("SELECT * FROM users WHERE name = '" + userName + "'", ...)`
    *   *Good:* `jdbcTemplate.query("SELECT * FROM users WHERE name = ?", new Object[]{userName}, ...)`

## 3. Output Encoding (XSS Prevention)
Cross-Site Scripting (XSS) is a major risk, especially in the Forum module where users input text.

### Guidelines:
*   **JSP Escaping:** When rendering user-submitted data in a JSP, you must escape it to prevent the browser from executing malicious scripts.
    *   *Bad:* `${post.content}`
    *   *Good:* `<c:out value="${post.content}" />`
    *   *Alternative:* Use `fn:escapeXml()` from the JSTL functions library.
*   **Rich Text:** If the application eventually supports rich text (bold, italics) in the forum, we must use a robust HTML sanitizer (like OWASP Java HTML Sanitizer) on the backend before saving to the database or displaying it.

## 4. Cross-Site Request Forgery (CSRF)
If a user is logged in, a malicious site could trick their browser into submitting a request to MindHub.

### Guidelines:
*   All state-changing operations (POST, PUT, DELETE) must require a CSRF token. 
*   If we are not using Spring Security, we must manually generate a unique, cryptographically strong token upon session creation, store it in the session, embed it in a hidden field in every `<form>`, and validate it in a custom `CsrfInterceptor`.
