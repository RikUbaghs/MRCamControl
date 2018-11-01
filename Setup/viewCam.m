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
@title           :viewCam.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script allows to preview from the MRC HighResolution Camera.
%}

function viewCam(vidObj)

src = getselectedsource(vidObj);

% Auto Settings
src.PacketSize = 9000;
src.PacketDelay = 500;

% Preview
pre = preview(vidObj);
movegui(pre,'northeast');

input = {1};

while ~isempty(input)

    options.WindowStyle = 'normal';

    ROI = vidObj.ROIPosition;
    
    % User Input
    prompt = { ...
        'Global Gain (Max 3):', ...
        'Gain Red (Max 255):', ...
        'Gain Green (Max 255):', ...
        'Gain Blue (Max 255):', ...
        'Exposure Time:', ...
        'Width (Max 1280):', ...
        'Height (Max 960):', ...
        'Offset X:', ...
        'Offset Y:', ...
        'PacketSize:', ...
        'PacketDelay:', ...
        'AutoControl (True/False):'};

    title = 'Cam Control';
    dims = [1 35];
    definput = { ...
        num2str(src.GlobalGain)...
        num2str(src.GainRed) ...
        num2str(src.GainGreen) ...
        num2str(src.GainBlue) ...
        num2str(src.ExposureTime) ...
        num2str(ROI(3)) ...
        num2str(ROI(4)) ...
        num2str(ROI(1)) ...
        num2str(ROI(2)) ...
        num2str(src.PacketSize) ...
        num2str(src.PacketDelay) ...
        src.AutoControl ...
        };
    input = inputdlg(prompt, title, dims, definput, options);

    if ~isempty(input)
        
        if strcmp(input{12}, 'True')
            src.AutoControl = input{12};
            disp('AutoControl On; not all variables have been changed')
        else
            src.GlobalGain = str2double(input{1});
            src.GainRed = str2double(input{2});
            src.GainGreen = str2double(input{3});
            src.GainBlue = str2double(input{4});
            src.ExposureTime = str2double(input{5});
            vidObj.ROIPosition = [str2double(input{8}) ...
                str2double(input{9}) ...
                str2double(input{6}) ...
                str2double(input{7})];
            src.PacketSize = str2double(input{10});
            src.PacketDelay = str2double(input{11});
            src.AutoControl = input{12};
        end
        
    end
    
end

closepreview(vidObj)
