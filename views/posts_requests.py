import sqlite3
import json
from models import Posts, Users, Categories


def get_all_posts():
    with sqlite3.connect("./db.sqlite3") as conn:

        # Just use these. It's a Black Box.
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Write the SQL query to get the information you want
        db_cursor.execute("""
            SELECT
                p.id,
                p.user_id,
                p.category_id,
                p.title,
                p.publication_date,
                p.image_url,
                p.content,
                p.approved,
                u.first_name first_name,
                u.last_name last_name,
                u.email email,
                u.bio bio,
                u.username username,
                u.password password,
                u.profile_image_url image,
                u.created_on date,
                u.active active,        
                c.label category             
            FROM `Posts` p
            JOIN Users u 
                ON u.id = p.user_id
            JOIN Categories c
                ON c.id = p.category_id
            """)

        # Initialize an empty list to hold all order representations
        posts = []

        # Convert rows of data into a Python list
        dataset = db_cursor.fetchall()

        # Iterate list of data returned from database
        for row in dataset:

            post = Posts(row['id'], row['user_id'],
                         row['category_id'], row['title'],
                         row['publication_date'], row['image_url'],
                         row['content'], row['approved'])

            user = Users(row['id'], row['first_name'], row['last_name'], row['email'], row['bio'],
                         row['username'], row['password'], row['image'], row['date'], row['active'])

            categories = Categories(row['id'], row['category'])

            post.user = user.__dict__

            post.categories = categories.__dict__

            posts.append(post.__dict__)

    return posts


def get_single_post(id):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Use a ? parameter to inject a variable's value
        # into the SQL statement.
        db_cursor.execute("""
            SELECT
                p.id,
                p.user_id,
                p.category_id,
                p.title,
                p.publication_date,
                p.image_url,
                p.content,
                p.approved,
                u.first_name first_name,
                u.last_name last_name,
                u.email email,
                u.bio bio,
                u.username username,
                u.password password,
                u.profile_image_url image,
                u.created_on date,
                u.active active,        
                c.label category             
            FROM `Posts` p
            JOIN Users u 
                ON u.id = p.user_id
            JOIN Categories c
                ON c.id = p.category_id
            WHERE id = ?
            """, (id, ))

        # Load the single result into memo
        data = db_cursor.fetchone()

        # Create an animal instance from the current row
        post = Posts(data['id'], data['user_id'],
                     data['category_id'], data['title'],
                     data['publication_date'], data['image_url'],
                     data['content'], data['approved'])

        user = Users(data['id'], data['first_name'], data['last_name'], data['email'], data['bio'],
                     data['username'], data['password'], data['image'], data['date'], data['active'])

        categories = Categories(data['id'], data['category'])

        post.user = user.__dict__

        post.categories = categories.__dict__

        return post.__dict__
