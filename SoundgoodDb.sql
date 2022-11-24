CREATE TABLE email (
 email VARCHAR(100) NOT NULL UNIQUE 
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(50) NOT NULL,
 instrument_rental_cost INT,
 instrument_stock INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);

INSERT INTO instrument (instrument,instrument_rental_cost,instrument_stock)
VALUES
  ('Drums',230,20),
  ('Guitar',278,3),
  ('Piano',281,10);


CREATE TYPE skill_level AS ENUM ('beginner', 'intermediate','advanced');

CREATE TABLE payment (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(50) NOT NULL,
 price_per_skill_level INT NOT NULL,
 sibling_discount INT NOT NULL,
 billing_cycle VARCHAR(50) NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT PK_payment PRIMARY KEY (id);

INSERT INTO payment (skill_level,price_per_skill_level,sibling_discount,billing_cycle)
VALUES
  ('beginner',15,27,'monthly'),
  ('intermediate',6,17,'monthly'),
  ('beginner',15,0,'monthly'),
  ('intermediate',6,17,'monthly'),
  ('advanced',12,2,'monthly');


CREATE TABLE phone_number (
 phone_number VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (phone_number);

INSERT INTO phone_number (phone_number)
VALUES
  ('(031286) 773118'),
  ('(049) 62171729'),
  ('(033146) 429359'),
  ('(01142) 0774766'),
  ('(037025) 255501');


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id VARCHAR(50) NOT NULL UNIQUE,
 contact_person VARCHAR(50),
 instrument_quota INT,
 payment_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(50)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);

INSERT INTO student (student_id,contact_person,instrument_quota,skill_level)
VALUES
  ('XOK03GKQ8OY','Zelda Byrd',2,'intermediate'),
  ('BBE05RWZ5EQ','Alden Vaughan',1,'advanced'),
  ('QTA73QNP7JS','Melyssa Blevins',1,'intermediate'),
  ('WDA64ORT4II','Logan Dunn',2,'advanced'),
  ('KOH55NCG6GL','Ayanna Collier',1,'intermediate');


CREATE TABLE contact_details (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 personal_number VARCHAR(12) NOT NULL UNIQUE,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

ALTER TABLE contact_details ADD CONSTRAINT PK_contact_details PRIMARY KEY (student_id);

INSERT INTO contact_details (personal_number,first_name,last_name)
VALUES
  (6245947832,'Jolie','Ayers'),
  (3499085704,'Clark','O''connor'),
  (6864068284,'Dean','Wagner'),
  (6387710217,'Jacqueline','Blankenship'),
  (4135675225,'Emerson','Cabrera');


CREATE TABLE contact_email (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE contact_email ADD CONSTRAINT PK_contact_email PRIMARY KEY (student_id,email);

INSERT INTO email (email)
VALUES
  ('eu.tellus@google.couk'),
  ('cum.sociis@hotmail.org'),
  ('non@outlook.edu'),
  ('vestibulum.nec.euismod@google.couk'),
  ('ad.litora.torquent@hotmail.org');


CREATE TABLE contact_phone (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE contact_phone ADD CONSTRAINT PK_contact_phone PRIMARY KEY (student_id,phone_number);

CREATE TYPE subjects AS ENUM ('vocals', 'music theory','guitar', 'piano','drums'); 

CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 employment_id VARCHAR(50) NOT NULL UNIQUE,
 payment_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 subjects VARCHAR(10)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);

INSERT INTO instructor (employment_id,subjects)
VALUES
  ('KTX75WSG4VB','music theory, piano'),
  ('PTK58SVI8QI','vocals, guitar, piano, music theory'),
  ('QSM65YKQ7AC','drums, guitar, piano, vocals'),
  ('MXU94VLS6SU','music theory, piano, drums'),
  ('TZU01JQH1HR','drums, guitar, music theory, piano, vocals');


CREATE TABLE instrument_booking (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 booking_duration VARCHAR(50)
);

ALTER TABLE instrument_booking ADD CONSTRAINT PK_instrument_booking PRIMARY KEY (id,instrument_id,student_id);

INSERT INTO instrument_booking (booking_duration)
VALUES
  ('Thu, Sep 22nd, 2022'),
  ('Sun, Oct 2nd, 2022'),
  ('Tue, Feb 8th, 2022'),
  ('Fri, Apr 1st, 2022'),
  ('Wed, Aug 24th, 2022');


CREATE TYPE lesson_type AS ENUM ('individual', 'group','ensemble');
CREATE TYPE target_genre AS ENUM ('pop', 'rock','jazz');

CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 subjects VARCHAR(50) NOT NULL,
 lesson_type VARCHAR(50) NOT NULL,
 student_quota INT,
 target_genre VARCHAR(50),
 skill_level VARCHAR(50),
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);

INSERT INTO lesson (subjects,lesson_type,student_quota,target_genre,skill_level)
VALUES
  ('vocals','group',8,'rock','intermediate'),
  ('drums','group',7,'pop','advanced'),
  ('vocals','individual',5,'pop','beginner'),
  ('music theory','group',15,'rock','beginner'),
  ('guitar','group',8,'rock','intermediate');


CREATE TABLE lesson_booking (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time_slot TIMESTAMP(6),
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_id INT GENERATED ALWAYS AS IDENTITY,
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE lesson_booking ADD CONSTRAINT PK_lesson_booking PRIMARY KEY (id);

INSERT INTO lesson_booking (time_slot)
VALUES
  ('2022-10-15 11:00:00'),
  ('2022-08-01 14:00:00'),
  ('2022-11-09 15:00:00'),
  ('2022-01-20 14:00:00'),
  ('2022-12-10 16:00:00');


CREATE TABLE siblings (
 sibling_student_id VARCHAR(50) NOT NULL UNIQUE,
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (sibling_student_id,student_id);

ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE contact_email ADD CONSTRAINT FK_contact_email_0 FOREIGN KEY (student_id) REFERENCES contact_details (student_id);
ALTER TABLE contact_email ADD CONSTRAINT FK_contact_email_1 FOREIGN KEY (email) REFERENCES email (email);


ALTER TABLE contact_phone ADD CONSTRAINT FK_contact_phone_0 FOREIGN KEY (student_id) REFERENCES contact_details (student_id);
ALTER TABLE contact_phone ADD CONSTRAINT FK_contact_phone_1 FOREIGN KEY (phone_number) REFERENCES phone_number (phone_number);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (payment_id) REFERENCES payment (id);


ALTER TABLE instrument_booking ADD CONSTRAINT FK_instrument_booking_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE instrument_booking ADD CONSTRAINT FK_instrument_booking_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson_booking ADD CONSTRAINT FK_lesson_booking_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE lesson_booking ADD CONSTRAINT FK_lesson_booking_1 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE lesson_booking ADD CONSTRAINT FK_lesson_booking_2 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (id);


