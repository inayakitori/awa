cards = ones(1152, 1152, 3, 40);
[elementPictures, elementPicturesA] = getElementPictures("Fish");
cardElements = getCardElements();


for cardIndex = 1:40

    thisCardsElements = cardElements(cardIndex,:);
    
    for cardPositionIndex = 0 : 12
        elementIndex = thisCardsElements(cardPositionIndex+1); 
        element = elementPictures(:,:,:,elementIndex);
        elementA = elementPicturesA(:,:,elementIndex); 
        j = floor(cardPositionIndex/ 4);
        i = cardPositionIndex - 4 * j;
        x = 256 * i + 128;
        y = 256 * j + 128;
        
        cards(x:x+127, y:y + 127, :, cardIndex) = (elementA  > 0.99) .* element(:,:,:) + (elementA <= 0.99) * 1;
    end 
end

card1 = cards(:,:,:,1);
card2 = cards(:,:,:,2);
card3 = cards(:,:,:,3);

imshow([card1 card2 card3])

% subplot(1,3,1), imshow(cards(:,:,:,1))
% subplot(1,3,2), imshow(cards(:,:,:,2))
% subplot(1,3,3), imshow(cards(:,:,:,3))