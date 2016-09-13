function [ config ] = setAnalyzeTime(config)

    config.analyzeTime(1,1) = 5000;
    config.analyzeTime(1,2) = config.timeLength;
    
end