% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 7

clear all;

s = 1;
t = 0;

Tmax = 100000;

trace = [t, s];

Tc1 = 0; %s = 2
Tc2 = 0; %s= 3
Texit = 0; %s = 4
Tlava = 0; %s = 5

%To compute the average game time
RTT = [];
game_time = 0;

%To compute the win-ratio
win_counter = 0;
lose_counter = 0;

while t < Tmax

    %Starting the game
    if s == 1
        if rand() < 0.3 %going to c2 via blue
            if rand() < 0.3 %Reached C2
                %Time uniform a=3 b=6
                dt = 3 + rand() * (6-3);
                ns = 3; %C2
            else % Fell in the Lava
                %Time exp lambda = 0.25
                dt = -log(rand())/0.25;
                ns = 5; %Lava
            end
        else 
            %Going to c1
            if rand() < 0.2
                %Fell in the Lava
                % Exp lambd = 0.5
                dt = -log(rand())/0.5;
                ns = 5; %Lava
            else
                %Success!
                %Erlang k=4 lambd =1.5
                dt = -log(prod(rand(4,1)))/1.5;
                ns = 2; %C1
            end
        end
    end

    if s == 2 %C1 successfully reached     
        if rand() < 0.50
            %Will continue on yellow to C2
            if rand () < 0.25
                %Was successfull, reached C2
                %Erlang k=3 lambd =2
                dt = -log(prod(rand(3,1)))/2;
                ns = 3;
            else
                %Fell in the Lava
                %Exponential 0.4
                dt = -log(rand())/0.4;
                ns = 5;
            end
        else
            %Will go to C2 via white
            if rand() < 0.6
                %Was successfull!
                %Exp = 0.15
                dt = -log(rand())/0.15;
                ns = 3;
            else
                %Fell in the lava
                %Exp lambd = 0.2
                dt = -log(rand())/0.2;
                ns = 5;
            end
        end		
    end
    
    %In C2
    if s == 3
        %Will try to go to the exit
        %Both cases have Erlang k= 5 lambd = 4
        dt = -log(prod(rand(5,1)))/4;
        if rand() < 0.6
            %Success
            ns = 4;
        else
            %Fell in lava
            ns = 5;
        end
    end
    
    %Reached the end! 
    if s == 4
        dt = 5; %Need 5min to reset the room
        ns = 1;
        win_counter = win_counter + 1;
    end
    
    %Fell in Lava... Need 5min to reset the rooms
    if s == 5
        dt = 5; %Need 5min to reset the room
        ns = 1;
        lose_counter = lose_counter + 1;
    end

    s = ns;
	t = t + dt;
	trace(end + 1, :) = [t, s];
end

game_counter = win_counter + lose_counter;
win_prob = win_counter/game_counter

