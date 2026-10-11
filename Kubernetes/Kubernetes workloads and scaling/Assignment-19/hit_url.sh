#!/bin/bash

while true;
do
  curl -H "Host: myapp.example.com" http://localhost:80
  sleep 1
done