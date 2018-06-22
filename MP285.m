function varargout = MP285(varargin)
% MP285 MATLAB code for MP285.fig
%      MP285, by itself, creates a new MP285 or raises the existing
%      singleton*.
%
%      H = MP285 returns the handle to a new MP285 or the handle to
%      the existing singleton*.
%
%      MP285('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MP285.M with the given input arguments.
%
%      MP285('Property','Value',...) creates a new MP285 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MP285_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MP285_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MP285

% Last Modified by GUIDE v2.5 22-Jun-2018 12:19:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MP285_OpeningFcn, ...
                   'gui_OutputFcn',  @MP285_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MP285 is made visible.
function MP285_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MP285 (see VARARGIN)

% Choose default command line output for MP285
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MP285 wait for user response (see UIRESUME)
% uiwait(handles.MP285);


% --- Outputs from this function are returned to the command line.
function varargout = MP285_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function port_Callback(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of port as text
%        str2double(get(hObject,'String')) returns contents of port as a double
    global state
    genericCallback(hObject);
    port=instrfind('Port',state.motor.port);
	if length(port) > 0
		fclose(port); 
		delete(port);
    end
    try
        state.motor.object = sutterMP285(state.motor.port);
    catch
        state.motor.connectionStatus='inactive';
        updateGUIByGlobal('state.motor.connectionStatus');
        disp('*** Connection failure: incorrect COM port? ***');
    end       
    state.motor.connectionStatus='connected';
    updateGUIByGlobal('state.motor.connectionStatus');
    xyz_um = getPosition(state.motor.object);
    state.motor.currentZ = xyz_um(3);
    updateGUIByGlobal('state.motor.currentZ');
    


% --- Executes during object creation, after setting all properties.
function port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function velocity_Callback(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocity as text
%        str2double(get(hObject,'String')) returns contents of velocity as a double
    global state
    genericCallback(hObject);
    setVelocity(state.motor.object, state.motor.velocity, state.motor.vScaleFactor);
    getStatus(state.motor.object);


% --- Executes during object creation, after setting all properties.
function velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function currentZ_Callback(hObject, eventdata, handles)
% hObject    handle to currentZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currentZ as text
%        str2double(get(hObject,'String')) returns contents of currentZ as a double


% --- Executes during object creation, after setting all properties.
function currentZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currentZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function requestedZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to requestedZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function requestedZ_Callback(hObject, eventdata, handles)
% hObject    handle to requestedZlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of requestedZlabel as text
%        str2double(get(hObject,'String')) returns contents of requestedZlabel as a double
genericCallback(hObject);


% --- Executes during object creation, after setting all properties.
function requestedZlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to requestedZlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in enableStop.
function enableStop_Callback(hObject, eventdata, handles)
% hObject    handle to enableStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enableStop
    global state gh
    genericCallback(hObject);
    if state.motor.enableStop
        gh.motor.pauseButton.String = 'stop';
    else
        switch state.motor.actionFlag
            case 'moving'
                gh.motor.pauseButton.String = 'pause';
            case 'paused'
                gh.motor.pauseButton.String = 'resume';
        end
    end

% --- Executes on button press in moveButton.
function moveButton_Callback(hObject, eventdata, handles)
% hObject    handle to moveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global state
    switch state.motor.actionFlag
        case 'stopped'
            state.motor.actionFlag = 'moving';
            updateGUIByGlobal('state.motor.actionFlag'); % moveByIncrements should now stop move
            moveByIncrements;
    end
    


function CloseFunction(hObject, eventdata, handles)
% is called when window is closed
    global state
% close connection to Sutter
    port=instrfind('Port',state.motor.port);
	if length(port) > 0
		fclose(port); 
		delete(port);
    end


% --- Executes on button press in pauseButton.
function pauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to pauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global state gh

    switch state.motor.actionFlag
        case 'moving'
            if state.motor.enableStop
                state.motor.actionFlag = 'stopped';
                updateGUIByGlobal('state.motor.actionFlag'); % moveByIncrements should now stop move
                state.motor.enableStop = 0; % reset stop flag
                updateGUIByGlobal('state.motor.enableStop');
                gh.motor.pauseButton.String = 'pause';
                stop(state.motor.object); % stop MP285
            else
                state.motor.actionFlag = 'paused';
                updateGUIByGlobal('state.motor.actionFlag'); % moveByIncrements should now pause move
                gh.motor.pauseButton.String = 'resume';
            end
        case 'paused'
            if state.motor.enableStop
                state.motor.actionFlag = 'stopped';
                updateGUIByGlobal('state.motor.actionFlag'); % moveByIncrements should now stop move
                state.motor.enableStop = 0; % reset stop flag
                updateGUIByGlobal('state.motor.enableStop');
                gh.motor.pauseButton.String = 'pause';
                stop(state.motor.object); % stop MP285
            else
                state.motor.actionFlag = 'moving';
                updateGUIByGlobal('state.motor.actionFlag'); % moveByIncrements should now resume move
                gh.motor.pauseButton.String = 'pause';
            end       
    end
        
