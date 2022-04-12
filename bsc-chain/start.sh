#!/bin/bash

if [ ! -n "$NET" ]; then
  echo "not found NET"
  exit
fi
if [ "$NET" != "mainnet" -a "$NET" != "testnet" ];then
  echo "not match $NET chain"
  exit
fi

if [ ! -d "/app/$NET" ]; then
  mkdir -p /app/$NET
fi
if [ ! -f "/app/$NET/config.toml" ]; then
  cd /app/$NET
  wget -P /app/$NET https://github.com/bnb-chain/bsc/releases/latest/download/$NET.zip
  unzip $NET.zip
  
  sed -i '/HTTPHost = "localhost"/c HTTPHost = "0.0.0.0"' /app/$NET/config.toml
  sed -i '/HTTPHost = "127.0.0.1"/c HTTPHost = "0.0.0.0"' /app/$NET/config.toml
  sed -i '/HTTPPort = 8575/c HTTPPort = 11545' /app/$NET/config.toml
  sed -i '/WSPort = 8576/c WSPort = 11546' /app/$NET/config.toml

  /app/geth_linux --datadir /app/$NET init /app/$NET/genesis.json

  rm $NET.zip
fi
/app/geth_linux --syncmode "$SYNCMODE" --config /app/$NET/config.toml --cache 18000 --port $PORT --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.port $HTTP_PORT --http.api db,eth,net,web3,personal,txpool --rpc.allow-unprotected-txs --txlookuplimit 0 --usb --datadir /app/$NET
