import mysql.connector
from faker import Faker

fake = Faker()

# Establish a database connection
cnx = mysql.connector.connect(
    user='your_username', 
    password='your_password', 
    host='your_host', 
    database='dbs2024-119'
)
cursor = cnx.cursor()

# Generate data for food_group table
for _ in range(10):
    query = ("INSERT INTO food_group (group_name, group_description) VALUES (%s, %s)")
    data = (fake.word(), fake.sentence())
    cursor.execute(query, data)

# Generate data for theme table
for _ in range(10):
    query = ("INSERT INTO theme (theme_name, theme_description) VALUES (%s, %s)")
    data = (fake.word(), fake.sentence())
    cursor.execute(query, data)

# Generate data for cousine table
for _ in range(10):
    query = ("INSERT INTO cousine (cousine_name) VALUES (%s)")
    data = (fake.word(),)
    cursor.execute(query, data)

# Generate data for tag table
for _ in range(10):
    query = ("INSERT INTO tag (tag_name) VALUES (%s)")
    data = (fake.word(),)
    cursor.execute(query, data)

# Generate data for ingridient table
for _ in range(10):
    query = ("INSERT INTO ingridient (ingridient_name, food_group_id) VALUES (%s, %s)")
    data = (fake.word(), fake.random_int(min=1, max=10, step=1))
    cursor.execute(query, data)

# Commit the changes and close the connection
cnx.commit()
cursor.close()
cnx.close()