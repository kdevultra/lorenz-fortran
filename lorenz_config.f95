module lorenz_config
implicit none

type parameters
	real :: sigma
	real :: beta
	real :: rho
end type parameters

type init
	real :: x0
	real :: y0
	real :: z0
end type init

type time_config
	real :: t0 = 0.0
	real :: tmax
	real :: dt
end type time_config


! subroutine that will compute the results of the computation

! write a function that will save the results in a csv file

contains

subroutine simulate_lorenz_euler (params, initConds, timeConfig, xs, ys, zs, nb_points)
	
	implicit none
	type (parameters), intent(in) :: params
	type (init), intent(in) :: initConds
	type (time_config), intent(in) :: timeConfig
	
	integer :: nb_points
	real, dimension(nb_points) :: xs, ys, zs
	integer :: i, start=2, finish
	
	finish=nb_points
	
	! initialization of the solutions vectors
	xs(1) = initConds%x0
	ys(1) = initConds%y0
	zs(1) = initConds%z0
	
	! looping
	do i = start, finish
		xs(i) = xs(i-1) + timeConfig%dt * params%sigma * (ys(i-1) - xs(i-1))
                ys(i) = ys(i-1) + timeConfig%dt * ( params%rho * xs(i-1) - ys(i-1) - xs(i-1) * zs(i-1 ) )
                zs(i) = zs(i-1) + timeConfig%dt * ( xs(i-1) * ys(i-1) - params%beta * zs(i-1) )
	end do
	
	return
	
end subroutine simulate_lorenz_euler

subroutine save_solutions_csv(file_name, xs, ys, zs, size, time_configuration)
	
	implicit none
	
	! variables declaration
	character(30) :: file_name
	integer :: size, i
	real :: t=0.0
	real, dimension(size) :: xs, ys, zs
	type (time_config) :: time_configuration
	
	integer :: open_status, write_status 
	
	open(unit=1, status='replace', action='write', iostat=open_status, file=file_name)
	
	if (open_status .gt. 0) stop "Cannot save solutions."
	
	! header
	write(unit=1, fmt='(A, ",", A, ",", A, ",", A)', iostat=write_status) "t", "x", "y", "z"
	
	! body
	do i = 1, size
		write(unit=1, fmt='(F10.4, ",", F10.4, ",", F10.4, ",", F10.4)', iostat=write_status) t, xs(i), ys(i), zs(i)
		t = t + time_configuration%dt
	end do
	
	close(unit=1)
	
	write(*,*) "Solutions saved successfully at ", file_name
end subroutine save_solutions_csv

end module lorenz_config
