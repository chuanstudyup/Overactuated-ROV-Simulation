function plotTrack(logsout)
X = logsout{25}.Values.Data;
Y = logsout{26}.Values.Data;
Yaw = logsout{3}.Values.Data;

hold on;box on;grid on;axis equal;
color = [rand rand rand];
plot(Y,X,'color',color,'LineWidth',1);
drawusv(Y(1),X(1),Yaw(1),0.2,color,0.3);
drawusv(Y(end),X(end),Yaw(end),0.2,color,0.3);

% Len = size(X,1);
% usv_num = 11;
% for i=1:usv_num-1
%     p = fix(Len*i/usv_num);
%     drawusv(Y(p),X(p),Yaw(p),0.2,color,0.3);
% end

end