function [p, crossings] = BuffonSquaresPiPlot(width, length, throws, h, boardNum, VisibleNeedles)
    crossings = 0;

    % Generate x and y values of the board 1
    b1x1 = 0;
    b1y1 = 0;

    b1x2 = 0;
    b1y2 = 1;


    % create vector of board x coordinates from 0 up to the end coordinate
    boards = (0:width:((boardNum*width) - 1));


    % Generate a vector of lenght throws of random numbers for point
    % one of the square 
    nx1 = ((b1x1 + (boards(boardNum) - b1x1)) * rand(1, throws));
    ny1 = ((b1y1 + (b1y2 - b1y1)) * rand(1, throws));


    % Generate random angle between 0 and 180
    theta = 180 * rand(1, throws);

    % Find point two, three and four of the square using trig
    nx2 = nx1 + cosd(theta) * length;
    ny2 = ny1 + sind(theta) * length;

    nx3 = nx2 + sind(theta) * length;
    ny3 = ny2 - cosd(theta) * length;

    nx4 = nx3 - cosd(theta) * length;
    ny4 = ny3 - sind(theta) * length;
    

    crossings1 = sum((floor(nx1 / width)) ~= (floor(nx2 / width)));
    crossings2 = sum((floor(nx2 / width)) ~= (floor(nx3 / width)));
    crossings3 = sum((floor(nx3 / width)) ~= (floor(nx4 / width)));
    crossings4 = sum((floor(nx4 / width)) ~= (floor(nx1 / width)));

    
    % Add up the times each side of the square has crossed a board
    crossings = crossings1 + crossings2 + crossings3 + crossings4; 

    % Calculate the value of pi
    p = (2 * length * throws) / (width * (crossings / 4));

    % for loop goes through and displays all the sets of points with
    % lines between them on graph in gui, h sends data to gui ui.axis
    for i = 1:VisibleNeedles

        if ((floor(nx1(i) / width)) ~= (floor(nx2(i) / width)) | (floor(nx2(i) / width)) ~= (floor(nx3(i) / width)) | (floor(nx3(i) / width)) ~= (floor(nx4(i) / width)) | (floor(nx4(i) / width)) ~= (floor(nx1(i) / width)))
            plot(h, [nx1(i) nx2(i) nx3(i) nx4(i) nx1(i)], [ny1(i) ny2(i) ny3(i) ny4(i) ny1(i)],  '-g');
        else
            plot(h, [nx1(i) nx2(i) nx3(i) nx4(i) nx1(i)], [ny1(i) ny2(i) ny3(i) ny4(i) ny1(i)],  '-b');
        end

        hold(h, 'on');
    end

    for i = 1:boardNum
        xline(h, boards(i), 'r');
    end

    grid(h, 'on');
    axis(h, 'equal');
    hold(h, 'off');

end