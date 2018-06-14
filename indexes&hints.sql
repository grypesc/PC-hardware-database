drop index tab1_idx1;
create index tab1_idx1 on CPU(CORES);
drop index tab1_idx2;
create index tab1_idx2 on CPU(CORES, FREQUENCY);

alter index tab1_idx1 visible;
alter index tab1_idx2 visible;
EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('GRYPESC','CPU');

--index range scan
explain plan for
select CORES from CPU where CORES >=7 order by 1;
select *
from table (dbms_xplan.display);
select count(*)/2001 from CPU where CORES >=7 order by 1;

--index fast full scan
explain plan for
select CORES from CPU where CORES >=6 order by 1;
select *
from table (dbms_xplan.display);
select count(*)/2001 from CPU where CORES >=6 order by 1;



--table access full
EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('GRYPESC','CPU');
explain plan for
select  CORES,  FREQUENCY from CPU where FREQUENCY between 3000 and 4000 and CORES>=7 order by 1;
select *
from table (dbms_xplan.display);
select count(*)/2016 from CPU where FREQUENCY between 3000 and 4000 and CORES>=7 order by 1;

--table access full
EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('GRYPESC','CPU');
explain plan for
select  CORES,  FREQUENCY from CPU where FREQUENCY between 3200 and 4000 and CORES>=6 order by 1;
select *
from table (dbms_xplan.display);
select count(*)/2016 from CPU where FREQUENCY between 3200 and 4000 and CORES>=6 order by 1;




create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on COMPUTER(name);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');
execute dbms_stats.gather_table_stats ('grypesc','COMPUTER');

explain plan for
SELECT 
    a.name, a.cores, b.name
  FROM CPU a, COMPUTER b
  WHERE a.cores>=8 and b.name>=c;
  select *
from table (dbms_xplan.display);

-------------------------HINTY---------------------------------
---merge join
drop index idx1;
drop index idx2;
create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on CPU(FREQUENCY);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');


explain plan for
SELECT 
     a.cores, b.cores, a.name, b.name, a.frequency, b.FREQUENCY
  FROM CPU a, CPU b
  WHERE a.THREADS=4 and b.THREADS>=4 AND a.cores between b.cores-1 and b.cores+1  and a.FREQUENCY between b.FREQUENCY-10 and b.FREQUENCY+1 ;
  select *
from table (dbms_xplan.display);

---nested loops
drop index idx1;
drop index idx2;
create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on CPU(FREQUENCY);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');


explain plan for
SELECT 
     a.cores, b.cores, a.name, b.name, a.frequency, b.FREQUENCY
  FROM CPU a, CPU b
  WHERE a.THREADS=4 and b.THREADS>=4 AND a.cores between b.cores-1 and b.cores+1  and a.FREQUENCY between b.FREQUENCY-10 and b.FREQUENCY+1 and a.ID=4 ;
  select *
from table (dbms_xplan.display);
---hashed join nie udalo mi sie uzyskac poprzez manipulacje warunkami

---wymuszenie hashed a mimo to jest nested loops???
drop index idx1;
drop index idx2;
create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on CPU(FREQUENCY);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');


explain plan for
SELECT  /*+ USE_HASH(a b) */ 
     a.cores, b.cores, a.name, b.name, a.frequency, b.FREQUENCY
  FROM CPU a, CPU b
  WHERE a.THREADS=4 and b.THREADS>=4 AND a.cores between b.cores-1 and b.cores+1  and a.FREQUENCY between b.FREQUENCY-10 and b.FREQUENCY+1 ;
  select *
from table (dbms_xplan.display);


--merge sort wymuszony
drop index idx1;
drop index idx2;
create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on CPU(FREQUENCY);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');


explain plan for
SELECT /*+ USE_MERGE(a b) */ 
     a.cores, b.cores, a.name, b.name, a.frequency, b.FREQUENCY
  FROM CPU a, CPU b
  WHERE a.THREADS=4 and b.THREADS>=4 AND a.cores between b.cores-1 and b.cores+1  and a.FREQUENCY between b.FREQUENCY-10 and b.FREQUENCY+1 and a.ID=4 ;
  select *
from table (dbms_xplan.display);

---nested loops wymuszone
drop index idx1;
drop index idx2;
create index idx1 on CPU(cores);
alter index idx1 visible;
create index idx2 on CPU(FREQUENCY);
alter index idx2 visible;

execute dbms_stats.gather_table_stats ('grypesc','CPU');


explain plan for
SELECT /*+ USE_NL(a b) */
     a.cores, b.cores, a.name, b.name, a.frequency, b.FREQUENCY
  FROM CPU a, CPU b
  WHERE a.THREADS=4 and b.THREADS>=4 AND a.cores between b.cores-1 and b.cores+1  and a.FREQUENCY between b.FREQUENCY-10 and b.FREQUENCY+1 ;
  select *
from table (dbms_xplan.display);