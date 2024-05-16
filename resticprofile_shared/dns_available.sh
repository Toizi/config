#!/bin/bash
# checking for 1 minute via resolvectl whether dns is available, exiting with
# 0 if it is and 1 otherwise

for i in {1..10}; do
  resolvectl query google.com >/dev/null 2>&1 && exit 0
  sleep 6
done
exit 1
