% Hands on solution for Simple Mechanism task, modified for assignment4
clear all
%  u = [phi_2; d];
a = 0.1;
% r = 0.2;
b = 0.2;
phi_1 = deg2rad(30);

% set a reasonable starting point
u0 = [0; b + a];

% create function handles
F = @(u) constraint(u, a, b, phi_1);
J = @(u) jacobian(u, b);

eps = 1e-8;
[u, iteration_counter] = NR_method(F, J, u0, eps);

fprintf('\n\tMechanism valid position is for d = %.3g m and phi1 = %g deg\n\n', ...
    u(2), rad2deg(u(1)));

function P = constraint(u, a, b, phi_1)
phi_2 = u(1);
d = u(2);

P = [a * cos(phi_1) + b * cos(phi_2) - d
    a * sin(phi_1) - b * sin(phi_2)];
end

function P = jacobian(u, b)
phi_2 = u(1);
P = [-b * sin(phi_2), -1
    b * cos(phi_2), 0];
end