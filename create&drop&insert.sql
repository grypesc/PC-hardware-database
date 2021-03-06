drop table RAM cascade constraints;
drop table CPU cascade constraints;
drop table GRAPHICS_CARD cascade constraints;
drop table REVIEWER cascade constraints;
drop table COMPUTER cascade constraints;
drop table REVIEW cascade constraints;
drop table TEST cascade constraints;

  CREATE TABLE "GRYPESC"."RAM" 
   (	"ID" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"MEM_SIZE" NUMBER, 
	"FREQUENCY" NUMBER, 
	"TYPE" VARCHAR2(20 BYTE), 
	"NAME" VARCHAR2(50 BYTE), 
	"PRODUCER" VARCHAR2(20 BYTE), 
	 CONSTRAINT "PK_RAM" PRIMARY KEY ("ID"),
   );

  CREATE TABLE "GRYPESC"."CPU" 
   (	
    "NAME" VARCHAR2(20 BYTE), 
	"CORES" NUMBER(*,0), 
	"THREADS" NUMBER(*,0), 
	"FREQUENCY" NUMBER(*,0), 
	"PRODUCER" VARCHAR2(20 BYTE), 
	"ID" VARCHAR2(20 BYTE), 
	 CONSTRAINT "IDPK" PRIMARY KEY ("ID"),
  );

 CREATE TABLE "GRYPESC"."GRAPHICS_CARD" 
   (	
    "ID" VARCHAR2(20 BYTE), 
	"GPU" VARCHAR2(20 BYTE), 
	"MEMORY_TYPE" VARCHAR2(20 BYTE), 
	"MEMORY_SIZE" VARCHAR2(20 BYTE), 
	"PRODUCER" VARCHAR2(20 BYTE), 
	"NAME" VARCHAR2(50 BYTE), 
	 CONSTRAINT "PK_ID" PRIMARY KEY ("ID"),
	);

  CREATE TABLE "GRYPESC"."COMPUTER" 
   (	
    "GRAPHICS_CARD" VARCHAR2(20 BYTE), 
	"CPU" VARCHAR2(20 BYTE), 
	"COMPUTER_ID" VARCHAR2(20 BYTE), 
	"RAM" VARCHAR2(20 BYTE), 
	"NAME" VARCHAR2(50 BYTE), 
	 CONSTRAINT "ID" PRIMARY KEY ("COMPUTER_ID"),
	 CONSTRAINT "CPU" FOREIGN KEY ("CPU") REFERENCES "GRYPESC"."CPU" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "FK_GRAPHICS_CARD" FOREIGN KEY ("GRAPHICS_CARD") REFERENCES "GRYPESC"."GRAPHICS_CARD" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "FK_ID" FOREIGN KEY ("RAM") REFERENCES "GRYPESC"."RAM" ("ID") ON DELETE CASCADE ENABLE
   ) ;

     CREATE TABLE "GRYPESC"."REVIEWER" 
   (	
    "ID" VARCHAR2(20 BYTE), 
	"NAME" VARCHAR2(20 BYTE), 
	"SURNAME" VARCHAR2(20 BYTE), 
	"CITY" VARCHAR2(20 BYTE), 
	"GOOD_AT" VARCHAR2(50 BYTE), 
	"COUNTRY" VARCHAR2(20 BYTE), 
	 CONSTRAINT "REVIEWER_ID" PRIMARY KEY ("ID"),

   ) ;

  CREATE TABLE "GRYPESC"."REVIEW" 
   (	
    "REVIEW_ID" VARCHAR2(20 BYTE), 
	"AUTHOR" VARCHAR2(20 BYTE), 
	"REVIEW_DATE" DATE, 
	"DESCRIPTION" VARCHAR2(100 BYTE), 
	"THE_BEST_PC" VARCHAR2 (20 BYTE),
	 CONSTRAINT "REVIEW_ID" PRIMARY KEY ("REVIEW_ID"),
	 CONSTRAINT "AUTHOR" FOREIGN KEY ("AUTHOR") REFERENCES "GRYPESC"."REVIEWER" ("ID") ENABLE
	 CONSTRAINT "THE_BEST_PC" FOREIGN KEY ("THE_BEST_PC") REFERENCES "GRYPESC"."COMPUTER" ("ID") ON DELETE CASCADE ENABLE, 
   ) 


  CREATE TABLE "GRYPESC"."TEST" 
   (	
    "COMPUTER_ID" VARCHAR2(20 BYTE), 
	"CINEBENCH_R15_SINGLE_CORE" NUMBER(20,0), 
	"CINEBENCH_R15_MULTI_CORES" NUMBER(20,0), 
	"CINEBENCH_TOTAL_SCORE" NUMBER(20,0), 
	"BF3_AVERAGE_FPS" NUMBER(20,0), 
	"TEST_ID" VARCHAR2(20 BYTE), 
	"REVIEW_ID" VARCHAR2(20 BYTE), 
	 CONSTRAINT "TEST_ID" PRIMARY KEY ("TEST_ID")
	 CONSTRAINT "COMPUTER_ID" FOREIGN KEY ("COMPUTER_ID") REFERENCES "GRYPESC"."COMPUTER" ("COMPUTER_ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "REVIEW_ID_FK" FOREIGN KEY ("REVIEW_ID") REFERENCES "GRYPESC"."REVIEW" ("REVIEW_ID") ON DELETE CASCADE ENABLE
	);


INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('FX-8350', '4', '8', '4200', 'AMD', '3');
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('Pentium G4600', '2', '2', '3600', 'INTEL', '4');
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('I3-7100', '2', '2', '3900', 'INTEL', '5');
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('I5-8600K', '6', '6', '3600', 'INTEL', '6');
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('Phenom II 955', '4', '4', '3400', 'AMD', '7')
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('Athlon II 255', '2', '2', '3100', 'AMD', '8')
INSERT INTO "GRYPESC"."CPU" (NAME, CORES, THREADS, FREQUENCY, PRODUCER, ID) VALUES ('FX-4300', '2', '4', '4200', 'AMD', '9')


INSERT INTO "GRYPESC"."RAM" (ID, MEM_SIZE, FREQUENCY, TYPE, NAME, PRODUCER) VALUES ('1', '16', '2400', 'DDR4', 'GoodRam Iridium Pro', 'GoodRam')
INSERT INTO "GRYPESC"."RAM" (ID, MEM_SIZE, FREQUENCY, TYPE, NAME, PRODUCER) VALUES ('2', '8', '1866', 'DDR3', 'Viper-X', 'Kingston')
INSERT INTO "GRYPESC"."RAM" (ID, MEM_SIZE, FREQUENCY, TYPE, NAME, PRODUCER) VALUES ('3', '4', '1600', 'DDR3', 'Samsung RAM memory', 'Samsung')
INSERT INTO "GRYPESC"."RAM" (ID, MEM_SIZE, FREQUENCY, TYPE, NAME, PRODUCER) VALUES ('4', '2', '800', 'DDR2', 'Viper-X', 'Kingston')

INSERT INTO "GRYPESC"."GRAPHICS_CARD" (ID, GPU, MEMORY_TYPE, MEMORY_SIZE, PRODUCER, NAME) VALUES ('3', 'GTX960', 'GDDR5', '2', 'MSI', 'MSI Ultimate')
INSERT INTO "GRYPESC"."GRAPHICS_CARD" (ID, GPU, MEMORY_TYPE, MEMORY_SIZE, PRODUCER, NAME) VALUES ('4', 'GTX950', 'GDDR5', '2', 'MSI', 'MSI Conqueror')
INSERT INTO "GRYPESC"."GRAPHICS_CARD" (ID, GPU, MEMORY_TYPE, MEMORY_SIZE, PRODUCER, NAME) VALUES ('5', 'HD7770', 'GDDR5', '1', 'ASUS', 'ASUS Rebel')
INSERT INTO "GRYPESC"."GRAPHICS_CARD" (ID, GPU, MEMORY_TYPE, MEMORY_SIZE, PRODUCER, NAME) VALUES ('6', 'HD7990', 'HBM', '8', 'Zotac', 'Showdown')

INSERT INTO "GRYPESC"."COMPUTER" (GRAPHICS_CARD, CPU, COMPUTER_ID, RAM, NAME) VALUES ('1', '2', '2', '1', 'custom')
INSERT INTO "GRYPESC"."COMPUTER" (GRAPHICS_CARD, CPU, COMPUTER_ID, RAM, NAME) VALUES ('2', '1', '3', '1', 'custom')
INSERT INTO "GRYPESC"."COMPUTER" (GRAPHICS_CARD, CPU, COMPUTER_ID, RAM, NAME) VALUES ('2', '2', '4', '1', 'custom')
INSERT INTO "GRYPESC"."COMPUTER" (GRAPHICS_CARD, CPU, COMPUTER_ID, RAM, NAME) VALUES ('2', '3', '5', '2', 'custom')

INSERT INTO "GRYPESC"."REVIEWER" (ID, NAME, SURNAME, CITY, GOOD_AT, COUNTRY) VALUES ('1', 'Andrzej', 'Rudy', 'Warszawa', 'Water cooling', 'Poland')
INSERT INTO "GRYPESC"."REVIEWER" (ID, NAME, SURNAME, CITY, GOOD_AT, COUNTRY) VALUES ('2', 'Ching', 'Mao', 'Beijing', 'Testing', 'China')
INSERT INTO "GRYPESC"."REVIEWER" (ID, NAME, SURNAME, CITY, GOOD_AT, COUNTRY) VALUES ('3', 'Mark', 'White', 'London', 'Writing felietons', 'U.K.')
INSERT INTO "GRYPESC"."REVIEWER" (ID, NAME, SURNAME, CITY, GOOD_AT, COUNTRY) VALUES ('4', 'Chang', 'Zao', 'Beijing', 'Testing', 'China')

INSERT INTO "GRYPESC"."REVIEW" (REVIEW_ID, AUTHOR, REVIEW_DATE, DESCRIPTION) VALUES ('1', '2', TO_DATE('2018-06-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Best picks for the price.')
INSERT INTO "GRYPESC"."REVIEW" (REVIEW_ID, AUTHOR, REVIEW_DATE, DESCRIPTION) VALUES ('2', '3', TO_DATE('2018-06-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Who wins?')
INSERT INTO "GRYPESC"."REVIEW" (REVIEW_ID, AUTHOR, REVIEW_DATE, DESCRIPTION) VALUES ('3', '1', TO_DATE('2018-06-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'The best CPUS out there.')

INSERT INTO "GRYPESC"."TEST" (COMPUTER_ID, CINEBENCH_R15_SINGLE_CORE, BF3_AVERAGE_FPS, TEST_ID, REVIEW_ID, CPU_TEMPERATURE_STRESS, CINEBENCH_R15_MULTI_CORES) VALUES ('1', '134', '45', '1', '1', '56', '678')
INSERT INTO "GRYPESC"."TEST" (COMPUTER_ID, CINEBENCH_R15_SINGLE_CORE, BF3_AVERAGE_FPS, TEST_ID, REVIEW_ID, CPU_TEMPERATURE_STRESS, CINEBENCH_R15_MULTI_CORES) VALUES ('2', '123', '65', '2', '1', '58', '567')
INSERT INTO "GRYPESC"."TEST" (COMPUTER_ID, CINEBENCH_R15_SINGLE_CORE, BF3_AVERAGE_FPS, TEST_ID, REVIEW_ID, CPU_TEMPERATURE_STRESS, CINEBENCH_R15_MULTI_CORES) VALUES ('3', '99', '34', '3', '1', '68', '345')
INSERT INTO "GRYPESC"."TEST" (COMPUTER_ID, CINEBENCH_R15_SINGLE_CORE, BF3_AVERAGE_FPS, TEST_ID, REVIEW_ID, CPU_TEMPERATURE_STRESS, CINEBENCH_R15_MULTI_CORES) VALUES ('2', '123', '53', '4', '2', '58', '445')
INSERT INTO "GRYPESC"."TEST" (COMPUTER_ID, CINEBENCH_R15_SINGLE_CORE, BF3_AVERAGE_FPS, TEST_ID, REVIEW_ID, CPU_TEMPERATURE_STRESS, CINEBENCH_R15_MULTI_CORES) VALUES ('3', '156', '66', '5', '2', '48', '678')

