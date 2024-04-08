% The function measures a temperature using thermistor.
% Every second, there is a temperature update to the data (which stores temperature each second).
% The first 15 seconds is the calibration stage, where data of current temperature is collected to smooth the future work of the function
% After the calibration stage, the function compares every new temperature value with the first measured value, and if the time exceeds 30 seconds, then it compares it to the value 30 seconds before to keep it relevant.
% That comparison is made in order to calculate the rate of change of temperature, so that it is possible to predict the approximate temperature in 5 minutes.
% The function shows all relevant data in console.
% If the rate of change of temperature is within (-4 to +4) °C/min range, the green LED shows constant light, while all others are shut down. 
% If the rate of change of temperature is greater or equal to +4 °C/min, then red LED shows constant light, while all others are shut down
% If the rate of change of temperature is below or equal to -4 °C/min, then yellow LED shows constant light, while all others are shut down.


function predicting = temp_prediction(a)
    
    green_LED_channel = 'd4'; % Define digital channel for green LED
    red_LED_channel = 'd2';  % Define digital channel for red LED
    yellow_LED_channel = 'd7';  % Define digital channel for yellow LED
    
    thermistor_channel = 'A1'; % Define analog channel for thermistor
    V_zero_deg = 500e-3; % Define V_zero_degree_celsius as thermistor parameter (Volts)
    temp_coefficient = 10e-3; % Define temperature coefficient as thermistor parameter (Volts/°C)

    time = 0; % Set current time to zero seconds
    calibration = time; % Set calibration time to current time (zero)
    
    data = zeros(0, 2); % Define matrix for further data collection which will contain temperature in °C and time in seconds
    
    % Enter infinite loop
    while true
        time = time + 1; % Add up time (1 second), in the end of the code there will be a pause for that 1 second
        voltage_value = readVoltage(a, thermistor_channel); % Get voltage output value on thermistor
        T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient; % Convert voltage into temperature (°C)

        data(time, 1) = T_Celsius; % Record temperature value
        data(time, 2) = time; % Record time value

        if calibration >= 15 % Do the calibration check (if the program worked for at least 15 seconds, then data is calibrated)
            current_temperature = data(time, 1); % Define current temperature which was just collected
            previous_temperature = data(1, 1); % Extract the first recorded temperature at the start of calibration phase

            current_time = data(time, 2); % Current time
            previous_time = data(1, 2); % The first recorded temperature was at the first second

            if time > 30 % After certain time it would make less sense to use data from the calibration, check if 30s has passed
                previous_temperature = data(time-30, 1); % Redefine the temperature, take the temperature 30 seconds ago
                previous_time = data(time-30, 2); % Redefine the time, take the time corresponding to the new temperature 
            end
            
            rate_of_change_of_temp = (current_temperature-previous_temperature)/(current_time - previous_time); % Calculate rate of change of temperature [ (Temp_f-Temp_i)/(time_f-time_i) ]

            temp_prediction_in_5_min = current_temperature + (rate_of_change_of_temp*300); % Attempt to predict the temperature in 5 minutes based on current rate of change

            rate_of_change_per_minute = rate_of_change_of_temp*60; % Calculate rate of change per minute by multiplying current rate of change per second by 60 seconds (make that assumption)

            % Format the required data into displayable string
            formatted_string = sprintf('Current temperature:\t\t\t\t%.2f °C\nRate of change of temperature:\t\t%.2f °C/s\nRate of change per minute:\t\t\t%.2f °C/min\nTemperature predicted in 5 minutes:\t%.2f °C\n\n', current_temperature, rate_of_change_of_temp, rate_of_change_per_minute, temp_prediction_in_5_min);

            % Display the data
            fprintf(formatted_string);


            if rate_of_change_per_minute >= 4 % Check if rate of change per minute value is greater than +4 °C/min
                writeDigitalPin(a, green_LED_channel, 0); % Turn off LEDs that are not needed
                writeDigitalPin(a, yellow_LED_channel, 0); % Turn off LEDs that are not needed

                writeDigitalPin(a, red_LED_channel, 1); % Turn on red LED
            elseif rate_of_change_per_minute <= -4 % Check if rate of change per minute value is less than -4 °C/min
                writeDigitalPin(a, green_LED_channel, 0); % Turn off LEDs that are not needed
                writeDigitalPin(a, red_LED_channel, 0); % Turn off LEDs that are not needed

                writeDigitalPin(a, yellow_LED_channel, 1); % Turn on yellow LED
            else % Then the rate of change per minute is within the range of (-4 to +4) °C/min
                writeDigitalPin(a, red_LED_channel, 0); % Turn off LEDs that are not needed
                writeDigitalPin(a, yellow_LED_channel, 0); % Turn off LEDs that are not needed

                writeDigitalPin(a, green_LED_channel, 1); % Turn on green LED
            end
        else
            calibration_log = sprintf("\nCALIBRATING THE DATA... WAIT %d SECONDS...\n", 15-calibration); % Notify user that the data is being calibrated
            fprintf(calibration_log); % Print the message to console
            calibration = calibration + 1; % Add up 1 second to calibration time

        end
        pause(1); % Pause for 1 second before the next loop iteration
    end

end