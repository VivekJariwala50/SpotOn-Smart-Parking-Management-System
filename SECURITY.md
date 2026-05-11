# Security Policy

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| latest  | ✅ Yes             |

---

## Reporting a Vulnerability

If you discover a security vulnerability, **please do not open a public GitHub issue**.

Instead, report it privately:

1. Email the maintainer directly or open a [GitHub Security Advisory](https://github.com/VivekJariwala50/SpotOn-Smart-Parking-Management-System/security/advisories/new).
2. Include a description of the vulnerability, steps to reproduce, and potential impact.
3. We will acknowledge your report within **72 hours** and aim to release a fix within **14 days** for critical issues.

---

## Demo / Development Credentials Disclaimer

> [!WARNING]
> SpotOn ships with **demo-only payment credentials** for local development and classroom use:
> - **Demo card number:** `8111 1111 1111 1111`
> - **Demo CVV:** `007`
> - **Promo codes:** `SPOTON10` (10% off), `CS691PACE` (25% off)
>
> These are **not real payment credentials** and must never be used in a production payment gateway.

The application connects to a database via the `DATABASE_URL` environment variable. **Never hardcode real database passwords or secret keys in source code.**

---

## Security Best Practices Used in This Project

| Practice | Implementation |
|---|---|
| Password hashing | `werkzeug.security.generate_password_hash` (PBKDF2-HMAC-SHA256) |
| Session management | Flask signed cookies, 30-minute TTL, `session.permanent = True` |
| SQL injection prevention | Parameterized queries via `psycopg2` |
| Open-redirect protection | `safe_internal_next()` validates all redirect paths |
| Role-based access control | `@login_required(role=...)` decorator on every protected route |
| Secrets management | `SECRET_KEY` and `DATABASE_URL` loaded from environment variables |
| TLS in transit | Supabase connections enforce `sslmode=require` |
