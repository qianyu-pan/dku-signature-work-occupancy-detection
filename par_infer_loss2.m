function err = par_infer_loss2(p,x,C)
obs_t = x;
obs_y1 = C;

T = max(obs_t);
options = odeset('MaxStep',0.01); % 最大步长不超过0.01
 %% solve
[t, Y] = ode45(@(t,Y)Spiky_p_2(t,p,Y),[0,T],1);

pre_y1 = interp1(t,Y, obs_t);

err_1 = abs(pre_y1-obs_y1); % Matrix dimensions must agree.

%err = (sum(err_1.^2,1) +sum(err_2.^2,1)); %% L2 norm 
err = (sum(err_1)); % L1 better when theres noise
end