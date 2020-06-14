function [ hNetModel ] = SelectNetLayerModel( netModelIdx, numRows, numCols, numChannels )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

switch(netModelIdx)
    case(1)
        hNetModel = [
                        imageInputLayer([numRows, numCols, numChannels])
                        
                        % dane wejsciowe - [28 x 28 x 1]
                        batchNormalizationLayer()
                        convolution2dLayer(5, 16, 'Padding', 0)
                        maxPooling2dLayer(2, 'Stride', 2)
                        leakyReluLayer()

                        % dane wejsciowe - [12 x 12 x 16]
                        batchNormalizationLayer()
                        convolution2dLayer(3, 32, 'Padding', 0)
                        maxPooling2dLayer(2, 'Stride', 2)
                        leakyReluLayer()

                        % dane wejsciowe - [5 x 5 x 32]
                        batchNormalizationLayer()
                        convolution2dLayer(3, 64, 'Padding', 0)
                        leakyReluLayer()

                        % dane wejsciowe - [5 x 5 x 64]
                        fullyConnectedLayer(64)
                        leakyReluLayer()
                        fullyConnectedLayer(10)
                        softmaxLayer()
                        classificationLayer()];
    case(2)
        hNetModel = [
                        imageInputLayer([numRows, numCols, numChannels])
    
                        
                        convolution2dLayer(5, 50, 'Padding', 0)
                        maxPooling2dLayer(2, 'Stride', 2)
                        reluLayer()
                        batchNormalizationLayer()

                        convolution2dLayer(3, 40, 'Padding', 1)
                        maxPooling2dLayer(2, 'Stride', 2)
                        reluLayer()
                        batchNormalizationLayer()

                        convolution2dLayer(3, 30, 'Padding', 1)
                        reluLayer()
                        batchNormalizationLayer()

                        fullyConnectedLayer(48)
                        leakyReluLayer()
                        dropoutLayer(0.1)
                        fullyConnectedLayer(32)
                        leakyReluLayer()
                        dropoutLayer(0.1)
                        fullyConnectedLayer(10)
                        softmaxLayer()
                        classificationLayer()];
    
end


end

