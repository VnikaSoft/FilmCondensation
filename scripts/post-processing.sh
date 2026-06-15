#!/bin/bash
# cd ../output
# python3 gr_U.py
# python3 gr_TAU-X.py
# python3 gr_H-X.py
# python3 gr_T-Y.py
# python3 gr_Alpha-X.py
cd ../input

run_test_1_1=$(awk 'NR==1 {print $1}' settings.txt)
run_test_1_2=$(awk 'NR==2 {print $1}' settings.txt)
run_test_2_1=$(awk 'NR==3 {print $1}' settings.txt)
run_test_3_1=$(awk 'NR==4 {print $1}' settings.txt)
run_program=$(awk 'NR==5 {print $1}' settings.txt)



if [ "$run_test_1_1" -eq 1 ]; then
    echo "Saving results of run_test_1_1"
    cd ../output/tests/test_1_1
    python3 gr_U-Y.py
    python3 gr_H-X.py
    python3 gr_TAU-X.py
    cd ~/code/FilmCondensation/scripts
fi

if [ "$run_test_1_2" -eq 1 ]; then
    cd ../output/tests/test_1_2
    python3 gr_H-X.py
    cd ~/code/FilmCondensation/scripts
fi

if [ "$run_test_2_1" -eq 1 ]; then
    echo "Saving results of run_test_2_1"
    #
    cd ../output/tests/test_2_1
    python3 gr_Alpha-X.py
    python3 gr_U-Y.py
    python3 gr_T-Y.py
    #
    cd ~/code/FilmCondensation/scripts
fi

if [ "$run_test_3_1" -eq 1 ]; then
    echo "Saving results of run_test_3_1"
    #
    cd ../output/tests/test_3_1
    python3 gr_Alpha-X.py
    python3 gr_U-Y.py
    python3 gr_T-Y.py
    #
    cd ~/code/FilmCondensation/scripts
fi


if [ "$run_program" -eq 1 ]; then
    echo "run_program активен, значение: $run_program"
    cd ~/code/FilmCondensation/scripts
fi
