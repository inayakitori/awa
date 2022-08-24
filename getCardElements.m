function [finalList] = getCardElements()
%GETCARDELEMENTS Summary of this function goes here
%   Detailed explanation goes here
cards(4, 4, 4, 2).position = [];
cards(4, 4, 4, 2).hasElement = [];
cards(4, 4, 4, 2).elementList = [];

directions = [
[1 0 0 0]
[1 0 1 0]
[1 0 2 0]
[1 1 0 0]
[1 1 1 0]
[1 1 2 0]
[1 2 0 0]
[1 2 1 0]
[1 2 2 0]
[0 1 0 0]
[0 1 1 0]
[0 1 2 0]
[0 0 1 0]
[0 0 0 0] % plane at infinity
];


%for every card
for z = 1:1:3
    for y = 1:1:3
        for x = 1:1:3
            %finite cards
            cards(x,y,z,2).position = [x-1,y-1,z-1, 1];
            cards(x,y,z,2).hasElement = false([1 40]);
        end
        %yz
        cards(2,y,z,1).position = [1,y-1,z-1, 0];
        cards(2,y,z,1).hasElement = false([1 40]);
    end
    %y
    cards(1,2,z,1).position = [0,1,z-1, 0];
    cards(1,2,z,1).hasElement = false([1 40]);
end

%z
cards(1,1,2,1).position = [0, 0, 1, 0];
cards(1,1,2,1).hasElement = false([1 40]);


for dirI = 1:length(directions)
    dir = directions(dirI,:);
    t = num2cell(dir);
    [a, b, c, ~] = deal(t{:});
    for cardIndex = 1:numel(cards)
        card = cards(cardIndex);
        if(size(card.position) > 0)
            if(all([a,b,c] == [1,1,2]) && all(card.position == [0, 1, 0, 1]))
                stop = 1;
            end
            if(a==0 && b==0 && c== 0) % plane at infinity
                if(card.position(4) == 0)
                    cards(cardIndex).hasElement(40) = true;
                end
            else %finite plane
                planeIndex = mod(dot([a,b,c],card.position(1:3)),3); 
                if(card.position(4) == 0)%point at infinity
                    if(planeIndex == 0)
                    cards(cardIndex).hasElement(3 * dirI - 2 : 3 * dirI) = true(1,3);
                    end
                else %finite point
                    cards(cardIndex).hasElement(3 * dirI + planeIndex - 2) = true;
                end
            end
        end
    end
end

validCardsList(40) = cards(1);
l = 1;

for cardIndex = 1:numel(cards)
    card = cards(cardIndex);
    if(size(card.position) > 0)
        validCardsList(l) = cards(cardIndex);
    
        %get list
        i=1;
        for e = 1:40
            if(card.hasElement(e) == 1)
                validCardsList(l).elementList(i) = e;
                i=i+1;
            end
        end
        validCardsList(l).elementList = validCardsList(l).elementList(:, randperm(13)); %shuffle elements
        l=l+1;
    end
end

%shuffle cards
validCardsList = validCardsList(:,randperm(40));

matches = [];
for e = validCardsList(1).elementList
    if( ...
            ismember(e,validCardsList(2).elementList) && ...
            ismember(e,validCardsList(3).elementList))
        matches(end+1) = e;
        disp(matches)
    end
end

finalList = reshape([validCardsList.elementList],13,40).';
end

