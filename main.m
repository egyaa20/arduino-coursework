% Artem Avdieiev
% egyaa20@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

%a = arduino; % Define arduino variable

writeDigitalPin(a, 'd2', 1); % For the sake of test
writeDigitalPin(a, 'd2', 0); % For the sake of test

digital_channel = 'd2'; % Define digital channel for further use
blinks_amount = 10; % e.g. blink 10 times

for i = 1:blinks_amount % Start 'for loop'
    % Add voltage
    writeDigitalPin(a, digital_channel, 1); % LED on
    
    pause(0.5); % Pause for 0.5 seconds
    
    % Remove voltage
    writeDigitalPin(a, digital_channel, 0); % LED off
    
    
    pause(0.5); % Pause for 0.5 seconds
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

% Insert answers here

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here
