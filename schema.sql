-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

-- DROP TABLE IF EXISTS groceries;

-- Define your schema here:

-- CREATE TABLE groceries (
--   <column definitions go here>
-- );

DROP TABLE IF EXISTS grocery_list;

CREATE TABLE grocery_list (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  amount INTEGER
);
