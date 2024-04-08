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

    %green: d4
    %red: d2
    %yellow: d7

    green_LED_channel = 'd4';
    red_LED_channel = 'd2';
    yellow_LED_channel = 'd7';
    
    thermistor_channel = 'A1';
    V_zero_deg = 500e-3; % V
    temp_coefficient = 10e-3; %V per Celsius

    time = 0;
    calibration = 0;
    
    data = zeros(0, 2);
    
    while true
        time = time + 1;
        voltage_value = readVoltage(a, thermistor_channel);
        T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient;

        data(time, 1) = T_Celsius;
        data(time, 2) = time;

        if calibration >= 15
            current_temperature = data(time, 1);
            previous_temperature = data(1, 1);

            current_time = data(time, 2);
            previous_time = data(1, 2);

            if time > 30
                previous_temperature = data(time-30, 1);
                previous_time = data(time-30, 2);
            end
            
            rate_of_change_of_temp = (current_temperature-previous_temperature)/(current_time - previous_time);

            temp_prediction_in_5_min = current_temperature + (rate_of_change_of_temp*300);

            rate_of_change_per_minute = rate_of_change_of_temp*60;

            formatted_string = sprintf('Current temperature:\t\t\t\t%.2f\nRate of change of temperature:\t\t%.2f\nRate of change per minute:\t\t\t%.2f\nTemperature predicted in 5 minutes:\t%.2f\n\n', current_temperature, rate_of_change_of_temp, rate_of_change_per_minute, temp_prediction_in_5_min);

            fprintf(formatted_string);


            if rate_of_change_per_minute >= 4
                writeDigitalPin(a, green_LED_channel, 0);
                writeDigitalPin(a, yellow_LED_channel, 0);

                writeDigitalPin(a, red_LED_channel, 1);
            elseif rate_of_change_per_minute <= -4
                writeDigitalPin(a, green_LED_channel, 0);
                writeDigitalPin(a, red_LED_channel, 0);

                writeDigitalPin(a, yellow_LED_channel, 1);
            else
                writeDigitalPin(a, red_LED_channel, 0);
                writeDigitalPin(a, yellow_LED_channel, 0);

                writeDigitalPin(a, green_LED_channel, 1);
            end
        else
            calibration_log = sprintf("\nCALIBRATING THE DATA... WAIT %d SECONDS...\n", 15-calibration);
            fprintf(calibration_log);
            calibration = calibration + 1;

        end
        pause(1);
    end

end