close all
clear
clc

sceneImage = imread('../2.jpg');
boxImage = imread('../template.jpg');

bbox = ColorCardBBOX(sceneImage,boxImage)


rm_width = 0.06;
rm_height = 0.21;

h = abs(bbox(1, 2) - bbox(4, 2));
w = sqrt((bbox(1, 1) - bbox(2, 1))^2 + (bbox(1, 2) - bbox(2, 2))^2);


remove_skew = sceneImage(bbox(1, 2):bbox(1, 2)+h,bbox(1, 1):bbox(1, 1)+w,:);
%figure; imshow(remove_skew)
% Remove Blue shades of card

detected_card = remove_skew(rm_width*w:h-(h*rm_height),...
    rm_width*w:w-rm_width*w,:);
figure;
imshow(detected_card)
hold on

[rr cc d] = size(detected_card);
XX = 0.125:0.25:1;
XX = repmat(XX,6);
XX = int32(XX(1,1:24)* cc);
YY = 0.0833:0.1667:1;
YY = int32(repelem(YY,4)*rr);
plot(XX,YY,'rs');

size(detected_card)
RGB_VALUES = [];

for i=1:24
    RGB_VALUES = [RGB_VALUES ;[detected_card(YY(i),XX(i),1)...
        detected_card(YY(i),XX(i),2) detected_card(YY(i),XX(i),3)]];
end

Mcorrpseudo = calccolortransform(double(RGB_VALUES));

A = sceneImage;
sceneMatrix = reshape(A,size(A,1)*size(A,2),3);
Corrected_Matrix = round(double(sceneMatrix) * Mcorrpseudo); 
Corrected_Image = uint8(reshape(Corrected_Matrix,size(A,1),...
    size(A,2),3));

figure;
imshow(Corrected_Image);
