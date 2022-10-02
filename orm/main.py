from sqlalchemy.orm import declarative_base, relationship
from sqlalchemy import Column, ForeignKey, Table, Integer, String, create_engine

URL="mysql+mysqlconnector://root@localhost/exam"
engine = create_engine(url=URL)

Base = declarative_base()

## Many-to-Many relationships
group_members = Table(
    "group_members",
    Base.metadata,
    Column("user_id", ForeignKey("user.id"), primary_key=True),
    Column("group_id", ForeignKey("group.id"), primary_key=True),
)

user_interests = Table(
    "user_interests",
    Base.metadata,
    Column("user_id", ForeignKey("user.id"), primary_key=True),
    Column("interest_id", ForeignKey("interest.id"), primary_key=True),
)

group_interests = Table(
    "group_interests",
    Base.metadata,
    Column("group_id", ForeignKey("group.id"), primary_key=True),
    Column("interest_id", ForeignKey("interest.id"), primary_key=True),
)

## All Tables
class User(Base):
    __tablename__ = "user"
    id = Column(Integer, primary_key=True)
    nickname = Column(String(150), nullable=False)
    photo_id = Column(Integer, ForeignKey("profile_photo.id"), nullable=False)
    about_me = Column(String(150), nullable=False)
    language_id = Column(Integer, ForeignKey("language.id"), nullable=False)
    country_id = Column(Integer, ForeignKey("country.id"), nullable=False)
    members = relationship(
        "Group", secondary=group_members, back_populates="user"
    )
    interests = relationship(
        "Interest", secondary=user_interests, back_populates='user'
    )


class Group(Base):
    __tablename__ = "group"
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    description = Column(String(150), nullable=False)
    language_id = Column(Integer, ForeignKey("language.id"), nullable=False)
    members = relationship(
        "User", secondary=group_members, back_populates="group"
    )
    interests = relationship(
        "Interest", secondary=group_interests, back_populates='group'
    )


class Interest(Base):
    __tablename__ = "interest"
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    description = Column(String(150), nullable=False)
    user_interest = relationship(
        "User", secondary=user_interests, back_populates='interest'
    )
    group_interest = relationship(
        "Group", secondary=group_interests, back_populates='interest'
    )


class Country(Base):
    __tablename__ = "country"
    id = Column(Integer, primary_key=True)
    name = Column(String(80), nullable=False)


class Language(Base):
    __tablename__ = "language"
    id = Column(Integer, primary_key=True)
    name = Column(String(80), nullable=False)

class Profile_Photo(Base):
    __tablename__ = "profile_photo"
    id = Column(Integer, primary_key=True)
    url = Column(String(150), nullable=False)


## Create tables in 'exam' database
Base.metadata.drop_all(engine)
Base.metadata.create_all(engine)