import sqlite3
from models import Tags


def get_all_tags():
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
            SELECT
                t.id,
                t.label
            FROM Tags t
        """)

        tags = []
        dataset = db_cursor.fetchall()

        for row in dataset:
            tag = Tags(row['id'], row['label'])
            tags.append(tag.__dict__)

    return tags


def get_single_tag(id):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
            SELECT
                t.id,
                t.label
            FROM Tags t
            WHERE t.id = ?
        """, (id, ))

        data = db_cursor.fetchone()

        # Create an tag instance from the current row
        tag = Tags(data['id'], data['label'])
        return tag.__dict__


def create_tag(new_tag):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        INSERT INTO Tags (label)
        VALUES (?)
        """, (new_tag['label'],))

        # Get the last inserted row id
        id = db_cursor.lastrowid

        # Set the id property of the new_tag object
        new_tag['id'] = id

    return new_tag


def update_tag(id, new_tag):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        UPDATE Tags
        SET label = ?
        WHERE id = ?
        """, (new_tag['label'], id, ))

        row_affected = db_cursor.rowcount
        
        if row_affected == 0:
            # Log more information if update fails
            print(f"Update failed for id: {id}, label: {new_tag['label']}")
            return False
        else:
            print(f"Update succeeded for id: {id}, label: {new_tag['label']}")
            return True


def delete_tag(id):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        try:
            db_cursor.execute("""
                DELETE FROM Tags
                WHERE id = ?
            """, (id,))
            conn.commit()
            return True
        except sqlite3.Error:
            return False
