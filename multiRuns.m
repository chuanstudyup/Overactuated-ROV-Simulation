%% 设置仿真输入
N = 8; %仿真次数
R = 10; %半径
target_P = [0 0 5]; %目标位置
target_Yaw = 90; %目标艏向

%% 根据N和R计算出N个初始位置和艏向
P0 = zeros(N,4);
for i=1:N
    rad = i*2*pi/N;
    P0(i,1) = cos(rad)*R; %初始水平位置均布在半径为R的圆上
    P0(i,2) = sin(rad)*R;
    P0(i,3) = 0.5;  %初始深度为0.5
    P0(i,4) = rand*360; %初始艏向为0-360的随机值
end

%% 将目标位姿设置到simulink中
set_param('ROVSim_dp','SimulationMode','accelerator');
set_param('ROVSim_dp/Cmd Yaw 0-360 [Deg]','Value',num2str(target_Yaw));
set_param('ROVSim_dp/Cmd Position X Y Z [m]','Value',sprintf('[%d %d %d]',target_P(1),target_P(2),target_P(3)));

%% 重置绘图
close all
figure
hold on; box on; grid on;
xlabel('Y[m]');
ylabel('X[m]');
axis equal;

drawusv(target_P(2),target_P(1),target_Yaw,0.2,[0 0 0],0); %绘制目标位姿

%% 循环仿真
for i=1:N
    i
    set_param('ROVSim_dp/Kinematics','x0',num2str( P0(i,1),'%.2f'),...
               'y0',num2str(P0(i,2),'%.2f'),...
               'z0',num2str(P0(i,3),'%.2f'),...
                'yaw0',num2str(P0(i,4),'%.2f'));%设置初始位姿
    sim('ROVSim_dp');
    out(i) = logsout; %将所有仿真记录数据保持到out数组中
    plotTrack(out(i)); %绘制仿真轨迹
end