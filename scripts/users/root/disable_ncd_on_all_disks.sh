#!/bin/bash
for i in sd[bc]
do
  echo '1' > /sys/block/$i/device/queue_depth
done
