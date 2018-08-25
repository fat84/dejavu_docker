#!/bin/bash

cat <<EOF >/opt/dejavu/dejavu.cnf
{
    "database": {
        "host": "$HOST",
        "user": "$USER",
        "passwd": "$PASSWORD",
        "db": "$DB"
    }
}
EOF

python /opt/dejavu/server.py
