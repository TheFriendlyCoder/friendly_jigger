#!/bin/bash -e
# Default threshold to 80% if not provided
threshold=${1:-0.8}

# extract the line-rate attribute from the report which has a decimal
# representation of the coverage persent (ie: line-rate="0.175")
rate=`xpath -e //coverage/@line-rate $PWD/coverage/**/coverage.cobertura.xml 2>/dev/null`

# Extract the numeric value from the line rate attribute
# split on the = and keep the second token (quoted number)
rate=${rate#*=}  

# 2 different ways here to remove the surrounding quotes
# from the numeric value
#rate=${rate%\"}
#rate=${rate#\"}
rate=`echo $rate | tr -d '"'`

# perform a decimal numeric comparison to see if the rate
# is above the specified threshold
if (( `echo "$rate < $threshold" | bc -l` )); then 
    echo "Coverage below threshold $rate"
	exit 1
fi
