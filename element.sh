PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INPUT=$1


if [[ -z $INPUT ]]
then
  echo "Please provide an element as an argument."
elif [[ ! $INPUT =~ ^[0-9]+$ ]]
then
  LENGTH=$(echo -n "$INPUT" | wc -m)
  if [[ $LENGTH -gt 2 ]]
  then
    # get data by full name
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name='$INPUT'")
    if [[ -z $DATA ]]
    then
      echo -e "I could not find that element in the database." 
    else
      echo "$DATA" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do  
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  else
    # get data by symbol
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$INPUT'")
    if [[ -z $DATA ]]
    then
      echo -e "I could not find that element in the database." 
    else
      echo "$DATA" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do  
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  fi
else
  # get data by atomic number
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$INPUT")
  if [[ -z $DATA ]]
    then
      echo -e "I could not find that element in the database." 
    else
      echo "$DATA" | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do  
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi 
fi
