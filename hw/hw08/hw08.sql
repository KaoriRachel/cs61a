CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name as Name, Size as size from dogs, sizes
      where height > min and height <= max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child as dog from parents, dogs where name = parent
      order by -height;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as sib1, b.child as sib2 from parents as a, parents as b
      where a.parent = b.parent and a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT sib1 || " and " || sib2 ||" are " || a.Size ||" siblings" 
      from siblings, size_of_dogs as a, size_of_dogs as b
      where a.Size = b.Size and a.Name = sib1 and b.Name = sib2;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);

insert into stacks_helper select name, height, height, 1 from dogs;
insert into stacks_helper select dogs || ", " || name, stack_height + height,
  height, 2 from stacks_helper, dogs 
  where height > last_height and n = 1;
insert into stacks_helper select dogs || ", " || name, stack_height + height,
  height, 3 from stacks_helper, dogs 
  where height > last_height and n = 2;
insert into stacks_helper select dogs || ", " || name, stack_height + height,
  height, 4 from stacks_helper, dogs 
  where height > last_height and n = 3;



CREATE TABLE stacks AS
  SELECT dogs as dogs_name, stack_height as dogs_height from stacks_helper
        where n = 4 and stack_height >= 170 order by stack_height;


WHERE a.number = 7 and b.'7' = True and a.time = b.time;