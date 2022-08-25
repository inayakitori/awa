function [imgList] = getElementPictures(skin, elementSize)

[img, map]= imread("Skins\" + skin + ".png");

if(numel(map)>0)
    img = ind2rgb(img, map);
end

if(any(img(:) > 1))
    finalisedImg = double(img)/256.0;
else
    finalisedImg = double(img);
end

imgList = zeros(elementSize,elementSize,3,40);

for elementIndex = 0:39
    j = floor(elementIndex/ 4);
    i = elementIndex - 4 * j;
    x = elementSize * i;
    y = elementSize * j;
    imgList(:,:,:, elementIndex+1) = finalisedImg(y+1:y+elementSize, x+1:x+elementSize, :);
end


end

