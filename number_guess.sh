#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  $PSQL "INSERT INTO users(username) VALUES('$USERNAME')" > /dev/null
  WELCOME="Welcome, $USERNAME! It looks like this is your first time here."
else
  IFS="|" read GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  WELCOME="Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Print the welcome and first prompt in one write so each prompt reads exactly one guess
printf '%s\nGuess the secret number between 1 and 1000:\n' "$WELCOME"
