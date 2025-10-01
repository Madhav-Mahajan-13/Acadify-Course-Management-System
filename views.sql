-- 1. View: Course Offerings with Details
-- Instead of joining Courses, Semesters, Personnel, use one view.

CREATE OR REPLACE VIEW vw_course_offerings AS
SELECT 
    o.offering_id,
    c.course_code,
    c.course_name,
    s.semester_name,
    s.start_date,
    s.end_date,
    p.full_name AS coordinator_name,
    p.email AS coordinator_email
FROM public.Course_Offerings o
JOIN public.Courses c ON c.course_id = o.course_id
JOIN public.Semesters s ON s.semester_id = o.semester_id
JOIN public.Personnel p ON p.personnel_id = o.coordinator_id;


Example API query:

SELECT * FROM vw_course_offerings WHERE semester_name = 'Spring 2025';



-- 🔹 2. View: Faculty Assigned to Courses
-- See which faculty are assigned to which offerings (with course details).

CREATE OR REPLACE VIEW vw_faculty_assignments AS
SELECT 
    fa.offering_id,
    f.full_name AS faculty_name,
    f.email AS faculty_email,
    c.course_code,
    c.course_name,
    s.semester_name
FROM public.Faculty_Assignments fa
JOIN public.Course_Offerings o ON o.offering_id = fa.offering_id
JOIN public.Courses c ON c.course_id = o.course_id
JOIN public.Semesters s ON s.semester_id = o.semester_id
JOIN public.Personnel f ON f.personnel_id = fa.faculty_id;


Example:

SELECT * FROM vw_faculty_assignments WHERE faculty_name = 'Dr. Anil Sharma';



-- 🔹 3. View: Pending Document Uploads
-- List all pending uploads with faculty + course details.

CREATE OR REPLACE VIEW vw_pending_uploads AS
SELECT 
    dua.upload_id,
    c.course_code,
    c.course_name,
    s.semester_name,
    d.document_name,
    dua.due_date,
    f.full_name AS assigned_faculty,
    dua.upload_status
FROM public.Document_Upload_Assignments dua
JOIN public.Course_Offerings o ON o.offering_id = dua.offering_id
JOIN public.Courses c ON c.course_id = o.course_id
JOIN public.Semesters s ON s.semester_id = o.semester_id
JOIN public.Documents d ON d.document_id = dua.document_id
JOIN public.Personnel f ON f.personnel_id = dua.assigned_faculty_id
WHERE dua.upload_status = 'Pending';


 Example:

SELECT * FROM vw_pending_uploads ORDER BY due_date;



-- 🔹 4. View: Chatroom Messages with Context
-- Messages enriched with sender + course + semester details.

CREATE OR REPLACE VIEW vw_chatroom_messages AS
SELECT 
    m.message_id,
    ch.chatroom_name,
    c.course_code,
    c.course_name,
    s.semester_name,
    p.full_name AS sender_name,
    p.email AS sender_email,
    m.message_text,
    m.sent_at
FROM public.Messages m
JOIN public.Chatrooms ch ON ch.chatroom_id = m.chatroom_id
JOIN public.Course_Offerings o ON o.offering_id = ch.offering_id
JOIN public.Courses c ON c.course_id = o.course_id
JOIN public.Semesters s ON s.semester_id = o.semester_id
JOIN public.Personnel p ON p.personnel_id = m.sender_id;


 Example:

SELECT * FROM vw_chatroom_messages WHERE chatroom_name = 'CSE101 - Spring 2025' ORDER BY sent_at DESC LIMIT 20;



-- 🔹 5. View: Required Documents per Offering
-- See which docs are required for each course.

CREATE OR REPLACE VIEW vw_required_documents AS
SELECT 
    o.offering_id,
    c.course_code,
    c.course_name,
    s.semester_name,
    d.document_name,
    d.description
FROM public.Required_Documents rd
JOIN public.Course_Offerings o ON o.offering_id = rd.offering_id
JOIN public.Courses c ON c.course_id = o.course_id
JOIN public.Semesters s ON s.semester_id = o.semester_id
JOIN public.Documents d ON d.document_id = rd.document_id;

Example:

SELECT * FROM vw_required_documents WHERE course_code = 'CSE101';