#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

TRIM_SPACES() {
  echo "$1" | sed -r 's/^ *| *$//g'
}

GET_SERVICE_NAME() {
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")
  TRIM_SPACES "$SERVICE_NAME"
}

GET_CUSTOMER_NAME() {
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$1'")
  TRIM_SPACES "$CUSTOMER_NAME"
}

MAIN_MENU() {
  if [[ ! -z $1 ]]
  then
    echo -e "$1"
  fi

  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE
  do
    echo "$SERVICE_ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED
  SCHEDULE_SERVICE $SERVICE_ID_SELECTED
  return $?
}

SCHEDULE_SERVICE() {
  SERVICE=$(GET_SERVICE_NAME $1)
  if [[ -z $SERVICE ]]
  then
    return 1
  fi
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$(GET_CUSTOMER_NAME $CUSTOMER_PHONE)
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nNo name entered."
      return 1
    else
      INSERT_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  echo -e "\nWhat time would you like your $SERVICE, $CUSTOMER_NAME?"
  read SERVICE_TIME
  if [[ -z $SERVICE_TIME ]]
  then
    echo -e "\nNo time given."
    return 1
  else
    INSERT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $1, '$SERVICE_TIME')")
    if [[ $INSERT_RESULT != 'INSERT 0 1' ]]
    then
      return 1
    else
      echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
      return 0
    fi
  fi
}

echo -e "\n~~~~~ MY SALON ~~~~~\n"
MAIN_MENU "\nWelcome to My Salon, how can I help you?\n"
while [ $? = 1 ]
do
  MAIN_MENU "I could not find that service. What would you like today?"
done
