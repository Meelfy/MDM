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
function node_coordinate = displayStructure_original(bar,node)
    nodeNum = max(max(bar(:,2:3)));
    barNum = size(bar,1);

    % 因为原结构存在两个节点胶接的情况，所以需要将胶接的节点变为一根长度为0的杆件
    for i = 1:barNum - 1
        for j = (i + 1):barNum
            num_prev = bar(j,2);
            num_next = bar(j,3);
            if node(bar(i,2),2:3) == node(num_prev,2:3) & sum(node(bar(i,2),2:3)) > 0
                temp_barNum = size(bar,1);
                bar(temp_barNum + 1,:) = [temp_barNum + 1, bar(i,2), num_prev,0 0 0 0];
            elseif node(bar(i,2),2:3) == node(num_next,2:3) & sum(node(bar(i,2),2:3)) > 0
                temp_barNum = size(bar,1);
                bar(temp_barNum + 1,:) = [temp_barNum + 1, bar(i,2), num_next,0 0 0 0];
            elseif node(bar(i,3),2:3) == node(num_prev,2:3) & sum(node(bar(i,3),2:3)) > 0
                temp_barNum = size(bar,1);
                bar(temp_barNum + 1,:) = [temp_barNum + 1, bar(i,3), num_prev,0 0 0 0];
            elseif node(bar(i,3),2:3) == node(num_next,2:3) & sum(node(bar(i,3),2:3)) > 0
                temp_barNum = size(bar,1);
                bar(temp_barNum + 1,:) = [temp_barNum + 1, bar(i,3), num_next,0 0 0 0];
            end
            if bar(end,2) == bar(end,3)
                bar = bar(1:end-1,:);
            end
        end
    end


    node_coordinate = zeros(nodeNum,3);
    % 第三位标定结果是否已经计算出来
    node_coordinate(1,3) = 1;% 第一个点默认（0，0）
    for i = 1:nodeNum
        for j = 1:size(bar,1)
            num_now = i;
            num_prev = bar(j,2);
            num_next = bar(j,3);
            bar_length = bar(j,4);
            bar_Alpha = bar(j,5)/180*pi;
            if bar(j,2) == num_now & node_coordinate(num_next,3) ~= 1
                node_coordinate(num_next,1) = node_coordinate(num_now,1) + bar_length*cos(bar_Alpha);
                node_coordinate(num_next,2) = node_coordinate(num_now,2) - bar_length*sin(bar_Alpha);
                node_coordinate(num_next,3) = 1;
            elseif bar(j,3) == num_now & node_coordinate(num_prev,3) ~= 1
                node_coordinate(num_prev,1) = node_coordinate(num_next,1) - bar_length*cos(bar_Alpha);
                node_coordinate(num_prev,2) = node_coordinate(num_next,2) + bar_length*sin(bar_Alpha);
                node_coordinate(num_prev,3) = 1;
            end
        end
    end

    for i = 1:size(bar,1)
        num_prev = bar(i,2);
        num_next = bar(i,3);
        plot(node_coordinate([num_prev,num_next],1),node_coordinate([num_prev,num_next],2),'k-');
        hold on;
    end
    axis equal
    axis off
    hold off