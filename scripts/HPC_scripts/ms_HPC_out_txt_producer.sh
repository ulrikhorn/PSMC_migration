#!/bin/bash
module load ms
ms 2 1 -t 1200 -r 1600 1000000 -p 6 | grep 'positions' | sed s/positions:// | sed s/" "// > msout.txt
cat msout.txt
