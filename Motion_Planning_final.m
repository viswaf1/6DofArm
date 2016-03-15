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
%%
moves = [ 1250 1200 600 1200 500 ;1250 1500 2200 2200 2000];
data  = [];
for m = 1:size(moves,1)
    done = 0;
    command = '';
    for i = 1:length(moves(m,:))
       command = [command,'#', num2str(i-1), ' P', num2str(moves(m,i)) ];
       if(i == length(moves(m,:)) )
           
           command = strcat(command,' T1000');
       else
           command = [command,' '];
       end
    end
    command
    fprintf(Serial, '%s\r', command);
    count = 0;
    while ~done
        %fprintf(Serial, 'Q\r');
        %fscanf(Serial,
        
        
        fprintf(Serial,'%s\r', 'Q');
        t = fscanf(Serial,'%c',1);
        if(t == '.')
            done = 1;
        end
%         if(mod(count,5) == 1)
%             fprintf(Serial,'%s\r', 'QP 0 QP 1 QP 2 QP 3 QP 4');
%             t = fread(Serial,5,'uint8')
%             %data = [data uint8(t)];
%         end
        count = count + 1;
    end
    fprintf(Serial,'%s\r', 'QP 0 QP 1 QP 2 QP 3 QP 4');
    t = fread(Serial,5,'uint8')
    %data = [data uint8(t)];
    pause(2);
end



% %sending data
% fprintf(Serial,'%s\r','#1 P500  T100');
%  
% fprintf(Serial,'%s\r', '#2 P500  T100');
% pause(0.5);
% 
% fprintf(Serial,'%s\r','#1 P1500  T100');
% fprintf(Serial,'%s\r', '#2 P1500  T100');
% pause(0.5);

%close the serial
% fclose serial;
% delete(Serial)
%clear Serial
%%
for x = 1:4
    fprintf(Serial,'%s\r', 'QP 1');
    %pause(0.5)
    t = fscanf(Serial,'%c',1);
    int8(t)
    
end

%%
fclose(Serial);
delete(Serial);
clear Serial;