Matrix displacement method
==========================

该文件用来说明结构力学2大作业Matrix displacement method的相关内容，所有数据文件文件和源码文件采用UTF-8编码。
- Author:     梅杰
- Student No: 2014010348
- Class No:   水工43


实现功能
--------

根据[结构力学教程]第九章的主要内容，本人基于

    MATLAB 版本: 9.0.0.341360 (R2016a)
    MATLAB 许可证编号: 123456
    操作系统: Microsoft Windows 10 家庭中文版 Version 10.0 (Build 14393)
    Java 版本: Java 1.7.0_60-b19 with Oracle Corporation Java HotSpot(TM) 64-Bit Server VM mixed mode

实现了矩阵位移法的计算机运算，包含以下功能：
- 单元刚度矩阵的计算
- 整体刚度矩阵的集成
- 求解线性代数方程组
- 求解病态线性方程组
- 绘制结构的内力图
- 保存各单元的杆端力向量


文件结构说明
------------

#### 输入文件结构说明

文件保存在以下目录

    /INPUT

各文件的结构如下，所有数据均以double保存，单位均为**国际单位制**

    /INPUT/bar.dat

|杆件编号|起始节点|终止节点|长度l|倾角|EA|EI|
|:----:|:-----:|:----:|:-----:|:----:|:----:|:----:|
 

    /INPUT/node.dat

|节点编号|u|v|θ|
|:----:|:----:|:----:|:----:|


    /INPUT/ExternalForce.dat  

  
  

受力情况暂时分为3种

第一种分布作用力数据结构如下

|受力编号1|杆件编号|a|q| 
|----|-----|----|-----|

第二种集中作用力数据结构如下

|受力编号2|杆件编号|a|F|  
|----|-----|----|-----|

第三种沿杆集中作用力

|受力编号6|杆件编号|a|F|  
|----|-----|----|-----|

当F与杆件正方向相同为正

* 具体参数含义可参照课本P325表9-1  

#### 输出文件结构说明

输出文件保存在

    /OUTPUT/FORCE.dat

输出各个杆件的杆端力向量，文件为 6*n 的矩阵，第 i 个杆件的杆端力向量保存在第 i 列。

算法亮点
--------

#### 求解病态线性方程组

因为所给的两个矩阵为[病态矩阵]，[条件数]分别为802.0911(问题1)，1613.8094(问题2)，已经远大于1，方程的微小摄动会引起解的很大变化。所以基于Matlab的``Symbolic Math Toolbox 版本 7.0 (R2016a)``进行了符号化运算，在求得矩阵位移法基本方程的精确解。同时，因为矩阵位移法需要求解的基本方程多为病态矩阵，所以符号求解具有一定的的必要性。

#### 程序的鲁棒性

本程序对多数常见的情况均适用，本人已经测试了第九章所有要求写的作业题:blush:，均与手算结果以及参考答案一致，具有较好的适应性。

运行结果
--------

### 问题一的运行结果为
<div align="center">
    <img src="https://github.com/MajorChina/MDM/blob/master/img/Image_001.png" width="550">
</div>

### 问题二的运行结果为
<div align="center">
    <img src="https://github.com/MajorChina/MDM/blob/master/img/Image_002.png" width="550">
</div>
### Function description

- 程序的入口
    main.m 


License
-------
Copyright 2016 梅杰 or Major

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; If not, see 
    
    http://www.gnu.org/licenses

[结构力学教程]: http://www.hep.com.cn/book/details?uuid=528838e6-1414-1000-b576-3fafc67de19c&objectId=oid:52883919-1414-1000-b577-3fafc67de19c
[病态矩阵]:     http://mathworld.wolfram.com/Ill-ConditionedMatrix.html
[条件数]:       https://en.wikipedia.org/wiki/Condition_number