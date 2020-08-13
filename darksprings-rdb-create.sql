-- BEGIN CREATION OF THE AQUATIC UNIVERSE --
CREATE TABLE bill (
    bill_id                    NUMBER NOT NULL,
    deliveries_delivery_id     NUMBER NOT NULL,
    generated_date             DATE DEFAULT SYSDATE NOT NULL,
    due_date                   DATE DEFAULT ADD_MONTHS( SYSDATE, 1 ) NOT NULL,
    days_late                  INTEGER DEFAULT '0',
    discount                   INTEGER DEFAULT '0',
    total_charges              FLOAT NOT NULL,
    paid                       CHAR(1) DEFAULT '0' NOT NULL
);
ALTER TABLE bill ADD CONSTRAINT bill_pk PRIMARY KEY ( bill_id );

CREATE TABLE contract (
    contract_id            NUMBER NOT NULL,
    customer_customer_id   NUMBER NOT NULL,
	employee_employee_id   NUMBER NOT NULL,
    contract_start         DATE DEFAULT SYSDATE NOT NULL,
    contract_end           DATE DEFAULT ADD_MONTHS( SYSDATE, 12 ) NOT NULL,
	number_of_employees    INTEGER NOT NULL,
    street                 VARCHAR2 (64) NOT NULL,
    city                   VARCHAR2 (32) NOT NULL,
    state                  VARCHAR2 (32) NOT NULL,
    zip                    VARCHAR2 (5)  NOT NULL,
    region_region_name     VARCHAR2(5) NOT NULL,
    status		           CHAR(1) DEFAULT '1' NOT NULL
);
ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( contract_id );

CREATE TABLE customer (
    customer_id            NUMBER NOT NULL,
    name                   VARCHAR2 (64) NOT NULL,
    phone                  NUMBER NOT NULL,
    point_of_contact       VARCHAR2 (64),
    referral_referral_id   NUMBER
);
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

CREATE TABLE deliveries (
    delivery_id            NUMBER NOT NULL,
    delivery_date          DATE DEFAULT SYSDATE NOT NULL,
    driver_comment         VARCHAR2(4000),
    customer_comment       VARCHAR2(4000),
    contract_contract_id   NUMBER NOT NULL,
	route_route_id		   NUMBER NOT NULL
);
ALTER TABLE deliveries ADD CONSTRAINT deliveries_pk PRIMARY KEY ( delivery_id );

CREATE TABLE delivery_items (
    delivery_items_id         NUMBER NOT NULL,
    deliveries_delivery_id    NUMBER NOT NULL,
	products_product_id       NUMBER NOT NULL,
    quantity                  INTEGER NOT NULL
);
ALTER TABLE delivery_items ADD CONSTRAINT delivery_items_pk PRIMARY KEY ( delivery_items_id );

CREATE TABLE driver (
    driver_id        		NUMBER NOT NULL,
    license_number  		VARCHAR2(60) NOT NULL,
    employee_employee_id    NUMBER NOT NULL
);
ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( driver_id );

CREATE TABLE employee (
    employee_id          NUMBER NOT NULL,
    fname                VARCHAR2 (64) NOT NULL,
    lname                VARCHAR2 (64) NOT NULL,
    street               VARCHAR2 (64) NOT NULL,
    city                 VARCHAR2 (32) NOT NULL,
    state                VARCHAR2 (32) NOT NULL,
    zip                  VARCHAR2 (5) NOT NULL,
    sex                  VARCHAR2(6) NOT NULL,
    race                 VARCHAR2(32) NOT NULL,
    date_of_birth        DATE NOT NULL,
	age					 NUMBER DEFAULT '0' NOT NULL,
    national_id_number   VARCHAR2(128),
    cell_number          NUMBER,
	employee_manager_id  NUMBER,
    position             VARCHAR2 (128) NOT NULL,
	active               CHAR(1) DEFAULT '1' NOT NULL
);
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

CREATE TABLE ethnicity (
    ethnicity_name      VARCHAR(32) NOT NULL
);
ALTER TABLE ethnicity ADD CONSTRAINT ethnicity_pk PRIMARY KEY ( ethnicity_name );

CREATE TABLE eval (
    eval_id             	NUMBER NOT NULL,
    eval_date               DATE DEFAULT SYSDATE NOT NULL,
    evaluation_result   	INTEGER NOT NULL,
	employee_employee_id	NUMBER NOT NULL,
    manager_id              NUMBER NOT NULL,
    employee_comments       VARCHAR2(4000),
    manager_comments   	    VARCHAR2(4000)
);
ALTER TABLE eval ADD CONSTRAINT eval_pk PRIMARY KEY ( eval_id );

CREATE TABLE products (
    product_id    NUMBER NOT NULL,
    description   VARCHAR2(4000) NOT NULL,
    cost          FLOAT(2) NOT NULL
);
ALTER TABLE products ADD CONSTRAINT products_pk PRIMARY KEY ( product_id );

CREATE TABLE referral (
    referral_id            			NUMBER NOT NULL,
    customer_referring_customer_id  NUMBER NOT NULL,
    referred_date          			DATE DEFAULT SYSDATE NOT NULL,
    is_lead                			CHAR(1) DEFAULT '1',
    discount_aplied                 CHAR(1) DEFAULT '0'
);
ALTER TABLE referral ADD CONSTRAINT referral_pk PRIMARY KEY ( referral_id );

CREATE TABLE region (
	region_short	 VARCHAR2(1) NOT NULL,
    region_name      VARCHAR2(5) NOT NULL
);
ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( region_short );

CREATE TABLE route (
    route_id                 NUMBER NOT NULL,
    region_region_name       VARCHAR2(5) NOT NULL,
	driver_driver_id		 NUMBER NOT NULL,
    vehicle_type             VARCHAR2 (32),
    vehicle_license          VARCHAR2(10)
);
ALTER TABLE route ADD CONSTRAINT route_pk PRIMARY KEY ( route_id );

CREATE TABLE sex (
    sex_short                VARCHAR2(1) NOT NULL,
    sex_name                 VARCHAR2(10) NOT NULL
);
ALTER TABLE sex ADD CONSTRAINT sex_pk PRIMARY KEY ( sex_short );




-- Generate sequences for primary keys.
CREATE SEQUENCE bill_seq START WITH 1;
CREATE SEQUENCE contract_seq START WITH 1;
CREATE SEQUENCE customer_seq START WITH 1;
CREATE SEQUENCE deliveries_seq START WITH 1;
CREATE SEQUENCE delivery_items_seq START WITH 1;
CREATE SEQUENCE driver_seq START WITH 1;
CREATE SEQUENCE employee_seq START WITH 1;
CREATE SEQUENCE eval_seq START WITH 1;
CREATE SEQUENCE products_seq START WITH 1;
CREATE SEQUENCE referral_seq START WITH 1;
CREATE SEQUENCE route_seq START WITH 1;




-- Add foreign keys.
ALTER TABLE bill ADD CONSTRAINT bill_deliveries_fk FOREIGN KEY ( deliveries_delivery_id ) REFERENCES deliveries ( delivery_id );
ALTER TABLE contract ADD CONSTRAINT contract_customer_fk FOREIGN KEY ( customer_customer_id ) REFERENCES customer ( customer_id );
ALTER TABLE contract ADD CONSTRAINT contract_employee_fk FOREIGN KEY ( employee_employee_id ) REFERENCES employee ( employee_id );
ALTER TABLE contract ADD CONSTRAINT contract_region_fk FOREIGN KEY ( region_region_name ) REFERENCES region ( region_short );
ALTER TABLE customer ADD CONSTRAINT customer_referral_fk FOREIGN KEY ( referral_referral_id ) REFERENCES referral ( referral_id );
ALTER TABLE deliveries ADD CONSTRAINT deliveries_contract_fk FOREIGN KEY ( contract_contract_id ) REFERENCES contract ( contract_id );
ALTER TABLE deliveries ADD CONSTRAINT deliveries_route_fk FOREIGN KEY ( route_route_id ) REFERENCES route ( route_id );
ALTER TABLE delivery_items ADD CONSTRAINT delivery_items_deliveries_fk FOREIGN KEY ( deliveries_delivery_id ) REFERENCES deliveries (delivery_id);
ALTER TABLE delivery_items ADD CONSTRAINT delivery_items_products_fk FOREIGN KEY ( products_product_id ) REFERENCES products ( product_id );
ALTER TABLE driver ADD CONSTRAINT driver_employee_fk FOREIGN KEY ( employee_employee_id ) REFERENCES employee ( employee_id );
ALTER TABLE employee ADD CONSTRAINT employee_employee_manager_fk FOREIGN KEY ( employee_manager_id ) REFERENCES employee ( employee_id );
ALTER TABLE employee ADD CONSTRAINT employee_sex_fk FOREIGN KEY ( sex ) REFERENCES sex ( sex_short );
ALTER TABLE employee ADD CONSTRAINT employee_ethnicity_fk FOREIGN KEY ( race ) REFERENCES ethnicity ( ethnicity_name );
ALTER TABLE eval ADD CONSTRAINT eval_employee_fk FOREIGN KEY ( employee_employee_id ) REFERENCES employee ( employee_id );
ALTER TABLE referral ADD CONSTRAINT referral_customer_fk FOREIGN KEY ( customer_referring_customer_id ) REFERENCES customer ( customer_id );
ALTER TABLE route ADD CONSTRAINT route_region_fk FOREIGN KEY ( region_region_name ) REFERENCES region ( region_short );
ALTER TABLE route ADD CONSTRAINT route_driver_fk FOREIGN KEY ( driver_driver_id ) REFERENCES driver ( driver_id );




-- Add constraints.
ALTER TABLE bill ADD CONSTRAINT bill_discount_chk CHECK (discount >= 0 AND discount <= 50);
ALTER TABLE bill ADD CONSTRAINT bill_late_chk CHECK (days_late >= 0);
ALTER TABLE bill ADD CONSTRAINT bill_due_chk CHECK (due_date >= generated_date + 28);
ALTER TABLE bill ADD CONSTRAINT bill_paid_chk CHECK (paid = 0 OR paid = 1);
ALTER TABLE contract ADD CONSTRAINT contract_end_chk CHECK (contract_end >= contract_start);
ALTER TABLE contract ADD CONSTRAINT contract_num_emps_chk CHECK (number_of_employees >= 0);
ALTER TABLE employee ADD CONSTRAINT enployee_age_chk CHECK (age >= 0);
ALTER TABLE employee ADD CONSTRAINT employee_active_chk CHECK (active = 0 OR active = 1);
ALTER TABLE eval ADD CONSTRAINT evaluation_eval_result_chk CHECK (evaluation_result >=1 AND evaluation_result <= 10);
ALTER TABLE products ADD CONSTRAINT product_description_unq UNIQUE (description);
ALTER TABLE products ADD CONSTRAINT product_cost_chk CHECK (cost >= 0);
ALTER TABLE referral ADD CONSTRAINT referral_is_lead_chk CHECK (is_lead = 0 OR is_lead = 1);
ALTER TABLE region ADD CONSTRAINT region_name_unq UNIQUE (region_name);
ALTER TABLE sex ADD CONSTRAINT sex_name_unq UNIQUE (sex_name);




-- Add alternate indexes to tables wherever needed.
CREATE INDEX customer_name_idx ON customer(name);
CREATE INDEX employee_combined_name_idx ON employee(lname, fname);




-- Add functions
CREATE OR REPLACE FUNCTION age_calc(bday IN DATE)
    RETURN NUMBER IS
    age NUMBER;
BEGIN
    age := TRUNC(months_between(sysdate, bday)/12);
    RETURN age;
END;
/

CREATE OR REPLACE FUNCTION bill_days_late_calc(ddate IN DATE)
    RETURN NUMBER IS
    days NUMBER;
BEGIN
    days := (TRUNC(sysdate) - ddate);
    RETURN days;
END;
/

create or replace FUNCTION calc_discount(c_id customer.customer_id%type)
RETURN NUMBER IS
discount NUMBER := 000.00;
referrals NUMBER;

BEGIN
    SELECT count(*) INTO referrals FROM referral WHERE customer_referring_customer_id = c_id AND discount_aplied = 0;
    discount := discount + referrals*25;
    RETURN discount;
END;
/


-- Add packages

create or replace PACKAGE bill_actions AS
PROCEDURE generate_bill(d_id deliveries.delivery_id%TYPE);
PROCEDURE pay_bill(billno bill.bill_id%TYPE);
PROCEDURE update_bill(d_id deliveries.delivery_id%TYPE);
END bill_actions;
/

create or replace PACKAGE BODY bill_actions AS

PROCEDURE generate_bill(d_id deliveries.delivery_id%TYPE) IS 
    CURSOR d_items_c(deliv_id deliveries.delivery_id%TYPE) IS
    SELECT products_product_id, quantity, (quantity*cost) AS total
    FROM delivery_items d JOIN products p ON d.products_product_id = p.product_id
    WHERE deliveries_delivery_id = d_id;
    total_cost NUMBER := 000.00;
    item d_items_c%ROWTYPE;
    discount NUMBER := 000;
    cust customer.customer_ID%TYPE;
    BEGIN
        OPEN d_items_c(d_id);
        LOOP
            FETCH d_items_c into item;
            EXIT WHEN d_items_c%NOTFOUND;
            total_cost := total_cost + item.total;
        END LOOP;
        CLOSE d_items_c;
        SELECT customer_ID into cust FROM deliveries JOIN contract ON deliveries.contract_contract_id = contract.contract_id JOIN
        customer on contract.customer_customer_id = customer.customer_id WHERE deliveries.delivery_id = d_id;
        discount := calc_discount(cust);
        IF discount > 0 THEN
            UPDATE referral SET discount_aplied = 1 WHERE customer_referring_customer_id = cust;
        END IF;
        IF discount >= total_cost THEN
            total_cost := 0;
        ELSE
            total_cost := total_cost - discount;
        END IF;
        INSERT INTO bill(deliveries_delivery_id, total_charges) VALUES(d_id, total_cost);
        COMMIT;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid delivery number');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error has occured');
        ROLLBACK;
    END generate_bill;

PROCEDURE pay_bill(billno bill.bill_id%TYPE) IS
    BEGIN
        UPDATE bill SET paid = 1 WHERE bill_id = billno;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid delivery number');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error has occured');
    END pay_bill;

PROCEDURE update_bill(d_id deliveries.delivery_id%TYPE) IS
    CURSOR d_items_c(deliv_id deliveries.delivery_id%TYPE) IS
    SELECT products_product_id, quantity, (quantity*cost) AS total
    FROM delivery_items d JOIN products p ON d.products_product_id = p.product_id
    WHERE deliveries_delivery_id = d_id;
    total_cost NUMBER := 000.00;
    item d_items_c%ROWTYPE;
    discount NUMBER;
    cust customer.customer_ID%TYPE;
    BEGIN
        OPEN d_items_c(d_id);
        LOOP
            FETCH d_items_c into item;
            EXIT WHEN d_items_c%NOTFOUND;
            total_cost := total_cost + item.total;
        END LOOP;
        CLOSE d_items_c;
        SELECT customer_ID into cust FROM deliveries JOIN contract ON deliveries.contract_contract_id = contract.contract_id JOIN
        customer on contract.customer_customer_id = customer.customer_id WHERE deliveries.delivery_id = d_id;
        discount := calc_discount(cust);
        IF discount > 0 THEN
            UPDATE referral SET discount_aplied = 1 WHERE customer_referring_customer_id = cust;
        END IF;
        IF discount >= total_cost THEN
            total_cost := 0;
        ELSE
            total_cost := total_cost - discount;
        END IF;        
        UPDATE bill SET total_charges = total_cost WHERE deliveries_delivery_id = d_id;
        COMMIT;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Invalid delivery number');
                ROLLBACK;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('An error has occured');
                ROLLBACK;
    COMMIT;
    END update_bill;

END bill_actions;
/

-- Add procedures
CREATE OR REPLACE PROCEDURE bill_days_late_update IS
CURSOR bill_c IS SELECT bill_id, due_date, days_late, paid FROM bill FOR UPDATE OF days_late;
currow bill_c%ROWTYPE;
late_count NUMBER;
BEGIN
OPEN bill_c;
    LOOP
        FETCH bill_c INTO currow;
        EXIT WHEN bill_c%NOTFOUND;
        late_count := bill_days_late_calc(currow.due_date);
        IF late_count <> currow.days_late AND late_count > 0  AND currow.paid = 0 THEN
            UPDATE bill
            SET days_late = late_count
            WHERE CURRENT OF bill_c;
        END IF;
        END LOOP;
    CLOSE bill_c;
END;
/

CREATE OR REPLACE PROCEDURE age_update IS
CURSOR employee_c IS SELECT employee_id, date_of_birth, age FROM employee FOR UPDATE OF age;
worker employee_c%ROWTYPE;
new_age NUMBER;
BEGIN
OPEN employee_c;
    LOOP
        FETCH employee_c INTO worker;
        EXIT WHEN employee_c%NOTFOUND;
        new_age := age_calc(worker.date_of_birth);
        IF new_age <> worker.age THEN
            UPDATE employee
            SET age = new_age
            WHERE CURRENT OF employee_c;
        END IF;
        END LOOP;
    CLOSE employee_c;
END;
/


create or replace PROCEDURE record_sale(d_id deliveries.delivery_id%TYPE, item_no products.product_id%TYPE, 
qty delivery_items.quantity%TYPE) IS
BEGIN
    INSERT INTO delivery_items(deliveries_delivery_id, products_product_id, quantity) VALUES (d_id, item_no, qty);
    bill_actions.update_bill(d_id);
END;
/

create or replace PROCEDURE terminate_contract(con_id contract.contract_id%TYPE) IS
status_check number;
already_expired EXCEPTION;
BEGIN
    select status into status_check FROM contract where contract_id = con_id;
    IF status_check = 1 THEN
        UPDATE contract SET contract_end = sysdate, status = 2 WHERE contract_id = con_id;
        COMMIT;
    ELSE RAISE already_expired;
    END IF;
EXCEPTION
WHEN already_expired THEN
    DBMS_OUTPUT.PUT_LINE('This contract has already expired');
WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid contract number');
END;

/

create or replace PROCEDURE update_contracts IS
CURSOR contract_c IS SELECT contract_id, contract_end FROM contract FOR UPDATE OF status;
contract_record contract_c%ROWTYPE;
BEGIN
    OPEN contract_c;
        LOOP
            FETCH contract_c INTO contract_record;
            EXIT WHEN contract_c%NOTFOUND;
            IF contract_record.contract_end <= sysdate THEN
            UPDATE contract SET status = 0 WHERE CURRENT OF contract_c;
            END IF;
        END LOOP;
    CLOSE contract_c;
    COMMIT;
END;
/

create or replace PROCEDURE enter_eval (eval_result eval.evaluation_result%TYPE, emp_id eval.employee_employee_id%TYPE, 
manag_id eval.manager_id%TYPE, emp_comm eval.employee_comments%TYPE,  manag_comm eval.manager_comments%TYPE) IS
CURSOR 
	c1 IS SELECT employee_id from employee where employee_id = emp_id and employee_manager_id = manag_id;
check_employee_id c1%ROWTYPE;
invalid_data EXCEPTION;
BEGIN
	OPEN c1;
		FETCH c1 INTO check_employee_id; 
	IF c1%NOTFOUND THEN RAISE invalid_data;
	ELSIF (eval_result<0) THEN RAISE invalid_data;
	ELSIF(eval_result>10) THEN RAISE invalid_data;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Data entering'); 
		INSERT INTO eval (eval_id, eval_date, evaluation_result, employee_employee_id, manager_id, employee_comments, manager_comments ) 
			VALUES (eval_seq.nextval, SYSDATE, eval_result, emp_id, manag_id, emp_comm, manag_comm);
	END IF;
	CLOSE c1;
	COMMIT;
	DBMS_OUTPUT.PUT_LINE('Data commit'); 
EXCEPTION
	WHEN invalid_data
	 	THEN DBMS_OUTPUT.PUT_LINE('Invalid data');
             ROLLBACK;
	WHEN OTHERS
		THEN DBMS_OUTPUT.PUT('The PLSQL procedure executed by ' || USER || ' returned and unhandled exception on ' || SYSDATE);
             ROLLBACK;
END;
/


execute enter_eval('9.235','3','1','I did well','Much better english now');


--Add triggers
CREATE OR REPLACE TRIGGER bill_seq_trg BEFORE INSERT ON bill FOR EACH ROW
BEGIN
    SELECT bill_seq.NEXTVAL INTO :new.bill_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER contract_seq_trg BEFORE INSERT ON contract FOR EACH ROW
BEGIN
    SELECT contract_seq.NEXTVAL INTO :new.contract_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER contract_check before insert on deliveries for each row
DECLARE
cstatus contract.status%type;
inactive_contract EXCEPTION;
BEGIN
    SELECT status into cstatus from contract where contract_id = :new.contract_contract_id;
    IF cstatus = 0 THEN
        RAISE inactive_contract;
    END IF;
EXCEPTION
    WHEN inactive_contract THEN
    DBMS_OUTPUT.PUT_LINE('This contract has expired');
    RAISE;
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error has occurred');
    RAISE;
END;
/

CREATE OR REPLACE TRIGGER customer_seq_trg BEFORE INSERT ON customer FOR EACH ROW
BEGIN
    SELECT customer_seq.NEXTVAL INTO :new.customer_id FROM dual;
END;
/


CREATE OR REPLACE TRIGGER deliveries_seq_trg BEFORE INSERT ON deliveries FOR EACH ROW
BEGIN
    SELECT deliveries_seq.NEXTVAL INTO :new.delivery_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER delivery_items_seq_trg BEFORE INSERT ON delivery_items FOR EACH ROW
BEGIN
    SELECT delivery_items_seq.NEXTVAL INTO :new.delivery_items_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER driver_seq_trg BEFORE INSERT ON driver FOR EACH ROW
BEGIN
    SELECT driver_seq.NEXTVAL INTO :new.driver_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER employee_seq_trg BEFORE INSERT ON employee FOR EACH ROW
BEGIN
    SELECT employee_seq.NEXTVAL INTO :new.employee_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER eval_seq_trg BEFORE INSERT ON eval FOR EACH ROW
BEGIN
    SELECT eval_seq.NEXTVAL INTO :new.eval_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER products_seq_trg BEFORE INSERT ON products FOR EACH ROW
BEGIN
    SELECT products_seq.NEXTVAL INTO :new.product_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER referral_seq_trg BEFORE INSERT ON referral FOR EACH ROW
BEGIN
    SELECT referral_seq.NEXTVAL INTO :new.referral_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER route_seq_trg BEFORE INSERT ON route FOR EACH ROW
BEGIN
    SELECT route_seq.NEXTVAL INTO :new.route_id FROM dual;
END;
/




-- Build scheduled jobs
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
    job_name => 'update_employee_ages',
    job_type => 'STORED_PROCEDURE',
    job_action => 'age_update',
    repeat_interval => 'FREQ=MINUTELY;INTERVAL=5',
    comments => 'Every five minutes');
END;
/


-- Add in specialized views/reports
CREATE view region_wise_customers AS
SELECT 
    r.region_name, 
    LISTAGG(cu.name, ', ')  WITHIN GROUP (ORDER BY cu.name) AS all_customers
FROM region r 
        JOIN contract c ON r.region_short = c.region_region_name
        JOIN customer cu ON c.customer_customer_id = cu.customer_id
GROUP BY r.region_name;
/

create view top_5_sold_products AS
WITH aggregated_data AS (
SELECT di.products_product_id, p.description,SUM(quantity) AS total_quantity
FROM delivery_items di 
    JOIN products p ON di.products_product_id = p.product_id
GROUP BY products_product_id, p.description
ORDER BY SUM(quantity) DESC)
SELECT * FROM aggregated_data
WHERE rownum<=5;
/


--- Create Roles
create role darksprings_manager;
/

grant select, insert, update on eval to darksprings_manager;
/

grant select on employee_evaluation_report to darksprings_manager;
/


create role delivery_manager;

grant select, insert, update on deliveries to delivery_manager;
/

grant select, insert, update on delivery_items to delivery_manager;
/

grant execute on record_sale to delivery_manager;
/

-- POPULATE THE DATABASE WITH SOME DATA!
-- Add sex
INSERT INTO sex (sex_short, sex_name) VALUES ('O','Other');
INSERT INTO sex (sex_short, sex_name) VALUES ('M','Male');
INSERT INTO sex (sex_short, sex_name) VALUES ('F','Female');

-- Add regions
INSERT INTO region (region_short, region_name) VALUES ('N','North');
INSERT INTO region (region_short, region_name) VALUES ('E','East');
INSERT INTO region (region_short, region_name) VALUES ('S','South');
INSERT INTO region (region_short, region_name) VALUES ('W','West');

-- Add ethnicities
INSERT INTO ethnicity (ethnicity_name) VALUES ('Alaska Native');
INSERT INTO ethnicity (ethnicity_name) VALUES ('Native Hawaiian');
INSERT INTO ethnicity (ethnicity_name) VALUES ('Other Pacific Islander');
INSERT INTO ethnicity (ethnicity_name) VALUES ('Asian');
INSERT INTO ethnicity (ethnicity_name) VALUES ('African American');
INSERT INTO ethnicity (ethnicity_name) VALUES ('Hispanic');
INSERT INTO ethnicity (ethnicity_name) VALUES ('White');
INSERT INTO ethnicity (ethnicity_name) VALUES ('American Indian');

-- Add products
INSERT INTO products (description, cost) VALUES ('Cups','5');
INSERT INTO products (description, cost) VALUES ('Stainless Steel Cup Holder','45');
INSERT INTO products (description, cost) VALUES ('Large Water','15');
INSERT INTO products (description, cost) VALUES ('Small Water','5');
INSERT INTO products (description, cost) VALUES ('Water Cooler Deposit','150');
INSERT INTO products (description, cost) VALUES ('Administrative Fee','10');
INSERT INTO products (description, cost) VALUES ('Delivery Fee','20');

-- Add customers
INSERT INTO customer (name, phone) VALUES ('Fake News Inc.','5276554027');
INSERT INTO customer (name, phone, point_of_contact) VALUES ('Thirsty Workers Ltd.','9904452123','Aiesha Howard');
INSERT INTO customer (name, phone, point_of_contact) VALUES ('Desert Dwellers LLC','2317782780','Shah Field');
INSERT INTO customer (name, phone, point_of_contact) VALUES ('We Pay Late Corp','6769888152','John Doe');
INSERT INTO customer (name, phone, point_of_contact) VALUES ('Dihydrogen Monoxide Educaters','9253483373','Jane Smith');
INSERT INTO customer (name, phone, point_of_contact) VALUES ('The Throw Away Society','9515051480','Hungry Jack');

-- Add employees
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,national_id_number,cell_number,position,active) VALUES (
'Lowri','Norris','628 Fawn St.','Mechanicsville','PA','23111','F','Alaska Native','12-AUG-1925','123-45-6789','0118999881','General Manager','1');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,national_id_number,employee_manager_id,position,active) VALUES (
'Molly','Johnson','7174 South Wild Rose Ave.','Schenectady','PA','12302','F','Native Hawaiian','29-FEB-2004','908-76-5432',(SELECT employee_id FROM employee WHERE position = 'General Manager'),'Contract and Delivery Coordinator','1');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active) VALUES (
'Ria','Schneider','825 North Rd.','Rahway','PA','07065','M','Other Pacific Islander','03-SEP-1943',(SELECT employee_id FROM employee WHERE position = 'General Manager'),'Contract and Financial Coordinator','1');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active,cell_number) VALUES (
'Libby','Schneider','9824 Mayfair St.','Cincinnati','PA','45211','O','Asian','06-MAR-1987',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Driver','1','2025550178');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active,cell_number) VALUES (
'Hana','Khan','20 Summer Ave.','Muskegon','PA','49441','M','African American','02-OCT-1991',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Driver','1','2025550119');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active,cell_number) VALUES (
'Loni','Gardner','9992 Franklin St.','Munster','PA','46321','O','Hispanic','12-NOV-2001',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Driver','1','2025550127');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active,cell_number) VALUES (
'Fifi','Dawson','7212 Wakehurst Ave.','Goose Creek','PA','95008','M','White','10-JUN-2004',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Driver','1','2025550198');
INSERT INTO employee (fname,lname,street,city,state,zip,sex,race,date_of_birth,employee_manager_id,position,active,cell_number) VALUES (
'Charley','Moore','8967 Hilltop Circle','Ladson','PA','29456','F','American Indian','28-DEC-1979',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Driver','0','2025550128');

-- Add evals
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, manager_comments) VALUES ('12-MAR-2018','6',(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),(SELECT employee_id FROM employee WHERE position = 'General Manager'),'Generic name, generic person.');
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, employee_comments) VALUES ('11-DEC-2019','8',(SELECT employee_id FROM employee WHERE fname='Libby' AND lname='Schneider'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'I swear I do not make the bagged chips!');
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, manager_comments) VALUES ('9-AUG-2018','7',(SELECT employee_id FROM employee WHERE fname='Loni' AND lname='Gardner'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Customer complained about bringing water with the wrong chemical composition.');
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, employee_comments, manager_comments) VALUES ('27-JAN-2020','9',(SELECT employee_id FROM employee WHERE fname='Loni' AND lname='Gardner'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'Convinced customer H2O is the healthiest chemical makeup of water, H2O + C6H12O6 causes obesity.','Heard playing banjo death metal, must be a good person. Upping eval score!');
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, employee_comments, manager_comments) VALUES ('10-AUG-2019','10',(SELECT employee_id FROM employee WHERE fname='Fifi' AND lname='Dawson'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'I love water!','Clearly loves working here.');
INSERT INTO eval (eval_date, evaluation_result, employee_employee_id, manager_id, employee_comments, manager_comments) VALUES ('2-FEB-2020','3',(SELECT employee_id FROM employee WHERE fname='Loni' AND lname='Gardner'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'I admit, country music is awesome.','Heard her listening to country music. The only way this could be worse is if I was in the car. Evaluation score adjusted appropriately.');

-- Add drivers
INSERT INTO driver (license_number,employee_employee_id) VALUES ('2346235678123',(SELECT employee_id FROM employee WHERE fname='Libby' AND lname='Schneider'));
INSERT INTO driver (license_number,employee_employee_id) VALUES ('2340597108945',(SELECT employee_id FROM employee WHERE fname='Hana' AND lname='Khan'));
INSERT INTO driver (license_number,employee_employee_id) VALUES ('1240984578294',(SELECT employee_id FROM employee WHERE fname='Loni' AND lname='Gardner'));
INSERT INTO driver (license_number,employee_employee_id) VALUES ('5674547352368',(SELECT employee_id FROM employee WHERE fname='Fifi' AND lname='Dawson'));

-- Add routes
INSERT INTO route (region_region_name,driver_driver_id,vehicle_type,vehicle_license) VALUES ('N', (SELECT driver_id FROM driver WHERE employee_employee_id = (SELECT employee_id FROM employee WHERE fname='Libby' AND lname='Schneider')), 'Chevrolet Vega', 'H20');
INSERT INTO route (region_region_name,driver_driver_id,vehicle_type,vehicle_license) VALUES ('E', (SELECT driver_id FROM driver WHERE employee_employee_id = (SELECT employee_id FROM employee WHERE fname='Hana' AND lname='Khan')), 'Pontiac Aztek', '2H20');
INSERT INTO route (region_region_name,driver_driver_id,vehicle_type,vehicle_license) VALUES ('S', (SELECT driver_id FROM driver WHERE employee_employee_id = (SELECT employee_id FROM employee WHERE fname='Loni' AND lname='Gardner')), 'Renault Fuego', '3H20');
INSERT INTO route (region_region_name,driver_driver_id,vehicle_type,vehicle_license) VALUES ('W', (SELECT driver_id FROM driver WHERE employee_employee_id = (SELECT employee_id FROM employee WHERE fname='Fifi' AND lname='Dawson')), 'Austin Allegro', '4H20');

-- Add lead: referral first, then referred customer info into customer linking to referral
BEGIN
	INSERT INTO referral (customer_referring_customer_id, referred_date, is_lead) VALUES (
	(SELECT customer_id FROM customer WHERE name = 'Thirsty Workers Ltd.'),
	'01-JAN-19',
	'1');     
	INSERT INTO customer (name, phone, point_of_contact, referral_referral_id) VALUES ('Niagra Falls Lifeguard Recruitment Center','4114743081','Aquaman',(SELECT MAX(referral_id) FROM referral));
END;
/
	
-- Add referral
BEGIN
	INSERT INTO referral (customer_referring_customer_id, referred_date, is_lead) VALUES (
	(SELECT customer_id FROM customer WHERE name = 'Dihydrogen Monoxide Educaters'),
	'11-MAR-17',
	'0');     
	INSERT INTO customer (name, phone, point_of_contact, referral_referral_id) VALUES ('Dead Sea Desalination Plant','9281732068','King Triton',(SELECT MAX(referral_id) FROM referral));
END;
/

-- Add contract
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Fake News Inc.'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'02-JAN-19','02-JAN-20','42','429 Gulf Drive','Norwood','PA','02062','N');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Fake News Inc.'),(SELECT employee_id FROM employee WHERE fname = 'Ria' AND lname = 'Schneider'),'02-JAN-19','02-JAN-20','901','398 Jockey Hollow St.','Fairborn','PA','45324','N');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Fake News Inc.'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'02-JAN-19','02-JAN-20','210','961 Church St.','Auburndale','PA','33823','W');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Thirsty Workers Ltd.'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'12-AUG-19','12-AUG-20','2','0 E. Race Road','Ladson','PA','29183','E');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='We Pay Late Corp'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'30-NOV-19','30-NOV-20','43','922 Brickyard Street','Richmond','PA','93817','S');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Desert Dwellers LLC'),(SELECT employee_id FROM employee WHERE fname = 'Ria' AND lname = 'Schneider'),'28-FEB-19','28-FEB-20','1','7 South Spruce Street','Egg Harbor Township','PA','32123','W');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Dihydrogen Monoxide Educaters'),(SELECT employee_id FROM employee WHERE fname = 'Ria' AND lname = 'Schneider'),'18-JAN-20','18-JAN-21','98','590 Riverside Court','Annapolis','PA','34567','S');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='The Throw Away Society'),(SELECT employee_id FROM employee WHERE fname = 'Ria' AND lname = 'Schneider'),'01-JAN-20','01-JAN-21','1047','121 Boston Street','Bronx','PA','23456','E');
INSERT INTO contract (customer_customer_id,employee_employee_id,contract_start,contract_end,number_of_employees,street,city,state,zip,region_region_name) VALUES ((SELECT customer_id FROM customer WHERE name='Dead Sea Desalination Plant'),(SELECT employee_id FROM employee WHERE fname = 'Molly' AND lname = 'Johnson'),'02-JAN-19','02-JAN-20','50','717 S. Buttonwood Street','Circle Pines','PA','12345','N');

-- Add deliveries
INSERT INTO deliveries (delivery_date,contract_contract_id,route_route_id) VALUES ('06-DEC-2019',(SELECT contract_id FROM contract WHERE street='429 Gulf Drive'),'1');
INSERT INTO deliveries (delivery_date,contract_contract_id,route_route_id) VALUES ('12-DEC-2019',(SELECT contract_id FROM contract WHERE street='429 Gulf Drive'),'1');
INSERT INTO deliveries (delivery_date,driver_comment,customer_comment,contract_contract_id,route_route_id) VALUES ('31-DEC-2019','Making me deliver on a holiday... come on.','Happy new year!',(SELECT contract_id FROM contract WHERE street='398 Jockey Hollow St.'),'1');
INSERT INTO deliveries (delivery_date,customer_comment,contract_contract_id,route_route_id) VALUES ('13-JAN-2020','I want double water next time.',(SELECT contract_id FROM contract WHERE street='0 E. Race Road'),'2');
INSERT INTO deliveries (delivery_date,driver_comment,contract_contract_id,route_route_id) VALUES ('11-FEB-2018','They keep asking me about the Schneider twins making chips at work. I am dropping this route.',(SELECT contract_id FROM contract WHERE street='7 South Spruce Street'),'4');
INSERT INTO deliveries (delivery_date,contract_contract_id,route_route_id) VALUES ('05-DEC-2019',(SELECT contract_id FROM contract WHERE street='717 S. Buttonwood Street'),'1');

-- Add items to deliveries
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('1','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('1','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('2','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('2','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('3','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('3','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('4','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('4','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('5','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('5','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('6','6','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('6','7','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('1','5','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('2','5','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('6','5','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('1','3','5');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('2','3','45');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('3','3','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('4','3','2');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('5','3','2');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('6','3','3');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('3','1','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('3','2','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('4','4','10');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('5','4','1');
INSERT INTO delivery_items (deliveries_delivery_id,products_product_id,quantity) VALUES ('6','4','100');

-- Add items to bill
execute bill_actions.generate_bill('1');
execute bill_actions.generate_bill('2');
execute bill_actions.generate_bill('3');
execute bill_actions.generate_bill('4');
execute bill_actions.generate_bill('5');

--INSERT INTO bill (deliveries_delivery_id,generated_date,due_date,total_charges,paid) VALUES ('1','31-DEC-2019','31-JAN-2020','1460','1');
--INSERT INTO bill (deliveries_delivery_id,generated_date,due_date,total_charges,paid) VALUES ('2','31-DEC-2019','02-FEB-2020','105','1');
--INSERT INTO bill (deliveries_delivery_id,generated_date,due_date,total_charges,paid) VALUES ('3','31-JAN-2020','03-MAR-2020','120','0');
--INSERT INTO bill (deliveries_delivery_id,generated_date,due_date,total_charges,paid) VALUES ('4','25-FEB-2018','25-MAR-2018','75','1');
--INSERT INTO bill (deliveries_delivery_id,generated_date,due_date,total_charges,paid) VALUES ('5','31-DEC-2019','31-JAN-2020','790','1');

-- Mark some bills as paid
execute bill_actions.pay_bill('1');
execute bill_actions.pay_bill('3');
execute bill_actions.pay_bill('4');
execute bill_actions.pay_bill('5');

-- Change some bill due dates to make them run late.
UPDATE bill SET generated_date = TO_DATE('12-DEC-2018'), due_date = TO_DATE('12-JAN-2019') WHERE bill_id = '1';
UPDATE bill SET generated_date = TO_DATE('09-MAR-2019'), due_date = TO_DATE('09-APR-2019') WHERE bill_id = '2';
UPDATE bill SET generated_date = TO_DATE('01-MAR-2020'), due_date = TO_DATE('01-APR-2020') WHERE bill_id = '3';

COMMIT;
