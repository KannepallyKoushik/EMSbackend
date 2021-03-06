Create Database ems;

CREATE EXTENSION "uuid-ossp";
--set extension of uuid before this
CREATE TABLE admin(
   	ad_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ad_email VARCHAR ( 100 ) UNIQUE NOT NULL,
   	password VARCHAR ( 255 ) NOT NULL
);

CREATE TABLE department(
   	dep_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   	dep_name VARCHAR(100) UNIQUE  NOT NULL
);

CREATE TABLE batch(
   	batch_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   	pass_in VARCHAR(50) NOT NULL,
	pass_out VARCHAR(50) NOT NULL
);

CREATE TABLE users(
	userid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	username VARCHAR ( 100 ) NOT NULL,
	user_email VARCHAR ( 100 ) UNIQUE NOT NULL,
	dep_id INT,
	CONSTRAINT fk_dep FOREIGN KEY(dep_id) REFERENCES department(dep_id),
	mobile VARCHAR(15),
	user_password VARCHAR ( 50 ) NOT NULL,
	verified string NOT NULL DEFAULT "no"
	batch_id INT,CONSTRAINT fk_batch FOREIGN KEY(batch_id) REFERENCES batch(batch_id),
	timestamp timestamp NOT NULL DEFAULT NOW(),
	address text
);

CREATE TABLE faculty(
	fac_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	facname VARCHAR ( 100 ) NOT NULL,
	dep_id INT,
	CONSTRAINT fk_dep FOREIGN KEY(dep_id) REFERENCES department(dep_id),
	fac_email VARCHAR ( 100 ) UNIQUE NOT NULL
);


CREATE TABLE event(
	eid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ev_name VARCHAR ( 250 ) NOT NULL,
	dep_id INT,
	CONSTRAINT fk_dep FOREIGN KEY(dep_id) REFERENCES department(dep_id),
	ev_deadline VARCHAR ( 50 ) NOT NULL,
	timestamp timestamp NOT NULL DEFAULT NOW(),
	batch_id INT,
	CONSTRAINT fk_batch FOREIGN KEY(batch_id) REFERENCES batch(batch_id),
	event_type VARCHAR(100) NOT NULL,
	credit_total INT DEFAULT NULL,
);


CREATE TABLE course(
	cid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	c_code VARCHAR (50) UNIQUE Not NULL,
	cname VARCHAR ( 100 ) NOT NULL,
	cdescription VARCHAR (250) NOT NULL,
	dep_id INT,
	CONSTRAINT fk_dep FOREIGN KEY(dep_id) REFERENCES department(dep_id),
	fac_id INT,
	CONSTRAINT fk_fac FOREIGN KEY(fac_id) REFERENCES faculty(fac_id),
	eid INT,
	CONSTRAINT fk_eid FOREIGN KEY(eid) REFERENCES event(eid),
	course_credit INT NOT NULL,
	demo_link TEXT,
	offered BOOLEAN NOT NULL DEFAULT FALSE
);




CREATE TABLE approvedcourse(
	ap_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cid INT,
	CONSTRAINT fk_course FOREIGN KEY(cid) REFERENCES course(cid),
	userid INT,
	CONSTRAINT fk_users FOREIGN KEY(userid) REFERENCES users(userid),
	fac_id INT,
	CONSTRAINT fk_fac FOREIGN KEY(fac_id) REFERENCES faculty(fac_id),
	dep_id INT,
	CONSTRAINT fk_dep FOREIGN KEY(dep_id) REFERENCES department(dep_id),
	batch_id INT,
	CONSTRAINT fk_batch FOREIGN KEY(batch_id) REFERENCES batch(batch_id)	
);

CREATE TABLE feedback(
	feed_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	feedback TEXT NOT NULL,
	cid INT,
	CONSTRAINT fk_course FOREIGN KEY(cid) REFERENCES course(cid),
	batch_id INT,
	CONSTRAINT fk_batch FOREIGN KEY(batch_id) REFERENCES batch(batch_id),
	userid INT,
	CONSTRAINT fk_users FOREIGN KEY(userid) REFERENCES users(userid),
	fac_id INT,
	CONSTRAINT fk_fac FOREIGN KEY(fac_id) REFERENCES faculty(fac_id)	
);

--Inserting Super user
insert into users (username, user_email,user_password,user_role) values ('admin','cb.en.p2cse20017@cb.students.amrita.edu','1234@Abcd','admin')

-- Inserting a fake student user
insert into users (username, user_email,user_password,user_role) values ('deep pancholi','cb.en.p2cse20011@cb.students.amrita.edu','abcd@1234','student')

