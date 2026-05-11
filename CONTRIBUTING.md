# Contributing to SpotOn

Thank you for your interest in contributing! Please follow these guidelines to keep the codebase clean and the review process smooth.

## Table of Contents

- [Getting Started](#getting-started)
- [Branch Strategy](#branch-strategy)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Running Tests](#running-tests)

---

## Getting Started

1. **Fork** the repository and clone your fork locally.
2. Create a virtual environment and install dependencies:
   ```bash
   python -m venv .venv
   source .venv/bin/activate   # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```
3. Copy `.env.example` to `.env` and fill in your local values.
4. Set up the database using the provided SQL dump:
   ```bash
   psql -U postgres -f supabase_dump.sql
   ```

---

## Branch Strategy

| Branch type   | Naming convention         | Example                        |
|---------------|---------------------------|--------------------------------|
| Feature       | `feature/<short-desc>`    | `feature/ev-slot-filter`       |
| Bug fix       | `fix/<short-desc>`        | `fix/duplicate-booking-crash`  |
| Chore / docs  | `chore/<short-desc>`      | `chore/update-readme`          |
| Hot fix       | `hotfix/<short-desc>`     | `hotfix/login-redirect-loop`   |

- Branch off from `main`.
- Keep branches short-lived — open a PR as soon as the feature is ready for review.
- Delete the branch after merging.

---

## Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <short summary>

[optional body]
[optional footer]
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Examples:**
```
feat(reservations): add bulk-reservation cancellation endpoint
fix(auth): prevent open-redirect via `next` parameter
docs(readme): add Docker setup instructions
test(smoke): add route health checks
```

---

## Pull Request Process

1. Ensure all CI checks pass (`pytest`, lint).
2. Fill in the PR template — describe *what* changed and *why*.
3. Request a review from at least one team member.
4. Squash-merge once approved.
5. Delete the source branch.

---

## Code Style

- **Python**: follow [PEP 8](https://peps.python.org/pep-0008/). Use 4-space indentation.
- **HTML/CSS/JS**: 2-space indentation, semantic elements, no inline styles.
- Use descriptive variable names — no single-letter names outside loops.
- Every new function/route must have a docstring.
- Do not commit secrets, passwords, or API keys.

---

## Running Tests

```bash
pytest tests/ -v
```

The smoke test suite verifies core routes return expected HTTP status codes.
Add a test for any new route or business-logic function you introduce.
