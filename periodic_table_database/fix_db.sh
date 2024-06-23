#!/bin/bash

# Reset test database
PSQL_SUPERUSER="psql -X --username=postgres --dbname=postgres -t -A -c"
echo $($PSQL_SUPERUSER "DROP DATABASE IF EXISTS periodic_table_test")
#echo $($PSQL_SUPERUSER "CREATE DATABASE periodic_table_test WITH TEMPLATE periodic_table")

#PSQL="psql -X --username=freecodecamp --dbname=periodic_table_test -t -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

echo -e '\n~~~~~ Correction of database ~~~~~\n'

# rename columns of "properties"
echo $($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")
echo $($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")
echo $($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")

# set not null constraints for "properties"
echo $($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")
echo $($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")

# set not null and uniqueness constraints for "elements"
echo $($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
echo $($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")
echo $($PSQL "ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE(symbol)")
echo $($PSQL "ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name)")

# add foreign key to "properties", referencing "elements"
echo $($PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number)")

# insert Fluorine and Neon data if not there
echo $($PSQL "INSERT INTO elements (atomic_number, symbol, name)
  VALUES (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon')
")
echo $($PSQL "INSERT INTO properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius)
  VALUES (9, 'nonmetal', 18.998, -220, -188.1),
  (10, 'nonmetal', 20.18, -248.6, -246.1)
")

# create "types" table
echo $($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR(30) UNIQUE NOT NULL)")

# insert the "type" column data from "properties" into "types"
TYPE_NAMES=$($PSQL "SELECT DISTINCT type FROM properties")
echo "$TYPE_NAMES" | while read TYPE_NAME
do
  # check if type is already in "types"
  TYPE_NAME_IS_ALREADY_ADDED=$($PSQL "SELECT type_id FROM types WHERE type = '$TYPE_NAME'")
  # insert type into "types" if not already in there
  if [[ -z $TYPE_NAME_IS_ALREADY_ADDED ]]
  then
    echo $($PSQL "INSERT INTO types (type) VALUES ('$TYPE_NAME')")
  fi
done

# add "type_id" column to "properties"
echo $($PSQL "ALTER TABLE properties ADD COLUMN type_id INT")

# insert "type_id" data into "properties" from "types"
TYPES=$($PSQL "SELECT type_id, type FROM types")
echo "$TYPES" | while read TYPE_ID BAR TYPE_NAME
do
  echo "$TYPE_ID: $TYPE_NAME"
  # update "type_id" column of "properties" using TYPE_ID and TYPE_NAME
  echo $($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE type = '$TYPE_NAME'")
done

# set not null constraint for "type_id" column of "properties"
echo $($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")

# add foreign key to "properties", referencing "types"
echo $($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id)")

# capitalize first letter of chemical symbols
SYMBOLS=$($PSQL "SELECT atomic_number, symbol FROM elements")
echo "$SYMBOLS" | while read ATOMIC_NUMBER BAR SYMBOL
do
  NEW_SYMBOL="$(echo "$SYMBOL" | sed -e 's/^\([a-z]\)/\U\1/')"
  echo "$ATOMIC_NUMBER: $SYMBOL -> $NEW_SYMBOL"
  echo $($PSQL "UPDATE elements SET symbol = '$NEW_SYMBOL' WHERE atomic_number = $ATOMIC_NUMBER")
done

# set data type of "atomic_mass" column of "properties" to decimal
echo $($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")

# remove trailing zeroes from "atomic_mass" data in "properties"
MASSES=$($PSQL "SELECT atomic_number, atomic_mass FROM properties")
echo "$MASSES" | while read ATOMIC_NUMBER BAR MASS
do
  NEW_MASS="$(echo "$MASS" | sed -e 's/0\+$//')"
  echo "$ATOMIC_NUMBER: $MASS -> $NEW_MASS"
  echo $($PSQL "UPDATE properties SET atomic_mass = $NEW_MASS WHERE atomic_number = $ATOMIC_NUMBER")
done

# remove "type" column from "properties"
echo $($PSQL "ALTER TABLE properties DROP COLUMN type")

# remove non-existent element
echo $($PSQL "DELETE FROM properties WHERE atomic_number = 1000")
echo $($PSQL "DELETE FROM elements WHERE atomic_number = 1000")
