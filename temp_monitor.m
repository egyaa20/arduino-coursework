% The function measures the temperature with the help of thermistor. 
% Every second, it receives output voltage from thermistor, which is then
% used to obtain current temperature in Celsius using a formula which is based on certain thermistor parameters.
% It then plots a graph of temperature vs time, which is updated every other second. If the temperature is withing the range of 18-24 °C, the green LED will show a constant light.
% In case if the temperature is greater than 24 °C, the red LED will blink 4 times, pausing for 0.25s in-between.
% After that, another temperature update will be conducted.
% If the temperature is below 18 °C, then the yellow LED will blink 2 times, pausing for 0.5s in-between, and conducting temperature update afterwards.



function monitoring = temp_monitor(a)

    green_LED_channel = 'd4'; % Define digital channel for green LED
    red_LED_channel = 'd2';  % Define digital channel for red LED
    yellow_LED_channel = 'd7';  % Define digital channel for yellow LED
    
    thermistor_channel = 'A1'; % Define analog channel for thermistor
    V_zero_deg = 500e-3; % Define V_zero_degree_celsius as thermistor parameter (Volts)
    temp_coefficient = 10e-3; % Define temperature coefficient as thermistor parameter (Volts/°C)

    time = 0; % Set current time to zero seconds
    
    graph_data = zeros(0, 2); % Define matrix for further data collection which will contain temperature in °C and time in seconds

    xlabel('Time, seconds'); % Label the x axis
    ylabel('Temperature, Celsius'); % Label the y axis
    title('Temperature vs Time'); % Add the graph title

    % Enter infinite loop
    while true
        time = time + 1; % Add up time (1 second), in the end of the code there will be a pause for that 1 second
        voltage_value = readVoltage(a, thermistor_channel); % Get voltage output value on thermistor
        T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient; % Convert voltage into temperature (°C)


        graph_data(time, 1) = T_Celsius; % Record temperature value
        graph_data(time, 2) = time; % Record time value

        x = graph_data(:, 2); % Define x axis on the graph (time)
        y = graph_data(:, 1); % Define x axis on the graph (temperature)

        plot(x, y, 'o-'); % Plot the graph
        
        ylim([15, 27]); % Set y axis limited to values between +15 and +27 so that the graph has good visibility and covers most temperatures
        % x (time) axis remains without limit restrictions to see historical data

        drawnow(); % Update graph every second

        if T_Celsius > 24 % Check if current temperature is greater than +24°C
            %red
            
            writeDigitalPin(a, green_LED_channel, 0);  % Turn off green LED just in case
            blink_frequency = 0.25; % Define blinking frequency
            blinking(red_LED_channel, blink_frequency, a); % Call blinking frequency before proceeding to the next loop iteration

        elseif T_Celsius < 18 % Check if current temperature is less than +18°C
            %yellow
            
            writeDigitalPin(a, green_LED_channel, 0); % Turn off green LED just in case
            blink_frequency = 0.5; % Define blinking frequency
            blinking(yellow_LED_channel, blink_frequency, a); % Call blinking frequency before proceeding to the next loop iteration
        else % Then the temperature is within the range of (+18 to +24) °C

            writeDigitalPin(a, green_LED_channel, 1); % Show constant green LED
            
            pause(1); % Pause for 1 second before the next loop iteration

        end

    end

end


function x = blinking(LED_channel, blink_frequency, a) % Blinking frequency function
    for i = 1:(1/blink_frequency) % 1/blink_frequency gives the required amount of blinks in a single second
        writeDigitalPin(a, LED_channel, 1); % Turn on the LED
        writeDigitalPin(a, LED_channel, 0); % Turn off the LED
        pause(blink_frequency); % Pause for the required amount of time
    end % When the loop ends, exactly 1 second would have passed, so the global while loop can proceed to the next iteration
end
