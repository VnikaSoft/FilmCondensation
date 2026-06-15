    SUBROUTINE test_2_1()
    IMPLICIT NONE
    INTEGER,PARAMETER:: IO = 12, KIND = 8 ! input-output unit, kind date
    INTEGER NI, NJ
    INTEGER I,J, MAX_NUM_OF_ITERATIONS,console_output,mass_flow_conservation
    REAL (kind) L,H,U0,MU,NU,R0,P0,U_theor,g,Psat,AT,LAMBDA,heat_phase_transition
    REAL (kind) dx,CFL,EPS,dx_opt,H_theor,TI,TW,temp
    REAL (kind) ,ALLOCATABLE :: X_Node(:,:),Y_Node(:,:)
    REAL (kind) ,ALLOCATABLE :: U_n(:,:),V_n(:,:),T_n(:,:),Alpha(:),Alpha_corr(:),TAU(:),P_n(:,:),dy(:,:)
    write(*,*) 'Read input file'
    open(IO,FILE='input/tests/input_test_2_1.txt')
    read(IO,*) L
	read(IO,*) H
    read(IO,*) NI, NJ
    read(IO,*) EPS
    read(IO,*) MAX_NUM_OF_ITERATIONS
    read(IO,*) U0
    read(IO,*) MU
    read(IO,*) R0
    read(IO,*) P0
    read(IO,*) TW
    read(IO,*) TI
    CLOSE(IO)
		
    g=9.80665
    AT=1.43e-7                      ! m2/s
    LAMBDA = 0.6                    ! Dj/(s*m*K)
    heat_phase_transition = 2259000 ! Dj/kg
		
    allocate(X_Node(NI,NJ)) ! mesh nodes X-coordinates
    allocate(Y_Node(NI,NJ)) ! mesh nodes Y-coordinates
!----------------- Node variables -----------------------------
    allocate(U_n(NI,NJ))  ! Velocity U
    allocate(V_n(NI,NJ))  ! Velocity V
    allocate(P_n(NI,NJ))  ! Pressure
    allocate(T_n(NI,NJ))  ! Temperature
    allocate(Alpha(NI))
    allocate(Alpha_corr(NI))
    allocate(TAU(NI))
	allocate(dy(NI,NJ))
!----------------- Coordinate of nodes ------------------------

    dx=L/(NI-1)
	DO I=1,NI
        DO J=1,NJ
        dy(I,J)=H/(NJ-1)
        END DO
    END DO

    DO I=1,NI
        DO J=1,NJ
        X_Node(I,J)=(I-1)*dx
        Y_Node(I,J)=(J-1)*dy(I,J)
        END DO
    END DO

!----------------- Parameters ------------------------
    call  mu_t(TW, NU)
    write(*,*) 'TI=', TI
    dx_opt=(dy(1,1)**2)/(NU/U0)
	write(*,*) 'dx_opt=', dx_opt,'NI', int(L/dx_opt)+1
		

!----------------- Initial fields -----------------------------

    DO I=1,NI
        DO J=1,NJ
        U_n(I,J)=U0
        V_n(I,J)=0.0
        P_n(I,J)=P0
        T_n(I,J)=TW
        Alpha(I)=0.0
        ENDDO
    ENDDO

	U_n(:,1)=0.0
    V_n(:,1)=0.0
    T_n(:,NJ)=TI

    call  Prandtl(U_n,V_n,L,T_n,Alpha,X_Node,Y_Node,P_n,NI,NJ,MAX_NUM_OF_ITERATIONS,EPS,U0,H,dx,dy,R0,H_theor,&
                  g,AT,LAMBDA,heat_phase_transition,console_output,mass_flow_conservation,NU,TAU,&
                  Alpha_corr)

    
    J=1
    Open(IO,FILE='output/tests/test_2_1/Alpha-X.txt')
    do i=2,NI
    if(X_Node(I,J)>2e-3) then
    Write(IO,*) Alpha(I), X_Node(I,J), &
               ( R0*R0 * g * heat_phase_transition * LAMBDA**3 &
               / (4.0 * (NU*R0) * (T_n(NI,NJ)-T_n(NI,1)) * X_Node(I,J)) )**0.25
    endif
    enddo
    Close(IO)

    i=NI
    Open(IO,FILE='output/tests/test_2_1/T-Y.txt')
    do j=1,NJ
    Write(IO,*)  Y_Node(I,J),T_n(I,J)
    enddo
    Close(IO)

    Open(IO,FILE='output/tests/test_2_1/U-Y.txt')
    do j=1,NJ
    Write(IO,*)  Y_Node(I,J),U_n(I,J)
    enddo
    Close(IO)
    END SUBROUTINE test_2_1