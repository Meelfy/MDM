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
function displayStructure(bar,node,F_bar,Force_All)
    figure;
    set(gcf,'color','w')
    % 原结构
    subplot(2,2,1)
    node_coordinate = displayStructure_original(bar,node);
    title('Original Structure','fontsize',16)
    % M图
    subplot(2,2,2)
    displayStructure_BendingMoment(bar,node,F_bar,Force_All);
    title('Bending moment diagram','fontsize',16)
    % FQ图
    subplot(2,2,3)
    displayStructure_ShearDiagram(bar,node,F_bar,Force_All);
    title('Shear Diagram','fontsize',16)
    % FN图
    subplot(2,2,4)
    displayStructure_AxialForceDiagram(bar,node,F_bar,Force_All);
    title('Axial Force Diagram','fontsize',16)
end