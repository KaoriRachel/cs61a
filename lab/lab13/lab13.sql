.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" and pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = "blue" and pet = "dog";


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color FROM students AS a, students AS b
  WHERE a.pet = b.pet and a.song = b.song and a.time < b.time;


CREATE TABLE sevens AS
  SELECT seven FROM students AS a, numbers AS b 
    WHERE a.number = 7 and a.time = b.time;



CREATE TABLE favpets AS
  SELECT pet, count(*) as num from students group by pet order by -count(*) limit 10;  


CREATE TABLE dog AS
  SELECT pet, num from favpets where pet = "dog";


CREATE TABLE bluedog_agg AS
  SELECT song, count(*) from bluedog_songs group by song order by -count(*);


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, count(*) from students 
  where seven = "7" group by instructor;

