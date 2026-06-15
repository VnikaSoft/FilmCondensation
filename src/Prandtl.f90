    SUBROUTINE Prandtl(U,V,L,T,Alpha,X,Y,P,NI,NJ,MAX_NUM_OF_ITERATIONS,EPS,U0,H,dx,dy,R0,H_theor,&
                       g,AT,LAMBDA,heat_phase_transition,console_output,mass_flow_conservation,NU,TAU,&
                       Alpha_corr)
    IMPLICIT NONE
    INTEGER,PARAMETER:: KIND = 8 ! kind date       
    INTEGER NI,NJ,MAX_NUM_OF_ITERATIONS,I,J,NUM_OF_ITER_H,NUM_OF_ITER_U,console_output,mass_flow_conservation
    REAL (KIND) dx,U0,H,R0, DH, H_theor,AT,LAMBDA,heat_phase_transition, QI, koef, NU
    REAL (KIND) A_NJm1,B_NJm1,C_NJm1,D_NJm1
    REAL (KIND) EPS,ERRO_U,ERRO_H, DT_Dksi, DT_Deta,U_theor,ERRO_T,Re,psi,dRMS,H_current,L
    REAL (KIND) g,x_ksi, DU_Dksi, DU_Deta, TAU_bottom, TAU_top,Q_THEOR_CORRECTED,TAU_THEOR
    REAL (KIND) , DIMENSION(NI,NJ):: X,Y,dy,Y_n
	REAL (KIND) , DIMENSION(NI,NJ):: U,V,P,T
    REAL (KIND) , DIMENSION(NI):: Alpha,Alpha_corr,TAU
    REAL (KIND) , ALLOCATABLE :: U_n(:,:),V_n(:,:),T_n(:,:),A(:),B(:),C(:),D(:),mass_flow(:),y_eta(:),y_ksi(:),UI_th(:),& 
                                 dTdy(:)
    REAL (KIND) , ALLOCATABLE :: U_big_IM(:),U_big(:),V_big(:),UI(:),VI(:),YI(:),NUI(:),TI(:), FLOW_QI(:),mass_flow_change(:)
    ALLOCATE( U_n(NI,NJ), V_n(NI,NJ), T_n(NI,NJ), U_big(NJ), U_big_IM(NJ), &
          V_big(NJ), UI(NJ), VI(NJ), TI(NJ), YI(NJ), A(NJ), B(NJ), &
          C(NJ), D(NJ), mass_flow(NI), y_eta(NJ), y_ksi(NJ), NUI(NJ), &
          FLOW_QI(NI),mass_flow_change(NI), UI_th(NJ),&
          dTdy(NI))

    TI(1)=T(1,1)
    call  mu_t(TI(1), NUI(1))
    NUI(:)=NUI(1)
    NU=NUI(1)

!========================================================
    I = 1
    UI(:) = U(I,:);  VI(:) = V(I,:);   YI(:) = Y(I,:);   TI(:) = T(I,:);         ! temporary variables in the cross section
		
    J = 1
    y_eta(J) = YI(J+1) - YI(J)
    U_big(J) = y_eta(J) * UI(J)
    mass_flow(I) = 0.5 * U_big(J)
		
    do J = 2,NJ-1
        y_eta(J) = 0.5 * (YI(J+1) - YI(J-1))
        U_big(J) = y_eta(J) * UI(J)
        mass_flow(I) = mass_flow(I) + U_big(J)
    enddo

    J = NJ
    y_eta(J) = YI(J) - YI(J-1)
    U_big(J) = y_eta(J) * UI(J)
    mass_flow(I) = mass_flow(I) + 0.5 * U_big(J)

    U_n(I,:) = UI(:);  V_n(I,:) = VI(:);  Y_n(I,:) = YI(:); T_n(I,:) = TI(:);  ! new variables in the cross section
    U_big_IM = U_big	
	
	Q_THEOR_CORRECTED=U0*H
	H_theor=(3*NUI(1)*Q_THEOR_CORRECTED/g)**(1.0/3.0)
    koef = 0.5*U0*y_eta(1)


!========================================================

	H_current=H
    do I=2,NI

        UI(:) = U(I-1,:);  VI(:) = V(I-1,:);   YI(:) = Y(I-1,:); TI(:)=T(I,:) ! temporary variables in the cross section

        NUM_OF_ITER_H = 1;    ERRO_H = EPS;
        DO WHILE (NUM_OF_ITER_H <= MAX_NUM_OF_ITERATIONS .AND. ERRO_H >= EPS) 
            ERRO_H = 0.0

            NUM_OF_ITER_U = 1;  ERRO_U = EPS;
            DO WHILE (NUM_OF_ITER_U <= MAX_NUM_OF_ITERATIONS .AND. ERRO_U >= EPS) 
            ERRO_U = 0.0

            J = 1
            y_eta(J) = YI(J+1) - YI(J)
            U_big(J) = y_eta(J) * UI(J)

            do J = 2,NJ-1
                y_eta(J) = 0.5 * (YI(J+1) - YI(J-1))
                U_big(J) = y_eta(J) * UI(J)
            enddo

            J = NJ
            y_eta(J) = (YI(J) - YI(J-1))
            U_big(J) = y_eta(J) * UI(J)

            J = 1
            x_ksi = X(I,J) - X(I-1,J) 

            do J = 1,NJ
                y_ksi(J) = YI(J) - Y_n(I-1,J)
                V_big(J) = - y_ksi(J) * UI(J) + x_ksi * VI(J)
            enddo
            

            J = 2

            
            TAU_bottom = x_ksi * 0.5 * (NUI(J-1)/y_eta(J-1) + NUI(J)/y_eta(J)) 

		  
            do J = 2,NJ-1
            
            DU_Dksi = UI(J) - U_n(I-1,J)
            DU_Deta = 0.5 * (UI(J+1) - UI(J-1))

            TAU_top =  x_ksi * 0.5 * (NUI(J+1)/y_eta(J+1) + NUI(J)/y_eta(J)) 
			

            A(J) =  - TAU_bottom
            C(J) =  - TAU_top
            B(J) = - (A(J) + C(J)) + U_big(J)
            A(J) = A(J) - 0.5 * V_big(J)
            C(J) = C(J) + 0.5 * V_big(J)

            D(J) = - ( U_big(J) * DU_Dksi + V_big(J) * DU_Deta - x_ksi * y_eta(J) * g        &
                   - (TAU_top * (UI(J+1) - UI(J)) - TAU_bottom * (UI(J) - UI(J-1)) ) )



            ERRO_U = AMAX1 (ERRO_U, ABS( D(J)) /                                             &
                     (2.0*(ABS( U_big(J)) + ABS( V_BIG(J)) + 2.0*ABS(TAU_top)) * ABS(UI(J)) ) )
		    TAU_bottom = TAU_top
            enddo
          

          J = 1;  A(J) =  0.0; B(J) = 1.0; C(J) = 0.0; D(J) = 0.0;           ! wall
          J = NJ; A(J) = -1.0; B(J) = 1.0; C(J) = 0.0; D(J) = 0.0;           ! interface

          
            A_NJm1 = A(NJ-1)
            B_NJm1 = B(NJ-1)
            C_NJm1 = C(NJ-1)
            D_NJm1 = D(NJ-1)

            A(NJ) = -(4.0 * A_NJm1 + B_NJm1)
            B(NJ) = 3.0 * A_NJm1 - C_NJm1
            C(NJ) = 0.0
            D(NJ) = -D_NJm1

          Call gauss3(A,B,C,D,NJ)

          UI(:) = UI(:) + D(:)

          U_big(:) = Y_eta(:) * UI(:)   


          Do J =2,NJ
            V_big(J) = V_big(J-1) - 0.5 * ( (U_big(J) - U_big_IM(J)) + (U_big(J-1) - U_big_IM(J-1)) )
          EndDo
          Do J =1,NJ
            VI(J) = ( V_big(J) + Y_ksi (J) * UI(J) ) / X_ksi
          EndDo


          NUM_OF_ITER_U = NUM_OF_ITER_U + 1



        ENDDO  !  DO WHILE (UI-VI)


        call solve_Energy_eq(TI,T_n,NI,NJ,U_big,V_BIG,I,J,AT,x_ksi,y_eta)
    

        Re = mass_flow(I)/NUI(1)
        call psi_Re(psi,Re)
        QI = - LAMBDA * (TI(NJ) - TI(NJ-1)) / (  0.5 * (y_eta(NJ) + y_eta(NJ-1)*H_current) )

          
        FLow_QI (I) = QI * x_ksi * L/ heat_phase_transition/R0
          

!-------------------------------------------------------------------------------------v


        H = 0.5 * (Y_eta(1) + Y_eta(NJ) )

        mass_flow(I) = 0.5 * ( U_big(1) + U_big(NJ) ) + koef


        Do J =2,NJ-1
          H = H + Y_eta(J) 
          mass_flow(I) = mass_flow(I) + U_big(J)
        EndDo

        DH = - H * (mass_flow(I) -  (mass_flow(I-1) - FLOW_QI(I) + V_big(1))) / mass_flow(I)

        

        Do J =1,NJ
          YI(J) = YI(J) + DH * (J-1) / (NJ - 1)
        ENDDO


        ERRO_H = ABS(DH)/H
        NUM_OF_ITER_H = NUM_OF_ITER_H + 1

    ENDDO  !  DO WHILE (H)



    U_n(I,:) = UI(:)
    V_n(I,:) = VI(:)
    Y_n(I,:) = YI(:)
    T_n(I,:) = TI(:) 
    U_big_IM(:) = U_big(:)
	  
	  

	
    console_output=1
	if(console_output==1) then
    write(*,*) 'I=', I,'H=', H,'Re=', Re, 'psi=', psi
    endif

    TAU(I)=R0*NUI(1)*(1.0/y_eta(1))*(UI(2)-UI(1))
    TAU(I) = R0 * NUI(1) * ( -3.0*UI(1) + 4.0*UI(2) - UI(3) ) / ( 2.0 * y_eta(1))
    dTdy(I)=(1.0/y_eta(1))*(TI(2) - TI(1))
    Alpha(I)=LAMBDA* dTdy(I)/(TI(NJ)-TI(1))
    Alpha_corr(I)=psi*LAMBDA* dTdy(I)/(TI(NJ)-TI(1))


    enddo    !  do I=2,NI


	TAU_THEOR=R0*g*H_theor
 
	
    U = U_n; V = V_n;  Y = Y_n; T = T_n 


    i=NI

    do j=1,NJ
       UI_th(J)=g/NUI(1)*(-Y(I,J)*Y(I,J)/2.0+H_theor*Y(I,J))
    enddo

    do i = 2, Ni
    mass_flow_change(I) = abs(mass_flow(i) - mass_flow(i-1) - V_big(1))
    if(mass_flow_change(I)<1e-6) then
    mass_flow_conservation = 1
    else
    mass_flow_conservation = 0
    exit
    endif
    end do
	

		
END SUBROUTINE Prandtl


    


