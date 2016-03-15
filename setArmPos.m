function setArmPos(Serial, angles)
    command = '';
    for i = 1:length(angles)
       command = [command,'#', num2str(i-1), ' P', num2str(angles(i)) ];
       if(i == length(angles) )
           
           command = strcat(command,' T500');
       else
           command = [command,' '];
       end
    end
    %command
    fprintf(Serial, '%s\r', command);

end

