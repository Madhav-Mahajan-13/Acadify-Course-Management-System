1. Personnel
-- Fast lookup by email (for login/auth API)
CREATE INDEX idx_personnel_email ON public.Personnel (email);

2. Courses
-- Fast lookup by course code (API might query "CSE101" directly)
CREATE INDEX idx_courses_code ON public.Courses (course_code);

3. Course_Offerings
-- For joining/filtering
CREATE INDEX idx_offerings_course ON public.Course_Offerings (course_id);
CREATE INDEX idx_offerings_semester ON public.Course_Offerings (semester_id);
CREATE INDEX idx_offerings_coordinator ON public.Course_Offerings (coordinator_id);

-- Composite index for queries like:
-- "Get all offerings for a semester + course"
CREATE INDEX idx_offerings_course_semester ON public.Course_Offerings (course_id, semester_id);

4. Chatrooms & Messages
-- Fast lookup of chatroom by offering
CREATE INDEX idx_chatrooms_offering ON public.Chatrooms (offering_id);

-- Messages: optimize API like "get latest 50 messages in chatroom"
CREATE INDEX idx_messages_chatroom_time ON public.Messages (chatroom_id, sent_at DESC);

-- Also index sender_id for "fetch all messages by a user"
CREATE INDEX idx_messages_sender ON public.Messages (sender_id);

5. Documents & Assignments
-- For filtering by offering
CREATE INDEX idx_docs_required_offering ON public.Required_Documents (offering_id);
CREATE INDEX idx_docs_upload_offering ON public.Document_Upload_Assignments (offering_id);

-- For checking faculty uploads
CREATE INDEX idx_docs_upload_faculty ON public.Document_Upload_Assignments (assigned_faculty_id);

-- Composite: "fetch pending uploads for offering"
CREATE INDEX idx_docs_upload_status ON public.Document_Upload_Assignments (offering_id, upload_status);

6. Faculty_Assignments
-- API might need: "all faculty for a course offering"
CREATE INDEX idx_faculty_assignments_offering ON public.Faculty_Assignments (offering_id);

-- Or reverse: "all offerings taught by a faculty"
CREATE INDEX idx_faculty_assignments_faculty ON public.Faculty_Assignments (faculty_id);