function binaryMask = toBinaryMask(input , threshold)
binaryMask = (input < threshold);

% c)To distinguish between searched regions(water) and background a look at the histogram is
%useful. Since the water regions are big and nearly in the same colour,
%they can be recognized in the histogram as many pixel in the darker area.
%So after inspecting the histogram it is uncertain that the water regions
%have to be between 47 and 79 because there is a cut in the curve. Since we
%are searching for a threshold the next value, which is 80, is the border
%to produce the binary mask.