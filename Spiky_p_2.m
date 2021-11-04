
function dYdt = Spiky_p_2(t,p,Y)
alpha = p(1);
C0 = p(2);
dYdt = - alpha*Y+alpha*C0;
end

