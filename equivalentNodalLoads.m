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
function [ENL,Fp_e] = equivalentNodalLoads(Force_All,bar,node)
    ENL = zeros(max(max(node(:,2:end))),1);
    Fp_e = zeros(6,size(bar,1));
    for i = 1:size(Force_All,1)
        bar_number = Force_All(i, 2);
        bar_length = bar(bar_number,4);
        bar_Alpha  = bar(bar_number,5)/180*pi;
        switch Force_All(i,1)
            case 1
                a = Force_All(i, 3);
                q = Force_All(i,4);
                F_bar_P = [0;-q*a*(1-a^2/bar_length^2+a^3/2/bar_length^3);-q*a^2/12*(6-8*a/bar_length+3*a^2/bar_length^2);...
                           0;-q*a^3/bar_length^2*(1-a/2/bar_length);q*a^3/12/bar_length*(4-3*a/bar_length)];
            case 2
                a = Force_All(i, 3);
                Fp_e_F =  Force_All(i, 4);
                b = bar_length - a;
                F_bar_P = [0; -Fp_e_F*b^2/bar_length^2*(1+2*a/bar_length); -Fp_e_F*a*b^2/bar_length^2;...
                           0; -Fp_e_F*a^2/bar_length^2*(1+2*b/bar_length); Fp_e_F*a^2*b/bar_length^2];
            case 6
                a = Force_All(i,3);
                Fp_e_F =  Force_All(i,4);
                b = bar_length - a;
                F_bar_P = [-Fp_e_F*b/bar_length; 0; 0; -Fp_e_F*a/bar_length;0;0];
            otherwise
                disp('ILLEGAL INPUT!')
        end
        temp = [cos(bar_Alpha) sin(bar_Alpha) 0;
                -sin(bar_Alpha) cos(bar_Alpha) 0;
                0 0 1];
        temp(abs(temp)<1e-10) = 0;
        T = [temp,zeros(3,3);zeros(3,3),temp];
        P_bar_e = -F_bar_P;
        P_e = T'*P_bar_e;
        if ~((a == bar_length | a == 0) && Force_All(i,1) == 2)
            Fp_e(:,bar_number) = Fp_e(:,bar_number) + P_e;
        end
        idx = [node(bar(bar_number,2),[0,node(bar(bar_number,2),2:4)]>0),node(bar(bar_number,3),[0,node(bar(bar_number,3),2:4)]>0)];
        idx2 = [node(bar(bar_number,2),2:4)>0,node(bar(bar_number,3),2:4)>0];
        ENL(idx) = ENL(idx) + P_e(idx2);
    end
end