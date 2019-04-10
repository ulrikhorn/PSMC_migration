#!/bin/bash
msdir/ms 2 1 -t 12000 -r 1600 1000000 -p 6 | grep 'positions' | sed s/positions:// | sed s/" "// > msout.txt
cat msout.txt
