
**************************** 1] Basic Village Information ************************
-- Create Table Village
CREATE TABLE Village
(
 Village_id number(10) constraint pk PRIMARY KEY,
 Village_name varchar2(20) NOT NULL,
 Village_address varchar2(30) NOT NULL,
 Total_economy number(10) NOT NULL,
 APL number(10)  NOT NULL,
 BPL number(10)  NOT NULL,
 No_PSD_Shop number(10) NOT NULL,
 No_PHC number(10) NOT NULL,
 No_secondary_school number(10) NOT NULL,
 No_primary_school number(10) NOT NULL
);
-- Inserting into table Village
INSERT INTO Village VALUES(01,'Kanersar','Kanersar,Tal-Khed,Dist-Pune',1770000,1000,100,1,1,1,1);

**************************** 2] Public Distribution System Information ************
-- Create table Public_Distribution_System-Fair_Price_Shop
CREATE TABLE PSD_FPS
(
 Shop_id number(10) constraint Fk PRIMARY KEY,
 Shop_name varchar2(30) NOT NULL,
 Shop_address varchar2(50) NOT NULL,
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE
);
INSERT INTO PSD_FPS VALUES(101,'SKSHOP','KANERSAR',01);

**************************** 3] Healthcare System Information *********************
-- Create table PHC(Primary_Healthcare_Center)
CREATE TABLE PHC
(
 PHC_id number(10) constraint Ck PRIMARY KEY,
 PHC_name varchar2(30) NOT NULL,
 PHC_address varchar2(50) NOT NULL,
 No_Doctors number(5) NOT NULL,
 No_Assistant number(5) NOT NULL,
 Rate_of_Immunization number(5,2) NOT NULL,
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE 
);
INSERT INTO PHC VALUES(201,'PHC KANERSAR','KANERSAR GAON',1,2,2.5,01);

**************************** 4] Education System Information **********************
-- Create table Schools
CREATE TABLE Schools
(
 School_id number(10) constraint Dk PRIMARY KEY,
 School_name varchar2(30) NOT NULL,
 School_address varchar2(30) NOT NULL,
 School_type varchar2(20) NOT NULL,
 No_Teachers number(10) NOT NULL,
 No_Students number(10) NOT NULL,
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE
);
INSERT INTO Schools VALUES(3001,'ZPS KANERSAR','KANERSAR','PRIMARY',2,25,01);

**************************** 5] Population Information ****************************
-- Create table Population
CREATE TABLE Population
(
 Total_Population number(30) NOT NULL,
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE,
 Village_name varchar2(20),
 Teenagers_populaion number(30) NOT NULL,
 Youngster_population number(30) NOT NULL,
 Old_Peoples_population number(30) NOT NULL,
 Female_population number(30) NOT NULL,
 Male_population number(30) NOT NULL,
 Literate_Peoples number(30) NOT NULL,
 Illiterate_Peoples number(30) NOT NULL
);
INSERT INTO Population VALUES(2000,01,'kandersar',500,250,500,1000,800,1000,1000);

**************************** 6] Farmers Information *******************************
--Create table Farmers
CREATE TABLE Farmers
(
 Total_Farmers number(30) NOT NULL,
 No_SMF number(30) NOT NULL,
 No_LMF number(30) NOT NULL,
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE 
);
INSERT INTO Farmers VALUES(1000,800,200,01);


**************************** 7] PRI Information ***********************************
-- Create table PRI(Panchayti Raj Institution)
CREATE TABLE PRI
(
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE,
 Village_name varchar2(20),
 Sarpanch_name varchar2(30) NOT NULL,
 Deputy_Sarpanch_Name varchar2(30) NOT NULL,
 Village_Accountant_name varchar2(30) NOT NULL,
 Village_Servant_name varchar2(30) NOT NULL,
 PRI_Members_count number(10) NOT NULL
);
INSERT INTO PRI VALUES(01,'kanersar','r.r.hajare','s.k.duandkar','s.b.pwar','b.s.kharpude',13);

**************************** 8] Infrastructure Information ************************
-- Create table Infrastructure
CREATE TABLE Infrastructure
(
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE,
 Village_name varchar2(20),
 Water_Resource_infra varchar2(50) NOT NULL,
 Banking_infra varchar2(30) NOT NULL,
 Transportation_infra varchar2(30) NOT NULL,
 Network_Communication_infra varchar2(30) NOT NULL
);
INSERT INTO Infrastructure VALUES(01,'KANERSAR','NOT GOOD','VERY GOOD','NICE','BETTER');

**************************** 9] Geographical Data **********************************
-- Create table Geography
CREATE TABLE Geography
(
 Village_id number(10) references Village(Village_id) ON DELETE CASCADE,
 Village_name varchar2(20),
 Total_Area number(20) NOT NULL,
 Farming_Land number(20) NOT NULL,
 Non_Farming_Land number(20) NOT NULL,
 Total_Forest_Area number(20) NOT NULL
);
INSERT INTO Geography VALUES(01,'KANERSAR',1000,500,500,20);

***************************** 10] Development Ratios ******************************** 
--Create table Devlopment_Ratios
CREATE TABLE Development_Ratios
(
 Village_id number(10) references Village(Village_id),
 Village_name varchar2(20),
 Literacy_Rate number(5,2) NOT NULL,
 Death_Ratio number(5,2) NOT NULL,
 Birth_Ratio number(5,2) NOT NULL,
 Tree_Plantation_Ratio number(5,2) NOT NULL,
 Growth_Ratio number(5,2) NOT NULL,
 Economy_Development_Ratio number(5,2) NOT NULL,
 Immunization_rate number(5,2) NOT NULL
);
INSERT INTO Development_Ratios VALUES(01,'KANERSAR',2.2,2.2,2.2,3.5,6.5,1.2,2.5); 

★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
 -- PL/SQL procedure to find if the Village is present in the database or not
CREATE OR REPLACE PROCEDURE find(ID IN NUMBER) IS
    
    CURSOR cur IS select  Village_id, Village_name
    FROM Village;
    rec  cur%ROWTYPE;
BEGIN
    FOR rec IN cur
    LOOP
        EXIT WHEN cur%NOTFOUND;
        IF ID= rec.Village_id THEN
               DBMS_OUTPUT.PUT_LINE(' Village Id = ' || rec.Village_id || ' Village Name = ' || rec.Village_name );
       END IF;
    END LOOP;
END;
/
EXECUTE find(01);
★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
-- PL/SQL Procedure to Extract data of particular village from database
CREATE OR REPLACE PROCEDURE disp(ID IN NUMBER)
IS
CURSOR cur IS  SELECT * FROM Village
WHERE Village_id=ID;
rec cur%ROWTYPE;
BEGIN
     OPEN cur;
     LOOP
           FETCH cur INTO rec;
           EXIT WHEN cur%NOTFOUND;
           IF(ID= rec.Village_id)THEN
         
            DBMS_OUTPUT.PUT_LINE('Village id = ' || rec.Village_id );
            DBMS_OUTPUT.PUT_LINE('Village Name = ' || rec.Village_name );
            DBMS_OUTPUT.PUT_LINE( 'Total Economy = ' || rec.Total_economy  );
            DBMS_OUTPUT.PUT_LINE( 'Number of PSD Shops = ' || rec.No_PSD_Shop );
            DBMS_OUTPUT.PUT_LINE('Number of PHC = ' || rec.No_PHC);
            DBMS_OUTPUT.PUT_LINE('Number of Secondary school = ' || rec.No_secondary_school);
            DBMS_OUTPUT.PUT_LINE('Number of Primary School ='|| rec.No_primary_school);
 
           ELSE 
           
rf
           
           END IF;
      END LOOP;   
      CLOSE cur;
END;
/ 

★★★★★★★★★★★★★★★★★ TRIGGERS ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
-- TRIGGER for Table Village
CREATE OR REPLACE TRIGGER trg
AFTER 
DELETE OR  UPDATE OR INSERT ON Village 
FOR EACH ROW
BEGIN
     CASE 
       WHEN INSERTING THEN
         DBMS_OUTPUT.PUT_LINE('Inserting Data into table Village. . .');
       WHEN UPDATING THEN
         DBMS_OUTPUT.PUT_LINE('Updating Data into table Village . . .');
       WHEN DELETING THEN
         DBMS_OUTPUT.PUT_LINE('Deleting  Data into table Village . . .');
     END CASE;
END;       
/    

--TRIGGER for table PHC
CREATE OR REPLACE TRIGGER trg_1
AFTER 
DELETE OR  UPDATE OR INSERT ON PHC 
FOR EACH ROW
BEGIN
     CASE 
       WHEN INSERTING THEN
         DBMS_OUTPUT.PUT_LINE('Inserting Data into table PHC. . .');
       WHEN UPDATING THEN
         DBMS_OUTPUT.PUT_LINE('Updating Data into table PHC . . .');
       WHEN DELETING THEN
         DBMS_OUTPUT.PUT_LINE('Deleting  Data into table PHC . . .');
     END CASE;
END;       
/    
--TRIGGER for table PSD_FPS
CREATE OR REPLACE TRIGGER trg_2
AFTER 
DELETE OR  UPDATE OR INSERT ON PSD_FPS
FOR EACH ROW
BEGIN
     CASE 
       WHEN INSERTING THEN
         DBMS_OUTPUT.PUT_LINE('Inserting Data into table PSD-FPS. . .');
       WHEN UPDATING THEN
         DBMS_OUTPUT.PUT_LINE('Updating Data into table PSD-FPS . . .');
       WHEN DELETING THEN
         DBMS_OUTPUT.PUT_LINE('Deleting  Data into table PSD-FPS . . .');
     END CASE;
END;       
/    
-- Trigger for checking invalid I'd for Village table

CREATE OR REPLACE TRIGGER check_id
BEFORE
INSERT OR UPDATE ON Village
FOR EACH ROW
BEGIN
  IF (:NEW.Village_id=<0) THEN
           RAISE_APPLICATION_ERROR('Error:: Invalid I'd !!!!');
  END IF;
END;
/




