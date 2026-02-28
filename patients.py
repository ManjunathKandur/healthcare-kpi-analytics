import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker("en_IN")

# Urban Weighting (Realistic Hospital Load)
cities = [
    ("Bengaluru", 30),
    ("Mysuru", 10),
    ("Hubballi", 8),
    ("Mangaluru", 8),
    ("Belagavi", 7),
    ("Dharwad", 6),
    ("Shivamogga", 6),
    ("Udupi", 5),
    ("Ballari", 5),
    ("Vijayapura", 5),
    ("Kalaburagi", 4),
    ("Tumakuru", 3),
    ("Davanagere", 2),
    ("Chitradurga", 1)
]

city_names = [c[0] for c in cities]
city_weights = [c[1] for c in cities]

# Karnataka Surnames
karnataka_surnames = [
    "Reddy", "Gowda", "Shetty", "Naik", "Patil",
    "Kulkarni", "Bhat", "Hegde", "Desai",
    "Rao", "Murthy", "Joshi", "Sharma",
    "Acharya", "Poojary", "Nayak"
]

# Registration date range
start_date = datetime(2025, 8, 1)
end_date = datetime(2026, 2, 27)

def random_registration_date():
    delta = end_date - start_date
    return (start_date + timedelta(days=random.randint(0, delta.days))).date()

def random_gender():
    return random.choices(
        ["Male", "Female", "Other"],
        weights=[48, 48, 4]
    )[0]

def random_dob():
    age_group = random.choices(
        ["pediatric", "young", "adult", "middle", "senior"],
        weights=[18, 15, 35, 15, 17]
    )[0]

    age_ranges = {
        "pediatric": (0, 12),
        "young": (13, 25),
        "adult": (26, 45),
        "middle": (46, 65),
        "senior": (66, 85)
    }

    min_age, max_age = age_ranges[age_group]
    age = random.randint(min_age, max_age)

    return fake.date_of_birth(minimum_age=age, maximum_age=age)

def random_name(gender):
    if gender == "Male":
        first = fake.first_name_male()
    elif gender == "Female":
        first = fake.first_name_female()
    else:
        first = fake.first_name()

    last = random.choice(karnataka_surnames)
    return first.replace("'", "''"), last.replace("'", "''")

# Generate SQL
with open("patients_5000_v2.sql", "w", encoding="utf-8") as f:

    batch_size = 1000
    total_records = 5000

    for batch_start in range(0, total_records, batch_size):

        f.write("INSERT INTO patients (first_name, last_name, gender, date_of_birth, city, registration_date) VALUES\n")

        values = []

        for _ in range(batch_size):
            gender = random_gender()
            first_name, last_name = random_name(gender)
            dob = random_dob()
            city = random.choices(city_names, weights=city_weights)[0]
            reg_date = random_registration_date()

            record = f"('{first_name}','{last_name}','{gender}','{dob}','{city}','{reg_date}')"
            values.append(record)

        f.write(",\n".join(values))
        f.write(";\n\n")

print("✅ Ultra-Realistic 5000 Karnataka patient records generated!")