--Advantages of PL/SQL
--  1. Reduced Network Traffic
--        Entire block sent at once → faster

--  2. Better Performance
--        Less context switching
--        Faster execution

--  3. Error Handling
--        Built-in EXCEPTION block
--        Prevents crashes

--  4. Modularity
--        Procedures
--        Functions
--        Reusable code

--  5. Security
--        Hide logic using packages
--        No direct table access

--  6. Tight Integration with SQL
--        SQL + Programming together

--  7. Maintainability
--        Clean structure
--        Easy updates


--** Support for SQL
   -- means PL/SQL can directly use SQL inside code

DECLARE
   v_sal NUMBER;
BEGIN
    SELECT salary INTO v_sal
    FROM xxdn_emp
    WHERE emp_id = 3;
      DBMS_OUTPUT.PUT_LINE(v_sal);
END;

--EX
DECLARE 
      v_sal NUMBER;
BEGIN
      SELECT salary INTO v_sal
      FROM xxdn_emp
      WHERE emp_id = 3;
      
      IF NVL(v_sal,0) > 5000 THEN
         DBMS_OUTPUT.PUT_LINE('HIGH');
      ELSE
         DBMS_OUTPUT.PUT_LINE('LOW');
      END IF;
END;


--
DECLARE 
      v_sal xxdn_emp.salary%TYPE;
BEGIN
      SELECT salary INTO v_sal
      FROM xxdn_emp
      WHERE emp_id = 4;
      
      IF v_sal IS NULL THEN
         DBMS_OUTPUT.PUT_LINE('NO SALARY');
      ELSIF v_sal > 8000 THEN
         DBMS_OUTPUT.PUT_LINE('VERY HIGH');
      ELSE
         DBMS_OUTPUT.PUT_LINE('NORMAL');
      END IF;
END;


--**Identify Benefits of PL/SQL Subprograms

--Ex
CREATE OR REPLACE FUNCTION get_bonus (p_sal NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN p_sal * 0.1;
END; 

--above ex usage

DECLARE
   v_bonus NUMBER;
BEGIN
   v_bonus := get_bonus(5000);
   DBMS_OUTPUT.PUT_LINE(v_bonus);
END;


--FUNCTION
CREATE OR REPLACE FUNCTION calc_bonus (p_sal NUMBER)
RETURN NUMBER
IS
BEGIN
    IF p_sal IS NULL THEN
       RETURN 0;
    ELSIF p_sal > 8000 THEN
       RETURN p_sal * 0.2;
    ELSE 
       RETURN p_sal * 0.1;
    END IF;
END;

--USAGE

DECLARE
      v_bonus NUMBER;
BEGIN
    v_bonus := calc_bonus(9000);
    DBMS_OUTPUT.PUT_LINE(v_bonus);
END;

--Function = reusable logic that always returns a value

--fucntion created
CREATE OR REPLACE FUNCTION calc_bonus(e_sal NUMBER)
RETURN NUMBER
IS

BEGIN
     IF e_sal IS NULL THEN 
         RETURN 0;
     ELSIF e_sal > 8000 THEN
         RETURN e_sal * 0.2;
     ELSE 
         RETURN e_sal*0.1;
     END IF;
END;

--usage
DECLARE 
      v_sal xxdn_emp.salary%TYPE;
      e_bonus xxdn_emp.salary%TYPE;
BEGIN
      SELECT salary INTO v_sal
      FROM xxdn_emp
      WHERE emp_id = 5;
      
      e_bonus := calc_bonus(v_sal);
      DBMS_OUTPUT.PUT_LINE(e_bonus);
END;


--** Overview of Types of PL/SQL Blocks

--  1. Anonymous Block 
--     No name
--     Not stored
--     One-time use

--  2. Named Block
--     Stored in DB
--     Reusable
--      Examples:
--        Procedures
--        Functions

--  3. Nested Block
--      Block inside block

--Anonymous Block

SET SERVEROUTPUT ON;

DECLARE
    e_name xxdn_emp.emp_name%TYPE;
    e_id xxdn_emp.emp_id%TYPE;
BEGIN
     SELECT emp_id,emp_name INTO e_id,e_name
     FROM xxdn_emp
     WHERE emp_id = 2;
     
     DBMS_OUTPUT.PUT_LINE(e_id || ' - ' || e_name);
END;



--***[Support for Object-Oriented Programming (OOP)]***

--packages → group related code
--Hide data → expose only required parts

--Package = class
--Procedure/Function = methods
--Variables = data


--Better Performance
--  PL/SQL is faster:-
--    Entire block sent to DB once
--    Less context switching
--    Precompiled code


--Higher Productivity
--Reusable code (functions/procedures)
--Less code repetition
--Faster development


--Full Portability
--Same PL/SQL code works on different Oracle systems


--Tight Integration with SQL
--SQL + PL/SQL work seamlessly


--Tight Security
--Hide logic using:
--Functions
--Packages
--No direct table access


---***[Fundamentals of PL/SQL]***

DECLARE
   -- declarations
BEGIN
   -- executable statements
EXCEPTION
   -- error handling
END;

--ex

DECLARE
     v_num NUMBER:= 10;
BEGIN
     DBMS_OUTPUT.PUT_LINE(v_num);
--EXCEPTION
END;


--nested blocks

BEGIN
    DECLARE
        v_num NUMBER:=10;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_num);
    END;
END;
/

--Important Syntax Rules
--Must close:
--   IF → END IF;
--   LOOP → END LOOP;

--Memory Shortcut
--Block = DECLARE → BEGIN → EXCEPTION → END



--**Character Set + Lexical Units**
--    PL/SQL code is made of small pieces = lexical units


--Types:
--Identifiers → variable names
--Literals → values
--Delimiters → symbols (; , :=)
--Keywords → reserved words (BEGIN, IF)

SET SERVEROUTPUT ON;
DECLARE
    v_job VARCHAR2(10) := 'MANAGER';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_job);
END;



--**Identifiers + Literals**

--Identifier Rules (VERY IMPORTANT)
--Must start with letter
--Can contain:
--   letters
--   numbers
--   _ (underscore)
--   No spaces
--   Cannot use keywords (BEGIN, SELECT)


--Literals

--'JOHN'     -- string
--100        -- number
--SYSDATE    -- date (function)


DECLARE
   v_name VARCHAR2(20) := 'SMITH';
   v_salary NUMBER := 7000;
BEGIN
   DBMS_OUTPUT.PUT_LINE(v_name || ' earns ' || v_salary);
END;


--**Comments + Declarations

-- this is comment

/* this is
   multi-line */
   
--   Declarations (Advanced usage)

v_num NUMBER DEFAULT 10;

--   Not Null\

v_num NUMBER NOT NULL := 10; --Must assign value


DECLARE
     v_count NUMBER DEFAULT 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_count);
    --one line commment
END;



--** %TYPE and %ROWTYPE **

--%TYPE
--
--👉 Takes datatype from table column
--
--v_sal xxdn_emp.salary%TYPE;
--
--✔ Safe
--✔ No datatype mismatch



--%ROWTYPE
--
--👉 Takes full row structure
--
--v_emp xxdn_emp%ROWTYPE;
--
--✔ Access like:
--
--v_emp.emp_name
--v_emp.salary


--ex : %TYPE

DECLARE
   v_name xxdn_emp.emp_name%TYPE;
   
BEGIN
   SELECT emp_name INTO v_name
   FROM xxdn_emp
   WHERE emp_id = 1;
   DBMS_OUTPUT.PUT_LINE(v_name);
END;


-- EX: %ROWTYPE

DECLARE
    v_emp xxdn_emp%ROWTYPE;
BEGIN
    SELECT * INTO v_emp
    FROM xxdn_emp
    WHERE emp_id = 3;
    
    DBMS_OUTPUT.PUT_LINE(v_emp.emp_name || ' - ' || v_emp.salary);
END;

--Important Industry Insight
--%TYPE → use when single column needed
--%ROWTYPE → use when multiple columns / full row needed


--**Restrictions on Declarations + Naming Conventions + Scoping**

--Restrictions
--Cannot declare:
--  duplicate variable names
--  NOT NULL → must initialize
--  Wrong datatype → error


--Naming Conventions (Best Practice)
--v_ → variables
--c_ → constants
--p_ → parameters

--Scope (IMPORTANT)

DECLARE
    v_outer NUMBER := 10;
BEGIN
    DECLARE
      v_inner :=20;
    BEGIN
      DBMS_OUTPUT.PUT_LINE(v_inner);
    END;
    DBMS_OUTPUT.PUT_LINE(v_outer);
END;

