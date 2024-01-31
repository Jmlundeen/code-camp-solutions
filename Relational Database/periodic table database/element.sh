PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  exit
fi
if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
else
  ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'")
fi
if [[ -z $ELEMENT ]]
then
  echo I could not find that element in the database.
  exit
else
  echo "$ELEMENT" | while read ID BAR ATOMIC BAR SYMBOL BAR NAME BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
  do
    echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done 
fi
