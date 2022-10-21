%AM595 MATLAB HW: Game of Life
% Chi-Sheng Lo


function Lo_ChiSheng()
    % initial state
    seeduv1 = [
        0 0 0 0 0 0 0;
        0 0 0 1 0 0 0;
        0 0 0 0 1 0 0;
        0 0 1 1 1 0 0;
        0 0 0 0 0 0 0;
        0 0 0 0 0 0 0;
        0 0 0 0 0 0 0;
        ];
    
    % Parameters
    genspeed= 0.1; %Displays each generation for 0.1 seconds
    genrounds = 56+4; % The glider has a period of 4 and runs 56 more generations
    
    for i=1:genrounds
        seeduv = seeduv1;
        [~, seeduv1] = advance(seeduv, seeduv1);
        imagesc(seeduv1);
        colormap(gray(2));
        pause(genspeed)
    end
end

% "advance" function which is required
% Takes in two copies of the universe of arbitrary size and return one of them (univ2) as the
% The universe is updated
function [univ1, univ2] = advance(univ1, univ2)
    [numrow, numcol] = size(univ1);
    for r=1:numrow
        for c=1:numcol
            urow = boundary(r-1, numrow);
            drow = boundary(r+1, numrow);
            lcol = boundary(c-1, numcol);
            rcol = boundary(c+1, numcol);
            
            % Computes number of neighbouring lives
            numnb = sum([
                univ1(urow, lcol),  univ1(urow, c), univ1(urow, rcol);
                univ1(r, lcol),     0,              univ1(r, rcol);
                univ1(drow, lcol),  univ1(drow, c), univ1(drow, rcol)
                ], [1,2]);
            
            if univ1(r,c)==0 && numnb==3 % born
                univ2(r,c) = 1;
            elseif univ1(r,c)==1 && not(numnb==2 || numnb==3) % dead
                univ2(r,c) = 0;
            end          
        end
    end
end

% Another function to deal with the periodic boundary condition
function i = boundary(i, len)
    if i==0
        i = len;
    elseif i==len+1
        i = 1;
    end
end