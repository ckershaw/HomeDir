#!/bin/bash
rm -v `find ./  -maxdepth 1 -name "*" -not -name "*.*"  -type f -executable `
