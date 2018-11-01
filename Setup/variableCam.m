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
@title           :variableCam.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script start a GUI to change variables on the MRC HighResolution Camera
through Matlab. It can also restore base values.
%}

function vidObj = variableCam(vidObj, stand)

src = getselectedsource(vidObj);

options.WindowStyle = 'normal';

if stand == 1

    disp('Standard Settings Restored')
    
    src.AutoControl = 'False';
    
    % Standard Settings
    vidObj.ROIPosition = [0 0 1280 960];
    src.GlobalGain = 0;
    src.GainRed = 100;
    src.GainGreen = 100;
    src.GainBlue = 100;
    src.ExposureTime = 50000;
    src.PacketSize = 9000;
    src.PacketDelay = 500;
    
elseif stand == 2
    
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
        try
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
        catch
            error('World is crumbling... Autocontrol is probably on')
        end
    end
end
