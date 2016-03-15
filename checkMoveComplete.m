function [ complete ] = checkMoveComplete( Serial )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    complete = 0;
    fprintf(Serial,'%s\r', 'Q');
    t = fscanf(Serial,'%c',1);
    if(t == '.')
        complete = 1;
    end

end

