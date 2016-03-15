function [ touchret ] = checkCollandStop(Serial)
   touch = evalin('base', 'touch');
   touchret = touch;
   if(touch)
       assignin('base', 'touch', 0);
       fprintf(Serial, '%s\r', char(27));
       disp('stopping');
   end
end

