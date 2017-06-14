function bbox = ColorCardBBOX(sceneImageRGB,boxImageRGB)
    sceneImage = rgb2gray(sceneImageRGB);
    boxImage = rgb2gray(boxImageRGB);
    
    boxPoints = detectBRISKFeatures(boxImage);
    scenePoints = detectBRISKFeatures(sceneImage);


    [boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

    boxPairs = matchFeatures(boxFeatures, sceneFeatures);

    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    
    [tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');


    boxPolygon = [1, 1;...                           % top-left
        size(boxImage, 2), 1;...                 % top-right
        size(boxImage, 2), size(boxImage, 1);... % bottom-right
        1, size(boxImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

    bbox = transformPointsForward(tform, boxPolygon);
    figure;
imshow(sceneImageRGB);
hold on;
line(bbox(:, 1), bbox(:, 2), 'Color', 'y');
title('Detected Box');
hold off
end
