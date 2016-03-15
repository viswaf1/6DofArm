function [ angles] = getRandomMovewithBelief( currentPos, belief, limits )
angles = [];
while size(angles,1) < 1
         dims = size(limits,1);
%          vector = [];
%          for i = 1:dims
%             vector(end+1) = rand(); 
%          end
%          if( sqrt( sum(vector.^2) )  > 1)
%              continue
%          else
             mu = 10;
             sigma = 10;
             for i = 1:dims
                randNum = rand();
                sumBelief = 0;
                for c = 1:length(belief(i).cellBelief)
                    sumBelief = sumBelief+belief(i).cellBelief(c);
                    if(randNum <= sumBelief)
                        break;
                    end
                end
                control = [];
                while length(control)<1
                    control  = (belief(i).cells(c,2) - belief(i).cells(c,1))*rand();
                    if (control < belief(i).cells(1,1) || control > belief(i).cells(end,2) )
                        control = [];
                    end
                end
                angles(i) = currentPos(i)+control;
                
             end
%              mag = mu + sigma.*randn(1,dims); 
%              angles = currentPos+(mag);%*vector);
%              for(p = 1:dims)
%                 if(angles(p)>limits(p,2) || angles(p)<limits(p,1))
%                     angles = [];
%                     break;
%                 end
%              end
         %end
    end
angles = int16(angles);
end
