% Artem Avdieiev
% egyaa20@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

if exist('a', 'var')
    clear a;
end

a = arduino; % Define arduino variable

%func1 = temp_monitor(2, 3, a);
%disp(func1);

% % % writeDigitalPin(a, 'd2', 1); % For the sake of test
% % % writeDigitalPin(a, 'd2', 0); % For the sake of test
% % % 
% % % digital_channel = 'd2'; % Define digital channel for further use
% % % blinks_amount = 10; % e.g. blink 10 times
% % % 
% % % for i = 1:blinks_amount % Start 'for loop'
% % %     % Add voltage     
% % %     writeDigitalPin(a, digital_channel, 1); % LED on
% % % 
% % %     pause(0.5); % Pause for 0.5 seconds
% % % 
% % %     % Remove voltage
% % %     writeDigitalPin(a, digital_channel, 0); % LED off
% % % 
% % % 
% % %     pause(0.5); % Pause for 0.5 seconds
% % % end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

%idea => replace jump wire with resistor when connecting to 5V supply; make
%photo
% % % thermistor_channel = 'A1'; % Define digital channel for further use
% % % duration = 600; % Seconds
% % % voltage_values = zeros(duration, 1);
% % % temp_values = zeros(duration, 2);
% % % 
% % % V_zero_deg = 500e-3; % V
% % % temp_coefficient = 10e-3; %V per Celsius
% % % 
% % % for i = 1:duration % Start 'for loop'
% % %     voltage_value = readVoltage(a, thermistor_channel);
% % % 
% % %     disp(voltage_value);
% % %     voltage_values(i) = voltage_value;
% % %     T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient;
% % % 
% % %     temp_values(i, 1) = T_Celsius;
% % %     temp_values(i, 2) = i;
% % % 
% % %     disp(T_Celsius)
% % % 
% % %     pause(1); % Pause for 1 second
% % % end
% % % 
% % % min_temp = min(temp_values);
% % % max_temp = max(temp_values);
% % % avg_temp = mean(temp_values);
% % % 
% % % %convert voltage values into temp values
% % % 
% % % x = temp_values(:, 1);
% % % y = temp_values(:, 2);
% % % 
% % % plot(x, y, 'o-');
% % % 
% % % xlabel('Time, seconds');
% % % ylabel('Temperature, Celsius');
% % % title('Temperature vs Time');
% % % % Display the grid
% % % grid on;
% % % 
% % % data = sprintf('Data logging initiated - 04/04/2024\nLocation - Nottingham\n\nMinute\t0\nTemperature\t%.2f\n\nMinute\t1\nTemperature\t%.2f\n\nMinute\t2\nTemperature\t%.2f\n\nMinute\t3\nTemperature\t%.2f\n\nMinute\t4\nTemperature\t%.2f\n\nMinute\t5\nTemperature\t%.2f\n\nMinute\t6\nTemperature\t%.2f\n\nMinute\t7\nTemperature\t%.2f\n\nMinute\t8\nTemperature\t%.2f\n\nMinute\t9\nTemperature\t%.2f\n\nMinute\t10\nTemperature\t%.2f', temp_values(1, 1), temp_values(60, 1), temp_values(120, 1), temp_values(180, 1), temp_values(240, 1), temp_values(300, 1), temp_values(360, 1), temp_values(420, 1), temp_values(480, 1), temp_values(540, 1), temp_values(600, 1));
% % % 
% % % new_file = fopen(cabin_temperature.txt, "w");
% % % fprintf(new_file, data);
% % % fclose(new_file);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here
