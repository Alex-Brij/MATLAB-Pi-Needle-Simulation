function [p, crossings] = BuffonStandardPi(width, length, throws)
    if length >= width
        error(['The length of the needle cannot be larger than or equal to the width otherwise ' ...
            'the experiment will not produce accurate reults'])
    else
        crossings = 0;
    
        % Generate x and y values of the board 1
        b1x1 = 0;
        b1y1 = 0;
    
        b1x2 = 0;
        b1y2 = 1;
    
        % Generate x and y values of the board 2
    
        b2x1 = b1x1 + width;
        b2y1 = 0;
    
        b2x2 = b2x1;
        b2y2 = 1;
    
    
        % Generate a vector of lenght throws of random numbers for point 
        % one of the needle between the two boards 
        nx1 = ((b1x1 + (b2x1 - b1x1)) * rand(1, throws));
        ny1 = ((b1y1 + (b1y2 - b1y1)) * rand(1, throws));
    
    
        % Generate random angle between 0 and 180
        theta = (90 * rand(1, throws));
    
        % Find point two of needle using cos in degrees
        nx2 = nx1 + cosd(theta) * length;
        ny2 = ny1 + sind(theta) * length;
    
        % Compare each pair of nx1 and nx2 values to bx1 and bx2
        crossings = sum(nx2 < b1x1 | nx2 > b2x1);
    
        % Estimate pi using the calculated crossings
        p = (2 * length * throws) / (width * crossings);

    end
    
end



 

