%% General Parameters
close('all');
clear();
clc();

figPosSmall     = [100, 100, 0400, 0300];
figPosMedium    = [100, 100, 0800, 0600];
figPosLarge     = [100, 100, 0960, 0720];
figPosXLarge    = [100, 100, 1100, 0825];
figPosX2Large   = [100, 100, 1200, 0900];
figPosX3Large   = [100, 100, 1400, 1050];
figPosDefault   = [100, 100, 0560, 0420];

fontSizeTitle   = 14;
fontSizeAxis    = 12;
fontSizeString  = 12;

lineWidthThin   = 1;
lineWidthNormal = 3;
lineWidthThick  = 4;

markerSizeSmall     = 4;
markerSizeNormal    = 8;
markerSizeLarge     = 10;

mColorOrder = get(groot, 'DefaultAxesColorOrder');

randomNumberStream  = RandStream('mlfg6331_64', 'NormalTransform', 'Ziggurat');
subStreamNumber     = round(sum(clock()));
subStreamNumber     = 2144;
set(randomNumberStream, 'Substream', subStreamNumber);
RandStream.setGlobalStream(randomNumberStream);
FALSE   = 0;
TRUE    = 1;
OFF     = 0;
ON      = 1;

