import MySQLdb

def insert_image(db_params, table_name, column_name, image_path, identifier_column, identifier_value):
    # Connect to the database
    db = MySQLdb.connect(**db_params)
    cursor = db.cursor()

    # Read the image file
    with open(image_path, 'rb') as file:
        binary_data = file.read()

    # Prepare the SQL query
    query = f"""
    UPDATE {table_name}
    SET {column_name} = %s
    WHERE {identifier_column} = %s
    """
    
    # Execute the query
    cursor.execute(query, (binary_data, identifier_value))

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

# Example usage
insert_image(db_params, 'recipe', 'image', 'path/to/your/image.jpg', 'recipe_id', 1)
insert_image(db_params, 'cooking_equipment', 'actual_image', 'chef_1.jpg', 'equipment_id', 1)
insert_image(db_params, 'chef', 'actual_image', 'chef_1.jpg', 'chef_id', 1)
