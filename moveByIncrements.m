function moveByIncrements

    global state gh
    
    
%     
%             actionFlag='stopped'      % {'stopped', 'moving', 'paused'}
%         enableStop=0            Gui gh.MP285.enableStop Numeric 1
% 		currentZ=0				Gui gh.MP285.currentZ   Numeric 1
%         requestedZ=0            Gui gh.MP285.requestedZ Numeric 1
%         stepSize=50             Gui gh.MP285.stepSize   Numeric 1



    requested = state.motor.requestedZ;
    current = getPosition(state.motor.object);
    stepSize = state.motor.stepSize;
    % which way are we going?
    direction = sign(requested - current(3));
    step = stepSize * direction;
    while abs(requested - current(3)) > stepSize
        switch state.motor.actionFlag
            case 'stopped'
                disp('*** MP285 movement stopped ***');
                return % return (exit function)
            case 'paused'
                pause(0.1); % loop continues...
            case 'moving'                
                current = getPosition(state.motor.object);
                state.motor.currentZ = current(3);
                updateGUIByGlobal('state.motor.currentZ');
                nextIncrement = current + [0; 0; step];               
                moveTo(state.motor.object,nextIncrement);
        end
    end