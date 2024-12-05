# StudyCentral
*A collaborative platform for Cornell students to share and access study resources for prelims.*

---

## Overview

**StudyCentral** is an open-source resource-sharing app designed for Cornell students to streamline their study preparations. It allows users to add topics and share resource links for each prelim in every course. The app fosters collaboration and provides centralized access to all study materials in an intuitive and easy-to-use interface.

The backend is built using **Flask (Python)**, while the frontend is developed in **XCode** using **Swift** for a seamless and user-friendly experience.

---

## Features

- **Course Management**: Create and view courses with detailed information, including descriptions, schedules, and prerequisites.
- **Prelim Tracker**: Add prelims associated with specific courses, complete with titles and dates.
- **Resource Sharing**: Add and view study topics along with resource links for each prelim.
- **Frontend Features**:  
  - Intuitive UI for managing courses, prelims, and resources.  
  - Mobile compatibility for on-the-go study planning.  
  - Easy navigation with dedicated sections for courses, prelims, and topics.  
- **Seamless API Functionality**: Offers a robust backend for managing courses, prelims, and topics through well-structured API routes.

---

## Screenshots

### Home Page
![Home Page](ScreenshotsOfApp/MainScreen.jpeg)

### Top of Course Page 
![Top of Course Page](ScreenshotsOfApp/ClassSS1.jpeg)

### Adding a Resource to each Prelim
![Add Resource](ScreenshotsOfApp/ClassSS2.jpeg)

---

## API Endpoints

### Course Management
- **`GET /api/courses/`**  
  Retrieve all courses.

- **`POST /api/courses/`**  
  Create a new course with details like name, description, and schedule.

- **`GET /api/courses/<int:course_id>/`**  
  Retrieve details of a specific course.

- **`DELETE /api/courses/<int:course_id>/`**  
  Delete a specific course.

### Prelim Management
- **`GET /api/prelims/`**  
  Retrieve all prelims across courses.

- **`POST /api/prelims/`**  
  Add a new prelim by specifying course ID, title, and date.

- **`GET /api/prelims/<int:prelim_id>/`**  
  Retrieve details of a specific prelim.

- **`DELETE /api/prelims/<int:prelim_id>/`**  
  Delete a specific prelim.

### Topic and Resource Sharing
- **`GET /api/topics/`**  
  Retrieve all topics and resources.

- **`POST /api/topics/`**  
  Add a new topic and resource link to a specific prelim.

- **`GET /api/topics/<int:topic_id>/`**  
  Retrieve details of a specific topic.

- **`DELETE /api/topics/<int:topic_id>/`**  
  Delete a specific topic.

---

## How We Addressed the Requirements

1. **CRUD Operations**  
   The app supports full CRUD operations for courses, prelims, and topics via the backend API routes.

2. **Logical Flow**  
   The API endpoints are well-structured and ensure a clear workflow for managing data, complemented by a user-friendly frontend.

3. **Collaboration**  
   StudyCentral allows students to collaboratively build and share study resources, making it easier for everyone to prepare for prelims.

4. **Cross-Platform Availability**  
   - Backend: A robust API that can handle requests from multiple frontend clients.
   - Frontend: A mobile-friendly Swift app developed using XCode.

5. **Documentation**  
   This README includes all necessary documentation about the app's purpose, features, and API routes.

---

## Technology Stack
- **Backend**: Flask (Python)
- **Database**: SQLite
- **Frontend**: XCode (Swift)
- **Hosting**: Localhost for development (port `8000`)

---

## Contributors
Frontend: 
- Samantha Ahn, Ruby Penafiel-Gutierrez
  
Backend:
- Aleks Dzudzevic, Shannon Lin, Sandra Tang

---

## Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/mcorgi/hackchallenge2024.git
   cd hackchallenge2024
2. Set up the frontend (iOS):
- Open the project folder in XCode (look for the .xcodeproj or .xcworkspace file).
- Update the backend URL in the iOS app’s configuration to match your backend deployment or local server URL.

3. Run the frontend app:
- Select your target device or iOS simulator in XCode.
- Click the Run button to launch the app.

4. Access your app:
- Backend: http://localhost:8000/
- Frontend: iOS app running on the simulator or device.
