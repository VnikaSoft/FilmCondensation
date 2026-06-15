subroutine mu_t(t, mu) 
implicit none
integer, parameter :: n = 19
integer :: i
real(8) :: mu, t, t_tab(n), mu_tab(n)


t_tab = [0.d0,   25.d0,  50.d0,  75.d0, 100.d0, &
      125.d0, 150.d0, 175.d0, 200.d0, 225.d0, &
      250.d0, 275.d0, 300.d0, 310.d0, 320.d0, &
      330.d0, 340.d0, 350.d0, 360.d0]

mu_tab = [10.d0, 11.d0, 12.d0, 13.d0, 14.d0, &
      15.d0, 16.d0, 17.d0, 18.d0, 19.d0, &
      20.d0, 21.d0, 22.d0, 22.5d0, 23.d0, &
      24.d0, 25.d0, 26.5d0, 28.d0]

do i = 1, n-1
   if (T >= T_tab(i) .and. T < T_tab(i+1)) then
      mu = mu_tab(i) + (mu_tab(i+1)-mu_tab(i)) * (T - T_tab(i)) / (T_tab(i+1)-T_tab(i))
   end if
end do

mu = mu*10e-6/1000.0

end subroutine mu_t

