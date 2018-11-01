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
@title           :setupCam.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script sets up the MRC HighResolution Camera before recording.
%}

function vidObj = setupCam(cam)

list = gigecamlist;

if isempty(list)
    error('Camera Not Detected')
end

fprintf('Available Systems: \n \n')
disp(list(:,1:4))

fprintf('Adding: %s \n', list.SerialNumber{cam, end})

vidObj = videoinput('gige', 1, 'Mono8');
src = getselectedsource(vidObj);

src.AutoControl = 'False';
src.PacketSize = 9000;
src.PacketDelay = 500;

disp('Done...')
