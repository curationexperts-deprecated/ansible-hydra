#!/bin/bash

for F in `find . -type d -name defaults`
do
  G=`find $F -name main.yml`
  echo
  echo $G
  cat $G
done
