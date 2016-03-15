% %clc;
% %clear all;
% 
% %Serial = serial('COM4');
% Serial = serial('/dev/ttyUSB0');
% set(Serial,'Terminator','CR/LF');
% set(Serial,'BaudRate',115200);
% set(Serial,'DataBits',8);
% % set(Serial,'Parity','none');
% set(Serial,'StopBits',1);
% % set(Serial,'FlowControl','none');
% fopen(Serial);
% blocking = 0;
%%
%moves = [ 1250 1200 600 1200 500 ;1250 1500 2200 2200 500];
limits = [500,2500; 500, 2500; 500, 2500; 500, 2500; 500,2500];
controlLimits = [-2, 2; -1, 1; -1, 1; -1, 1; -1, 1].*15;
nodes = [];
goodPos = [];
count = 0;
touch = 0;
goBack = 0;
%posToMove = [1000 1300 1650 1900 500];
posToMove = [1300 1500 1150 1500 1000];
setArmPosBlocking(Serial,posToMove);
currentBelief = createInitialBeliefs(controlLimits,4);
goingBack = 0;
touch = 0;
nodeHitCount = 0;

while count < 3000
   currentPos = readArmPos(Serial);
   if(touch == 1)
       goBack = 1;
   end
   if(~goBack)
       if(goingBack == 0)
            oldPos = posToMove;
            goodPos(end+1,:) = posToMove;
            endNode = size(nodes,2)+1;
            nodes(endNode).pos = currentPos;
            nodeHitCount = 0;
            nodes(endNode).beliefs = currentBelief;
       end
       if(size(nodes,2) > 1 && goingBack == 0)
            currentBelief = updateBelief(currentBelief, currentPos, nodes(endNode-1).pos, 1);           
       end
       
              
       if(mod(count,2) == 1)
            gotPos = 0;
            while ~gotPos
                if( size(nodes,2) < 6)
                    %dist = calcDist(nodes(1).pos, nodes(end).pos);
                    %dist2 = calcDist(posToMove, nodes(1).pos);
                    dist = nodes(end).pos(1) - nodes(1).pos(1);
                    dist2 = posToMove(1) - nodes(1).pos(1);
                else
                    %dist = calcDist(nodes(end-5).pos, nodes(end).pos);
                    %dist2 = calcDist(posToMove, nodes(end-5).pos);
                    dist = nodes(end).pos(1) -nodes(end-5).pos(1) ;
                    dist2 = posToMove(1) - nodes(end-5).pos(1) ;
                end
                posToMove = getRandomMovewithBelief(currentPos,currentBelief,limits);
                %if(calcDist(goodPos(1,:), posToMove) > dist)
                 %   gotPos = 1;
                    %disp('found good pos');
                %end
                if(dist2 > dist)
                    gotPos = 1;
                end
            end
       else
            posToMove = getRandomMovewithBelief(currentPos,currentBelief,limits);
       end
       
       if( goingBack == 0)
           %currentBelief = nodes(end).beliefs;
           for b = 1:size(currentBelief,2)
               %currentBelief(b).plusCount = zeros(1,length(currentBelief(b).plusCount))+1;
               %currentBelief(b).minusCount = zeros(1,length(currentBelief(b).plusCount))+1;
           end
       end
       
           
       %else
           %currentBelief = createInitialBeliefs(controlLimits,4);
       %end
       goingBack = 0;
   else
       goBack = 0;
       goingBack = 1;
       nodeHitCount = nodeHitCount + 1;
       
%        if(nodeHitCount == 1)
%            currentBelief = createInitialBeliefs(controlLimits, size(currentBelief(1).cells,1));
%        end
%        if(nodeHitCount > 5)
%             currentBelief = createInitialBeliefs(controlLimits, size(currentBelief(1).cells,1));
%             disp('resitting Beliefs');
%        end
       if(size(nodes,2) > 1)
           endNode = size(nodes,2)+1;
            currentBelief = updateBelief(currentBelief, posToMove, nodes(endNode-1).pos, 0);
       end
       %disp('Going Back');
       %posToMove =  int16 ((goodPos(end,:))+((currentPos - goodPos(end,:))./2) )
       if(nodeHitCount < 6)
            posToMove = nodes(end).pos;
       else
           posToMove = nodes(end-1).pos;
           if(size(nodes,2) > 1)
                nodes(end) = [];
           end
       end
       
       %break;
       if(size(nodes,2) > 1)
            nodes(end).beliefs = currentBelief;
       end
       setArmPosBlocking(Serial,posToMove);
       
       continue;

   end
   moving = 1;
   setArmPos(Serial,posToMove);
   
   if(checkCollandStop(Serial))
       goBack = 1;
       continue;
   end
   
   while(~checkMoveComplete(Serial) && moving == 1)
       continue;
   end
   moving = 0;
   count = count + 1;
end
disp('DONE!');
% %%
% for i = 1:size(nodes,2)
%     setArmPosBlocking(Serial, nodes(i).pos)
% end
%%
% fclose(Serial);
% delete(Serial);
% clear Serial;