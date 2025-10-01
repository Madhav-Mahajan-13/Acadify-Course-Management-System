# 📚 Course Management System

A comprehensive **Course Management System** designed to streamline academic workflows.  
This system manages **courses, offerings, faculty, documents, chatrooms, and communication**,  
ensuring smooth coordination between faculty, coordinators, and administration.

---

## 🚀 Highlights
- **Structured Course Offerings** – link courses, semesters, and coordinators.
- **Automated Chatrooms** – every course offering gets its own discussion space.
- **Document Management** – track required documents, assignments, due dates, and statuses.
- **Faculty Assignments** – assign multiple faculty to offerings and prevent duplication.
- **Messaging System** – real-time communication with audit logging for accountability.
- **Data Integrity via Triggers** – smart automation like:
  - Auto-create chatrooms when a course is offered.
  - Prevent past due dates for assignments.
  - Auto-update upload status when files are submitted.
  - Log every message for history tracking.
- **Optimized Indexing** – fast retrieval for APIs, supporting pagination, search, and filtering.
- **Clean API-Oriented Views** – simplified SQL access via pre-built views.

---

## 🗂 Database Schema Overview
### Key Entities
- **Personnel** – Faculty, coordinators, staff.
- **Courses** – Each course with unique code and name.
- **Semesters** – Academic terms with start and end dates.
- **Course_Offerings** – Specific instance of a course in a semester, coordinated by faculty.
- **Faculty_Assignments** – Faculty linked to offerings.
- **Documents & Required_Documents** – Syllabi, assignments, guidelines required per offering.
- **Document_Upload_Assignments** – Track faculty uploads with due dates and status.
- **Chatrooms & Messages** – Course-based discussion forums.

---

## 📊 Views (API Friendly)
- **vw_course_offerings** – all offerings with course, semester, and coordinator details.  
- **vw_faculty_assignments** – faculty assignments enriched with course and semester info.  
- **vw_pending_uploads** – pending faculty uploads with deadlines.  
- **vw_chatroom_messages** – enriched chatroom messages with sender and course context.  
- **vw_required_documents** – required documents per offering.  

---

## ⚡ Indexing Strategy
- Indexes on **foreign keys** for fast joins.
- Composite indexes for **messages** (chatroom_id + sent_at) → efficient chat history retrieval.
- Search-friendly indexes on **course_code**, **email**, and optional **full-text search** for messages/documents.
- Partial indexes for **pending uploads** to speed up workflow dashboards.

---

## 🔒 Triggers for Automation
1. **Auto-create Chatroom** – when a new course offering is inserted.  
2. **Validate Due Date** – prevent assignments with past deadlines.  
3. **Auto-set Upload Status** – mark as *Uploaded* when file path is provided.  
4. **Message Audit Logging** – store every message in a separate audit table.  

---

## 📂 Example Use Cases
- **Faculty Dashboard** → See assigned courses, pending uploads, and chatrooms.  
- **Coordinator Dashboard** → Monitor required documents, faculty assignments, and chat activity.  
- **Admin Dashboard** → Track all course offerings, documents, and semester schedules.  
- **Chatroom API** → Fetch latest 50 messages for a course chat instantly.  

---

## 🛠 Tech Stack
- **Database**: PostgreSQL  
- **Schema Features**: Normalized schema, triggers, indexing, views  
- **API-Ready**: Queries optimized for backend integration  

---

## ✅ Summary
The **Course Management System** centralizes academic operations into one robust database.  
By combining **document management, communication tools, automated workflows, and optimized indexing**,  
it provides a scalable backend for building modern academic portals and APIs.

---
