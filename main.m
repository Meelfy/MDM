% Copyright 2016 梅杰 or Major
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.



%*********************** 作业一 ***********************%
clear all,clc
% 读取数据，杆件、节点和力的数据
bar       = dlmread('INPUT/bar1.dat');
node      = dlmread('INPUT/node1.dat');
Force_All = dlmread('INPUT/ExternalForce1.dat');

% 计算等效节点荷载、整体刚度矩阵和节点位移
[P,Fp_e] = equivalentNodalLoads(Force_All,bar,node);
K        = assembledStiffnessMatrix(bar,node);
if cond(K) > 1
    disp('K may be an ill-conditioned matrix, use it with care')
    disp(['cond(K) = ',num2str(cond(K))]);
    Delta = double(pinv(sym(K))*sym(P));
else
    Delta = pinv(K)*P;
end
% 计算杆端力向量
F_bar = rodEndForceVector(bar,node,Delta,Fp_e);

% 绘制原结构图、弯矩图、剪力图和轴力图
displayStructure(bar,node,F_bar,Force_All);

% 输出杆端力向量
dlmwrite('OUTPUT/FORCE1.dat', F_bar, 'delimiter', '\t');
%******************** 作业一结束 ********************%



fprintf('Program paused. Press enter to continue.\n');
pause;



%*********************** 作业二 ***********************%
% 读取数据，杆件、节点和力的数据
bar       = dlmread('INPUT/bar2.dat');
node      = dlmread('INPUT/node2.dat');
Force_All = dlmread('INPUT/ExternalForce2.dat');

% 计算等效节点荷载、整体刚度矩阵和节点位移
[P,Fp_e] = equivalentNodalLoads(Force_All,bar,node);
K        = assembledStiffnessMatrix(bar,node);
if cond(K) > 1
    disp('K may be an ill-conditioned matrix, use it with care')
    disp(['cond(K) = ',num2str(cond(K))]);
    Delta = double(pinv(sym(K))*sym(P));
else
    Delta = pinv(K)*P;
end
% 计算杆端力向量
F_bar = rodEndForceVector(bar,node,Delta,Fp_e);

% 绘制原结构图、弯矩图、剪力图和轴力图
displayStructure(bar,node,F_bar,Force_All);

% 输出杆端力向量
dlmwrite('OUTPUT/FORCE2.dat', F_bar, 'delimiter', '\t');
%********************作业二结束********************%