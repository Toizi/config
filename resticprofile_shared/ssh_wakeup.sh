#!/bin/bash
echo "Waking up target"

for i in {1..5}
do
  ssh router ether-wake -i br0 BC:5F:F4:36:B6:A1
  if ping -4 -c1 "192.168.50.2" ; then
    echo "Server woken up successfully"
    exit 0
  fi
  sleep 5
done

echo "Wakeup failed"
exit 1
