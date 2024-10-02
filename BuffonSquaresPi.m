function [p, crossings] = BuffonSquaresPi(width, length, throws)
    if length >= width
        error(['The length of the squares side cannot be larger than or equal to the width of the boards' ...
            ' otherwise the experiment will not produce accurate reults'])
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
        % one of the square 
        nx1 = ((b1x1 + (b2x1 - b1x1)) * rand(1, throws));
        ny1 = ((b1y1 + (b1y2 - b1y1)) * rand(1, throws));
    
    
        % Generate random angle between 0 and 90
        theta = (90 * rand(1, throws));
    
        % Find points two, three and four of the square using trig
        nx2 = nx1 + cosd(theta) * length;
        ny2 = ny1 + sind(theta) * length;
    
        nx3 = nx2 + sind(theta) * length;
        ny3 = ny2 - cosd(theta) * length;
    
        nx4 = nx3 - cosd(theta) * length;
        ny4 = ny3 - sind(theta) * length;
        
    
        % See if each point of the square crosses the second board
        crossings1 = sum(nx1 < b2x1 & nx2 > b2x1);
        crossings2 = sum(nx2 < b2x1 & nx3 > b2x1);
        crossings3 = sum(nx3 > b2x1 & nx4 < b2x1);
        crossings4 = sum(nx4 > b2x1 & nx1 < b2x1);
        
        % Add up the times each side of the square has crossed a board
        crossings = crossings1 + crossings2 + crossings3 + crossings4; 
    
        % Calculate the value of pi
        p = (2 * length * throws) / (width * (crossings / 4));
    end

end