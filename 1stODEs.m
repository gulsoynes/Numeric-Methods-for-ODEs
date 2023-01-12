%%%%%% HOMEWORK 1 %%%%%%
clear; clc; close all;

%%Givens

func_ODE = @(x,y) 1 - x + 4 * y;   %ODE

y(1) = 1;   %Initial Value of y

%Interval of x
x(1) = 0;   %Initial Value for x
x_end = 1;  %Stop Value for x

func_true_y = @(x) -3/16 + x/4 + 19/16 * exp(4.*x); %True Func. of y

%% Step Size = 0.1
h = .1; %Step Size = 0.1

%Create x Points with Given Step Sie
for i = 1 : 1/h
    x(i+1) = h + x(i);
end

%True y Values
true_y = func_true_y(x);    %To Calculate True y Values Call func_true_y

%To Make Numerical Computation Call Defined Functions
[y_ME,rel_err_ME,true_err_ME] = ...
    ME(func_ODE,x,y,x_end,h,true_y);

[y_FORK,rel_err_FORK,true_err_FORK] = ...
    FORK(func_ODE,x,y,x_end,h,true_y);

[y_TOAB,rel_err_TOAB,true_err_TOAB] = ...
    TOAB(func_ODE,x,y,x_end,h,true_y);

% To Create Table for h = 0.1
Output.Step = (0:length(x)-1)';
Output.x = x';
Output.y = true_y';
Output.y_ME = y_ME';
Output.y_FORK =  y_FORK';
Output.y_TOAB = y_TOAB';

Output.rel_e_ME = rel_err_ME';
Output.rel_e_FORK = rel_err_FORK';
Output.rel_e_TOAB = rel_err_TOAB';

Output.true_e_ME = true_err_ME';
Output.true_e_FORK = true_err_FORK';
Output.true_e_TOAB = true_err_TOAB';

disp('   <strong> h = 0.1</strong>');
T = struct2table( Output );
disp(T) %Display Outputs

%To Create an Excel File to Form Proper Table
writetable(T,'Table.xls','Sheet',"h = 0.1")

%%% Plotting %%%%
%Function Plot
% Create figure
figure1 = figure('WindowState','maximized');

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create fplot
fplot(func_true_y,[0 1],'DisplayName','True Function','Parent',axes1,...
    'MarkerSize',6);

% Create multiple lines using matrix input to plot
plot1 = plot(x,[y_ME; y_FORK; y_TOAB],'MarkerSize',24,'Marker','.',...
    'LineStyle','--',...
    'Parent',axes1);
set(plot1(1),'DisplayName','Modified-Euler');
set(plot1(2),'DisplayName','4th-Order RK');
set(plot1(3),'DisplayName','3rd-Order AB');

% Create ylabel
ylabel({'Y points'},'Interpreter','latex');

% Create xlabel
xlabel('X points','Interpreter','latex');

box(axes1,'on');
axis(axes1,'tight');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.146055 0.75134 0.1219 0.1394],'LineWidth',0.8,...
    'Interpreter','latex',...
    'FontSize',12);
title(legend1,'h = 0.1');

saveas(gcf,'func1.png')
saveas(gcf,'func1.fig')


%ERROR PLOT

% Create figure
figure3 = figure('WindowState','maximized');

% Create axes
axes1 = axes('Parent',figure3);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(x,[true_err_ME; true_err_FORK; true_err_TOAB],...
    'MarkerSize',24,'Marker','.',...
    'LineStyle','--',...
    'Parent',axes1);
set(plot1(1),'DisplayName','Modified-Euler');
set(plot1(2),'DisplayName','4th-Order RK');
set(plot1(3),'DisplayName','3rd-Order AB');

% Create ylabel
ylabel({'$\%\mid\varepsilon_{true}\mid$'},'Fontsize',15,...
    'Interpreter','latex');

% Create xlabel
xlabel('X points','Interpreter','latex');

box(axes1,'on');
axis(axes1,'tight');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.146055 0.75134 0.1219 0.1394],...
    'LineWidth',0.8,...
    'Interpreter','latex',...
    'FontSize',12);
title(legend1,'h = 0.1');

close all;
%% Step Size = 0.05
h = .05; %Step Size = 0.05

%Create x Points
for i = 1 : 1/h
    x(i+1) = h + x(i);
end

%True y Values
true_y = func_true_y(x);

[y_ME,rel_err_ME,true_err_ME,slope_ME] = ...
    ME(func_ODE,x,y,x_end,h,true_y);

[y_FORK,rel_err_FORK,true_err_FORK,k1,k2,k3,k4] = ...
    FORK(func_ODE,x,y,x_end,h,true_y);

[y_TOAB,rel_err_TOAB,true_err_TOAB] = ...
    TOAB(func_ODE,x,y,x_end,h,true_y);

%To Create Table for h = 0.05
Output.Step = (0:length(x)-1)';
Output.x = x';
Output.y = true_y';
Output.y_ME = y_ME';
Output.y_FORK =  y_FORK';
Output.y_TOAB = y_TOAB';

Output.rel_e_ME = rel_err_ME';
Output.rel_e_FORK = rel_err_FORK';
Output.rel_e_TOAB = rel_err_TOAB';

Output.true_e_ME = true_err_ME';
Output.true_e_FORK = true_err_FORK';
Output.true_e_TOAB = true_err_TOAB';

disp('   <strong> h = 0.05</strong>');
T = struct2table( Output );
disp(T) %Display Outputs

writetable(T,'Table.xls','Sheet',"h = 0.05")

%%%% PLOTTING
figure2 = figure('WindowState','maximized');

% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create fplot
fplot(func_true_y,[0 1],'DisplayName','True Function','Parent',axes2,...
    'MarkerSize',6);
% Create multiple lines using matrix input to plot
plot1 = plot(x,[y_ME; y_FORK; y_TOAB],'MarkerSize',24,'Marker','.',...
    'LineStyle','--',...
    'Parent',axes2);
set(plot1(1),'DisplayName','Modified-Euler');
set(plot1(2),'DisplayName','4th-Order RK');
set(plot1(3),'DisplayName','3rd-Order AB');

% Create ylabel
ylabel({'Y points'},'Interpreter','latex');

% Create xlabel
xlabel('X points','Interpreter','latex');

box(axes2,'on');
axis(axes2,'tight');
hold(axes2,'off');
% Set the remaining axes properties
set(axes2,'XGrid','on','XTick',(0:.05:1));
% Create legend
legend1 = legend(axes2,'show');
set(legend1,...
    'Position',[0.146055 0.75134 0.1219 0.1394],...
    'LineWidth',0.8,...
    'Interpreter','latex',...
    'FontSize',12);
title(legend1,'h = 0.05');

%ERROR PLOT

figure4 = figure('WindowState','maximized');

% Create axes
axes2 = axes('Parent',figure4);
hold(axes2,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(x,[true_err_ME; true_err_FORK; true_err_TOAB],...
    'MarkerSize',24,'Marker','.',...
    'LineStyle','--',...
    'Parent',axes2);
set(plot1(1),'DisplayName','Modified-Euler');
set(plot1(2),'DisplayName','4th-Order RK');
set(plot1(3),'DisplayName','3rd-Order AB');

% Create ylabel
ylabel({'$\%\mid\varepsilon_{true}\mid$'},'Fontsize',15,...
    'Interpreter','latex');
% Create xlabel
xlabel('X points','Interpreter','latex');

box(axes2,'on');
axis(axes2,'tight');
hold(axes2,'off');
% Set the remaining axes properties
set(axes2,'XGrid','on','XTick',(0:.05:1));
% Create legend
legend1 = legend(axes2,'show');
set(legend1,...
    'Position',[0.146055 0.75134 0.1219 0.1394],...
    'LineWidth',0.8,...
    'Interpreter','latex',...
    'FontSize',12);
title(legend1,'h = 0.05');

%% Functions for Methods

%For Modified-Euler Method
function [y,rel_err,true_err,slope] = ME(func,x,y,x_end,h,true_y)
%%Formulation for Moduler Euler Method
for i = 1 : x_end/h
    f(i) = func(x(i),y(i));
    y_e(i+1) = y(i) + h * f(i);   %First Appx. y_(i+1) with Euler Method
    %Corrector Equation
    y(i+1) = y(i) + h/2 * (f(i) + func(x(i+1),y_e(i+1)));
    %Relative Percent Error
    rel_err(i+1) = abs( (y(i+1)-y(i)) / (y(i+1)) ) *100;
end

%%True Percent Error Calculation
true_err = abs((true_y - y ) ./ (true_y)) * 100;
slope = func(x,y);
end

%For 4th Order Runge-Kutta Method
function [y,rel_err,true_err,k1,k2,k3,k4] = FORK(func,x,y,x_end,h,true_y)

for i = 1 : x_end/h
    k1(i) = func(x(i),y(i));
    k2(i) = func(x(i) + h/2, y(i)+k1(i)*h/2);
    k3(i) = func(x(i) + h/2, y(i)+k2(i)*h/2);
    k4(i) = func(x(i) + h, y(i)+k3(i)*h);
    y(i+1) = y(i) + h/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
    %Relative Percent Error
    rel_err(i+1) = abs( (y(i+1)-y(i)) / (y(i+1)) ) *100;
end

%%True Percent Error Calculation
true_err = abs((true_y - y ) ./ (true_y)) * 100;
%slope = func(x,y);

end

%For 3rd Order Adams-Bashforth Method
function [y,rel_err,true_err] = TOAB(func,x,y,x_end,h,true_y)
bo = 23/12; b1 = -16/12; b2 = 5/12; %Coef.
%To Calculate Initial Values with 4th Order RK Method
for i = 1 : 2
    k1(i) = func(x(i),y(i));
    k2(i) = func(x(i) + h/2, y(i)+k1(i)*h/2);
    k3(i) = func(x(i) + h/2, y(i)+k2(i)*h/2);
    k4(i) = func(x(i) + h, y(i)+k3(i)*h);
    y(i+1) = y(i) + h/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
end

for i = 3 : x_end/h
    %Using Predictor Formula
    y(i+1) = y(i) + h * (bo * func(x(i), y(i)) + b1 * func(x(i-1), ...
        y(i-1)) + b2 * func(x(i-2), y(i-2)) );
    %Relative Percent Error
    rel_err(i+1) = abs( (y(i+1)-y(i)) / (y(i+1)) ) *100;
end
%%True Error Calculation
true_err = abs((true_y - y ) ./ (true_y)) * 100;
end