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
