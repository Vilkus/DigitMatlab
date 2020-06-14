
%% Parametry ogólne

run('InitScript.m');

addpath(genpath('./AuxiliaryFunctions'));
figureIdx           = 0;
figureCounterSpec   = '%04d';
generateFigures = OFF;


%% Parametryzacja danych

dataFolderPath      = './Data/';
netFolderPath       = 'NetModels/';
trainDataFileName   = 'tTrainImage.mat';
imageNumberFileName = 'vImageNum.mat';


%% Parametryzacja symulacji

normalizeData       = OFF;
dataAugmentation    = ON;
netLayerModelIdx    = 2;


%% ³adowanie danych

% ³adowanie danych do uczenia
load([dataFolderPath, trainDataFileName]);
% ³adowanie etykiet danych
load([dataFolderPath, imageNumberFileName]);


%%

numRows     = size(tTrainImage, 1);
numCols     = size(tTrainImage, 2);
numChannels = 1;
numSamples  = size(tTrainImage, 3);

numClasses = length(unique(vImageNum));


mImageData = reshape(tTrainImage, [numRows, numCols, numChannels, numSamples]);
vDataClass = categorical(vImageNum);

meanVal = mean(mImageData(:));
stdVal = std(mImageData(:));

if(normalizeData == ON)
    mImageData = (mImageData - meanVal) / stdVal;
end

mTrainData = mImageData(:, :, :, 1:40000);
vTrainClass = vDataClass(1:40000);

mValidationData     = mImageData(:, :, :, 40001:42000);
vValidationClass    = vDataClass(40001:42000);

if(dataAugmentation == ON)
    imageSource = augmentedImageSource([numRows, numCols], mTrainData, vTrainClass, 'DataAugmentation', imageDataAugmenter('RandRotation', [-7.5, 7.5]));
else
    imageSource = augmentedImageSource([numRows, numCols], mTrainData, vTrainClass);
end


%% Definiowanie sieci.

hNetLayerModel = SelectNetLayerModel(netLayerModelIdx, numRows, numCols, numChannels);




%% Trenowanie


trainingOptions = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.045, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.98, ...
    'LearnRateDropPeriod', 1, ...
    'L2Regularization', 0.00001, ...
    'MaxEpochs', 500, ...
    'MiniBatchSize', 200, ...
    'Momentum', 0.65, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {mValidationData, vValidationClass}, ...
    'ValidationFrequency', 50, ...
    'ValidationPatience', 5000, ...
    'Verbose', true, ...
    'VerboseFrequency', 50, ...
    'Plots', 'training-progress');

[hMnistNet, sTrainInfo] = trainNetwork(imageSource, hNetLayerModel, trainingOptions);


%% Save Data

sTrainParams.subStreamNumber    = subStreamNumber;
sTrainParams.normalizeData      = normalizeData;
sTrainParams.netLayerModelIdx   = netLayerModelIdx;
sTrainParams.dataAugmentation   = dataAugmentation;
sTrainParams.meanVal            = meanVal;
sTrainParams.stdVal             = stdVal;

save([netFolderPath, 'hNetModel', num2str(netLayerModelIdx, '%03d')], 'hMnistNet', 'sTrainInfo', 'trainingOptions', 'sTrainParams');



