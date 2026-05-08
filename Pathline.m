rootDir = fileparts(mfilename('fullpath'));
addpath(fullfile(rootDir, 'src'));
addpath(fullfile(rootDir, 'functions'));

tic;

params = config();

di = 0.2;

for i = 0:di:(1-di)
    plotPathline(params, 0.2, i*2*pi, 0.1, [i 0 0])
    hold on
end 

di = 0.2;

for i = 0:di:(1-di)
    plotPathline(params, 0.7, i*2*pi, 0.1, [0 0 i])
    hold on
end 

di = 0.2;

for i = 0:di:(1-di)
    plotPathline(params, 0.5, i*2*pi+1, 0.3, [0 i 0])
    hold on
end

set(gcf, 'Color', 'white')
view(105, 30)