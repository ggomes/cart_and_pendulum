function controller_gain = design_controller(A,B,closed_loop_poles)

% check controllability
if rank(ctrb(A,B))~=4
    error('The system is not controllable.')
end

% controller
controller_gain = place(A,B,closed_loop_poles);
