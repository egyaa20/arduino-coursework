% Artem Avdieiev
% egyaa20@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

if exist('a', 'var') % Check if a is alredy defined in the workspace
    clear a; % If yes, then clear it before defining it again, because otherwise there is error
end

a = arduino; % Define arduino variable

digital_channel = 'd2'; % Define digital channel for further use
blinks_amount = 10; % e.g. blink 10 times

for i = 1:blinks_amount % Start 'for loop'
    % Add voltage     
    writeDigitalPin(a, digital_channel, 1); % LED on

    % Remove voltage
    writeDigitalPin(a, digital_channel, 0); % LED off


    pause(0.5); % Pause for 0.5 seconds
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

thermistor_channel = 'A1'; % Define analog channel for further use
duration = 600; % Define the duration for data reading (Seconds)
temp_values = zeros(duration, 2); % Define vector for temperature values

V_zero_deg = 500e-3; % Define V_zero_degree_celsius as thermistor parameter (Volts)
temp_coefficient = 10e-3; % Define temperature coefficient as thermistor parameter (Volts/°C)

for i = 1:duration % Start 'for' loop
    voltage_value = readVoltage(a, thermistor_channel); % Get voltage output value on thermistor

    T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient; % Convert voltage into temperature (°C)

    temp_values(i, 1) = T_Celsius; % Record temperature value
    temp_values(i, 2) = i; % Record time value

    pause(1); % Pause for 1 second
end

min_temp = min(temp_values); % Get min temperature value
max_temp = max(temp_values); % Get max temperature value
avg_temp = mean(temp_values); % Get average temperature value

x = temp_values(:, 1); % Define x axis on the graph (time)
y = temp_values(:, 2); % Define y axis on the graph (temperature)

plot(x, y, 'o-'); % Plot the graph

xlabel('Time, seconds'); % Label the x axis
ylabel('Temperature, °C'); % Label the y axis
title('Temperature vs Time'); % Add the graph title

grid on; % Display the grid

% Format the recorded data into displayable string
data = sprintf('Data logging initiated - 04/04/2024\nLocation - Nottingham\n\nMinute\t0\nTemperature\t%.2f °C\n\nMinute\t1\nTemperature\t%.2f °C\n\nMinute\t2\nTemperature\t%.2f °C\n\nMinute\t3\nTemperature\t%.2f °C\n\nMinute\t4\nTemperature\t%.2f °C\n\nMinute\t5\nTemperature\t%.2f °C\n\nMinute\t6\nTemperature\t%.2f °C\n\nMinute\t7\nTemperature\t%.2f °C\n\nMinute\t8\nTemperature\t%.2f °C\n\nMinute\t9\nTemperature\t%.2f °C\n\nMinute\t10\nTemperature\t%.2f °C', temp_values(1, 1), temp_values(60, 1), temp_values(120, 1), temp_values(180, 1), temp_values(240, 1), temp_values(300, 1), temp_values(360, 1), temp_values(420, 1), temp_values(480, 1), temp_values(540, 1), temp_values(600, 1));

new_file = fopen(cabin_temperature.txt, "w"); % Create new text file and give the program permission to write in it
fprintf(new_file, data); % Insert previously displayed data into the text file
fclose(new_file); % Close the text file

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a); % Call an external function while passing the arduino variable to it


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

temp_prediction(a); % Call an external function while passing the arduino variable to it


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% The biggest challenge of the project was to actually connect the circuit properly. 
% I struggled to get proper thermistor readings, but figured out that the thermistor was not properly connected, and the problem was fixed. 
% I believe that the temperature values obtained from that particular thermistor are not necessarily accurate enough for aerospace application, but are decent for such project in order to get understanding of how Arduino and temperature measurements work.
% The measurements are accurate enough to accurately tell you that the temperature changes when you put the circuit close to an open fridge or put a finger on thermistor.
% Also, the room temperature measured was within 1°C range from what my room thermometer measured.
% Temperature prediction can sometimes show 0 rate of change per minute because the calculation is dependent on comparing two values, and if they are equal then the rate of change will be zero for both seconds and minutes (since the minutes are derived from rate of change per seconds). 
% There are a few possible solutions to that: either keep comparing other values of temperature until you get non-equal values or take last 60 values and get an average of that.
