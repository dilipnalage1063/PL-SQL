--Cursors
  --allows handling multiple rows one by one
  --Query returns multiple rows - cursor moves row by row
  
  --Pointer to result set of query
  
  --Types :-
  --1)Implicit Cursor
  -- auto created by Oracle
     -- Used for : INSERT, UPDATE, DELETE, SELECT INTO
     
  --2)Explicit Cursor
  --Created by developer
  --Used when query returns multiple rows
  
 --Examples :-
   --1)Implicit Cursor

SELECT * FROM xxdn_emp;  

SET SERVEROUTPUT ON;

BEGIN
     UPDATE xxdn_emp
     SET salary = salary + 1000
     WHERE dept_no = 10;
END;

--🧠 Internal:
--Oracle creates cursor automatically

--🔹 Cursor Attributes (Important)
--Used with implicit cursor:

--SQL%ROWCOUNT
--SQL%FOUND
--SQL%NOTFOUND

--ex:

BEGIN
     UPDATE xxdn_emp
     SET salary = salary + 1000
     WHERE dept_no = 10;
     
     DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
END;
/

--Explicit Cursor

   --Lifecycle :
   
--Step 1: Declare Cursor

CURSOR c_emp IS
SELECT emp_id, salary FROM xxdn_emp;

--Step 2: Open Cursor
OPEN c_emp;

--Step 3: Fetch Data
FETCH c_emp INTO v_id, v_salary;

--Step 4: Close Cursor
CLOSE c_emp;

--🔹 6. Full Example

DECLARE
   CURSOR c_emp IS
      SELECT emp_id, salary FROM xxdn_emp;
      
   v_id employees.emp_id%TYPE;
   v_salary xxdn_emp.salary%TYPE;
BEGIN
   OPEN c_emp;
   
   LOOP
       FETCH c_emp INTO v_id, v_salary;
       EXIT WHEN c_emp%NOTFOUND;
       
       DBMS_OUTPUT.PUT_LINE(v_id || ' - ' || v_salary);
    END LOOP;
    
    CLOSE c_emp;
END;


--
DECLARE
   CURSOR c_emp IS
      SELECT emp_id FROM xxdn_emp;
   v_id xxdn_emp.emp_id%TYPE;
   
BEGIN
   OPEN c_emp;
   
   LOOP
     FETCH c_emp INTO v_id;
--FETCH retrieves one row at a time from the cursor into variables.
     EXIT WHEN c_emp%NOTFOUND;
     
     DBMS_OUTPUT.PUT_LINE(v_id);
   END LOOP;
   
   CLOSE c_emp;
END;


--Cursor FOR Loop :
  -- It automates everything
  
  --syntax:
  
BEGIN
    FOR rec IN (SELECT column FROM table) LOOP
    -- use rec.column 
       -- - rec is temporary variable 
       -- - holds one row at a time
    END LOOP;
END;

  --ex:1)Print all EMP_ID
SELECT * FROM xxdn_emp;

SET SERVEROUTPUT ON;

BEGIN
    FOR rec IN (SELECT emp_id FROM xxdn_emp) LOOP
      DBMS_OUTPUT.PUT_LINE(rec.emp_id);
    END LOOP;
END;

--2)Print EMP_NAME and SALARY
BEGIN
   FOR rec IN (SELECT emp_name, salary FROM xxdn_emp) LOOP
     DBMS_OUTPUT.PUT_LINE(rec.emp_name || ' - ' || rec.salary);
   END LOOP;
END;

BEGIN
   FOR rec IN (SELECT emp_name, salary FROM xxdn_emp) LOOP
      DBMS_OUTPUT.PUT_LINE(
         rec.emp_name || ' - ' || NVL(TO_CHAR(rec.salary), 'NULL')
      );
   END LOOP;
END;
   
   
--3)Print only high salary (>6000)
BEGIN
    FOR rec IN (SELECT emp_name, salary FROM xxdn_emp) LOOP
      IF rec.salary > 6000 THEN
         DBMS_OUTPUT.PUT_LINE(rec.emp_name || ' - ' || rec.salary);
         
      END IF;
    END LOOP;
END;

--
BEGIN
    FOR rec IN (SELECT emp_name, job FROM xxdn_emp) LOOP
    DBMS_OUTPUT.PUT_LINE(rec.emp_name || ' - ' || rec.job);
    END LOOP;
END;


--Cursor Variables (REF CURSOR)
  --why ?
  --To handle dynamic queries 
  --and return result sets from PL/SQL programs.
  
DECLARE
   TYPE emp_cursor IS REF CURSOR;
   
   c_emp emp_cursor;
   v_name xxdn_emp.emp_name%TYPE;
   
BEGIN
   OPEN c_emp FOR SELECT emp_name FROM xxdn_emp;
   
   LOOP
     FETCH c_emp INTO v_name;
     EXIT WHEN c_emp%NOTFOUND;
    
     DBMS_OUTPUT.PUT_LINE(v_name);
   END LOOP;
   
   CLOSE c_emp;
END;


--CURSOR Attributes
  --Attributes work AFTER FETCH
  
--1. %FOUND
-- returns true if last FETCH returned a row
FETCH c_emp INTO v_id

IF c_emp%FOUND THEN
   DBMS_OUTPUT.PUT_LINE('Row Found');
END IF;

--2. %NOTFOUND
--Returns TRUE if last FETCH did NOT return a row

EXIT WHEN c_emp%NOTFOUND;

--3. %ROWCOUNT
--Number of rows fetched so far

DBMS_OUTPUT.PUT_LINE(c_emp%ROWCOUNT);

--4. %ISOPEN
-- checks if cursor is open

IF c_emp%ISOPEN THEN
   DBMS_OUTPUT.PUT_LINE('Cursor if open');
END IF;

--[IMP] Attributes work AFTER FETCH

FETCH c_emp INTO v_id;
IF c_emp%FOUND THEN ...

--Implicit Cursor Attributes
    -- Used with SQL
    
UPDATE employees SET salary = salary + 1000;
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);

--Full Example

DECLARE
    CURSOR c_emp IS SELECT emp_id FROM xxdn_emp;
    v_id xxdn_emp.emp_id%TYPE;
BEGIN
    OPEN c_emp;
    
    LOOP
       FETCH c_emp INTO v_id;
       
       EXIT WHEN c_emp%NOTFOUND;
       
       DBMS_OUTPUT.PUT_LINE(
         'Row: ' || c_emp%ROWCOUNT || ' ID: ' || v_id
         );
         
    END LOOP;
    
    CLOSE c_emp;
    
END;

--^^ Cursor attributes are meaningless without FETCH ^^

--Control Structures
  --controls flow of execution
  --they decides : what , when and how many times to run
  
  --Types:-
--  1) Conditional - IF
--  2) Looping - LOOP, WHILE, FOR

--IF statement:

IF v_salary > 5000 THEN
    DBMS_OUTPUT.PUT_LINE('High Salary');
END IF;

--IF ELSE
IF v_salary > 5000 THEN
  DBMS_OUTPUT.PUT_LINE('High');
ELSE
  DBMS_OUTPUT.PUT_LINE('Low');
END IF;

--IF-ELSIF

IF v_salary > 8000 THEN
  DBMS_OUTPUT.PUT_LINE('Very High');
ELSIF v_salary > 5000 THEN
  DBMS_OUTPUT.PUT_LINE('High');
ELSE
  DBMS_OUTPUT.PUT_LINE('Low');
END IF;


--LOOP (Basic Loop)
DECLARE
    v_num NUMBER:= 1;
BEGIN
 LOOP
   DBMS_OUTPUT.PUT_LINE(v_num);
   v_num := v_num + 1;
   
   EXIT WHEN v_num > 5;
 END LOOP;
END;

--WHILE LOOP
DECLARE
v_num NUMBER := 1;
BEGIN
WHILE v_num <=5 LOOP
   DBMS_OUTPUT.PUT_LINE(v_num);
   v_num := v_num + 1;
END LOOP;
END;

--FOR LOOP

BEGIN
FOR i IN 1..5 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

--NESTED IF INSIDE LOOP
SET SERVEROUTPUT ON;
DECLARE
   i NUMBER:= 1;
BEGIN
   WHILE i<=5 LOOP
   
     IF i MOD 2 = 0 THEN
        DBMS_OUTPUT.PUT_LINE(i || ' EVEN');
     ELSE
        DBMS_OUTPUT.PUT_LINE(i || ' ODD');
     END IF;
     
     i := i+1;
     END LOOP;
END;

COMMIT;

--practice
SET SERVEROUTPUT ON;
BEGIN
FOR i IN 1..5 LOOP
   IF i MOD 2 = 0 THEN
      DBMS_OUTPUT.PUT_LINE(i || ' EVEN');
   ELSE 
      DBMS_OUTPUT.PUT_LINE(i || ' ODD');
   END IF;
   END LOOP;
END;

--MODULARITY 
   -- Def:breaking large code into smaller reusable units
   -- Types: 1)Procedure, 2)Function
   
   --Procedure - block of code that performs task

PROCEDURE print_msg IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello');
END;

--calling it 

BEGIN
    print_msg;
END;

   --Function - returns a value
   
FUNCTION get_bonus RETURN NUMBER IS
BEGIN
     RETURN 1000;
END;

--calling only
v_bonus := get_bonus;

--** Key Difference **
--Procedure	        Function
--No return	        Must return
--Performs action	Returns value



--Data Abstraction
   --hides implementation details and show only required functionality
   
FUNCTION get_bonus(p_sal NUMBER) RETURN NUMBER IS
BEGIN 
    IF p_sal > 5000 THEN
        RETURN p_sal * 0.10;
    ELSE 
        RETURN p_sal * 0.05;
    END IF;
END;


--calling only
v_bonus := get_bonus(6000);


--Information Hiding (Important Distinction)
  --Restricting access to internal data and implementation
  --Not only hiding logic
  --But also preventing direct access
  
  
--  Difference from Abstraction
--Concept	                Meaning
--Abstraction	           Hide implementation
--Information Hiding	   Restrict access

--Direct access to internal data/implementation is restricted



--Error Handling

--Common Exceptions
--Exception	          Meaning
--NO_DATA_FOUND	      No row returned
--TOO_MANY_ROWS	      Multiple rows returned
--ZERO_DIVIDE	      Divide by zero
--OTHERS	          Any error


--ex

DECLARE 
    v_sal NUMBER;
BEGIN
    SELECT salary INTO v_sal
    FROM xxdn_emp
    WHERE emp_id = 20;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('No Employee Found');
END;


--Multiple Exception Handling

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      ...
   WHEN TOO_MANY_ROWS THEN
      ...
   WHEN OTHERS THEN
      ...
      
    --EXCEPTION block runs only when runtime error occurs in BEGIN section
    
