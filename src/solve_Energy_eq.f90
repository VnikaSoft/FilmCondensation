    SUBROUTINE solve_Energy_eq(TI,T_n,NI,NJ,U_big,V_BIG,I,J,AT,x_ksi,y_eta)
    IMPLICIT NONE
    INTEGER,PARAMETER:: KIND = 8 ! kind date
    INTEGER I,J,NI,NJ
    REAL AT, DT_Dksi, DT_Deta,ERRO_T,TAU_top,TAU_bottom,x_ksi
    REAL (KIND) TI(NJ),T_n(NI,NJ),y_eta(NJ),A(NJ),B(NJ),C(NJ),D(NJ),U_big(NJ),V_big(NJ)

    
    J = 2
    TAU_bottom = AT * x_ksi * 0.5 * (1.0/y_eta(J-1) + 1.0/y_eta(J)) 
    do J = 2,NJ-1
    DT_Dksi = TI(J) - T_n(I-1,J)
    DT_Deta = 0.5 * (TI(J+1) - TI(J-1))

    TAU_top = AT * x_ksi * 0.5 * (1.0/y_eta(J+1) + 1.0/y_eta(J)) 

    A(J) =  - TAU_bottom
    C(J) =  - TAU_top
    B(J) = U_big(J) - (A(J) + C(J))
    A(J) = A(J) - 0.5 * V_big(J)
    C(J) = C(J) + 0.5 * V_big(J)

    D(J) = - ( U_big(J) * DT_Dksi + V_big(J) * DT_Deta                                      &
            - (TAU_top * (TI(J+1) - TI(J)) - TAU_bottom * (TI(J) - TI(J-1)) ) )         
    ERRO_T = AMAX1 (ERRO_T, ABS( D(J)) /                                                    &
                (2.0*(ABS( U_big(J)) + ABS( V_BIG(J)) + 2.0*ABS(TAU_top)) * ABS(TI(J)) ) )

    TAU_bottom = TAU_top

    enddo

    J = 1;   A(J) =  0.0;   B(J) = 1.0;  C(J) = 0.0;    D(J) = 0.0;             ! wall       (T=TWall)
    J = NJ;  A(J) =  0.0;   B(J) = 1.0;  C(J) = 0.0;    D(J) = 0.0;             ! interface  (T=TInterface)

    Call gauss3(A,B,C,D,NJ)

    TI(:) = TI(:) + D(:)

    END SUBROUTINE solve_Energy_eq