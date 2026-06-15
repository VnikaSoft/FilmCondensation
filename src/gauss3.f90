!************************************************************************************************      	  
subroutine gauss3(a, b, c, f, ny) 
implicit none
integer :: ny, i
real(8) :: a(ny), b(ny), c(ny), f(ny)
c(1)=c(1)/b(1)
f(1)=f(1)/b(1)
b(1)=1.0d0
do i=2,ny
	b(i)=b(i)-a(i)*c(i-1)
	f(i)=f(i)-a(i)*f(i-1)
	f(i)=f(i)/b(i)
	c(i)=c(i)/b(i)
	b(i)=1.0d0
end do
do i=ny-1,1,-1
	f(i)=f(i)-c(i)*f(i+1)
end do
end subroutine
