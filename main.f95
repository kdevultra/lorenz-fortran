program main

	use lorenz_config
	implicit none

	! variables declaration
	type (parameters) :: params
	type (init) :: initialConditions
	type (time_config) :: tc
	
	integer :: nb_points
	real, dimension(:), allocatable :: xs, ys, zs
	integer :: xs_alloc_st, ys_alloc_st, zs_alloc_st
	character(30) :: file_name="solutions_lorenz_euler.csv"
	
	! count variable
	integer :: o=1
	
	! define the system's parameters
	params%sigma = 10.0
	params%beta = 8.0/3.0
	params%rho = 28
	
	! define the initial conditions
	initialConditions%x0 = 0.02
	initialConditions%y0 = 0.95
	initialConditions%z0 = 1.12
	
	! define the time discretization
	tc%t0 = 0.0
	tc%tmax = 10.0
	tc%dt = 0.01
	
	! TODO: see this again
	nb_points = tc%tmax / tc%dt
	
	! initialize the solutions's object
	allocate(xs(nb_points), stat=xs_alloc_st)
	if (xs_alloc_st .ne. 0) then
		write(*,*) "From main : x's solution vectors allocation unsuccessful"
	end if

	allocate(ys(nb_points), stat=ys_alloc_st)
	if (ys_alloc_st .ne. 0) then
		write(*,*) "From main : y's' solution vectors allocation unsuccessful"
	end if

	allocate(zs(nb_points), stat=zs_alloc_st)	
	if (zs_alloc_st .ne. 0) then
		write(*,*) "From main : z's' solution vectors allocation unsuccessful"
	end if
	
	! call the function that will compute the result
	call simulate_lorenz_euler(params, initialConditions, tc, xs, ys, zs, nb_points)
	

	! show solutions
	write(*,*) "First 10 values of solutions :"
	
	write(*,*) "xs :"
	do o = 1, 10
		write(*,'(f6.3, 1X)', advance='no') xs(o)
	end do
	write(*,*) ""
	
	write(*,*) "ys :"
	do o = 1, 10
		write(*,'(f6.3, 1X)', advance='no') ys(o)
	end do
	write(*,*) ""
	
	write(*,*) "zs :"
	do o = 1, 10
		write(*,'(f6.3, 1X)', advance='no') zs(o)
	end do
	write(*,*) ""
	
	! save the solution
	call save_solutions_csv(file_name, xs, ys, zs, nb_points, tc)
	
	 ! plot and save the results
	call execute_command_line("python3 plot_solutions_script.py")
	
end program main
