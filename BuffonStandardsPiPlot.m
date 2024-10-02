function [pi, crossings] = BuffonStandardsPiPlot(width, length, throws, h, boardNum, closeNum, VisibleNeedles)
    crossings = 0;

    % Generate x and y values of the board 1
    b1x1 = 0;
    b1y1 = 0;

    b1x2 = 0;
    b1y2 = 1;

    % create vector of board x coordinates from 0 up to the end coordinate
    boards = (0:width:((boardNum*width) - 1));

    % Generate a vector of lenght throws of random numbers for point 
    % one of the needle between the two boards 
    nx1 = ((b1x1 + (boards(boardNum) - b1x1)) * rand(1, throws));
    ny1 = ((b1y1 + (b1y2 - b1y1)) * rand(1, throws));


    % Generate random angle between 0 and 180
    theta = ((0 + (180 - 0)) * rand(1, throws));

    % Find point two of needle using cos in degrees
    nx2 = nx1 + cosd(theta) * length;
    ny2 = ny1 + sind(theta) * length;

    % Goes through the start and end points for the needles and floor
    % divides both of them with width, if they are not the same it means
    % they are on differnt sides of board- e.g. they cross.
    crossings = sum((floor(nx1 / width)) ~= (floor(nx2 / width)));

    % Estimate pi using the calculated crossings
    pi = (2 * length * throws) / (width * crossings);


    % Stores needles
    needles = zeros(VisibleNeedles);

    
    % for loop goes through and displays all the sets of points with
    % lines between them on graph in gui, h sends data to gui ui.axis
    for i = 1:VisibleNeedles
        % checks if needles cross, highlights them green if they do
        if (floor(nx1(i) / width)) ~= (floor(nx2(i) / width))
            p = plot(h, [nx1(i) nx2(i)], [ny1(i) ny2(i)], '-g');
        else
            p = plot(h, [nx1(i) nx2(i)], [ny1(i) ny2(i)], '-b');

        end    
        needles(i) = p;
        needleData.index = i;

        % Each needle assinged p as its plotted, then given the button down
        % function. If buttondown activated (needle is clicked), data for
        % needle is sent to ChangeColour function
        set(p, 'ButtonDownFcn', {@ChangeColour, p, needleData}); 

        hold(h, 'on');
    end


    % Adds lines for boards
    for i = 1:boardNum
        xline(h, boards(i), 'r');
    end

    grid(h, 'on');
    axis(h, 'equal');
    hold(h, 'off');

    lastNeedleIndicies = [];
    OldNeedle = [];





    % Changes the colour of the Needles based on how close they are
    function ChangeColour(~, ~, CurrentNeedle, needleData)

        % Checks if the first needle has been selected by seeing if an old needle exists   
        if ~isempty(OldNeedle)
            % Gets the x coordinates of the old needle that was clicked and
            % sets it back to its original colour
            OldNeedleXCoords = get(OldNeedle, 'XData');
            if (floor(OldNeedleXCoords(1) / width)) ~= (floor(OldNeedleXCoords(2) / width))
                    set(OldNeedle, 'Color', 'g');
                else 
                    set(OldNeedle, 'Color', 'b');
            end
    

            % Sets the Close needles back to there original colours
            for z = 1:(closeNum)
                wasMagentaNeedle = get(needles(lastNeedleIndicies(z)), 'XData');
                if (floor(wasMagentaNeedle(1) / width)) ~= (floor(wasMagentaNeedle(2) / width))
                    set(needles(lastNeedleIndicies(z)), 'Color', 'g');
                else 
                    set(needles(lastNeedleIndicies(z)), 'Color', 'b')
                end   
            end


        end


        % Sets the clicked needle to yellow
        set(CurrentNeedle, 'Color', 'y');

        % Gets the current needle index and finds the n closest needles to that needle
        CurrentNeedleIndex = needleData.index;
        [~,idx] = mink(abs(theta(1:VisibleNeedles)-theta(CurrentNeedleIndex)),(closeNum + 1));


        % Sets the n closest needles to magenta and stores there indexes so 
        % they can be turned back to there original colours later 
        for z = 2:(closeNum + 1)
            set(needles(idx(z)), 'Color', 'magenta')
            lastNeedleIndicies(z-1) = idx(z);
        end
            % sets the old needle to the current needle 
            OldNeedle = CurrentNeedle;

    end

end

 

