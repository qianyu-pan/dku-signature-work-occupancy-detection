clc
clear all
clc
%% load experiment data
load 7_6_data.mat;
C = data(318:446,1);
C = table2array(C);
C = C'; % C for concentration
% x = [0:0.5:64]; % x for tspan?
x = [0:0.5:64]; 

obs_t = x;
obs_y1 = C;

figure(1)
plot(obs_t,obs_y1,'r-');
hold on 

figure(2)
plot(obs_t,log(obs_y1-385), 'r-');% get alpha, and c0 for initial guesses

T = max(obs_t);
Y0 = [-1;1];
%% 
p0 = [0.1, 385]; % replace with the previous results
[p,fval] = fminsearch(@(p)par_infer_loss2(p,x,C), p0, optimset('TolX',1e-10,'TolFun',1e-10, 'MaxFunEvals', 1e8, 'MaxIter', 3e3, 'PlotFcns', @optimplotfval,'Display','iter'));

%%% post pross 
p
[t, Y] = ode45(@(t,Y)Spiky_p_2(t,p,Y), [0,T], 1);
figure(1) 
plot(obs_t,obs_y1,'r-');
hold on 
plot(t,Y,'r*');
hold on
legend('Y1','Y1_fit');
