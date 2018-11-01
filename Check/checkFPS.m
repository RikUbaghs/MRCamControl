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
@title           :checkFPS.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

Check frame stability over recording.
%}

function checkFPS()

uiopen('*.mat')

% Calculate FPS
ts = vidObj.UserData;
ts = ts(:, 1)';

ts = diff(ts);
FPS = ones(1, length(ts))./ts;

averageFPS = mean(FPS);
stdFPS = std(FPS);

txt = {['mean FPS: ' num2str(averageFPS)], ...
    ['St. dev: ' num2str(stdFPS)]};

% Plot
plot(FPS, 'o-', 'LineWidth', 1)

targetFPS = get(vidObj.DiskLogger, 'FrameRate');
line([1 length(FPS)], [targetFPS targetFPS], ...
    'Color','red')

% Label
text(length(FPS)/20, 50, txt)

axis([1 length(FPS) 0 55])
xlabel('Frame') 
ylabel('Delay (FPS)')