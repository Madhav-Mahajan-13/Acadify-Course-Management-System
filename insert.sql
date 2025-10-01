-- Insert Personnel (Faculty, Coordinators, etc.)
INSERT INTO public.Personnel (full_name, email, status) VALUES
('Dr. Anil Sharma', 'anil.sharma@univ.edu', 'Faculty'),
('Prof. Kavita Mehra', 'kavita.mehra@univ.edu', 'Coordinator'),
('Mr. Raj Singh', 'raj.singh@univ.edu', 'Faculty'),
('Ms. Neha Kapoor', 'neha.kapoor@univ.edu', 'Faculty'),
('Admin Office', 'admin@univ.edu', 'Staff');

-- Insert Semesters
INSERT INTO public.Semesters (semester_name, start_date, end_date) VALUES
('Spring 2025', '2025-01-10', '2025-05-15'),
('Fall 2025', '2025-08-01', '2025-12-15');

-- Insert Courses
INSERT INTO public.Courses (course_code, course_name) VALUES
('CSE101', 'Introduction to Programming'),
('CSE202', 'Database Systems'),
('CSE303', 'Operating Systems');

-- Insert Course Offerings
INSERT INTO public.Course_Offerings (course_id, semester_id, coordinator_id) VALUES
(1, 1, 2),  -- CSE101 offered in Spring 2025, coordinated by Kavita
(2, 1, 2),  -- CSE202 offered in Spring 2025
(3, 2, 2);  -- CSE303 offered in Fall 2025

-- Insert Faculty Assignments
INSERT INTO public.Faculty_Assignments (offering_id, faculty_id) VALUES
(1, 1), -- Dr. Anil teaches CSE101
(2, 3), -- Raj teaches CSE202
(3, 4); -- Neha teaches CSE303

-- Insert Documents (syllabus, assignment templates, etc.)
INSERT INTO public.Documents (document_name, description) VALUES
('Syllabus - CSE101', 'Course syllabus for Introduction to Programming'),
('Assignment Template - CSE101', 'Template for programming assignments'),
('Syllabus - CSE202', 'Course syllabus for Database Systems'),
('Research Paper Guidelines', 'Guidelines for term paper submission');

-- Required Documents for Courses
INSERT INTO public.Required_Documents (offering_id, document_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Insert Document Upload Assignments
INSERT INTO public.Document_Upload_Assignments (offering_id, document_id, assigned_faculty_id, due_date, upload_status, file_path) VALUES
(1, 1, 1, '2025-02-01', 'Uploaded', '/uploads/cse101/syllabus.pdf'),
(1, 2, 1, '2025-02-15', 'Pending', NULL),
(2, 3, 3, '2025-03-01', 'Uploaded', '/uploads/cse202/syllabus.pdf'),
(3, 4, 4, '2025-09-01', 'Pending', NULL);

-- Insert Chatrooms (one per course offering)
INSERT INTO public.Chatrooms (offering_id, chatroom_name) VALUES
(1, 'CSE101 - Spring 2025'),
(2, 'CSE202 - Spring 2025'),
(3, 'CSE303 - Fall 2025');

-- Insert Messages in Chatrooms
INSERT INTO public.Messages (chatroom_id, sender_id, message_text) VALUES
(1, 1, 'Welcome to CSE101! Please check the syllabus.'),
(1, 2, 'Reminder: Upload assignments by due date.'),
(2, 3, 'Lecture slides will be uploaded soon.'),
(3, 4, 'First lecture will be on August 5th.');

