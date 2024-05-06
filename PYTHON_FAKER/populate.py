import mysql.connector
from faker import Faker

fake = Faker()

# Establish a database connection
cnx = mysql.connector.connect(
    user='root', 
    password='', 
    host='localhost', 
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
for _ in range(100):
    query = ("INSERT INTO ingridient (ingridient_name, food_group_id) VALUES (%s, %s)")
    data = (fake.word(), fake.random_int(min=1, max=10, step=1))
    cursor.execute(query, data)

# Generate data for cook table
for _ in range(50):
    query = ("INSERT INTO cook (cook_name) VALUES (%s)")
    data = (fake.name(),)
    cursor.execute(query, data)

# Generate data for episode table
for _ in range(50):
    query = ("INSERT INTO episode (episode_name) VALUES (%s)")
    data = (fake.sentence(),)
    cursor.execute(query, data)

# Generate data for recipe table
for _ in range(50):
    query = ("INSERT INTO recipe (recipe_name, ingridient_id, cook_id, episode_id) VALUES (%s, %s, %s, %s)")
    data = (fake.sentence(), fake.random_int(min=1, max=100, step=1), fake.random_int(min=1, max=50, step=1), fake.random_int(min=1, max=50, step=1))
    cursor.execute(query, data)

# Commit the changes and close the connection
cnx.commit()
cursor.close()
cnx.close()