import json
from flask import Flask, request
from db import db, Course, Prelim, Topic

# Set up the Flask app and database configuration
db_filename = "database.db"
app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)

with app.app_context():
    db.create_all()


# Utility functions
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# COURSE ROUTES

@app.route("/")
def home():
    return "Hello, World!"

@app.route("/api/courses/", methods=["GET"])
def get_courses():
    """
    Endpoint for getting the list of all courses
    """
    courses = [course.serialize() for course in Course.query.all()]
    return success_response({"courses": courses})


@app.route("/api/courses/", methods=["POST"])
def create_course():
    """
    Endpoint for adding a new course
    """
    body = json.loads(request.data)
    name = body.get("name")
    description = body.get("description")
    schedule = body.get("schedule")
    prerequisites = body.get("prerequisites")

    if not name or not description or not schedule:
        return failure_response("Missing required fields", 400)

    course = Course(
        name=name,
        description=description,
        schedule=schedule,
        prerequisites=prerequisites or "",
    )
    db.session.add(course)
    db.session.commit()
    return success_response(course.serialize(), 201)


@app.route("/api/courses/<int:course_id>/", methods=["GET"])
def get_course(course_id):
    """
    Endpoint for getting a specific course by ID
    """
    course = Course.query.get(course_id)
    if course is None:
        return failure_response("Course not found", 404)
    return success_response(course.serialize())


@app.route("/api/courses/<int:course_id>/", methods=["DELETE"])
def delete_course(course_id):
    """
    Endpoint for deleting a course by ID
    """
    course = Course.query.get(course_id)
    if course is None:
        return failure_response("Course not found", 404)
    db.session.delete(course)
    db.session.commit()
    return success_response(course.serialize())


# PRELIM ROUTES

@app.route("/api/prelims/", methods=["GET"])
def get_prelims():
    """
    Endpoint for getting the list of all prelims
    """
    prelims = [prelim.serialize() for prelim in Prelim.query.all()]
    return success_response({"prelims": prelims})


@app.route("/api/prelims/", methods=["POST"])
def create_prelim():
    """
    Endpoint for adding a new prelim
    """
    body = json.loads(request.data)
    title = body.get("title")
    date = body.get("date")
    course_id = body.get("course_id")

    if not title or not date or not course_id:
        return failure_response("Missing required fields", 400)

    prelim = Prelim(title=title, date=date, course_id=course_id)
    db.session.add(prelim)
    db.session.commit()
    print("HELLO")
    print(prelim)
    return success_response(prelim.serialize(), 201)


@app.route("/api/prelims/<int:course_id>/", methods=["GET"])
def get_prelims_by_course(course_id):
    """
    Endpoint for getting a specific prelim by ID
    """
    course = Course.query.get(course_id)
    if course is None:
        return failure_response("Course not found", 404)

    prelims = Prelim.query.filter_by(course_id=course_id).all()

    if prelims is None:
        return failure_response("Course has no prelims", 404)
    
    prelims_res = []

    for p in prelims:
        prelims_res.append(p.serialize())
    
    return success_response({"prelims": prelims_res})



@app.route("/api/prelims/<int:prelim_id>/", methods=["DELETE"])
def delete_prelim(prelim_id):
    """
    Endpoint for deleting a prelim by ID
    """
    prelim = Prelim.query.get(prelim_id)
    if prelim is None:
        return failure_response("Prelim not found", 404)
    db.session.delete(prelim)
    db.session.commit()
    return success_response(prelim.serialize())


# TOPIC ROUTES

@app.route("/api/topics/", methods=["GET"])
def get_all_topics():
    """
    Endpoint for getting the list of all topics
    """
    topics = [topic.serialize() for topic in Topic.query.all()]
    return success_response({"topics": topics})


@app.route("/api/topics/", methods=["POST"])
def create_topic():
    """
    Endpoint for adding a new topic
    """
    body = json.loads(request.data)
    name = body.get("name")
    resource_link = body.get("resource_link")
    prelim_id = body.get("prelim_id")

    if not name or not prelim_id:
        return failure_response("Missing required fields", 400)
    
    prelim = Prelim.query.get(prelim_id)
    if not prelim:
        return failure_response("Prelim not found", 404)

    topic = Topic(name=name, resource_link=resource_link, prelim_id=prelim_id)
    prelim.topics.append(topic)

    db.session.add(topic)
    db.session.commit()
 

    return success_response({
        "name": name,
        "resource_link": resource_link,
        "prelim_id": prelim.id,
        "topic_id": topic.id
    }, 201)


@app.route("/api/topics/<int:topic_id>/", methods=["GET"])
def get_specific_topic(topic_id):
    """
    Endpoint for getting a specific topic by ID
    """
    topic = Topic.query.get(topic_id)
    if topic is None:
        return failure_response("Topic not found", 404)
    return success_response(topic.serialize())


@app.route("/api/topics/<int:topic_id>/", methods=["DELETE"])
def delete_topic(topic_id):
    """
    Endpoint for deleting a topic by ID
    """
    topic = Topic.query.get(topic_id)
    if topic is None:
        return failure_response("Topic not found", 404)
    db.session.delete(topic)
    db.session.commit()
    return success_response(topic.serialize())


@app.route("/api/topics/prelims/<int:course_id>", methods=["GET"])
def get_topics_by_course(course_id):
    """
    Endpoint for getting all topics from course id
    """
    course = Topic.query.get(course_id)
    # need to get all prelims from that course id 

    if course is None:
        return failure_response("Course not found", 404)
    return success_response(course.serialize())



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
