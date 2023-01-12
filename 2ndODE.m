%%%%%% HOMEWORK 2 %%%%%%
%%%% ANALYSIS : Differential of v (velocity) is already given (ODE2). 
% And differential of y (vertical path) is known as v. This equation is
% given at ODE1. Both ODE contain 1 different variable. Also 
% imaginary slopes of y (l1,l2,l3,l4) depend on imaginary slopes for 
% v which are k1,k2,k3,k4. 
% According to Mathematical background below code is written

%Written by Neslihan Gülsoy

clear; clc; close all;

%%Givens

func_ODE1 = @(v) v;      %ODE of Vertical Path, y (m)
func_ODE2 = @(t) 10000 ./ (100 - 5.*t)-9.8;  %ODE of Velocity, v (m/sec)

v(1) = 0;       %Initial Value of Vertical Velocity (v)
y(1) = 0;       %Initial Value of Vertical Flight (y)

%To Calculate True Solutions
syms t1 C1 C2
int1 = int((10000 / (100 - 5*t1)-9.8),t1);     %Integration of y'' (y')
eq1 = subs(int1,0) + C1 == 0;       %To find Constant with Initial Value
C1 = vpasolve(eq1,C1);              %Constant for Integration of y'' (y')
func_true_v = int1 + C1;            %True Solution of Velocity (m/sec) 

int2 = int(func_true_v);            %Integration of y' (y)
eq2 = subs(int2,0) + C2 == 0;       %To find Constant with Initial Value
C2 = vpasolve(eq2,C2);              %Constant for Integration of y' (y)
func_true_y = int2 + C2;            %True Solution of Height (m)

%Interval of t
t(1) = 0;       %Initial Value for time, t (sec)
t_end = 10;     %Stop Value for t
h = 1;          %Step Size = 1

%Create Time Points with Given Step Size
for i = 1 : t_end
    t(i+1,1) = h + t(i);
end

%To Calculate True Values 

for i = 1 : length(t)
    true_v(i,1) = real(double(subs(func_true_v,t(i))));
    true_y(i,1) = real(double(subs(func_true_y,t(i))));
end

%To Make Numerical Computation 

for i = 1 : length(t)-1
    k1(i,1) = h * func_ODE2(t(i));
    k2(i,1) = h * func_ODE2(t(i) + h/2);
    k3(i,1) = h * func_ODE2(t(i) + h/2);
    k4(i,1) = h * func_ODE2(t(i) + h);
    v(i+1,1) = v(i) + 1/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
    
    l1(i,1) = h * func_ODE1(v(i));
    l2(i,1) = h * func_ODE1(v(i) + k1(i)/2);
    l3(i,1) = h * func_ODE1(v(i) + k2(i)/2);
    l4(i,1) = h * func_ODE1(v(i) + k3(i));
    y(i+1,1) = y(i) + 1/6 * (l1(i) + 2*l2(i) + 2*l3(i) + l4(i));
    
    %Relative Percent Error
    rer_y(i+1,1) = abs( (y(i+1)-y(i)) / (y(i+1)) ) *100;
    rer_v(i+1,1) = abs( (v(i+1)-v(i)) / (v(i+1)) ) *100;
end

%True Percent Error
ter_v(2:i+1,1) = abs( (true_v(2:end) - v(2:end)) ./ true_v(2:end) ) * 100;
ter_y(2:i+1,1) = abs( (true_y(2:end) - y(2:end)) ./ true_y(2:end) ) * 100;

% To Create Table for h = 1
Output.t = t;
Output.v_true = true_v;
Output.v =  v;
Output.y_true = true_y;
Output.y =  y;
Output.true_error_v = ter_v;
Output.rel_error_v = rer_v;
Output.true_error_y = ter_y;
Output.rel_error_y = rer_y;
% 
disp('   <strong> h = 1</strong>');
T = struct2table( Output );
T.Properties.VariableNames = {'t (sec)','v_true','v_numeric','y_true', ...
    'y_numeric','%true. error (v)','%rel. error (v)', '%true. error (y)',...
    '%rel. error (y)'};
disp(T) %Display Outputs
%
%To Create an Excel File to Form Proper Table
writetable(T,'Table_HW2.xls')

%%%% PLOTTING
figure(1)
subplot(2,1,1)
plot(t,v,'b','MarkerSize',12,'Marker','.')
ylabel('Velocity of Rocket (m/sec)','Interpreter','latex')
xlabel('Time (sec)','Interpreter','latex');
ax = gca;
ax.XTick = (0:1:10);
ax.XGrid = 'on';
title('Modelling the Vertical Flight of a Rocket with $4^{th}$ Order RK'...
    ,'Interpreter','latex')

subplot(2,1,2)
plot(t,y,'r','MarkerSize',12,'Marker','.')
ylabel('Height of Rocket (m)','Interpreter','latex')
xlabel('Time (sec)','Interpreter','latex');
ax = gca;
ax.XTick = (0:1:10);
ax.XGrid = 'on';

saveas(gcf,'HW2fig1.jpg')
saveas(gcf,'HW2fig1.fig')

% ERROR PLOTTING
figure(2)
subplot(2,1,1)
plot( t(2:end),[rer_v(2:end),rer_y(2:end)],...
    'MarkerSize',12,'Marker','.');
title('Percantage Relative Error vs Step Number $4^{th}$ Order RK'...
    ,'Interpreter','latex')
% Create ylabel
ylabel('$\% \varepsilon_{rel}$','Interpreter','latex');
% Create xlabel
xlabel('Step Number ','Interpreter','latex');
legend('Velocity','Height','Interpreter','latex')
ax = gca;
ax.XTick = (0:1:10);
ax.XGrid = 'on';

subplot(2,1,2)
plot( t(2:end),[ter_v(2:end),ter_y(2:end)],...
    'MarkerSize',12,'Marker','.');
title('Percantage True Error vs Step Number $4^{th}$ Order RK'...
    ,'Interpreter','latex')
% Create ylabel
ylabel('$\% \varepsilon_{true}$','Interpreter','latex');
% Create xlabel
xlabel('Step Number ','Interpreter','latex');
legend('Velocity','Height','Interpreter','latex')
ax = gca;
ax.XTick = (0:1:10);
ax.XGrid = 'on';