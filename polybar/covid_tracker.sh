#! /usr/bin/bash

# ===================================================================== #
#  file: covid_tracker.sh                                               #
#  Fetch coronavirus progression data from the coronavirus-tracker API  #
#  https://github.com/ExpDev07/coronavirus-tracker-api                  #
# ===================================================================== #

URL="https://coronavirus-tracker-api.herokuapp.com/all"
res=$(curl -sf "$URL")

if [ -z "$res" ]; then
      echo " Impossible to fetch data. "
          return 1
fi

nb_confirmed=$(jq '.["latest"]["confirmed"]' <<< $res)
nb_death=$(jq '.["latest"]["deaths"]' <<< $res)
nb_recovered=$(jq '.["latest"]["recovered"]' <<< $res)

echo "COVID  $nb_confirmed |  $nb_death |  $nb_recovered "
