#!/bin/bash

geth --$NET --syncmode=$SYNCMODE --http --http.addr=0.0.0.0 --http.port=$HTTP_PORT --http.vhosts=* --port $PORT --http.api web3,eth,net,debug,personal,txpool --txlookuplimit=0 --datadir $DIR