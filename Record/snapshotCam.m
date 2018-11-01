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
@title           :snapshotCam.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script takes a snapshot from the MRC HighResolution Camera.
%}

function snapshotCam(vidObj)

img = getsnapshot(vidObj);
ROI = vidObj.ROIPosition;
src = getselectedsource(vidObj);
% if strcmp(vidObj.PixelFormat, 'Mono8')
%     img = demosaic(img, 'grbg');
% end

text = { ...
    ['Exposure Time: ' num2str(src.ExposureTime) ' ms'] ...
    ['Gain RGB: ' num2str(src.GainRed) ' ' num2str(src.GainGreen) ' ' num2str(src.GainBlue)] ...
    ['Global Gain: ' num2str(src.GlobalGain)] ...
    ['Resolution: ' num2str(ROI(3)) 'x' num2str(ROI(4))] ...
    ['Offset X: ' num2str(ROI(1))] ...
    ['Offset Y: ' num2str(ROI(2))] ...
    };

position = [ ...
    10 10; ...
    10 43; ...
    10 76; ...
    10 109; ...
    10 142; ...
    10 175; ...
    ];
box_color = {'black'};

vars = insertText(img, position, text, 'FontSize', 18, 'BoxColor',...
    box_color, 'BoxOpacity', 0.2, 'TextColor', 'white');

imshow(vars);
set(gcf, 'Position', get(0, 'Screensize'));
