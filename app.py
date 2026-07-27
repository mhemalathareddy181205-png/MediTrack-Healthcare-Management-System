from flask import Flask, render_template, request, redirect
import mysql.connector

print("NEW APP.PY LOADED")

app = Flask(__name__)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hemalatha@18125",
    database="MediTrack"
)

@app.route('/')
def home():

    cursor = db.cursor()

    cursor.execute("SELECT COUNT(*) FROM Patients")
    total_patients = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Doctors")
    total_doctors = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Visits")
    total_visits = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Prescriptions")
    total_prescriptions = cursor.fetchone()[0]

    return render_template(
        'home.html',
        total_patients=total_patients,
        total_doctors=total_doctors,
        total_visits=total_visits,
        total_prescriptions=total_prescriptions
    )

@app.route('/patients')
def patients():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Patients")
    patients = cursor.fetchall()

    print("Patients =", patients)

    return render_template('patients.html', patients=patients)

@app.route('/add_patient', methods=['GET', 'POST'])
def add_patient():

    if request.method == 'POST':

        full_name = request.form['full_name']
        dob = request.form['dob']
        gender = request.form['gender']
        blood_group = request.form['blood_group']
        contact = request.form['contact']
        email = request.form['email']
        address = request.form['address']
        emergency_contact = request.form['emergency_contact']

        cursor = db.cursor()

        query = """
        INSERT INTO Patients
        (
        Full_Name,
        DOB,
        Gender,
        Blood_Group,
        Contact_No,
        Email,
        Address,
        Emergency_Contact
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
        """

        values = (
            full_name,
            dob,
            gender,
            blood_group,
            contact,
            email,
            address,
            emergency_contact
        )

        cursor.execute(query, values)
        db.commit()

        return redirect('/patients')

    return render_template('add_patient.html')

@app.route('/edit_patient/<int:id>', methods=['GET', 'POST'])
def edit_patient(id):

    cursor = db.cursor()

    if request.method == 'POST':

        full_name = request.form['full_name']
        dob = request.form['dob']
        gender = request.form['gender']
        blood_group = request.form['blood_group']
        contact = request.form['contact']
        email = request.form['email']
        address = request.form['address']
        emergency_contact = request.form['emergency_contact']

        query = """
        UPDATE Patients
        SET Full_Name=%s,
            DOB=%s,
            Gender=%s,
            Blood_Group=%s,
            Contact_No=%s,
            Email=%s,
            Address=%s,
            Emergency_Contact=%s
        WHERE Patient_ID=%s
        """

        values = (
            full_name,
            dob,
            gender,
            blood_group,
            contact,
            email,
            address,
            emergency_contact,
            id
        )

        cursor.execute(query, values)
        db.commit()

        return redirect('/patients')

    cursor.execute(
        "SELECT * FROM Patients WHERE Patient_ID=%s",
        (id,)
    )

    patient = cursor.fetchone()

    return render_template(
        'edit_patient.html',
        patient=patient
    )

@app.route('/delete_patient/<int:id>')
def delete_patient(id):

    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM Patients WHERE Patient_ID=%s",
        (id,)
    )

    db.commit()

    return redirect('/patients')

@app.route('/doctors')
def doctors():

    cursor = db.cursor()

    query = """
    SELECT
        d.Doctor_ID,
        d.Doctor_Name,
        d.Specialization,
        d.Experience_Years,
        d.Contact_No,
        dp.Department_Name
    FROM Doctors d
    JOIN Departments dp
    ON d.Department_ID = dp.Department_ID
    """

    cursor.execute(query)

    doctors = cursor.fetchall()

    return render_template(
        'doctors.html',
        doctors=doctors
    )
@app.route('/prescription_history')
def prescription_history():

    cursor = db.cursor()

    query = """
SELECT
    p.Full_Name,
    d.Doctor_Name,
    v.Visit_Date,
    v.Diagnosis,
    m.Medicine_Name,
    pd.Dosage,
    pd.Frequency,
    pd.Start_Date,
    pd.End_Date
FROM Patients p
JOIN Visits v
    ON p.Patient_ID = v.Patient_ID
JOIN Doctors d
    ON v.Doctor_ID = d.Doctor_ID
JOIN Prescriptions pr
    ON v.Visit_ID = pr.Visit_ID
JOIN Prescription_Details pd
    ON pr.Prescription_ID = pd.Prescription_ID
JOIN Medicines m
    ON pd.Medicine_ID = m.Medicine_ID
ORDER BY p.Full_Name, v.Visit_Date
"""

    cursor.execute(query)

    history = cursor.fetchall()

    return render_template(
        'prescription_history.html',
        history=history
    )

@app.route('/search_patient')
def search_patient():
    return render_template('search_patient.html')

@app.route('/patient_history')
def patient_history():

    patient_id = request.args.get('patient_id')

    cursor = db.cursor()

    query = """
    SELECT
        p.Full_Name,
        d.Doctor_Name,
        v.Visit_Date,
        v.Diagnosis,
        m.Medicine_Name,
        pd.Dosage
    FROM Patients p
    JOIN Visits v
        ON p.Patient_ID = v.Patient_ID
    JOIN Doctors d
        ON v.Doctor_ID = d.Doctor_ID
    JOIN Prescriptions pr
        ON v.Visit_ID = pr.Visit_ID
    JOIN Prescription_Details pd
        ON pr.Prescription_ID = pd.Prescription_ID
    JOIN Medicines m
        ON pd.Medicine_ID = m.Medicine_ID
    WHERE p.Patient_ID = %s
    ORDER BY v.Visit_Date
    """

    cursor.execute(query, (patient_id,))
    history = cursor.fetchall()

    return render_template(
        'patient_history.html',
        history=history
    )

if __name__ == '__main__':
    app.run(debug=True)