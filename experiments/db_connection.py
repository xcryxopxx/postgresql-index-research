import os
from pathlib import Path

import psycopg
from dotenv import load_dotenv


# Load database credentials from the project directory
BASE_DIR = Path(__file__).resolve().parent.parent
load_dotenv(BASE_DIR / ".env")


def get_connection():
    return psycopg.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )


if __name__ == "__main__":
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT version();")
            version = cur.fetchone()[0]

            print("Database connection successful!")
            print(version)

            cur.execute(
                "SELECT COUNT(*) FROM transactions_normal;"
            )
            count = cur.fetchone()[0]

            print(f"Number of transactions: {count}")