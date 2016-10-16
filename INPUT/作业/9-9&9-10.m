clear all,clc
% 读取数据，杆件、节点和力的数据
bar       = dlmread('INPUT/bar.dat');
node      = dlmread('INPUT/node.dat');
Force_All = [2 1 1 3;2 1 3 2;2 2 1 2;2 3 5/6 -9/5;6 3 5/6 12/5];

syms E I L Fp
K = sym('[0 0 0;0 0 0;0 0 0]');

i = 1;
l = 3*L;
A = 12*sqrt(2)*I/l^2;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
Alpha = 0;
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
K(idx,idx) = K(idx,idx) + k_e(idx2,idx2);

i = 2;
l = 2*L;
A = 12*sqrt(2)*I/l^2;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
Alpha = 0;
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
K(idx,idx) = K(idx,idx) + k_e(idx2,idx2);

i = 3;
l = 5/2*L;
A = 12*sqrt(2)*I/l^2;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
Alpha = atan(3/4)+pi/2;
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
K(idx,idx) = K(idx,idx) + k_e(idx2,idx2);


ENL = sym('[0;0;0]');
Fp_e = sym('[0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;0 0 0]');
for i = 1:size(Force_All,1)
    No_bar = Force_All(i,2);
    l = L*bar(No_bar,4);
    Alpha = bar(No_bar,5)/180*pi;
    if No_bar == 3
        Alpha = atan(3/4)+pi/2;
    end
    switch Force_All(i,1)
        case 2
            a = L*Force_All(i,3);
            Fp_e_F =  Fp*Force_All(i,4);
            b = l - a;
            F_bar_P = [0;-Fp_e_F*b^2/l^2*(1+2*a/l);-Fp_e_F*a*b^2/l^2;...
                       0;-Fp_e_F*a^2/l^2*(1+2*b/l);Fp_e_F*a^2*b/l^2];
        case 6
            a = L*Force_All(i,3);
            Fp_e_F =  Fp*Force_All(i,4);
            b = l - a;
            F_bar_P = [-Fp_e_F*b/l;0;0;-Fp_e_F*a/l;0;0];
        otherwise
            disp('ILLEGAL INPUT!')
    end
    temp = [cos(Alpha) sin(Alpha) 0;
            -sin(Alpha) cos(Alpha) 0;
            0 0 1];
    temp(abs(temp)<1e-10) = 0;
    T = [temp,zeros(3,3);zeros(3,3),temp];
    P_bar_e = -F_bar_P;
    P_e = T'*P_bar_e;
    Fp_e(:,No_bar) = Fp_e(:,No_bar) + P_e;
    idx = [node(bar(No_bar,2),[0,node(bar(No_bar,2),2:4)]>0),node(bar(No_bar,3),[0,node(bar(No_bar,3),2:4)]>0)];
    idx2 = [node(bar(No_bar,2),2:4)>0,node(bar(No_bar,3),2:4)>0];
    ENL(idx) = ENL(idx) + P_e(idx2);
end


F_bar = sym('[0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;0 0 0]');
Delta = K\ENL;

i = 1;
l = 3*L;
A = 12*sqrt(2)*I/l^2;
Alpha = 0;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
Delta_e = sym('[0;0;0;0;0;0]');
Delta_e(idx2) = Delta(idx);
(k_e*Delta_e - Fp_e(:,i))
F_bar(:,i) = T*(k_e*Delta_e - Fp_e(:,i))


i = 2;
l = 2*L;
A = 12*sqrt(2)*I/l^2;
Alpha = 0;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
Delta_e = sym('[0;0;0;0;0;0]');
Delta_e(idx2) = Delta(idx);
(k_e*Delta_e - Fp_e(:,i))
F_bar(:,i) = T*(k_e*Delta_e - Fp_e(:,i))


i = 3;
l = 5/2*L;
A = 12*sqrt(2)*I/l^2;
Alpha = atan(3/4)+pi/2;
k_bar_e = [E*A/l 0 0 -E*A/l 0 0;
           0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3  6*E*I/l^2;
           0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l;
           -E*A/l 0 0 E*A/l 0 0;
           0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3  -6*E*I/l^2;
           0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l];
temp = [cos(Alpha) sin(Alpha) 0;
        -sin(Alpha) cos(Alpha) 0;
        0 0 1];
temp(abs(temp)<1e-10) = 0;
T = [temp,zeros(3,3);zeros(3,3),temp];
k_e = T'*k_bar_e*T;
idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
Delta_e = sym('[0;0;0;0;0;0]');
Delta_e(idx2) = Delta(idx);
(k_e*Delta_e - Fp_e(:,i))
F_bar(:,i) = T*(k_e*Delta_e - Fp_e(:,i))