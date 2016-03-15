function [ dist ] = calcDist( pos1, pos2 )


    sumsquare = 0;
    for p = 1:length(pos1)
       sumsquare = sumsquare + abs(pos1(p)-pos2(p)); 
    end
    dist = (sumsquare);



end

