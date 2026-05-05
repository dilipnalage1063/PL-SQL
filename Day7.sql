--*** 1. PL/SQL Control Structures ***
--Overview of PL/SQL Control Structures
--   👉 Means : Control how program flows


--Types:
--Type	               Use
--Conditional	  decision (IF, CASE)
--Iterative	      repetition (LOOP)
--Sequential	  jump/control (GOTO, NULL)

--2. Conditional Control
--IF-THEN
  IF v_sal > 5000 THEN
     DBMS_OUTPUT.PUT_LINE('HIGH');
  END IF;
  
--IF-THEN-ELSE
IF condition THEN
   ...
ELSE
   ...
END IF;

--IF-THEN-ELSIF
IF condition1 THEN
   ...
ELSIF condition2 THEN
   ...
ELSE
   ...
END IF;

--CASE Statement
CASE 
    WHEN codition THEN result
    ELSE result
END
--EX:
DBMS_OUTPUT.PUT_LINE(
   CASE
       WHEN v_sal > 8000 THEN 'HIGH'
       ELSE 'LOW'
   END
);

--Guidelines (Important)
--Always close:
     END IF;
--Avoid deep nesting
--Prefer CASE for cleaner logic


--3. Iterative Control
--LOOP (Basic)
LOOP 
    EXIT WHEN condition
END LOOP;

--WHILE LOOP
WHILE condition LOOP
   statements;
END LOOP;


--FOR LOOP 
FOR i IN 1..5 LOOP
  statements;
END LOOP;


--EXIT Statement
EXIT WHEN condition;

--Sequential Control
--GOTO

GOTO label;
<<label>>
--👉 Jump to label
--Avoid in real projects

--NULL Statement
NULL;  -- DO NOTHING

--Key Differences
--Structure	     Use
--IF	        decision
--CASE	        cleaner decision
--LOOP	        repeat
--GOTO	        jump
--NULL	        placeholder

--SELECT * FROM xxdn_emp;

--PRACTICE
--1)
SET SERVEROUTPUT ON;
DECLARE
      v_id xxdn_emp.emp_id%TYPE;
      v_sal xxdn_emp.salary%TYPE;
BEGIN
      SELECT emp_id,salary INTO v_id,v_sal
      FROM xxdn_emp
      WHERE emp_id = 2;
      
      DBMS_OUTPUT.PUT_LINE(
      CASE
          WHEN v_sal >= 6000 THEN 'HIGH'
          ELSE 'LOW'
      END
      );
END;
/


--2)
DECLARE
BEGIN
     FOR i IN 1..5 LOOP
     
       IF i=3 THEN
          CONTINUE;
       END IF;
       
       DBMS_OUTPUT.PUT_LINE(i);
     END LOOP;
END;
/

--Option 2 (If CONTINUE not allowed)

DECLARE
BEGIN
     FOR i IN 1..5 LOOP
        IF i<>3 THEN 
           DBMS_OUTPUT.PUT_LINE(i);
        END IF;
     END LOOP;
END;
/

--🧠 Key Learning
--Concept	        Rule
--Skip iteration	use CONTINUE
--FOR loop	        no EXIT needed
--GOTO	            avoid
--Label	            <<label>> only

