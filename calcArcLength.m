function [ dist ] = calcArcLength( positions )

dist = 0;
for i = 1:size(positions,1)-1
    sumsquare = 0;
    for p = 1:length(positions(i,:))
       sumsquare = sumsquare + (positions(i+1,p)-positions(i,p))^2; 
    end
    dist = dist + sqrt(sumsquare);
end


end

