function [imgList, imgListA] = getElementPictures(category)

imgList = zeros(128,128,3,40);
imgListA = zeros(128,128,40);

for elementIndex = 1:40
    elementName = num2str(elementIndex);
    [imgList(:,:,:, elementIndex), ~, imgListA(:,:,elementIndex)] = imread(category + "\" + elementName + ".png");
end
imgList = imgList/255;

end

