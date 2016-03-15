function setArmPosBlocking(Serial, angles)
    command = '';
    for i = 1:length(angles)
       command = [command,'#', num2str(i-1), ' P', num2str(angles(i)) ];
       if(i == length(angles) )
           
           command = strcat(command,' T200');
       else
           command = [command,' '];
       end
    end
    %command
    assignin('base', 'blocking', 1);
    fprintf(Serial, '%s\r', command);
    
    while(~checkMoveComplete(Serial))
       continue;
    end
    %disp('going Back Complete');
    assignin('base', 'blocking', 0);
end

