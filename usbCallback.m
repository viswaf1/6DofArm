function out = usbCallback(val1, obj, eventStruct, val2)

usbSerial = evalin('base', 'intSerial');
Serial = evalin('base', 'Serial');
blocking = evalin('base', 'blocking');
moving = evalin('base', 'moving');
A = fscanf(usbSerial,'%d');
% disp('got usb input')
% A
if(A == 0)
    assignin('base', 'touch', 0);
end
if(A == 1)
    assignin('base', 'touch', 1);
    if(blocking == 0 && moving == 1)
        fprintf(Serial, '%s\r', char(27));
        %disp('stopping');
        assignin('base', 'goBack', 1);
        assignin('base', 'moving', 0);
    end
end
end

