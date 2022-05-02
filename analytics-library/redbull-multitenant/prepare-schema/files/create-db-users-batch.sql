declare
  l_count number := 1;
  l_username varchar2(100);
  l_password varchar2(100) := 'Oracle_12345';
  l_script clob;
begin
  while l_count <= 40 loop
    l_script := '';
          l_username := 'workshop' || l_count;
          l_script := l_script || '
create user ' || l_username || ' identified by ' || l_password || ';
grant dwrole to ' || l_username || ';
alter user ' || l_username || ' quota unlimited on data;
grant create session to ' || l_username || ';
grant create table to ' || l_username || ';
begin
  ords.enable_schema(p_enabled => true,
    p_schema => ''' || l_username || ''',
    p_url_mapping_type => ''BASE_PATH'',
    p_url_mapping_pattern => ''' || l_username || ''',
    p_auto_rest_auth => true);
  commit;
end;
/
CREATE TABLE ' || l_username || '.RACES
   (	"RACEID" NUMBER(38,0),
	"YEAR" NUMBER(38,0),
	"ROUND" NUMBER(38,0),
	"NAME" VARCHAR2(255),
	"F1DATE" DATE,
	"TIME" VARCHAR2(255),
	"URL" VARCHAR2(500),
	"SCORE" NUMBER,
	"DNF_COUNT" NUMBER,
	"DNF_DUE_TO_ACCIDENT_COUNT" NUMBER,
	"WEATHER" VARCHAR2(500),
	"WEATHER_WET" VARCHAR2(1),
	"CIRCUITREF" VARCHAR2(100),
	"YEAR_C" VARCHAR2(4),
	"RACE_COUNT" NUMBER,
	"NAME_YEAR" VARCHAR2(100),
	"OVERTAKEN_POSITIONS_TOTAL" NUMBER
   );
CREATE TABLE ' || l_username || '.LAP_TIMES
   (	"RACEID" NUMBER(38,0),
	"DRIVERID" NUMBER(38,0),
	"LAP" NUMBER(38,0),
	"POSITION" NUMBER(38,0),
	"MILLISECONDS" NUMBER(38,0),
	"DRIVERREF" VARCHAR2(100),
	"RACE_NAME" VARCHAR2(100),
	"PIT_STOP" VARCHAR2(1),
	"MILLISECONDS_CUMULATIVE" NUMBER,
	"MEDIAN_MILLISECONDS_CUMULATIVE" NUMBER
   );
CREATE TABLE ' || l_username || '.SAFETY_CAR
   (	"YEAR" NUMBER(38,0),
	"RACE" VARCHAR2(128),
	"COUNT" NUMBER(38,0),
	"LAPS" NUMBER(38,0)
   );
CREATE TABLE ' || l_username || '.PIT_STOPS
   (	"RACEID" NUMBER(38,0),
	"DRIVERID" NUMBER(38,0),
	"STOP" NUMBER(38,0),
	"LAP" NUMBER(38,0),
	"TIME" VARCHAR2(255),
	"DURATION" VARCHAR2(255),
	"MILLISECONDS" NUMBER(38,0),
	"DATETIME_PITSTOP" DATE,
	"DRIVERREF" VARCHAR2(100)
   );
CREATE TABLE ' || l_username || '.RESULTS
      (	"RESULTID" NUMBER(38,0),
   	"RACEID" NUMBER(38,0),
   	"DRIVERID" NUMBER(38,0),
   	"CONSTRUCTORID" NUMBER(38,0),
   	"F1NUM" VARCHAR2(10),
   	"GRID" NUMBER(38,0),
   	"POSITION" VARCHAR2(10),
   	"POSITIONTEXT" VARCHAR2(255),
   	"POSITIONORDER" NUMBER(38,0),
   	"POINTS" FLOAT(126),
   	"LAPS" NUMBER(38,0),
   	"TIME" VARCHAR2(255),
   	"MILLISECONDS" VARCHAR2(255),
   	"FASTESTLAP" VARCHAR2(255),
   	"RANK" VARCHAR2(255),
   	"FASTESTLAPTIME" VARCHAR2(255),
   	"FASTESTLAPSPEED" VARCHAR2(255),
   	"STATUSID" NUMBER(38,0),
   	"YEAR" NUMBER,
   	"ROUND" NUMBER,
   	"NAME" VARCHAR2(100),
   	"POINTS_CHAR" VARCHAR2(100)
  );
CREATE TABLE ' || l_username || '.DRIVER_STANDINGS
     (	"DRIVERSTANDINGSID" NUMBER(38,0),
  	"RACEID" NUMBER(38,0),
  	"DRIVERID" NUMBER(38,0),
  	"POINTS" FLOAT(126),
  	"POSITION" NUMBER(38,0),
  	"POSITIONTEXT" VARCHAR2(500),
  	"WINS" NUMBER(38,0),
  	"YEAR" NUMBER,
  	"ROUND" NUMBER,
  	"NAME" VARCHAR2(100),
  	"DRIVERREF" VARCHAR2(100),
  	"FINAL" VARCHAR2(1),
  	"DRIVER_POSITION_BEFORE_RACE" NUMBER,
  	"DRIVER_POINTS_BEFORE_RACE" NUMBER,
  	"POSITION_POINTS_BEFORE_RACE" NUMBER,
  	"POINTS_OF_LOWER_POSITION" NUMBER,
  	"POINTS_OF_LOWER_POSITION_BEFORE_RACE" NUMBER,
  	"DELTA_POINTS_TO_LOWER_POSITION" NUMBER,
  	"DELTA_POINTS_TO_LOWER_POSITION_BEFORE_RACE" NUMBER,
  	"CHANGE_DELTA_BEFORE_AND_AFTER_RACE" NUMBER
  );';
    l_count := l_count + 1;
    dbms_output.put_line(l_script);
  end loop;
end;
