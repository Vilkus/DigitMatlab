run('InitScript.m');

dataFolderPath      = 'Data/';
testDataFileName    = 'tTestImage.mat';
netFolderPath       = 'NetModels/';
netModelFileName    = 'hNetModel002.mat';

fileName        = 'SubmissionData.csv';
headerRowString = 'ImageId,Label';


%% £adujemy dane
load([dataFolderPath, testDataFileName]);
load([netFolderPath, netModelFileName]); 

normalizeData       = sTrainParams.normalizeData;
netLayerModelIdx    = sTrainParams.netLayerModelIdx;
meanVal             = sTrainParams.meanVal;
stdVal              = sTrainParams.stdVal;


%% parametryzacja danych

numRows     = size(tTestImage, 1);
numCols     = size(tTestImage, 2);
numChannels = 1;
numSamples  = size(tTestImage, 3);


mImageData = reshape(tTestImage, [numRows, numCols, numChannels, numSamples]);

if(normalizeData == ON)
    mImageData = (mImageData - meanVal) / stdVal;
end


%% Klasyfikacja

vPredictedClass = classify(hMnistNet, mImageData);


%% zapisujemy date
hFileId = fopen([dataFolderPath, fileName], 'w');
fprintf(hFileId, [headerRowString, '\n']);

for ii = 1:numSamples    
    fprintf(hFileId, [num2str(ii), ',']);
    fprintf(hFileId, [num2str(uint32(vPredictedClass(ii)) - 1), '\n']);
end

fclose(hFileId);


%% Restore Defaults

% set(0, 'DefaultFigureWindowStyle', 'normal');
% set(0, 'DefaultAxesLooseInset', defaultLoosInset);

