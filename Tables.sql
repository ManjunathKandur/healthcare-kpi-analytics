CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    city VARCHAR(100),
    registration_date DATE NOT NULL 
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100)
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    experience_years INT CHECK (experience_years >= 0),
    consultation_fee DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
        
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type ENUM('General', 'Semi-Private', 'Private', 'ICU') NOT NULL,
    daily_rate DECIMAL(10,2) NOT NULL,
    total_beds INT NOT NULL CHECK (total_beds > 0)
);

CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    room_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    diagnosis VARCHAR(255),
    total_bill DECIMAL(12,2),
    
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
      ,
        
    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
  ,
        
    FOREIGN KEY (room_id)
        REFERENCES rooms(room_id)
        
);

CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT NOT NULL,
    treatment_name VARCHAR(150) NOT NULL,
    treatment_cost DECIMAL(10,2) NOT NULL,
    treatment_date DATE NOT NULL,
    
    FOREIGN KEY (admission_id)
        REFERENCES admissions(admission_id)
        
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(12,2) NOT NULL,
    payment_mode ENUM('Cash', 'Card', 'UPI', 'Insurance') NOT NULL,
    
    FOREIGN KEY (admission_id)
        REFERENCES admissions(admission_id)
        
);

CREATE TABLE opd_visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_date DATE NOT NULL,
    diagnosis VARCHAR(255),
    consultation_fee DECIMAL(10,2),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON DELETE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);