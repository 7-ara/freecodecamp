#!/bin/bash
# Script to create the tables

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Create tables ~~~~~\n"

# Drop existing tables
echo $($PSQL "DROP TABLE IF EXISTS customers, appointments, services CASCADE")

# Create customers table
echo $($PSQL "CREATE TABLE customers(
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(30) NOT NULL
)")

# Create services table
echo $($PSQL "CREATE TABLE services(
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL
)")
echo $($PSQL "INSERT INTO services(name) VALUES ('Cut'), ('Style'), ('Colour'), ('Extensions')")
echo "$($PSQL "SELECT * FROM services")" | while read SERVICE_ID BAR NAME
do
  echo "$SERVICE_ID) $NAME"
done

# Create appointments table
echo $($PSQL "CREATE TABLE appointments(
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers,
  service_id INT NOT NULL REFERENCES services,
  time VARCHAR(20)
)")
