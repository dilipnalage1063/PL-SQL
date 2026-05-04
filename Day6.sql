--**Case Sensitivity + Name Resolution

--PL/SQL is NOT case sensitive


--Name Resolution
--Priority:
--
--  Local variable
--  Outer variable
--  Table column

DECLARE
  x NUMBER := 10;  -- outer
BEGIN
  DECLARE
    x NUMBER := 20;  -- local
  BEGIN
    DBMS_OUTPUT.PUT_LINE(x);
  END;
END;


--Ouptut -> 20

--
DECLARE
   emp_id NUMBER := 5;
BEGIN
   SELECT emp_id INTO emp_id
   FROM xxdn_emp
   WHERE emp_id = 1;
END;
   --Column name overrides variable name in SQL

   --Best Practice - Avoid same name   
DECLARE
   v_emp_id NUMBER := 5;
BEGIN
   SELECT emp_id INTO v_emp_id
   FROM xxdn_emp
   WHERE emp_id = 1;
END;


--** Assignments + Boolean + Expressions (Core Logic)

--Assignment
v_num := 10;

--Boolean
v_flag BOOLEAN := TRUE;

--Expressions
v_total := v_sal + 1000;
/

--Questions

DECLARE
    v_num NUMBER := 10 ;
BEGIN
    IF MOD(v_num,2) = 0 THEN
       DBMS_OUTPUT.PUT_LINE('EVEN');
    ELSE 
       DBMS_OUTPUT.PUT_LINE('ODD');
    END IF;
END;
/


--** Operators + CASE + NULL Handling
--1) USING CASE Condition
DECLARE
     salary NUMBER := NULL;
BEGIN
  DBMS_OUTPUT.PUT_LINE(
     CASE
         WHEN salary IS NULL THEN 'NO SALARY'
         ELSE 'HAS SALARY'
      END
      );
END;
/

--2)
DECLARE
   v_sal NUMBER := NULL;
BEGIN
   IF v_sal IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('NO SALARY');
   END IF;
END;
/


--** Built-in Functions

--Numeric
--ROUND(10.56) -> 11


--String
--UPPER('john') → JOHN
--LOWER('JOHN') → john

--Date
--SYSDATE

--NULL Handling
--NVL(value, default);


--DECLARE
--    e_name xxdn_emp.emp_name%TYPE;
--    e_id   xxdn_emp.emp_id%TYPE;
--BEGIN
--     SELECT emp_id, emp_name INTO e_id, e_name
--     FROM xxdn_emp
--     WHERE emp_id = 2;
--     
--     DBMS_OUTPUT.PUT_LINE(e_id || ' - ' || e_name);
--END;

--SELECT * FROM xxdn_emp;

--1)
DECLARE
     v_emp_name xxdn_emp.emp_name%TYPE;
     v_sal xxdn_emp.salary%TYPE;
BEGIN
     SELECT emp_name, salary INTO v_emp_name, v_sal
     FROM xxdn_emp
     WHERE emp_id = 4;
     
     DBMS_OUTPUT.PUT_LINE(UPPER(v_emp_name) || ' - ' || NVL(v_sal,0));
END;
/


-- ** Character Set
   -- Defines how characters are stored (ASCII, Unicode)
   

--** Synonyms
   -- Alias for database object
   
--CREATE SYNONYM emplo FOR xxdn_emp;
--
--SELECT * FROM emplo;


-- ** Operator Precedence

--Order (Important)
--1. ()
--2. *, /
--3. +, -
--4. Comparison (=, >, <)
--5. NOT
--6. AND
--7. OR


--** Boolean Expressions
   -- Expression that returns TRUE / FALSE
   
--   Used in:
--IF condition THEN

--** Database Values
--Values coming from DB tables

--SELECT salary INTO v_sal FROM xxdn_emp;

--👉 v_sal = database value



--** Scope vs Visibility

--Scope: Where variable is declared
--Visibility: Where variable can be accessed

--🧠 Rule:
--Concept	      Meaning
--Scope	          region of declaration
--Visibility	  accessibility


--Inside can see outside, outside cannot see inside.

DECLARE
   v_a NUMBER := 10;
BEGIN
   DECLARE
      v_b NUMBER := 20;
   BEGIN
      DBMS_OUTPUT.PUT_LINE(v_a); -- visible
   END;
   DBMS_OUTPUT.PUT_LINE(v_a);
END;
/


-- *** PL/SQL Datatypes ***

--Main Categories:
--Type	        Examples
--Number	    NUMBER
--Character	    VARCHAR2, CHAR
--Date/Time	    DATE
--Boolean	    BOOLEAN
--LOB 	        CLOB, BLOB - 
  --(Large Obj) - used to store big data (text, images, files)
  
  -- LOB = Large Object
--Types with full forms:
--BLOB → Binary Large Object (images, videos)
--CLOB → Character Large Object (text)
--NCLOB → National Character Large Object (Unicode text)
--BFILE → Binary File (external file, read-only)
--One line:
--LOB types store large data in different formats.