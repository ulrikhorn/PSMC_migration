#!/bin/bash
grep 'positions' | sed s/positions:// | sed s/" "// > temp_ms2psmc/refined_msout.ms
cat temp_ms2psmc/refined_msout.ms
