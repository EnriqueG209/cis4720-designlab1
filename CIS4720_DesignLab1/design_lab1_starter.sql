/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;

-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
-- =================================================================
-- Count sessions that mention Ana in the combined students text.
SELECT COUNT(*) AS ana_sessions FROM tutoring_sheet WHERE students LIKE '%Ana Lopez%';
-- Count the spreadsheet rows; this counts sessions, not individual visits.
SELECT COUNT(*) AS spreadsheet_rows FROM tutoring_sheet;
-- COUNT cannot see individual students because the students column stores
-- multiple people in one text value. Six rows represent eleven visits.

-- =================================================================
-- STEP 4. First normal form
-- =================================================================
-- Give each student attendance its own row and use a two-column key.
CREATE TABLE tutoring_1nf (
 session_id INT NOT NULL,
 session_date DATE,
 room VARCHAR(10),
 tutor_id INT,
 tutor_name VARCHAR(40),
 tutor_email VARCHAR(60),
 course_code VARCHAR(10),
 course_title VARCHAR(40),
 student_id INT NOT NULL,
 student_name VARCHAR(40),
 student_major VARCHAR(30),
 rating INT,
 PRIMARY KEY (session_id, student_id)
);
-- The following eleven rows are the supplied attendance data.
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);



-- Count how many tutoring sessions each student attended.
SELECT student_name, COUNT(*) AS sessions FROM tutoring_1nf GROUP BY student_id, student_name ORDER BY student_name;

-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================
-- Copy the 1NF rows into a separate table so the original stays unchanged.
CREATE TABLE anomaly_copy AS SELECT * FROM tutoring_1nf;
-- Check that the copied table contains eleven rows.
SELECT COUNT(*) AS copied_rows FROM anomaly_copy;
-- CREATE TABLE AS SELECT does not copy NOT NULL or primary key constraints
-- reliably across versions. Restore the required key constraints for Step 7.
ALTER TABLE anomaly_copy MODIFY session_id INT NOT NULL, MODIFY student_id INT NOT NULL;

-- =================================================================
-- STEP 6. Update anomaly
-- =================================================================
-- Change Maya's email only for session 101, leaving inconsistent values.
UPDATE anomaly_copy SET tutor_email = 'maya.chen@campus.edu' WHERE session_id = 101;
-- Display the conflicting email addresses stored for the same tutor.
SELECT DISTINCT tutor_id, tutor_name, tutor_email FROM anomaly_copy WHERE tutor_id = 501;
-- Both emails appear, so the table cannot tell us which is current without
-- outside information. The intended new email is maya.chen@campus.edu.

-- =================================================================
-- STEP 7. Insert anomaly (INTENTIONAL ERROR: run only this statement)
-- =================================================================
-- Try to add a course without a session or student; this should fail.
INSERT INTO anomaly_copy (course_code, course_title) VALUES ('CIS 4720', 'Database Management');
-- Expected error: Field 'session_id' doesn't have a default value.
-- If your MySQL version reports a different NOT NULL error, record its exact text.
-- This error is expected; continue with Step 8 afterward.

-- =================================================================
-- STEP 8. Delete anomaly
-- =================================================================
-- Remove the three attendance rows belonging to session 103.
DELETE FROM anomaly_copy WHERE session_id = 103;
-- List remaining courses to show that MATH 1600 disappeared.
SELECT DISTINCT course_code, course_title FROM anomaly_copy ORDER BY course_code;
-- We meant to remove only session 103, but we also lost the only record
-- of the MATH 1600 course because its details were stored in session rows.

-- =================================================================
-- STEP 9. Functional dependencies and third normal form
-- =================================================================
-- Check whether every student ID consistently maps to a name and major.
SELECT student_id, COUNT(DISTINCT student_name) AS names,
 COUNT(DISTINCT student_major) AS majors FROM tutoring_1nf GROUP BY student_id;
-- Column         Determined by                 Dependency kind
-- session_date   session_id                    Partial
-- tutor_name     tutor_id                      Transitive
-- room           session_id                    Partial
-- tutor_id       session_id                    Partial
-- tutor_email    tutor_id                      Transitive
-- course_code    session_id                    Partial
-- course_title   course_code                   Transitive
-- student_name   student_id                    Partial
-- student_major  student_id                    Partial
-- rating         (session_id, student_id)      Full
-- SESSION contains transitive dependencies: tutor_name and tutor_email
-- depend on tutor_id, and course_title depends on course_code.
-- Move tutor_name and tutor_email into TUTOR (key: tutor_id).
-- Move course_title into COURSE (key: course_code).
-- The five 3NF tables are STUDENT, TUTOR, COURSE, SESSION, ATTENDANCE.

-- =================================================================
-- STEP 10. Build the five tables
-- =================================================================
-- Store each student only once using student_id as its primary key.
CREATE TABLE student (
 student_id INT PRIMARY KEY,
 student_name VARCHAR(40) NOT NULL,
 student_major VARCHAR(30)
);
-- Store each tutor once and prevent duplicate tutor email addresses.
CREATE TABLE tutor (
 tutor_id INT PRIMARY KEY,
 tutor_name VARCHAR(40) NOT NULL,
 tutor_email VARCHAR(60) UNIQUE
);
-- Store course information independently of tutoring sessions.
CREATE TABLE course (
 course_code VARCHAR(10) PRIMARY KEY,
 course_title VARCHAR(40) NOT NULL
);
-- Store each session with references to its tutor and course.
CREATE TABLE session (
 session_id INT PRIMARY KEY,
 session_date DATE NOT NULL,
 room VARCHAR(10),
 tutor_id INT NOT NULL,
 course_code VARCHAR(10) NOT NULL,
 FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id),
 FOREIGN KEY (course_code) REFERENCES course(course_code)
);
-- Link students to sessions and store each attendance rating.
CREATE TABLE attendance (
 session_id INT NOT NULL,
 student_id INT NOT NULL,
 rating INT,
 PRIMARY KEY (session_id, student_id),
 FOREIGN KEY (session_id) REFERENCES session(session_id),
 FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- =================================================================
-- STEP 11. Load five tables from tutoring_1nf
-- =================================================================
-- Copy distinct students from the original 1NF table.
INSERT INTO student (student_id, student_name, student_major)
 SELECT DISTINCT student_id, student_name, student_major FROM tutoring_1nf;
-- Copy distinct tutors from the original 1NF table.
INSERT INTO tutor (tutor_id, tutor_name, tutor_email)
 SELECT DISTINCT tutor_id, tutor_name, tutor_email FROM tutoring_1nf;
-- Copy distinct courses from the original 1NF table.
INSERT INTO course (course_code, course_title)
 SELECT DISTINCT course_code, course_title FROM tutoring_1nf;
-- Copy distinct sessions and their tutor and course references.
INSERT INTO session (session_id, session_date, room, tutor_id, course_code)
 SELECT DISTINCT session_id, session_date, room, tutor_id, course_code FROM tutoring_1nf;
-- Copy every attendance and rating from the original 1NF table.
INSERT INTO attendance (session_id, student_id, rating)
 SELECT session_id, student_id, rating FROM tutoring_1nf;
-- Confirm the expected row counts: 5 students, 3 tutors, 3 courses,
-- 6 sessions, and 11 attendance records.
SELECT (SELECT COUNT(*) FROM student) AS students,
 (SELECT COUNT(*) FROM tutor) AS tutors,
 (SELECT COUNT(*) FROM course) AS courses,
 (SELECT COUNT(*) FROM session) AS sessions,
 (SELECT COUNT(*) FROM attendance) AS attendances;

-- =================================================================
-- STEP 12. Rebuild the spreadsheet using a view
-- =================================================================
-- Join all five tables to recreate the original 1NF records.
CREATE VIEW tutoring_rebuilt AS
SELECT se.session_id, se.session_date, se.room,
 t.tutor_id, t.tutor_name, t.tutor_email,
 c.course_code, c.course_title,
 st.student_id, st.student_name, st.student_major,
 a.rating
FROM attendance a
JOIN session se ON a.session_id = se.session_id
JOIN tutor t ON se.tutor_id = t.tutor_id
JOIN course c ON se.course_code = c.course_code
JOIN student st ON a.student_id = st.student_id;
-- Confirm all eleven rows match their original values.
SELECT COUNT(*) AS matching_rows
FROM tutoring_1nf o
JOIN tutoring_rebuilt r
 ON o.session_id = r.session_id AND o.student_id = r.student_id
WHERE o.session_date = r.session_date AND o.room = r.room
 AND o.tutor_email = r.tutor_email AND o.course_title = r.course_title
 AND o.student_name = r.student_name AND o.student_major = r.student_major
 AND o.rating = r.rating;

-- =================================================================
-- STEP 13. Prove the three anomalies are fixed
-- =================================================================
-- Update Maya's email in the one tutor record that owns it.
UPDATE tutor SET tutor_email = 'maya.chen@campus.edu' WHERE tutor_id = 501;
-- Show the updated email through the reconstructed view.
SELECT DISTINCT tutor_email FROM tutoring_rebuilt WHERE tutor_id = 501;
-- The update problem is fixed because the tutor email is stored once.
-- Add a course even though no tutoring session exists for it yet.
INSERT INTO course (course_code, course_title) VALUES ('CIS 4720', 'Database Management');
-- Show that the course exists without a corresponding session.
SELECT * FROM course WHERE course_code = 'CIS 4720';
-- The insert problem is fixed because courses have their own table.
-- INTENTIONAL ERROR: session 103 cannot be deleted while attendance refers to it.
DELETE FROM session WHERE session_id = 103;
-- Expected error: Cannot delete or update a parent row: a foreign key constraint fails.
-- Show that MATH 1600 still exists as an independent course.
SELECT * FROM course WHERE course_code = 'MATH 1600';
-- The delete problem is fixed because the foreign key protects attendance,
-- and the course record remains separate from any session.

-- =================================================================
-- STEPS 14-15. Publish only this SQL file to a public GitHub repository
-- named cis4720-designlab1, then submit its URL on Canvas.
-- =================================================================
