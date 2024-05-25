import MySQLdb

def insert_image_with_description(db_params, table_name, image_column, image_path, description_column, description_value, identifier_column, identifier_value):
    # Connect to the database
    db = MySQLdb.connect(**db_params)
    cursor = db.cursor()

    # Read the image file
    with open(image_path, 'rb') as file:
        binary_data = file.read()

    # Prepare the SQL query
    query = f"""
    UPDATE {table_name}
    SET {image_column} = %s, {description_column} = %s
    WHERE {identifier_column} = %s
    """
    
    # Execute the query
    cursor.execute(query, (binary_data, description_value, identifier_value))

    # Commit the transaction
    db.commit()

    # Close the connection
    cursor.close()
    db.close()

# Database connection parameters
db_params = {
    'host': 'localhost',
    'user': 'root',
    'passwd': 'password',
    'db': 'dblabV2'
}

for i in range(1,51):
    path_to_image = "images/chefs/chef" + str(i) + ".jpg"
    print(f"adding image {path_to_image} to chef with id: {i}")
    insert_image_with_description(db_params, 'chef', 'actual_image', path_to_image, 'image_description', 'This is a renowned chef.', 'chef_id', i)
for i in range(1,51):
    path_to_image = "images/equipment/equip" + str(i) + ".jpg"
    print(f"adding image {path_to_image} to equipment with id: {i}")
    insert_image_with_description(db_params, 'cooking_equipment', 'image', path_to_image, 'image_description', 'This is a versatile piece of cooking equipment.', 'equipment_id', i)
for i in range(1,51):
        path_to_image = "images/recipes/recipe" + str(i) + ".jpeg"
        print(f"adding image {path_to_image} to recipe with id: {i}")
        insert_image_with_description(db_params, 'cooking_equipment', 'image', path_to_image, 'image_description', 'This is a versatile piece of cooking equipment.', 'equipment_id', i)