#!/bin/bash

keyword="Bespoke"

for i in `seq 1 10`;
do
  HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:80`
  if [ "$HTTP_CODE" == "200" ]; then
    if (curl -s "http://localhost:80" -m 10 | grep "$keyword"); then
            # if the keyword is in the conent
        echo "Successfully pulled root page."
        exit 0;
    fi
  fi
  echo "Attempt to curl endpoint returned HTTP Code $HTTP_CODE. Backing off and retrying."
  sleep 10
done
echo "Server did not come up after expected time. Failing."
exit 1
