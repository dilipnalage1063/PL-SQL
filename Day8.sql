--Collection: 
   -- ordered group of elements having same datatype.
   -- One variable holding multiple values
   -- Like Array/List
   
   
--** WITHOUT COLLECTION
--v1 := 10;
--v2 := 20;
--v3 := 30;
--
--Hard to manage.
--
--WITH COLLECTION
--numbers(1) := 10;
--numbers(2) := 20;
--numbers(3) := 30;
--
--One structure.
--Multiple values.

--** TYPES OF COLLECTIONS
--
--PDF covers 3 types:
--
--Collection	        Meaning
--Associative Array	    key-value memory collection
--Nested Table	        dynamic collection
--VARRAY	            fixed-size ordered collection


--NESTED TABLE
    -- Resizable array
    -- size - grow/shrink dynamically
    
TYPE num_tab IS TABLE OF NUMBER;

--Example
SET SERVEROUTPUT ON;
DECLARE
     TYPE num_tab IS TABLE OF NUMBER;
     v_nums num_tab;
BEGIN
     v_nums := num_tab();
     v_nums.EXTEND;
     v_nums(1) := 100;
     DBMS_OUTPUT.PUT_LINE(v_nums(1));
END;
/


--NESTED TABLE HANDS-ON
DECLARE
    TYPE num_tab IS TABLE OF NUMBER;
    -- Create collection datatype
    -- which stores NUMBER values
    v_nums num_tab;
    --Create collection variable
    --At this point:
    --v_nums = NULL
    --No memory allocated yet.

BEGIN
    v_nums := num_tab();
    -- Create empty collection object
    -- inside memory
    -- Without this:
    -- error occurs
    v_nums.EXTEND; 
    --Add one empty slot
    --    Index   Value
    --1       empty
    v_nums(1):=10; --
    
    v_nums.EXTEND;
    v_nums(2) := 20;
    
    DBMS_OUTPUT.PUT_LINE(v_nums(1));
    DBMS_OUTPUT.PUT_LINE(v_nums(2));
END;
/

--
