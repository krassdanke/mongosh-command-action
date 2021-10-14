#!/bin/bash
MONGO_URL=$1
MONGO_CMD=$2

echo "db = connect(process.env.MONGO_URL);" > ./mongo_cmd.js
echo "$MONGO_CMD" >> ./mongo_cmd.js

debugInput=$(cat ./mongo_cmd.js)
echo "::set-output name=input-command::$debugInput"

mongosh --quiet --nodb --file ./mongo_cmd.js > ./out.log

output=$(cat ./out.log)
echo "::set-output name=output::$output"

echo "Logged output:"
echo "=============="
echo "$output"
echo "=============="
echo "End of output"