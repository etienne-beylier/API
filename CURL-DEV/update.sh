curl -X PUT -v -H 'Content-Type: application/json' -H "Authorization: Token token=$1" http://dev-api.owma.ovh/users/$2 -d '{"user": { "firstname": "UPDATE", "pin_code": 1234 } }'