%% Path Management
% Locate the root directory of this script and add subdirectories to the path
rootDir = fileparts(mfilename('fullpath'));
addpath(fullfile(rootDir, 'src'));
addpath(fullfile(rootDir, 'functions'));

fprintf('Starting the computation and visualization...\n');
tic;

%% 1. Load global parameters
params = config();
fprintf('Parameters loaded successfully.\n');
%% 2. Compute gamma and omega
fprintf('[1/4] Computing gamma2, gamma3, omega2, omega3...\n');
[gamma2, gamma3, Tg] = compute_gamma(params);
[omega2, omega3, To] = compute_omega(params, gamma2, gamma3);
fprintf('Base numerical solutions computed.\n');
%% 3. Compute S, approximate solutions, and evaluate errors
fprintf('[2/4] Computing S, gammas1, omegas1, and relative errors...\n');
[gammas1, omegas1, errT, errgm, errwm] = compute_S(params, gamma2, omega2, gamma3, omega3);
fprintf('Approximate solutions computed.');

%% 4. Generate 3D surface plot for omega distribution
for t0 = 0:0.0822:0.1644
    t_str = sprintf('%.4f', t0);

    fname_gamma = sprintf('figures/surface_gamma_%s_gamma_%s_omega_%s.png', t_str, params.nameg, params.nameo);
    fname_omega = sprintf('figures/surface_omega_%s_gamma_%s_omega_%s.png', t_str, params.nameg, params.nameo);

    fprintf('[3/4] Generating 3D surface plot...\n');

    gamma_fig = plot_surface(gammas1, params.r, params.dt2, t0, 'gamma', 10000);
    omega_fig = plot_surface(omegas1, params.r, params.dt2, t0, 'omega', 10000);
    saveFig(gamma_fig, fname_gamma);
    saveFig(omega_fig, fname_omega);
end

%% Finished
elapsed = toc;
fprintf('\n All tasks completed successfully! Total time: %.2f seconds\n', elapsed);
fprintf('Results are stored in the workspace, and figure windows are open.\n');

function saveFig(hFig, filePath)
    if isvalid(hFig)
        mkdir(fileparts(filePath));
        exportgraphics(hFig, filePath, 'Resolution', 300);
    end
end