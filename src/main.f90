    Program FILM
    Implicit none
    INTEGER,PARAMETER:: IO = 12, KIND = 8 ! input-output unit, kind date
    INTEGER run_test_1_1,run_test_1_2,run_test_2_1,run_test_3_1,run
    open(IO,FILE='input/settings.txt')
        read(IO,*) run_test_1_1
        read(IO,*) run_test_1_2
    	read(IO,*) run_test_2_1
        read(IO,*) run_test_3_1
        read(IO,*) run
    CLOSE(IO)

    if(run_test_1_1==1) then
	call  test_1_1()
    endif

    if(run_test_1_2==1) then
	call  test_1_2()
    endif

    if(run_test_2_1==1) then
	call  test_2_1()
    endif

    if(run_test_3_1==1) then
	call  test_3_1()
    endif

    if(run==1) then

	write(*, '(A)')       "''''''"
    write(*, '(A)')       "|   |'"
    write(*, '(A)')       "|   |:"
    write(*, '(A)')       "|   |;"
    write(*, '(A)')       "|   | ,"
    write(*, '(A)')       "|   | ,"
    write(*, '(A)')       "|   |  , FilmCondensation v1.0"
    write(*, '(A)')       "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''"

    endif 
    END PROGRAM