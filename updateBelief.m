function [ newBelief ] = updateBelief( belief, position, oldPosition, success )

posDiff = double(int16(oldPosition) - int16(position));
newBelief = belief;
numCells = size(belief(1).cells, 1);

for p = 1:length(position)
   pos =posDiff(p);
   for(n = 1:numCells)
      if(pos >= belief(p).cells(n,1) && pos <= belief(p).cells(n,2))
          break
      end
   end
   if(success)
       
       newBelief(p).plusCount(n) = newBelief(p).plusCount(n) + 1;
       if(newBelief(p).plusCount(n) == 2)
            newBelief(p).cellBelief = zeros(1,numCells)+(1/numCells);
       end
       if(newBelief(p).plusCount(n) < 5)
            newBelief(p).cellBelief(n) = newBelief(p).cellBelief(n)+( newBelief(p).cellBelief(n) / newBelief(p).plusCount(n) );
       else
           newBelief(p).minusCount = zeros(1,length(newBelief(p).minusCount)) + 1;
       end
       
   else
       
       
       newBelief(p).minusCount(n) = newBelief(p).minusCount(n) + 1;
        if(newBelief(p).minusCount(n) == 2)
            newBelief(p).cellBelief = zeros(1,numCells)+(1/numCells);
       end
       if(newBelief(p).minusCount(n) < 5)
            newBelief(p).cellBelief(n) = newBelief(p).cellBelief(n)-( newBelief(p).cellBelief(n) / (newBelief(p).minusCount(n) ));
       else
           newBelief(p).plusCount = zeros(1,length(newBelief(p).plusCount)) + 1;
%            for b = 1:size(newBelief,2)
%                  newBelief(b).cellBelief = zeros(1,numCells)+(1/numCells);
%                  newBelief(b).minusCount = zeros(1,length(newBelief(p).minusCount)) + 1;
%                  newBelief(b).plusCount = zeros(1,length(newBelief(p).plusCount)) + 1;
%            end
           %newBelief(p).cellBelief(n) = newBelief(p).cellBelief(n)-( newBelief(p).cellBelief(n) / ((newBelief(p).minusCount(n))*0.5 ));
           newBelief(p).plusCount = zeros(1,length(newBelief(p).plusCount)) + 1;
       end
       if(newBelief(p).minusCount(n) > 5 )
           for b = 1:size(newBelief,2)
                 newBelief(b).cellBelief = zeros(1,numCells)+(1/numCells);
                 newBelief(b).minusCount = zeros(1,length(newBelief(p).minusCount)) + 1;
                 newBelief(b).plusCount = zeros(1,length(newBelief(p).plusCount)) + 1;
           end
           newBelief(p).cellBelief(n) = newBelief(p).cellBelief(n)-( newBelief(p).cellBelief(n) / (newBelief(p).minusCount(n) ));
       end
   end
   newBelief(p).cellBelief = newBelief(p).cellBelief ./ (sum(newBelief(p).cellBelief)) ;
end

end

