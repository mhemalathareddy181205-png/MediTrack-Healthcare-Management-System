CREATE DATABASE MediTrack;
USE MediTrack;
CREATE TABLE Patients (
    Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Gender VARCHAR(10),
    Blood_Group VARCHAR(5),
    Contact_No VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    Emergency_Contact VARCHAR(15)
);
CREATE TABLE Departments (
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    Head_Doctor VARCHAR(100)
);
CREATE TABLE Doctors (
    Doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Specialization VARCHAR(100),
    Experience_Years INT,
    Contact_No VARCHAR(15),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
    REFERENCES Departments(Department_ID)
);
CREATE TABLE Appointments (
    Appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status VARCHAR(20),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctors(Doctor_ID)
);
CREATE TABLE Visits (
    Visit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Visit_Date DATE,
    Symptoms TEXT,
    Diagnosis TEXT,
    Follow_Up_Date DATE,
    Doctor_Notes TEXT,

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctors(Doctor_ID)
);
CREATE TABLE Medicines (
    Medicine_ID INT AUTO_INCREMENT PRIMARY KEY,
    Medicine_Name VARCHAR(100),
    Manufacturer VARCHAR(100),
    Category VARCHAR(50)
);
CREATE TABLE Prescriptions (
    Prescription_ID INT AUTO_INCREMENT PRIMARY KEY,
    Visit_ID INT,
    Prescription_Date DATE,

    FOREIGN KEY (Visit_ID)
    REFERENCES Visits(Visit_ID)
);
CREATE TABLE Prescription_Details (
    Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Prescription_ID INT,
    Medicine_ID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    Purpose TEXT,
    Doctor_Remarks TEXT,

    FOREIGN KEY (Prescription_ID)
    REFERENCES Prescriptions(Prescription_ID),

    FOREIGN KEY (Medicine_ID)
    REFERENCES Medicines(Medicine_ID)
);
CREATE TABLE Medical_Reports (
    Report_ID INT AUTO_INCREMENT PRIMARY KEY,
    Visit_ID INT,
    Report_Type VARCHAR(100),
    Report_Date DATE,
    Result_Summary TEXT,

    FOREIGN KEY (Visit_ID)
    REFERENCES Visits(Visit_ID)
);
CREATE TABLE Progress_Tracking (
    Progress_ID INT AUTO_INCREMENT PRIMARY KEY,
    Visit_ID INT,
    Progress_Date DATE,
    Symptom_Severity INT,
    Weight DECIMAL(5,2),
    Blood_Pressure VARCHAR(20),
    Sugar_Level DECIMAL(5,2),
    Notes TEXT,

    FOREIGN KEY (Visit_ID)
    REFERENCES Visits(Visit_ID)
);
CREATE TABLE Patient_Allergies (
    Allergy_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID INT,
    Allergy_Name VARCHAR(100),
    Severity VARCHAR(50),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID)
);
CREATE TABLE Chronic_Conditions (
    Condition_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID INT,
    Disease_Name VARCHAR(100),
    Diagnosed_Date DATE,
    Current_Status VARCHAR(50),

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID)
);
CREATE TABLE Billing (
    Bill_ID INT AUTO_INCREMENT PRIMARY KEY,
    Visit_ID INT,
    Consultation_Fee DECIMAL(10,2),
    Test_Charges DECIMAL(10,2),
    Medicine_Charges DECIMAL(10,2),
    Total_Amount DECIMAL(10,2),
    Payment_Status VARCHAR(20),

    FOREIGN KEY (Visit_ID)
    REFERENCES Visits(Visit_ID)
);
CREATE TABLE Follow_Up (
    FollowUp_ID INT AUTO_INCREMENT PRIMARY KEY,
    Visit_ID INT,
    Scheduled_Date DATE,
    Status VARCHAR(20),

    FOREIGN KEY (Visit_ID)
    REFERENCES Visits(Visit_ID)
);
SHOW TABLES;
SELECT COUNT(*) FROM Patients;
INSERT INTO Departments (Department_Name, Head_Doctor)
VALUES
('Cardiology', 'Dr. Rajesh Kumar'),
('Neurology', 'Dr. Priya Sharma'),
('Orthopedics', 'Dr. Arjun Reddy'),
('Dermatology', 'Dr. Sneha Patel'),
('General Medicine', 'Dr. Vikram Singh');
INSERT INTO Patients
(Full_Name, DOB, Gender, Blood_Group, Contact_No, Email, Address, Emergency_Contact)
VALUES
('Ravi Kumar', '1995-06-12', 'Male', 'O+', '9876543210', 'ravi@gmail.com', 'Bangalore', '9876543211'),
('Ananya Sharma', '2000-03-22', 'Female', 'A+', '9876543212', 'ananya@gmail.com', 'Mysore', '9876543213'),
('Karthik Reddy', '1998-09-15', 'Male', 'B+', '9876543214', 'karthik@gmail.com', 'Hyderabad', '9876543215'),
('Priya Nair', '1997-11-08', 'Female', 'AB+', '9876543216', 'priya@gmail.com', 'Kochi', '9876543217'),
('Suresh Patel', '1988-04-30', 'Male', 'O-', '9876543218', 'suresh@gmail.com', 'Ahmedabad', '9876543219');
INSERT INTO Doctors
(Doctor_Name, Specialization, Experience_Years, Contact_No, Department_ID)
VALUES
('Dr. Rajesh Kumar', 'Cardiologist', 15, '9000000001', 1),
('Dr. Priya Sharma', 'Neurologist', 12, '9000000002', 2),
('Dr. Arjun Reddy', 'Orthopedic Surgeon', 10, '9000000003', 3),
('Dr. Sneha Patel', 'Dermatologist', 8, '9000000004', 4),
('Dr. Vikram Singh', 'General Physician', 18, '9000000005', 5);
INSERT INTO Medicines
(Medicine_Name, Manufacturer, Category)
VALUES
('Paracetamol', 'Sun Pharma', 'Fever'),
('Azithromycin', 'Cipla', 'Antibiotic'),
('Metformin', 'Dr Reddy''s', 'Diabetes'),
('Amlodipine', 'Torrent Pharma', 'Blood Pressure'),
('Cetirizine', 'Alkem', 'Allergy'),
('Pantoprazole', 'Sun Pharma', 'Gastric'),
('Ibuprofen', 'Cipla', 'Pain Relief'),
('Vitamin D3', 'Abbott', 'Supplement');
SELECT * FROM Departments;
SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Medicines;
INSERT INTO Appointments
(Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status)
VALUES
(1, 5, '2026-07-01', '10:00:00', 'Completed'),
(1, 5, '2026-07-15', '11:00:00', 'Completed'),
(2, 1, '2026-07-05', '09:30:00', 'Completed'),
(3, 3, '2026-07-10', '14:00:00', 'Completed'),
(4, 4, '2026-07-12', '15:30:00', 'Completed');
INSERT INTO Visits
(Patient_ID, Doctor_ID, Visit_Date, Symptoms, Diagnosis, Follow_Up_Date, Doctor_Notes)
VALUES
(1, 5, '2026-07-01', 'Fever, Headache', 'Viral Fever', '2026-07-15', 'Rest and hydration advised'),

(1, 5, '2026-07-15', 'Persistent Fever', 'Bacterial Infection', '2026-07-30', 'Changed medication'),

(2, 1, '2026-07-05', 'Chest Pain', 'Mild Hypertension', '2026-08-05', 'Monitor BP'),

(3, 3, '2026-07-10', 'Knee Pain', 'Ligament Strain', '2026-07-25', 'Physiotherapy suggested'),

(4, 4, '2026-07-12', 'Skin Rash', 'Allergic Dermatitis', '2026-07-20', 'Avoid allergens');
INSERT INTO Prescriptions
(Visit_ID, Prescription_Date)
VALUES
(1, '2026-07-01'),
(2, '2026-07-15'),
(3, '2026-07-05'),
(4, '2026-07-10'),
(5, '2026-07-12');
INSERT INTO Prescription_Details
(Prescription_ID, Medicine_ID, Dosage, Frequency, Start_Date, End_Date, Purpose, Doctor_Remarks)
VALUES

(1, 1, '500mg', '3 times/day', '2026-07-01', '2026-07-05',
'Reduce fever', 'Complete course'),

(2, 2, '250mg', '2 times/day', '2026-07-15', '2026-07-20',
'Treat infection', 'Replaced Paracetamol'),

(3, 4, '5mg', '1 time/day', '2026-07-05', '2026-08-05',
'Control BP', 'Monitor regularly'),

(4, 7, '400mg', '2 times/day', '2026-07-10', '2026-07-20',
'Pain relief', 'Take after food'),

(5, 5, '10mg', '1 time/day', '2026-07-12', '2026-07-18',
'Allergy treatment', 'Avoid dust');
SELECT
    p.Full_Name,
    v.Visit_Date,
    v.Diagnosis,
    m.Medicine_Name,
    pd.Start_Date,
    pd.End_Date
FROM Patients p
JOIN Visits v
    ON p.Patient_ID = v.Patient_ID
JOIN Prescriptions pr
    ON v.Visit_ID = pr.Visit_ID
JOIN Prescription_Details pd
    ON pr.Prescription_ID = pd.Prescription_ID
JOIN Medicines m
    ON pd.Medicine_ID = m.Medicine_ID
WHERE p.Patient_ID = 1
ORDER BY v.Visit_Date;
SELECT COUNT(*) FROM Patients;
SELECT DATABASE();

DESCRIBE Patients;

SELECT * FROM Patients;
USE MediTrack;
SELECT COUNT(*) FROM Patients;
SELECT * FROM Patients;
DESCRIBE Patients;
SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Departments;
DESCRIBE Visits;
DESCRIBE Prescriptions;
DESCRIBE Prescription_Details;
DESCRIBE Medicines;
SELECT * FROM Medicines;
SELECT * FROM Prescription_Details;