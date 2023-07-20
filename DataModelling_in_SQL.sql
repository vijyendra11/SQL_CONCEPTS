-- EER Diagram (Enhanced Entity Relationship Diagram)
-- EER Diagram is an essential part of modelling interface of MYSQL workbench.
-- It provides the visual representation of relationship among the different tables.
-- EER Diagra can be accessed after defining the data modelling.

-- Data Modelling
-- Data modelling is nothing but the association of one table with another table.
-- When ever we join any organization, generally company gives data modelling strategy. 
-- So before loading the data into database, we need to create a data modelling, that is nothing but
-- identifying link between the tables, relationship between table, primary key and foreign key of the tables.

-- Primary key
-- It is a constraint in a MySQL that uniquiely identifies each row (record) in the table.
-- Priamry key must contain unique values and it cannot conatin NULL values.
-- A table can have only one primary key.
-- Primary key can be bui;t with the single column or combination of multiple columns (fields).

-- Foreign Key
-- It is a field or collection of fields in a table that refers the primary key in another table.alter
-- A table with foreign key called child table and a atble with primary key called parent table.

-- Primary key and foreign key comes into picture when we want to have relationship between the tables.
-- There is possibilities that, primary key column name and foreign key column can be same or different.

-- While insertion of the data into child table does not find any reference in the parent table then 
-- execution will not happen. It will show an error.

-- To create one to one relatonship between table, parent table will hab eprimary key and 
-- child table will have same field as primary key and foreign key both.

-- parent table cannot be dropped if it is linked to some child table with foreign key.
-- Parent table entries cannot be dropped, if it is linked with some child table.

-- Child table can be dropped, even if it has some link with the parent table.

-- Let us suppose taht we have a huge number of records and may be we don't know that
-- in our data model, how many number tables are associated, but still we want to delete the entries 
-- from parent table primary key column.
-- We would like to perform an operation in a way that once one table updated other table should be updated 
-- automaticaly. It should allow delete operation.
-- There is some thing called cascade operation and it will allow us.

-- 1. We will create a table with primary key.

CREATE TABLE INEURON(
COURSE_ID INT NOT NULL,
COURSE_NAME VARCHAR(30),
COURSE_STATUS VARCHAR(40),
NUMBER_OF_ENROLL INT,
PRIMARY KEY(COURSE_ID));

DESCRIBE INEURON;
-- In the INEURON table COURSE_ID column is declared as a primary key

-- 2. Inserting a data in the created table

INSERT INTO INEURON VALUES(01, 'FSDA', 'Active', 100);

SELECT * FROM INEURON;

-- 3. For primary, duplicat entries are not allowed. We will try to insert the same data as above in the table and 
-- will observe error

INSERT INTO INEURON VALUES(01, 'FSDA', 'Active', 100);

-- It is showing an error of duplicate entry

-- 4. We will try to add one more record into the INEURON table.

INSERT INTO INEURON VALUES(02, 'FSDA', 'Active', 100);

SELECT * FROM INEURON;

-- 5. We will create a child table and foreign key will be referenced to the primary key of parent table 

CREATE TABLE STUDENTS_INEURON(
STUDENT_ID INT,
COURSE_NAME VARCHAR(30),
STUDENT_MAIL VARCHAR(60),
STUDENT_STATUS VARCHAR(40),
COURSE_ID INT,
FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID));

DESC STUDENTS_INEURON;

-- 6. We will try to load the data into chile table, which is not having any reference in the
-- parent table. And the execution will not happen

INSERT INTO STUDENTS_INEUORON VALUES (101, 'FSDA', 'test@gmail.com', 'Active', 05);

-- While insertion of the data into child table does not find any reference in the parent table then 
-- execution will not happen. It will show an error.

-- 7. We will try to insert the data which have some reference in parent table and the execution should happen

INSERT INTO STUDENTS_INEURON VALUES(101, 'FSDA', 'test@gmail.com', 'Active', 01);

SELECT * FROM STUDENTS_INEURON;

-- 8. Now we will create one more child table and it will be reference to the primary key of parent table

CREATE TABLE PAYMENT(
COURSE_NAME VARCHAR(30),
COURSE_ID INT,
COURSE_LIVE_STATUS VARCHAR(50),
COURSE_LAUNCH_DATE VARCHAR(60),
FOREIGN KEY (COURSE_ID) REFERENCES INEURON(COURSE_ID));

DESC PAYMENT;

-- 9. Now, we will try to load some data, which is not having any reference to the primary key of parent table

INSERT INTO PAYMENT VALUES('FSDA', 06, 'Not Active', '7th Aug');

-- Execution of teh above querry didn't happend because of no reference in the parent table.

-- 10. Now, we will add some data, shich will find some reference to the parent table.

INSERT INTO PAYMENT VALUES('FSDA', 01, 'Not Active', '7th Aug');
INSERT INTO PAYMENT VALUES('FSDA', 01, 'Not Active', '7th Aug');
INSERT INTO PAYMENT VALUES('FSDA', 01, 'Not Active', '7th Aug');

SELECT * FROM PAYMENT;

-- 11. Now, we will try to create one to one relation between the parent table (i.e. INEURON Table) and
-- a new table create below

CREATE TABLE CLASS(
COURSE_ID INT,
CLASS_NAME VARCHAR(40),
CLASS_TOPIC VARCHAR(50),
CLASS_DURATION INT,
PRIMARY KEY(COURSE_ID),
FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID));

-- One to one relation is created with the above querries between Ineuron table and class table.
-- To create one to one relatonship between table, parent table will hab eprimary key and 
-- child table will have same field as primary key and foreign key both.

-- Till now we have created the below tables
-- 1. INEURON -- Parent Table
-- 2. STUDENTS_INEURON -- Child Table
-- 3. PAYMENT -- Child Table
-- 4. CLASS -- Child Table for one to one relation

-- 12. Now we wanted to create a parent table, where primary key will be combination of two columns.
-- We will use same parent table i.e. INEURON Table

SELECT * FROM INEURON;

ALTER TABLE ineuron
ADD CONSTRAINT TETS_PRIM PRIMARY KEY(COURSE_ID, COURSE_NAME);

-- The above querry giving an error showing that "Multiple primary key defined". Since INEURON table is allready 
-- having one primary key, again we cannot add one more primary key.

-- There is a way by which we can create a primary key with a combination of two columns in INEURON table.
-- And that is, we can drop primary key and then add constraints same as above

ALTER TABLE INEURON
DROP PRIMARY KEY;

-- The abve gave an error and this approach also failed.
-- The reason is Primary key cannot be dropped if it linked with other table through foreign key.

-- There is another approch we can try by which we can add primary key which is a combination of two columns
-- by droping the table

DROP TABLE INEURON;

-- The above querry also giving an error, because parent table is linked to some child table.

-- Here we can conclude that:
-- parent table cannot be dropped if it is linked to some child table with foreign key.
-- Parent table entries cannot be dropped, if it is linked with some child table.


-- Here we will check for child table, whether we can drop or not

DROP TABLE CLASS;

-- Child table can be dropped, even if it has some link with the parent table.

-- 13. Now we will try to create table where we will add primary key with the combination of two columns

CREATE TABLE TEST(
ID INT NOT NULL,
`NAME` VARCHAR(50),
EMAIL VARCHAR(60),
MOBILE_NO VARCHAR(10),
ADDRESS VARCHAR(60));

-- Now we will add primary key using single column
ALTER TABLE TEST
ADD CONSTRAINT PRIM_KEY PRIMARY KEY(ID);

-- Since this table is not linked with any table so primary key can be dropped

ALTER TABLE TEST
DROP PRIMARY KEY;

-- Now we will try to add primary key with the combination of two columns

ALTER TABLE TEST
ADD CONSTRAINT KEY_PRIM PRIMARY KEY(ID, `NAME`);

DESC TEST;

-- 14. We will create parent table and child table with name of parent and child respectively
-- Then we will insert few records in the tables

CREATE TABLE PARENTS(
ID INT NOT NULL,
PRIMARY KEY(ID));

CREATE TABLE CHILD(
ID INT,
PARENT_ID INT,
FOREIGN KEY(PARENT_ID) REFERENCES PARENTS(ID));

INSERT INTO PARENTS VALUES(1);

INSERT INTO CHILD VALUES(1,1);

SELECT * FROM PARENTS;

SELECT * FROM CHILD;

INSERT INTO CHILD VALUES(1,2);
-- The above will give an error beacuse it doesn't find any references in parent table.

-- 15.	ON DELETE CASCADE & ON UPDATE CASCADE

DROP TABLE CHILD;

DROP TABLE PARENTS
-- The above queerries we notice that, we have deleted child table forst and the parent table.
-- This is because, we cant delete parent table first if it is associated with some other table.
-- That's why we have deleted first child table then parents table.

-- Because of the above problem, we have one option to update or delete the parent table on the forst place,
-- even though it is link with some other table and that is nothing but the cascade option

CREATE TABLE PARENTS(
ID INT NOT NULL,
PRIMARY KEY(ID));

CREATE TABLE CHILD(
ID INT NOT NULL,
PARENT_ID INT,
FOREIGN KEY (PARENT_ID) REFERENCES PARENTS(ID) ON DELETE CASCADE);

-- We will check by deleting the parent table after establishing the child table

INSERT INTO PARENTS VALUES
(1), (2);

INSERT INTO CHILD VALUES
(1,1),
(1,2),
(3,2),
(2,2);

DELETE FROM PARENTS
WHERE ID = 2;
-- The above querry is executed that means "ON DELETE CASCADE" is working fine

-- We can also update the parent table by using the "ON UPDATE CASCADE" option

UPDATE PARENTS
SET ID = 3 WHERE ID = 1;
-- The above querry didn't executed because we have not useed ON UPDATE CASCADE till now

DROP TABLE CHILD;

CREATE TABLE CHILD(
ID INT,
PARENT_ID INT,
FOREIGN KEY(PARENT_ID) REFERENCES PARENTS(ID) ON UPDATE CASCADE);

SELECT * FROM PARENTS;
SELECT * FROM CHILD;

INSERT INTO PARENTS VALUES (2), (3);

INSERT INTO CHILD VALUES
(1,1),
(1,2),
(3,2),
(2,2);

UPDATE PARENTS
SET ID = 4 WHERE ID = 1;

SELECT * FROM PARENTS;
SELECT * FROM CHILD;

-- If we are deleting / updating something fron the parent table then
-- sames is deletion / updation also reflect in the child table
-- Child table also gets updated automatically along with parent table

-- ON DELETE CASCADE & ON UPDATE CASCADE CAN ALSO BE APPLIED TOGETHER,

CREATE TABLE CHILD1(
ID INT,
PARENT_ID INT,
FOREIGN KEY(PARENT_ID) REFERENCES PARENTS(ID) ON DELETE CASCADE ON UPDATE CASCADE);
