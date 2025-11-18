from app.database.connection import engine, Base
from app.models import User, Portfolio, Holding


def init_db():
    Base.metadata.create_all(bind=engine)
    print("Database tables created successfully!")


if __name__ == "__main__":
    init_db()
