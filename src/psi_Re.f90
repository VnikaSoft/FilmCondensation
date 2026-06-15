subroutine psi_Re(psi, Re) 
implicit none
integer, parameter :: n = 8
integer :: i
real(8) :: psi, re, re_tab(n), psi_tab(n)


re_tab = [20.0,   50.0, 100.0, 200.0, 300.0, 500.0, 700.0, 1000.0]

psi_tab = [1.0,   1.1, 1.2, 1.4, 1.6, 1.9, 2.1, 2.45]

do i = 1, n-1
   if (re >= re_tab(i) .and. re < re_tab(i+1)) then
      psi = psi_tab(i) + (psi_tab(i+1)-psi_tab(i)) * (re - re_tab(i)) / (re_tab(i+1)-re_tab(i))
   end if
end do

if(re<=20.0) then
psi = 1.0
endif

end subroutine psi_Re

