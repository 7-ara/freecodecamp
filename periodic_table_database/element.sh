#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  # check if an integer
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # look for data with atomic number equal to the argument
    ELEMENT_DATA=$($PSQL "SELECT
      atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type
      FROM elements INNER JOIN properties USING(atomic_number)
      INNER JOIN types USING(type_id)
      WHERE atomic_number = $1
    ")
  else
    # look for data with symbol or name equal to the argument
    ELEMENT_DATA=$($PSQL "SELECT
      atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type
      FROM elements INNER JOIN properties USING(atomic_number)
      INNER JOIN types USING(type_id)
      WHERE symbol = '$1' OR name = '$1'
    ")
  fi
  # print message if data is found
  if [[ -z $ELEMENT_DATA ]]
  then
    echo I could not find that element in the database.
  else
    echo "$ELEMENT_DATA" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_PT BAR BOILING_PT BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $(echo $NAME | sed -e 's/^\([a-z]\)/\U\1/') has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
    done
  fi
fi
