clc
clear
close all

% Non-linear model - because we have powers and mutiplications between
% variables/constraints
% X^T * Q * X == objective function (non-linear part)
% we have to define a Qc matrix 

% max 𝑓 = 𝑥^2 + 𝑥𝑦 + 𝑦^2 + 𝑦𝑧 + 2𝑥
% 2x is the linear part
% 𝑠.𝑡.
% x + 𝑦 + 𝑧 = 1
% 𝑥^2 + 𝑦^2 ≤ 𝑧^2
% 𝑥^2 ≤ 𝑦𝑧
% 𝑥, 𝑦, 𝑧 ≥ 0

% [x y z] * [a11 a12 a13; a21 a22 a23; a31 a32 a33] * [x; y; z] = 𝑥^2 + 𝑥𝑦 + 𝑦^2 + 𝑦𝑧
% [a11x+a21y+a31z  a12x+a22y+a32z  a13x+a23y+a33z] * [x; y; z] =
% [a11x^2 + a21yz + a31zx + a12xy + a22y^2 + a32zy + a13xz + a23yz +
% a33z^2] = 
% a11x^2 + a22y^2 + a33z^2 + xy(a21 + a12) + xz(a31 + a13) + zy(a32 + a23)
% a11 = 1
% a22 = 1
% a33 = 0
% a13 = a31 = 0, it's better to have more zeros, so we will leave it 
% a12 + a21 = 1, so either 0.5 and 0.5, or 0 and 1, or 1 and 0...
% a23 + a32 = 1
% [a11 a12 a13; a21 a22 a23; a31 a32 a33] = [1 0.5 0; 0.5 1 0.5; 0 0.5 0]
% we don't need to do these calculation, we can just add one "row" xyz
% above the matrix, and one next to it vertically and multiply in certain
% columns

names = {'x', 'y', 'z'};
model.varnames = names;

%Set objective x^2 + 𝑥𝑦 + 𝑦^2 + 𝑦𝑧 + 2x
model.Q = sparse([1 0 0; 1 1 0; 0 1 0]); %we changed from 0.5&0.5 to 1&0
model.obj = [2 0 0]; %xyz
model.modelsense = 'max';

%Add constraint: x + y + z = 1
model.A = sparse([1 1 1]);
model.rhs = 1;
model.sense = '=';

% Add second-order cone: x^2 + y^2 <= z^2 using a sparse matrix

% x^2 + y^2 - z^2 <= 0
model.quadcon(1).Qc = sparse([ ...
    1 0 0; ...
    0 1 0; ...
    0 0 -1]);
model.quadcon(1).q = zeros(3,1); %linear part q - zeros everywhere
%x^2 + y^2 + z^2 + 0x + 0y + 0z <= 0
model.quadcon(1).rhs = 0;
%model.sense is by default <= (in real <, bc we don't have <=, >=) so we don't have to set this
model.quadcon(1).name = 'std_cone';

% Add rotated cone: x^2 <= yz using sparse triplet representation
% Equivalent sparse matrix data:
%model.quadcom(2).Qc = sparse ([
%     1 0 0;
%     0 0 -1;
%     0 0 0]);
model.quadcon(2).Qrow = [1, 2]; %in 1st and 2nd row
model.quadcon(2).Qcol = [1, 3]; %in 1st and 3rd col
model.quadcon(2).Qval = [1, -1];

%All zero sparse 3-by-1 vector
%no linear part (q)
model.quadcon(2).q = sparse(3,1); %same as zeros(3,1)
%no need to add model.sense, because we have <= sign - default
model.quadcon(2).rhs = 0;
model.quadcon(2).name = 'rot_cone';

gurobi_write(model, 'qp.lp');

params.NonConvex = 2; %non convex problem = 2
params.outputflag = 0;
result = gurobi(model, params);