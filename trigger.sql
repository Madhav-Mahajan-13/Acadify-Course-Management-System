-- 1. Auto-create a Chatroom when a Course Offering is inserted
-- Every new Course_Offerings entry should get a Chatroom.

-- Function
CREATE OR REPLACE FUNCTION create_chatroom_on_offering()
RETURNS TRIGGER AS $$
DECLARE
    course_name TEXT;
    semester_name TEXT;
BEGIN
    -- fetch details for chatroom name
    SELECT c.course_name, s.semester_name
    INTO course_name, semester_name
    FROM public.Courses c
    JOIN public.Semesters s ON s.semester_id = NEW.semester_id
    WHERE c.course_id = NEW.course_id;

    -- Insert chatroom
    INSERT INTO public.Chatrooms (offering_id, chatroom_name)
    VALUES (NEW.offering_id, course_name || ' - ' || semester_name);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_create_chatroom
AFTER INSERT ON public.Course_Offerings
FOR EACH ROW
EXECUTE FUNCTION create_chatroom_on_offering();

--------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Ensure Due Date is in the Future for Document Uploads
-- Prevent inserting an assignment with a past due_date.

-- Function
CREATE OR REPLACE FUNCTION validate_due_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.due_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Due date % cannot be in the past', NEW.due_date;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_validate_due_date
BEFORE INSERT OR UPDATE ON public.Document_Upload_Assignments
FOR EACH ROW
EXECUTE FUNCTION validate_due_date();

---------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Automatically Set Upload Status to "Uploaded" When File Path is Added
-- If a faculty uploads a document, set status to "Uploaded".

-- Function
CREATE OR REPLACE FUNCTION set_upload_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.file_path IS NOT NULL AND (NEW.upload_status IS NULL OR NEW.upload_status = 'Pending') THEN
        NEW.upload_status := 'Uploaded';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_set_upload_status
BEFORE INSERT OR UPDATE ON public.Document_Upload_Assignments
FOR EACH ROW
EXECUTE FUNCTION set_upload_status();

-------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Log Messages to an Audit Table
-- Keep a log of every message sent in chatrooms.

-- Audit Table
CREATE TABLE public.Message_Audit (
    audit_id SERIAL PRIMARY KEY,
    message_id INT,
    sender_id INT,
    chatroom_id INT,
    message_text TEXT,
    sent_at TIMESTAMP WITH TIME ZONE,
    logged_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Function
CREATE OR REPLACE FUNCTION log_message()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.Message_Audit (message_id, sender_id, chatroom_id, message_text, sent_at)
    VALUES (NEW.message_id, NEW.sender_id, NEW.chatroom_id, NEW.message_text, NEW.sent_at);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_log_message
AFTER INSERT ON public.Messages
FOR EACH ROW
EXECUTE FUNCTION log_message();