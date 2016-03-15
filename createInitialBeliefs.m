function [ beliefs ] = createInitialBeliefs( controlLimits, numCells )


beliefs = [];
for i = 1:size(controlLimits,1)
    cellwidth = (controlLimits(i,2)-controlLimits(i,1))/numCells;
    cells = [];
    for n = 1:numCells
        if(n == 1)
            cells(n,1) =  controlLimits(i,1);
        else
            cells(n,1) = cells(n-1,2);
        end
        
        if(n == numCells)
           cells(n,2) = controlLimits(i,2); 
        else
            cells(n,2) = int16(cells(n,1)+cellwidth);
        end
    end
    beliefs(i).cells = cells;
    beliefs(i).plusCount = zeros(1,numCells)+1;
    beliefs(i).minusCount = zeros(1,numCells)+1;
    
    beliefs(i).cellBelief = zeros(1,numCells)+(1/numCells);
end

end

