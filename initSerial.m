%%
%clc;
%clear all;

%Serial = serial('COM4');
Serial = serial('/dev/ttyUSB0');
set(Serial,'Terminator','CR/LF');
set(Serial,'BaudRate',115200);
set(Serial,'DataBits',8);
% set(Serial,'Parity','none');
set(Serial,'StopBits',1);
% set(Serial,'FlowControl','none');
fopen(Serial);
blocking = 0;
moving = 0;

%%
%sudo ln -s /dev/ttyACM0 /dev/ttyS101

intSerial = serial('/dev/ttyS101');

% set(intSerial,'BaudRate',9600);
% set(intSerial,'DataBits',8);
% set(intSerial,'Parity','none');
% set(intSerial,'StopBits',1);


intSerial.BytesAvailableFcnMode = 'terminator';
intSerial.BytesAvailableFcn = @usbCallback;
intSerial.OutputEmptyFcn = @instrcallback;
intSerial.BaudRate = 9600;

fopen(intSerial);
%%
fclose(Serial);
delete(Serial);
clear Serial;

%%
fclose(intSerial);
delete(intSerial);
clear intSerial;
