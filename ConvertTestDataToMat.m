run('InitScript.m');

addpath(genpath('./AuxiliaryFunctions'));

figureIdx           = 0;
figureCounterSpec   = '%04d';

generateFigures = OFF;


%% Parametryzacja danych

dataFolderPath      = './Data/';
testDataFileName    = 'test.csv';
numRows     = 28;
numCols     = 28;


numPx = numRows * numCols;

cRawData    = csvimport([dataFolderPath, testDataFileName]);
numImages   = size(cRawData, 1) - 1; 

tTestImage          = zeros([numRows, numCols, numImages], 'single'); 

runTime = 0;
for ii = 1:numImages
    hProcImageTimer = tic();
    imageIdx = ii + 1;
    for jj = 1:numPx
        [iRow, jCol] = ind2sub([numRows, numCols], jj);
        tTestImage(jCol, iRow, ii) = single(cRawData{imageIdx, jj} / 255); 
    end
    procImagTime = toc(hProcImageTimer);
    runTime = runTime + procImagTime;
    disp(['Finished processing Image #', num2str(ii, '%04d'), ' out of ', num2str(numImages), ' images']);
    disp(['Processig Time       - ', num2str(procImagTime, '%08.3f'), ' [Sec]']);
    disp(['Total Run Time       - ', num2str(runTime, '%08.3f'), ' [Sec]']);
    disp(['Expected Run Time    - ', num2str((numImages / ii) * runTime, '%08.3f'), ' [Sec]']);
    disp([' ']);
end

save([dataFolderPath, 'tTestImage'], 'tTestImage');




