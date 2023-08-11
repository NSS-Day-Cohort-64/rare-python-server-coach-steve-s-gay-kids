import sqlite3
import json
from models import Posts


def get_all_posts():
    with sqlite3.connect("./db.sqlite3") as conn:

        # Just use these. It's a Black Box.
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Write the SQL query to get the information you want
        db_cursor.execute("""
            SELECT
                id,
                user_id,
                category_id,
                title,
                publication_date,
                image_url,
                content,
                approved             
            FROM Posts
            """)

        # Initialize an empty list to hold all order representations
        posts = []

        # Convert rows of data into a Python list
        dataset = db_cursor.fetchall()

        # Iterate list of data returned from database
        for row in dataset:

            # Create an animal instance from the current row
            post = Posts(row['id'], row['user_id'],
                         row['category_id'], row['title'],
                         row['publication_date'], row['image_url'],
                         row['content'], row['approved'])

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
                id,
                user_id,
                category_id,
                title,
                publication_date,
                image_url,
                content,
                approved             
            FROM Posts
            WHERE id = ?
            """, (id, ))

        # Load the single result into memo
        data = db_cursor.fetchone()

        # Create an animal instance from the current row
        post = Posts(data['id'], data['user_id'],
                     data['category_id'], data['title'],
                     data['publication_date'], data['image_url'],
                     data['content'], data['approved'])

        return post.__dict__
