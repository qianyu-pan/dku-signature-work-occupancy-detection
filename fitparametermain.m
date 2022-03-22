%%
clear all
clc
close all 
%%
M = readmatrix( '2021.7.6.csv' );
Co2 = M(:,6);
Time = (M(:,1)-1)*0.5;
 
figure(1)
plot(Time, Co2,'r-'); 

Time_test = Time(318:440,1);% 7.6,3
%Time_test = Time(825:892,1); % 7.6,1


Time_test = Time_test-Time_test(1,1);
Co2_test = Co2(318:440,1);
%Co2_test = Co2(825:892,1);

%%
figure(2)
plot(Time_test, Co2_test,'r-'); 
Cinf = min(Co2_test)-1;
Co2_norm = Co2_test-Cinf;
figure(3)
plot(Time_test,Co2_norm);
figure(4)
plot(Time_test,log(Co2_norm));
%% fminsearch
y = Co2_norm;
x = Time_test ;
f = @(b,x) b(1).*exp(b(2).*x)+b(3);                                      
B = fminsearch(@(b) norm(y - f(b,x)), [max(y)-min(y); -1; 1]);
figure(5)
plot(x, y, 'pg')
hold on
plot(x, f(B,x), '-r')
hold off
grid
xlabel('x')
ylabel('f(x)')
legend('Observation','Prediction');