create or replace TRIGGER COUNT_CINEBENCH_TOTAL_SCORE 
BEFORE INSERT OR UPDATE ON TEST 
FOR EACH ROW
  BEGIN
    CASE
      WHEN INSERTING OR UPDATING THEN
        BEGIN
        :new.CINEBENCH_TOTAL_SCORE := :new.CINEBENCH_R15_SINGLE_CORE * :new.CINEBENCH_R15_MULTI_CORES;
        END;
    END CASE;
END;


create or replace TRIGGER THE_BEST_PC_IN_A_REVIEW 
AFTER INSERT OR UPDATE ON REVIEW 
FOR EACH ROW
    BEGIN
        CASE
         WHEN INSERTING THEN
             BEGIN
                CHOOSE_THE_BEST_PC(:new.REVIEW_ID );
             END;
        WHEN UPDATING THEN
           BEGIN
              CHOOSE_THE_BEST_PC(:new.REVIEW_ID);
                END;
        END CASE;
--rollback; 
END;


create or replace TRIGGER TRIGGERRAM 
    BEFORE INSERT OR UPDATE ON RAM
    FOR EACH ROW
BEGIN
    case
      when inserting OR updating then
                 IF :new.type = 'DDR3' AND :new.FREQUENCY>=2800 THEN
                 BEGIN
                    DBMS_OUTPUT.put_line('DDR3 ram cannot have so high frequency');
                    :new.FREQUENCY := 2000;
                   END;
                 END IF;

    end case;
END;


create or replace TRIGGER TRIGGERCPU 
    BEFORE INSERT OR UPDATE ON CPU
    FOR EACH ROW
BEGIN
    case
      when inserting OR updating  then
                IF :new.THREADS < :new.CORES THEN
                 BEGIN
                    DBMS_OUTPUT.put_line('CPU cannot have less threads than cores!');
                    :new.THREADS := :new.CORES;
                   END;
                 END IF;
                 
                IF :new.CORES < 1 THEN
                 BEGIN
                    DBMS_OUTPUT.put_line('CPU cannot have less than 1 cores!');
                    :new.CORES := 1;
                   END;
                 END IF;
                 
              IF :new.FREQUENCY <= 100 THEN
                 BEGIN
                    DBMS_OUTPUT.put_line('Minimal frequency is 100 MHz');
                    :new.FREQUENCY := 100;
                   END;
                 END IF;
    end case;
END;