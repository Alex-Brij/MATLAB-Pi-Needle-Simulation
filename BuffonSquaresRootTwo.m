function [r, crossings] = BuffonSquaresRootTwo(width, length, throws)
    if length >= width/sqrt(2)
        error(['The length of the squares side cannot be larger than or equal to the width of the boards divided by root two' ...
            ' otherwise the experiment will not produce accurate reults'])
    else
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
        % one of the square 
        nx1 = ((b1x1 + (b2x1 - b1x1)) * rand(1, throws));
        ny1 = ((b1y1 + (b1y2 - b1y1)) * rand(1, throws));
    
    
        % Generate random angle between 0 and 180
        theta = 90 * rand(1, throws);
    
        % Find point two, three and four of the square using trig
        nx2 = nx1 + cosd(theta) * length;
        ny2 = ny1 + sind(theta) * length;
    
        nx3 = nx2 + sind(theta) * length;
        ny3 = ny2 - cosd(theta) * length;
    
        nx4 = nx3 - cosd(theta) * length;
        ny4 = ny3 - sind(theta) * length;
    
    
        % See if any lines of the square crosses the board
        SingleCrossings = sum((nx1 < b2x1 & nx2 > b2x1) | (nx2 < b2x1 & nx3 > b2x1) | (nx3 > b2x1 & nx4 < b2x1) | (nx4 > b2x1 & nx1 < b2x1));
        
        % See if the two possible combinations of consecutive sides crossing a
        % board cross and sum all the times they do
        consecutives2 = sum((nx2 < b2x1 & nx3 > b2x1) & (nx3 > b2x1 & nx4 < b2x1));
        consecutives4 = sum((nx4 > b2x1 & nx1 < b2x1) & (nx1 < b2x1 & nx2 > b2x1));
    
    
        crossings = consecutives2 + consecutives4;
    
        % Calculate the value of root 2
        r = (2 - (crossings / SingleCrossings));
    end


end