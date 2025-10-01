-- SQL DDL script to create tables for the course management system

CREATE TABLE public.Chatrooms (
  chatroom_id integer NOT NULL DEFAULT nextval('"Chatrooms_chatroom_id_seq"'::regclass),
  offering_id integer NOT NULL UNIQUE,
  chatroom_name character varying NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT Chatrooms_pkey PRIMARY KEY (chatroom_id),
  CONSTRAINT fk_offering FOREIGN KEY (offering_id) REFERENCES public.Course_Offerings(offering_id)
);
CREATE TABLE public.Course_Offerings (
  offering_id integer NOT NULL DEFAULT nextval('"Course_Offerings_offering_id_seq"'::regclass),
  course_id integer NOT NULL,
  semester_id integer NOT NULL,
  coordinator_id integer NOT NULL,
  CONSTRAINT Course_Offerings_pkey PRIMARY KEY (offering_id),
  CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES public.Courses(course_id),
  CONSTRAINT fk_semester FOREIGN KEY (semester_id) REFERENCES public.Semesters(semester_id),
  CONSTRAINT fk_coordinator FOREIGN KEY (coordinator_id) REFERENCES public.Personnel(personnel_id)
);
CREATE TABLE public.Courses (
  course_id integer NOT NULL DEFAULT nextval('"Courses_course_id_seq"'::regclass),
  course_code character varying NOT NULL UNIQUE,
  course_name character varying NOT NULL,
  CONSTRAINT Courses_pkey PRIMARY KEY (course_id)
);
CREATE TABLE public.Document_Upload_Assignments (
  upload_id integer NOT NULL DEFAULT nextval('"Document_Upload_Assignments_upload_id_seq"'::regclass),
  offering_id integer NOT NULL,
  document_id integer NOT NULL,
  assigned_faculty_id integer NOT NULL,
  due_date date,
  upload_status character varying DEFAULT 'Pending'::character varying,
  file_path character varying,
  CONSTRAINT Document_Upload_Assignments_pkey PRIMARY KEY (upload_id),
  CONSTRAINT fk_offering FOREIGN KEY (offering_id) REFERENCES public.Course_Offerings(offering_id),
  CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES public.Documents(document_id),
  CONSTRAINT fk_assigned_faculty FOREIGN KEY (assigned_faculty_id) REFERENCES public.Personnel(personnel_id)
);
CREATE TABLE public.Documents (
  document_id integer NOT NULL DEFAULT nextval('"Documents_document_id_seq"'::regclass),
  document_name character varying NOT NULL,
  description text,
  CONSTRAINT Documents_pkey PRIMARY KEY (document_id)
);
CREATE TABLE public.Faculty_Assignments (
  offering_id integer NOT NULL,
  faculty_id integer NOT NULL,
  CONSTRAINT Faculty_Assignments_pkey PRIMARY KEY (offering_id, faculty_id),
  CONSTRAINT fk_offering FOREIGN KEY (offering_id) REFERENCES public.Course_Offerings(offering_id),
  CONSTRAINT fk_faculty FOREIGN KEY (faculty_id) REFERENCES public.Personnel(personnel_id)
);
CREATE TABLE public.Messages (
  message_id integer NOT NULL DEFAULT nextval('"Messages_message_id_seq"'::regclass),
  chatroom_id integer NOT NULL,
  sender_id integer NOT NULL,
  message_text text NOT NULL,
  sent_at timestamp with time zone DEFAULT now(),
  CONSTRAINT Messages_pkey PRIMARY KEY (message_id),
  CONSTRAINT fk_chatroom FOREIGN KEY (chatroom_id) REFERENCES public.Chatrooms(chatroom_id),
  CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES public.Personnel(personnel_id)
);
CREATE TABLE public.Personnel (
  personnel_id integer NOT NULL DEFAULT nextval('"Personnel_personnel_id_seq"'::regclass),
  full_name character varying NOT NULL,
  email character varying NOT NULL UNIQUE,
  status character varying,
  CONSTRAINT Personnel_pkey PRIMARY KEY (personnel_id)
);
CREATE TABLE public.Required_Documents (
  offering_id integer NOT NULL,
  document_id integer NOT NULL,
  CONSTRAINT Required_Documents_pkey PRIMARY KEY (offering_id, document_id),
  CONSTRAINT fk_offering FOREIGN KEY (offering_id) REFERENCES public.Course_Offerings(offering_id),
  CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES public.Documents(document_id)
);
CREATE TABLE public.Semesters (
  semester_id integer NOT NULL DEFAULT nextval('"Semesters_semester_id_seq"'::regclass),
  semester_name character varying NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  CONSTRAINT Semesters_pkey PRIMARY KEY (semester_id)
);