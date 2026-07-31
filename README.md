# 🏥 MediTrack – Healthcare Management System

MediTrack is a **Flask + MySQL** based Healthcare Management System that helps clinics and hospitals manage core operational data — patients, doctors, visits, medicines, prescriptions, and medical history — from a single, simple web interface.

---

## ✨ Features

- **Dashboard** – quick overview of total patients, doctors, visits, and prescriptions
- **Patient Management** – add, view, edit, and delete patient records
- **Doctor Directory** – view doctors along with their specialization, experience, and department
- **Prescription History** – see a consolidated view of every prescription across all patients and visits
- **Patient Search & History** – look up an individual patient and view their full visit and prescription history
- **Relational Data Model** – patients, doctors, departments, visits, prescriptions, prescription details, and medicines are linked through a normalized MySQL schema

---

## 🛠️ Tech Stack

| Layer      | Technology              |
|------------|--------------------------|
| Backend    | Python, Flask            |
| Database   | MySQL                    |
| DB Driver  | `mysql-connector-python`  |
| Frontend   | HTML (Jinja2 Templates)  |

---

## 📁 Project Structure

```
MediTrack-Healthcare-Management-System/
│
├── app.py               # Main Flask application (routes & DB logic)
├── templates/            # HTML templates rendered by Flask
│   ├── home.html
│   ├── patients.html
│   ├── add_patient.html
│   ├── edit_patient.html
│   ├── doctors.html
│   ├── prescription_history.html
│   ├── search_patient.html
│   └── patient_history.html
└── README.md
```

---

## 🗄️ Database Schema

MediTrack expects a MySQL database named `MediTrack` with the following tables:

- **Patients** – `Patient_ID`, `Full_Name`, `DOB`, `Gender`, `Blood_Group`, `Contact_No`, `Email`, `Address`, `Emergency_Contact`
- **Doctors** – `Doctor_ID`, `Doctor_Name`, `Specialization`, `Experience_Years`, `Contact_No`, `Department_ID`
- **Departments** – `Department_ID`, `Department_Name`
- **Visits** – `Visit_ID`, `Patient_ID`, `Doctor_ID`, `Visit_Date`, `Diagnosis`
- **Prescriptions** – `Prescription_ID`, `Visit_ID`
- **Prescription_Details** – `Prescription_ID`, `Medicine_ID`, `Dosage`, `Frequency`, `Start_Date`, `End_Date`
- **Medicines** – `Medicine_ID`, `Medicine_Name`

> 💡 Tip: Export your schema with `mysqldump --no-data MediTrack > schema.sql` and commit it to the repo so others can set up the database quickly.

---

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- MySQL Server
- `pip` package manager

### 1. Clone the repository

```bash
git clone https://github.com/mhemalathareddy181205-png/MediTrack-Healthcare-Management-System.git
cd MediTrack-Healthcare-Management-System
```

### 2. Install dependencies

```bash
pip install flask mysql-connector-python
```

### 3. Set up the MySQL database

Create the `MediTrack` database and the tables listed above (or run your own schema/seed SQL file):

```sql
CREATE DATABASE MediTrack;
USE MediTrack;
-- create Patients, Doctors, Departments, Visits,
-- Prescriptions, Prescription_Details, and Medicines tables here
```

### 4. Configure database credentials

`app.py` currently connects to MySQL with hardcoded credentials. Before running the app, update the connection block with your own local credentials:

```python
db = mysql.connector.connect(
    host="localhost",
    user="your_mysql_user",
    password="your_mysql_password",
    database="MediTrack"
)
```

> ⚠️ **Security note:** Avoid committing real database credentials to version control. Consider loading them from environment variables (e.g. with `python-dotenv`) instead of hardcoding them in `app.py`.

### 5. Run the application

```bash
python app.py
```

The app will start in debug mode at **http://127.0.0.1:5000**

---

## 🔗 Application Routes

| Route | Method(s) | Description |
|-------|-----------|--------------|
| `/` | GET | Dashboard with summary counts |
| `/patients` | GET | List all patients |
| `/add_patient` | GET, POST | Add a new patient |
| `/edit_patient/<id>` | GET, POST | Edit an existing patient |
| `/delete_patient/<id>` | GET | Delete a patient |
| `/doctors` | GET | List all doctors with department info |
| `/prescription_history` | GET | View all prescriptions across patients |
| `/search_patient` | GET | Search form for a specific patient |
| `/patient_history` | GET | View visit/prescription history for a selected patient |

---

## 🧭 Roadmap / Ideas for Improvement

- [ ] Move DB credentials to environment variables / a `.env` file
- [ ] Add a `requirements.txt`
- [ ] Add authentication for staff/admin login
- [ ] Add doctor/department/medicine CRUD screens
- [ ] Add form validation and error handling
- [ ] Add a `schema.sql` file for one-command database setup

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome. Feel free to open an issue or submit a pull request.

## 📄 License

This project currently has no license file. Consider adding one (e.g. MIT) to clarify how others can use this project.
