<div align="center">
  <img src="static/img/spoton-logo.png" alt="SpotOn Logo" width="200" style="margin-bottom: 20px;">
  
  # SpotOn Smart Parking Management System
  
  **Find, reserve, and manage your perfect parking spot instantly.**
  
  [![Python](https://img.shields.io/badge/Python-3.11-blue.svg?logo=python&logoColor=white)](#)
  [![Flask](https://img.shields.io/badge/Flask-3.1.0-white.svg?logo=flask&logoColor=black)](#)
  [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg?logo=postgresql&logoColor=white)](#)
  [![Docker](https://img.shields.io/badge/Docker-Ready-2496ED.svg?logo=docker&logoColor=white)](#)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

---

## 📖 Overview

SpotOn is a comprehensive, full-stack Smart Parking Management System designed to eliminate the stress of urban parking. It connects drivers with real-time parking availability, allowing them to search, filter (e.g., for EV charging or accessible spots), and secure their space before arriving. 

Simultaneously, SpotOn provides parking facility operators with a powerful suite of tools to manage inventory, adjust dynamic pricing, and monitor utilization in real time. Built for enterprise reliability, the platform features role-based access control, secure transaction handling, and robust data integrity checks.

---

## ✨ Key Features

### For Drivers 🚗
- **Real-Time Availability & Search**: Instantly find spots across multiple lots and garages with dynamic, real-time status updates.
- **Advanced Filtering**: Filter search results specifically for EV chargers, accessible bays, or vehicle size (Compact, Sedan, SUV, Truck).
- **Advance Reservations**: Securely book your parking space ahead of time to save fuel and skip the endless circling.
- **Smart Dashboard**: Manage active bookings, extend sessions, view transaction history, and download digital receipts.
- **Favorites & Vehicles**: Save your frequently visited lots and manage multiple registered vehicles under one profile.

### For Operators 🏢
- **Live Inventory Management**: Toggle spot availability, mark spots as out of service for maintenance, and track live occupancy.
- **Dynamic Pricing Overrides**: Set base rates for lots and configure specific pricing overrides based on slot type (e.g., premium pricing for EV slots) or vehicle size.
- **Analytics & Utilization**: Gain insights into booking trends, peak hours, and revenue generation.

### For Administrators 🛡️
- **System Oversight**: Comprehensive dashboard to monitor platform health, active users, total revenue, and overarching system metrics.
- **Support Ticketing**: Integrated customer support ticketing system to handle user queries and issues directly within the platform.

---

## 📸 Screenshots

### Homepage & Search Experience
|<img src="docs/assets/homepage.png" alt="Homepage">|<img src="docs/assets/search.png" alt="Search Lots">|
|:---:|:---:|
| *Modern, responsive homepage with quick location search* | *Detailed search interface with filters for vehicle and slot types* |

### Dashboards
|<img src="docs/assets/dashboard.png" alt="Driver Dashboard">|<img src="docs/assets/operator.png" alt="Operator Dashboard">|
|:---:|:---:|
| *Driver portal for managing active and past reservations* | *Operator inventory control and dynamic pricing tools* |

---

## 🛠️ Technology Stack

- **Backend Framework**: [Flask](https://flask.palletsprojects.com/) (Python 3.11)
- **Database**: [PostgreSQL](https://www.postgresql.org/) with `psycopg2` and `btree_gist` for advanced exclusion constraints (preventing double bookings)
- **Frontend**: Vanilla HTML5, CSS3 (Custom Design System), JavaScript
- **Authentication**: `werkzeug.security` (PBKDF2-HMAC-SHA256) and secure Flask sessions
- **Containerization**: Docker & Docker Compose
- **CI/CD**: GitHub Actions & Jenkins

---

## 🚀 Getting Started (Local Development)

### Prerequisites
- Python 3.11+
- PostgreSQL 15+ (or Docker)
- Git

### 1. Clone the Repository
```bash
git clone https://github.com/VivekJariwala50/SpotOn-Smart-Parking-Management-System.git
cd SpotOn-Smart-Parking-Management-System
```

### 2. Set Up Virtual Environment & Dependencies
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Environment Variables
Copy the provided example environment file and update it with your database credentials and a strong secret key.
```bash
cp .env.example .env
```
Ensure you set a strong `SECRET_KEY` and define your `DATABASE_URL` (or the individual `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` variables).

### 4. Database Setup
Ensure your local PostgreSQL server is running. Create the database and run the provided schema and seed data dump:
```bash
# Create the database (if using individual env vars)
createdb -U postgres smart_parking

# Import schema and seed data
psql -U postgres -d smart_parking -f supabase_dump.sql
```
*(Note: The database requires the `btree_gist` and `uuid-ossp` extensions, which the dump file will attempt to enable.)*

### 5. Run the Application
Start the Flask development server:
```bash
python app.py
```
The application will be available at `http://localhost:5055`.

---

## 🐳 Running with Docker

SpotOn is fully containerized and production-ready.

### Build and Run locally
```bash
# Build the image
docker build -t spoton-app:latest .

# Run the container (ensure your DB is accessible from the container network)
docker run -d -p 8000:8000 \
  -e DATABASE_URL=postgresql://user:pass@host:5432/db_name \
  -e SECRET_KEY=your_secure_key \
  --name spoton-web \
  spoton-app:latest
```

The Docker image uses `gunicorn` with multiple workers and includes a built-in health check endpoint (`/health`).

---

## 🧪 Testing

The project includes a suite of smoke tests built with `pytest` to verify core application functionality and routing integrity.

To run the tests:
```bash
pytest tests/ -v
```

---

## 🛡️ Security

We take security seriously. SpotOn implements several best practices including:
- Parameterized queries to prevent SQL Injection
- Password hashing using `werkzeug.security`
- Strict Role-Based Access Control (RBAC) via custom `@login_required` decorators
- Protection against Open Redirect vulnerabilities

Please read our [Security Policy](SECURITY.md) for details on reporting vulnerabilities.

**Note on Demo Credentials**: The system includes a simulated checkout for demonstration purposes. Use the demo card `8111 1111 1111 1111` and CVV `007`. *Never use real payment information in the demo environment.*

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on our branch strategy, commit message standards, and the pull request process.

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
<div align="center">
  <i>Built with ❤️ by the SpotOn Team</i>
</div>
