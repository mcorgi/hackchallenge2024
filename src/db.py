from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Links prelim to course (Many-to-Many relationship)
# This table is used to associate prelims with courses.
prelim_course = db.Table(
    "prelim_course",
    db.Column("prelim_id", db.Integer, db.ForeignKey("prelim.id"), primary_key=True),
    db.Column("course_id", db.Integer, db.ForeignKey("course.id"), primary_key=True)
)

# Links prelim to topic (Many-to-Many relationship)
# This table is used to associate prelims with topics.
prelim_topic = db.Table(
    "prelim_topic",
    db.Column("prelim_id", db.Integer, db.ForeignKey("prelim.id"), primary_key=True),
    db.Column("topic_id", db.Integer, db.ForeignKey("topic.id"), primary_key=True)
)


class Course(db.Model):
    """
    Represents a course in the system.
    Each course has:
      - A name (e.g., "CS4820")
      - A description (e.g., "Algorithms course")
      - A schedule (e.g., "MWF 10:00 AM - 11:00 AM")
      - A list of prerequisites (stored as a comma-separated string)
    A course can have multiple prelims (one-to-many relationship).
    """
    __tablename__ = "course"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    schedule = db.Column(db.String, nullable=False)
    prerequisites = db.Column(db.String, nullable=True)  
    prelims = db.relationship("Prelim", back_populates="course", cascade="all, delete")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "schedule": self.schedule,
            "prerequisites": self.prerequisites.split(",") if self.prerequisites else [],
        }


class Prelim(db.Model):
    """
    Represents a prelim (exam) in the system.
    Each prelim has:
      - A title (e.g., "Midterm 1")
      - A date (stored as a string, e.g., "2024-12-15")
      - A course ID (foreign key linking to the associated course)
    A prelim belongs to a course (many-to-one relationship) and
    can be associated with multiple topics (many-to-many relationship).
    """
    __tablename__ = "prelim"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String, nullable=False)
    date = db.Column(db.String, nullable=False)
    course_id = db.Column(db.Integer, db.ForeignKey("course.id"), nullable=False)
    course = db.relationship("Course", back_populates="prelims")
    topics = db.relationship(
        "Topic",
        secondary=prelim_topic,
        back_populates="prelims",
    )

    def serialize(self):
        return {
            "id": self.id,
            "title": self.title,
            "date": self.date,
            "course_id": self.course_id,
            "topics": [topic.serialize() for topic in self.topics],
        }

    def simple_serialize(self):
        return {
            "id": self.id,
            "title": self.title,
        }


class Topic(db.Model):
    """
    Represents a topic in the system.
    Each topic has:
      - A name (e.g., "Sorting Algorithms")
      - A resource link (e.g., a URL to a study resource, optional)
    A topic can be associated with multiple prelims (many-to-many relationship).
    """
    __tablename__ = "topic"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    resource_link = db.Column(db.String, nullable=True)
    prelim_id = db.Column(db.Integer, db.ForeignKey('prelim.id'), nullable=False) 
    prelims = db.relationship(
        "Prelim",
        secondary=prelim_topic,
        back_populates="topics",
    )



    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "resource_link": self.resource_link,
            "prelims": [prelim.simple_serialize() for prelim in self.prelims]
        }
