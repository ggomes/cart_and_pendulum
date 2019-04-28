function observer_gain = design_observer(A,C,observer_poles)

% check obervability
if rank(obsv(A,C))~=4
    error('The system is not observable.')
end

% observer 
observer_gain = place(A',C',observer_poles)';
