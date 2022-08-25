function CardDisplayer
skin = "HOMESTUCK3downscaled";
deck = "deck2";
cardCount = 40;

folder = "cards\" + skin + "\" + deck;
cards = zeros(1643, 1643, 3, 40);
randomList = randperm(cardCount);
cardList = randomList(1:3);

for cardIndex = 1:cardCount
    img = imread(folder + "\" + int2str(cardIndex) + ".png");
    img(:, 1 : 5, :) = 0;
    img(:, end-4 : end, :) = 0;
    cards(:,:,:,cardIndex) =  double(imresize(img, 0.25)) / 255;
    disp("Loading cards:" + cardIndex + "/" + cardCount);
end

fig = uifigure(1);
fig.Position = [0 0 1972 658];
windowSize = fig.Position(3:4);
uiimg = uiimage(fig, "Position",[0 0 windowSize]);

reshuffleBtn = uibutton(fig,'push',...
    'Position',[0 0 100 25],...
    'Text', "Reshuffle",...
    'ButtonPushedFcn', @(button, event) showNewCards() ...
    );

addBtn = uibutton(fig,'push',...
    'Position',[125 0 100 25],...
    'Text', "Add",...
    'ButtonPushedFcn', @(button, event) addCard() ...
    );

    function addCard()
        cardList = randomList(1:min(length(cardList) + 1, cardCount));
        showCards();
    end

    function showNewCards()
        randomList = randperm(cardCount);
        cardList = randomList(1:3);
        showCards();
    end

    function showCards()
        img = [];
        uiimg.Position = [0 0 fig.Position(3:4)];
        reshuffleBtn.Position = [0 0 100 25];
        addBtn.Position = [125 0 100 25];

        for cardShowingIndex = 1:length(cardList)
            img = [img cards(:,:,:,cardList(cardShowingIndex))];
        end

        uiimg.ImageSource = img;
    end
end