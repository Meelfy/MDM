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
%
% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.
function K = assembledStiffnessMatrix(bar,node)
    K = zeros(max(max(node(:,2:end))));
    bar_num = size(bar,1);
    for i = 1:bar_num
        EA = bar(i,6);
        l = bar(i,4);
        EI = bar(i,7);
        Alpha = bar(i,5)/180*pi;
        k_bar_e = [EA/l 0 0 -EA/l 0 0;
                   0 12*EI/l^3 6*EI/l^2 0 -12*EI/l^3  6*EI/l^2;
                   0 6*EI/l^2 4*EI/l 0 -6*EI/l^2 2*EI/l;
                   -EA/l 0 0 EA/l 0 0;
                   0 -12*EI/l^3 -6*EI/l^2 0 12*EI/l^3  -6*EI/l^2;
                   0 6*EI/l^2 2*EI/l 0 -6*EI/l^2 4*EI/l];
        temp = [cos(Alpha) sin(Alpha) 0;
                -sin(Alpha) cos(Alpha) 0;
                0 0 1];
        temp(abs(temp)<1e-10) = 0;
        T = [temp,zeros(3,3);zeros(3,3),temp];
        k_e = T'*k_bar_e*T;
        idx = [node(bar(i,2),[0,node(bar(i,2),2:4)]>0),node(bar(i,3),[0,node(bar(i,3),2:4)]>0)];
        idx2 = [node(bar(i,2),2:4)>0,node(bar(i,3),2:4)>0];
        K(idx,idx) = K(idx,idx) + k_e(idx2,idx2);
    end
end