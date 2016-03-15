function [ angles] = getRandomMove( currentPos, limits )
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
             mag = mu + sigma.*randn(1,dims); 
             angles = currentPos+(mag);%*vector);
             for(p = 1:dims)
                if(angles(p)>limits(p,2) || angles(p)<limits(p,1))
                    angles = [];
                    break;
                end
             end
         %end
    end
angles = int16(angles);
end

