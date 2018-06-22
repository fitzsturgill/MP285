function moveToPosition

    global state gh
    
    
%     
%             actionFlag='stopped'      % {'stopped', 'moving', 'paused'}
%         enableStop=0            Gui gh.MP285.enableStop Numeric 1
% 		currentZ=0				Gui gh.MP285.currentZ   Numeric 1
%         requestedZ=0            Gui gh.MP285.requestedZ Numeric 1
%         stepSize=50             Gui gh.MP285.stepSize   Numeric 1



    requested = state.motor.requestedZ;
    current = getPosition(obj);
    current = current(3);
    stepSize = state.motor.stepSize;
    % which way are we going?
    direction = sign(requested - current);
    step = stepSize * direction;
    while abs(requested - current) > stepSize
        switch state.motor.actionFlag;
            case 'stopped'
                
