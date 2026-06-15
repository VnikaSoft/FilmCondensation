#!/bin/bash
cd ../src
gfortran -o main *.f90
if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi
cd ..
./src/main