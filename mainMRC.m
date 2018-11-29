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
@title           :mainMRC.m
@author          :ru
@contact         :ubaghsr@ethz.ch
@created         :14/09/2018
@version         :1.0

This script is the main scipt to control the MRC HighResolution Camera.
%}

%% Setup Camera

% Clear Environment
close all;
clearvars;
clc

% Setup Camera
source = setupCam(1); % Setup camera

%% Set Variables
source = variableCam(source, 1); % Set variables (1 = reset, 2 = mod)

%% Preview
viewCam(source) % Set and view the effect of the variables on the camera
snapshotCam(source) % Preview a snapshot

%% Record
saveFolder = 'C:\Users\ExcitatoryInhibitory\Desktop\dump';
t = 1000 * 60 * 10;
initRec(source, saveFolder)
recordCam(source, t) % Record to disk (ms)

%% Controls
checkFPS
