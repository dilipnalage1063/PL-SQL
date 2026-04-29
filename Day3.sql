--Understanding the Main Features of PL/SQL
--EXAMPLE

--available online in file 'examp1'
DECLARE
    qty_on_hand NUMBER(5);
BEGIN
    SELECT quantity INTO qty_on_hand FROM inventory
       WHERE product = 'TENNIS RACKET'
       FOR UPDATE OF quantity;
    IF qty_on_hand > 0 THEN --check quantity
        UPDATE inventory SET quantity = quantity - 1
        WHERE product = 'TENNIS RACKET';
        INSERT INTO purchase_record
           VALUES ('Tennis racket purchased', SYSDATE);
    ELSE 
        INSERT INTO purchase_record
            VALUES ('Out of tennis rackets', SYSDATE);
    END IF;
    COMMIT;
END;


--Block Structure
[DECLARE
    --declarations]
BEGIN
    --statements
[EXCEPTION
    --handlers]
END;


--Declaring Variables
    part_no NUMBER(4);
    in_stock BOOLEAN;

--Assigning Values to a Variable
--METHOD - [1]
tax := price * tax_rate;
valid_id := FALSE;
bonus := current_salary * 0.10;
wages := gross_pay(emp_id, st_hrs, ot_hrs) - deductions;

--METHOD - [2]

SELECT sal*0.10 INTO bonus FROM emp WHERE empno = emp_id;

--METHOD - [3]

DECLARE
     my_sal REAL(7,2);
     PROCEDURE adjust_salary (emp_id INT, salary IN OUT REAL) IS ...
BEGIN
    SELECT AVG(sal) INTO my_sal FROM emp;
    adjust_salary(7788, my_sal);  --assigns a new value to my_sal
    
--Declaring Constants

credit_limit CONSTANT REAL := 5000.00

DECLARE
       v_name VARCHAR2(50);
       v_salary NUMBER := 5000;
       c_bonus CONSTANT NUMBER := 1000;
BEGIN
       v_name := 'John';
       
       DBMS_OUTPUT.PUT_LINE(v_name);
       DBMS_OUTPUT.PUT_LINE(v_salary + c_bonus);
       
       
END;




--
DECLARE
       v_num NUMBER := 25;
       c_val CONSTANT NUMBER := 5;
BEGIN
       DBMS_OUTPUT.PUT_LINE(v_num + c_val);
END;

--corrected code
DECLARE
   v_emp_name VARCHAR2(20); --added semicolon
   v_bonus NUMBER := 1000;  --added semicolon
   c_rate CONSTANT NUMBER := 3.14;
BEGIN
   v_emp_name := 'ALEXANDER'; --missing semi colon was added
   
   DBMS_OUTPUT.PUT_LINE(v_emp_name);
   DBMS_OUTPUT.PUT_LINE(v_bonus * c_rate); --here was one missing semi colon i added it
END;