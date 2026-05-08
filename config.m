function params = config()
    params.R = 1;
    params.dr = 0.001;
    params.t_switch = 0.17;          % 切换步长/精度的时间节点
    params.dt1 = 1e-4;  params.dt2 = 1e-5;
    params.step1 = 0.17; params.sep = 0.9;
    params.r = 0:params.dr:params.R;
    
    params.N = 10;    
%    params.gamma0 = params.N*(-2*params.r.^2 + 1);
    params.gamma0 =     params.N*(2*params.r.^2 - 4*params.r + 1);
    params.nameg = "20r^2-10";
    params.omega0 = ones(length(params.r), 1)*10;
    params.nameo = "10";

    params.N = 10;
    params.di = 0.1;
    % ... 其他参数
end