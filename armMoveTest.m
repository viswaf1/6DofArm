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
%%
%moves = [ 1250 1200 600 1200 500 ;1250 1500 2200 2200 500];
limits = [500,2500; 500, 1700; 500, 2200; 500, 2500; 500,2500];
nodes = [];
goodPos = [];
count = 0;
touch = 0;
goBack = 0;
posToMove = [1000 1300 1650 1900 500];
setArmPosBlocking(Serial,posToMove);
currentBelief = createInitialBeliefs(limits,3);

touch = 0;
while count < 1000
   if(checkCollandStop(Serial))
       goBack = 1;
       continue;
   end
   currentPos = readArmPos(Serial);
   
   if(~goBack)
       oldPos = posToMove;
       goodPos(end+1,:) = posToMove;
       if(mod(count,4) == 1)
            gotPos = 0;
            while ~gotPos
                dist = calcDist(goodPos(1,:), goodPos(end,:));
                posToMove = getRandomMove(currentPos,limits);
                if(calcDist(goodPos(1,:), posToMove) > dist)
                    gotPos = 1;
                    disp('found good pos');
                end
            end
       else
            posToMove = getRandomMove(currentPos,limits);
       end
   else
       goBack = 0;
       %posToMove =  int16 ((goodPos(end,:))+((currentPos - goodPos(end,:))./2) )
       posToMove = goodPos(end,:);
       %break;
       if(size(goodPos,1) > 2)
           goodPos(end,:) = [];
       end
       setArmPosBlocking(Serial,posToMove);
       
       continue;

   end
   setArmPos(Serial,posToMove);
   
   if(checkCollandStop(Serial))
       goBack = 1;
       continue;
   end
   
   while(~checkMoveComplete(Serial) && goBack == 0)
       if(checkCollandStop(Serial))
            goBack = 1;
       end
   end
   
   count = count + 1;
end
disp('DONE!');
%%
for i = 1:size(goodPos,1)
    setArmPosBlocking(Serial, goodPos(i,:))
end
%%
fclose(Serial);
delete(Serial);
clear Serial;