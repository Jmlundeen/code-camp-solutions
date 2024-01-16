#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
function insert_team() {
  INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$1')")
  if [[ $INSERT_RESULT = 'INSERT 0 1' ]]
  then
    ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$1'")
    echo $ID
  fi
}
$PSQL "TRUNCATE TABLE games, teams"
$PSQL "ALTER SEQUENCE games_game_id_seq RESTART WITH 1"
$PSQL "ALTER SEQUENCE teams_team_id_seq RESTART WITH 1"
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    #check for winner and opponent id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    if [[ -z $WINNER_ID ]]
    then
      WINNER_ID=$(insert_team "$WINNER")
      echo Added $WINNER to teams
    fi
    if [[ -z $OPPONENT_ID ]]
    then
      OPPONENT_ID=$(insert_team "$OPPONENT")
      echo Added $OPPONENT to teams
    fi
    RESP=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $RESP != 'INSERT 0 1' ]]
    then
      echo Insert failed for $YEAR $WINNER vs. $OPPONENT
    else
      echo Insert Successful for $YEAR $WINNER vs. $OPPONENT
    fi
  fi
done