function moveByIncrements

    global state
    



    requested = state.motor.requestedZ;
    current = getPosition(state.motor.object);
    stepSize = state.motor.stepSize;
    % which way are we going?
    direction = sign(requested - current(3));
    step = stepSize * direction;
    while abs(requested - current(3)) > stepSize
        pause(0.01); % NECESSARY FOR gui CALLBACKS TO EXECUTE AND MODIFY THE ACTION FLAG!!!!! 
        switch state.motor.actionFlag
            case 'stopped'
                disp('*** MP285 movement stopped ***');
                return % return (exit function)
            case 'paused'
            case 'moving'                
                current = getPosition(state.motor.object);
                state.motor.currentZ = current(3);
                updateGUIByGlobal('state.motor.currentZ');
                nextIncrement = current + [0; 0; step];               
                moveTo(state.motor.object,nextIncrement);
        end
    end
