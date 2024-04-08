% The function measures the temperature with the help of thermistor. 
% Every second, it receives output voltage from thermistor, which is then
% used to obtain current temperature in Celsius using a formula which is based on certain thermistor parameters.
% It then plots a graph of temperature vs time, which is updated every other second. If the temperature is withing the range of 18-24 °C, the green LED will show a constant light.
% In case if the temperature is greater than 24 °C, the red LED will blink 4 times, pausing for 0.25s in-between.
% After that, another temperature update will be conducted.
% If the temperature is below 18 °C, then the yellow LED will blink 2 times, pausing for 0.5s in-between, and conducting temperature update afterwards.



function monitoring = temp_monitor(a)
    monitoring = true;

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
    
    graph_data = zeros(0, 2);

    xlabel('Time, seconds');
    ylabel('Temperature, Celsius');
    title('Temperature vs Time');

    while true
        time = time + 1;
        voltage_value = readVoltage(a, thermistor_channel);
        T_Celsius = (voltage_value - V_zero_deg) / temp_coefficient;


        graph_data(time, 1) = T_Celsius;
        graph_data(time, 2) = time;

        x = graph_data(:, 2);
        y = graph_data(:, 1);

        plot(x, y, 'o-');
        
        ylim([15, 27]);

        drawnow();

        if T_Celsius > 24
            %red
            
            writeDigitalPin(a, green_LED_channel, 0);
            blink_frequency = 0.25;
            blinking(red_LED_channel, blink_frequency, a);

        elseif T_Celsius < 18
            %yellow
            
            writeDigitalPin(a, green_LED_channel, 0);
            blink_frequency = 0.5;
            blinking(yellow_LED_channel, blink_frequency, a);
        else

            writeDigitalPin(a, green_LED_channel, 1);
            
            pause(1);

        end

    end

end


function x = blinking(LED_channel, blink_frequency, a)
    for i = 1:(1/blink_frequency)
        writeDigitalPin(a, LED_channel, 1);
        writeDigitalPin(a, LED_channel, 0);
        pause(blink_frequency);

        disp('BLINK');
    end
end
