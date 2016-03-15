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
%%
fclose(intSerial);
delete(intSerial);
clear intSerial;