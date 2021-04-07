% Hands on solution for Simple Mechanism task, modified for assignment4
clear all
close all
%  u = [phi_2; d];
t = linspace(0,20);
a = 0.1;
% r = 0.2;
b = 0.2;
% phi_1 = deg2rad(90);
phi_1 = pi/6;
N = 100;
dvalues = zeros(1,100);
uvalues = zeros(1,100);
% set a reasonable starting point
u0 = [0; a+b];
scope = linspace(0,10,100);

% create function handles
F = @(u) constraint(u, a, b, phi_1);
J = @(u) jacobian(u, b);

eps = 1e-7;
[u, iteration_counter] = NR_method(F, J, u0, eps);

fprintf('\n\tMechanism valid position is for d = %.3g m and phi2 = %g deg\n\n', ...
    u(2), rad2deg(u(1)));
ploti2(u,N,J,u0,eps,uvalues,dvalues,scope,a,b)


function P = constraint(u, a, b, phi_1)
phi_2 = u(1);
d = u(2);

P = [a * cos(phi_1) + b * cos(phi_2) - d
    a * sin(phi_1) - b * sin(phi_2)];
end

function P = jacobian(u, b)
phi_2 = u(1);
P = [-b * sin(phi_2), -1
    -b * cos(phi_2), 0];
end


function ploti2(u,N,J,u0,eps,uvalues,dvalues,scope,a,b)
    for i = 1:N;
        phi_1 = pi/6 + 1*i;
        F = @(u) constraint(u, a, b, phi_1);
       [u, iteration_counter] = NR_method(F, J, u0, eps);
       
       dvalues(i) = u(2);
       uvalues(i) = u(1);
    end
    hold on
         plot(scope,dvalues)
        plot(scope,rad2deg(uvalues))
        legend({'d values','phi2 values'},'Location','southwest')
    hold off

end
