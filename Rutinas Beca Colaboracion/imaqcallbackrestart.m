function imaqcallback(obj, event, varargin)
%IMAQCALLBACK Display event information for the event.
%
%    IMAQCALLBACK(OBJ, EVENT) displays a message which contains the 
%    type of the event, the time of the event and the name of the
%    object which caused the event to occur.  
%
%    If an error event occurs, the error message is also displayed.  
%
%    IMAQCALLBACK is an example callback function. Use this callback 
%    function as a template for writing your own callback function.
%
%    Example:
%       obj = videoinput('winvideo', 1);
%       set(obj, 'StartFcn', {'imaqcallback'});
%       start(obj);
%       wait(obj);
%       delete(obj);
%
%    See also IMAQHELP.
%

%    CP 10-01-02
%    Copyright 2001-2006 The MathWorks, Inc.
%    $Revision: 1.1.6.7 $  $Date: 2006/11/17 13:41:54 $

% Define error identifiers.
errID = 'imaq:imaqcallback:invalidSyntax';
errID2 = 'imaq:imaqcallback:zeroInputs';



switch nargin
    case 0
        error(errID2, imaqgate('privateMsgLookup', errID2));
    case 1
        error(errID, imaqgate('privateMsgLookup', errID));
    case 2
        if ~isa(obj, 'imaqdevice') || ~isa(event, 'struct')
            error(errID, imaqgate('privateMsgLookup', errID));
        end   
        if ~(isfield(event, 'Type') && isfield(event, 'Data'))
            error(errID, imaqgate('privateMsgLookup', errID));
        end
end

% Determine the type of event.
EventType = event.Type;

% Determine the time of the error event.
EventData = event.Data;
EventDataTime = EventData.AbsTime;

% Create a display indicating the type of event, the time of the event and
% the name of the object.
name = get(obj, 'Name');
fprintf('%s event occurred at %s for video input object: %s.\n', ...
    EventType, datestr(EventDataTime,13), name);

% Display the error string.
if strcmpi(EventType, 'error')
    fprintf('%s\n', EventData.Message);
end

start(obj);
