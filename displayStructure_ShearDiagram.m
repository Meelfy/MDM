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
function displayStructure_ShearDiagram(bar,node,F_bar,Force_All)
    node_coordinate = displayStructure_original(bar,node);
    RESOLUTION = 0.01;

    % 计算尺度变换的大小
    shear_Scale = max(max(bar(:,4)))/4/max(max(abs(F_bar([2,5],:))));
    
    for i = 1:size(bar)
        shear_left  = -F_bar(2,i);
        shear_right = F_bar(5,i);

        x_local = 0:RESOLUTION:bar(i,4);

        % 使用两点式计算y坐标，bar(i,4)为杆件长度
        y_local = shear_left + (shear_right - shear_left)*x_local/bar(i,4);

        for j = 1:size(Force_All,1)
            if Force_All(j,1) == 1 & Force_All(j,2) == i
                % 当前杆件存在分布力
            end
        end

        % 对y进行尺度变换
        y_local = y_local*shear_Scale;

        % 对两端原点添加回连的线
        y_local(1) = 0;
        y_local(end) = 0;

        % 对坐标进行旋转
        bar_Alpha = bar(i,5)/180*pi;
        bar_Alpha = -bar_Alpha;
        T = [cos(bar_Alpha) -sin(bar_Alpha);
            sin(bar_Alpha) cos(bar_Alpha)];
        temp = T*[x_local;y_local];
        x_local = temp(1,:);
        y_local = temp(2,:);
        clear temp;

        % 对坐标进行平移
        x_local = x_local + node_coordinate(bar(i,2),1);
        y_local = y_local + node_coordinate(bar(i,2),2);

        hold on
        plot(x_local,y_local,'r-');
    end
    hold off