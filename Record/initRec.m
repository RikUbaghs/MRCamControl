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
@title           :initRec.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :20/09/2018
@version         :1.0

Initialize camera and create environment for dumping output
%}

function initRec(vidObj, folder)

% Set video object
src = getselectedsource(vidObj);
src.PacketSize = 9000;
src.PacketDelay = 500;

vidObj.LoggingMode = 'disk&memory';
vidObj.FramesPerTrigger = Inf;

% Set save folder
saveFolder = [folder '\' datestr(now, 'dd-mm-yy')];

if exist(saveFolder, 'dir') == 0
    mkdir(saveFolder)
end

cd(saveFolder)