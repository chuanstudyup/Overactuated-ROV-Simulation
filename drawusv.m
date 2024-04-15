function drawusv(x0,y0,yaw,scale,Facecolor,FaceAlpha)

RadiusSize = 1*scale;
LengthSize = 2*scale;

if(yaw < 90)
    psi = (90-yaw)/57.3;
else
    psi = (450-yaw)/57.3;
end

R = [cos(psi) -sin(psi);
    sin(psi) cos(psi)];

t = linspace(-pi/2,pi/2,30);
x1 = RadiusSize*cos(t) + LengthSize/3;
y1 = RadiusSize*sin(t);
x2 = [LengthSize 0 0 LengthSize]-2*LengthSize/3;
y2 = [RadiusSize RadiusSize -RadiusSize -RadiusSize];

V = [x1 x2;y1 y2];
V = R*V;
x = V(1,:)+x0;
y = V(2,:)+y0;

patch(x,y,Facecolor,'EdgeAlpha',1,'FaceAlpha',FaceAlpha,'EdgeColor',[0.5 0 0],'EdgeLighting','flat','LineWidth',1);
hold on
line([(x(end-2) + x(end-1))/2,(x(15) + x(16))/2],[(y(end-2) + y(end-1))/2,(y(15) + y(16))/2],'Color',[0.5 0 0],'LineWidth',1);
hold on

% Xarrow = (x(15) + x(16))/2 + LengthSize/2*cos(course);
% Yarrow = (y(15) + y(16))/2 + LengthSize/2*sin(course);
% line([x0,Xarrow],[y0,Yarrow],'Color','green','LineWidth',1);
% hold on
end