create or replace PROCEDURE CHOOSE_THE_BEST_PC(x IN number) IS 
   CURSOR test_cur is 
      SELECT COMPUTER_ID, TEST_ID, REVIEW_ID, BF3_AVERAGE_FPS,   CPU_TEMPERATURE_STRESS,  CINEBENCH_R15_MULTI_CORES, CINEBENCH_R15_SINGLE_CORE,  CINEBENCH_TOTAL_SCORE
      FROM TEST
      WHERE REVIEW_ID=x;
    best_score number(20); 
    best_pc number(20); 
    test_row test%rowtype; 
    BEGIN
    best_score:=0;
    best_pc:=0;
         OPEN test_cur; 
            LOOP 
                 FETCH test_cur into test_row; 
                 EXIT WHEN test_cur%notfound; 
                 if (test_row.CINEBENCH_TOTAL_SCORE>best_score) then
                        BEGIN
                         best_score:=test_row.CINEBENCH_TOTAL_SCORE;
                         best_pc:=test_row.COMPUTER_ID;
                        END;
                    end if;
              END LOOP;
         UPDATE REVIEW
        SET THE_BEST_PC = best_pc
        WHERE REVIEW_ID = x; 
    END;
	
	
	
	create or replace PROCEDURE TEST_COUNT_TOTAL_SCORE(x IN number) IS 
    a number; 
    b number; 
    test_row test%rowtype; 
    BEGIN
         SELECT * into test_row
         FROM TEST 
         WHERE TEST_ID = x; 
         a:=test_row.CINEBENCH_R15_SINGLE_CORE;
         b:=test_row.CINEBENCH_R15_MULTI_CORES;         
         UPDATE TEST
        SET CINEBENCH_TOTAL_SCORE = a*b
        WHERE TEST_ID = x; 
    END;
	
	
	
	create or replace PROCEDURE ADDCPU IS 
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	name VARCHAR(20);
	qname NUMBER(38);
	frequency NUMBER(38);
	id VARCHAR2(20);
	cores NUMBER(38);
    threads NUMBER(38);
    producer VARCHAR2(20);
BEGIN

	FOR i IN 1..1000 LOOP
        id:= dbms_random.string('l',15);
        cores:= dbms_random.value(1,8);
        name:=dbms_random.string('l',6);
        threads:= 2*cores;
        producer:='AMD';
        frequency:=dbms_random.value(2000,4000);
		INSERT INTO CPU(ID, NAME, CORES, THREADS, FREQUENCY, PRODUCER) VALUES (id, name, cores, threads, frequency, producer);
	END LOOP;
END ADDCPU;


create or replace PROCEDURE ADDCOMPUTER AS 
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	name TABSTR;
	qname NUMBER(38);
	frequency NUMBER(38);
	id VARCHAR2(20);
	cores NUMBER(38);
    threads NUMBER(38);
    producer VARCHAR2(20);
BEGIN
name := TABSTR ('UGI', 'AES', 'TelepSystems', 'Paccar', 'asddsa', 'asdasdasdasf', 'ehrgerg', 'wefwfw');
	qname := name.count;

		DBMS_OUTPUT.put_line('cos');
	FOR i IN 1..qname LOOP
        id:= dbms_random.string('l',15);
        cores:= dbms_random.value(1,8);
        threads:= 2*cores;
        producer:='AMD';
        frequency:=dbms_random.value(2000,4000);
		DBMS_OUTPUT.put_line(id||', '||name(i));
		INSERT INTO CPU(ID, NAME, CORES, THREADS, FREQUENCY, PRODUCER) VALUES (id, name(i), cores, threads, frequency, producer);
	END LOOP;
END ADDCOMPUTER;


create or replace PROCEDURE ADDRAM AS 
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	producer TABSTR;
    indexx NUMBER (38);
	qname NUMBER(38);
	id VARCHAR2(20);
	frequency NUMBER(38);
    memory_type VARCHAR2(20);
	memory_size NUMBER(38);
    name VARCHAR2(20);
BEGIN
    producer := TABSTR ('Kingston', 'GoodRam', 'Samsung', 'Corsair', 'ADATA', 'G.Skill', 'Patriot', 'AMD');
	qname := producer.count;

	FOR i IN 1..1000 LOOP
        id:= dbms_random.string('l',15);
        memory_size:= dbms_random.value(1,16);
        frequency:=dbms_random.value(2000,3000);
        name:=dbms_random.string('l',6);
        memory_type:= 'DDR4';
        indexx:=dbms_random.value(1,8);        
		INSERT INTO RAM(ID, NAME, FREQUENCY, TYPE, MEM_SIZE, PRODUCER) VALUES (id, name, frequency, memory_type, memory_size, producer(indexx));
        
	END LOOP;
    exception
        when dup_val_on_index then
        dbms_output.put_line('a duplicate primary key');
END ADDRAM;


create or replace PROCEDURE ADDGRAPHICSCARD IS 
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	name TABSTR;
    
	qname NUMBER(38);
	id VARCHAR2(20);
    gpu VARCHAR2(20);
    memory_type VARCHAR2(20);
	memory_size NUMBER(38);
    producer VARCHAR2(20);
BEGIN
name := TABSTR ('UGI', 'AES', 'TelepSystems', 'Paccar', 'asddsa', 'asdasdasdasf', 'ehrgerg', 'wefwfw');
	qname := name.count;

	FOR i IN 1..qname LOOP
        id:= dbms_random.string('l',15);
        memory_size:= dbms_random.value(1,8);
        gpu:= dbms_random.string('l',8);
        producer:='AMD';
        memory_type:= 'GDDR5';
		INSERT INTO GRAPHICS_CARD(ID, NAME, GPU, MEMORY_TYPE, MEMORY_SIZE, PRODUCER) VALUES (id, name(i), gpu, memory_type, memory_size, producer);
	END LOOP;
END ADDGRAPHICSCARD;