% Copyright 2018 Rik Ubaghs
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%    http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%{
@title           :recordCam.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script allows to record from the MRC HighResolution Camera
through Matlab.
%}

function recordCam(vidObj, duration)
% Initiate Recording
createLog(vidObj)

% Record
start(vidObj)
pause(duration/1000)
stop(vidObj);

% Check for Delayed Frames
while (vidObj.FramesAcquired ~= vidObj.DiskLoggerFrameCount)
    pause(.1)
end

close(vidObj.DiskLogger);

% Save Metadata
name = get(vidObj.DiskLogger, 'Filename');
name = name(1:strfind(name, '.')-1);
save(name, 'vidObj')

% Cleanup
vidObj.UserData = [];
disp('Log Complete')

end

function timeStampFunc(vid, events)

tsVec = vid.UserData;

% Get TS
[~, ts] = getdata(vid, 1); % Relative TS
tsVec(end+1, :) = [ts events.Data.AbsTime(end)]'; % Absolute TS

% Save TS
vid.UserData = tsVec;

end

function createLog(vid)

% Set CallBack
vid.FramesAcquiredFcnCount = 1;
vid.FramesAcquiredFcn = @timeStampFunc;

% Create logfile
logFile = VideoWriter( ...
    ['MRScope_' datestr(now, 'dd-mm-yy_HH-MM-SS') '.avi'], ...
    'Uncompressed AVI');

% Match Framerates
src = getselectedsource(vid);
exposureTime = double(src.ExposureTime);
frameRate = 1/(exposureTime/1000000);
if frameRate > 45
    frameRate = 45;
end
logFile.FrameRate = frameRate;

% Set logfile
vid.DiskLogger = logFile;

end
