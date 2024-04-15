function Out = AuvMathModel(In)
% In = [u;v;w;p;q;r(rad/s);phi(rad);theta(rad);tao(N,N,N,Nm,Nm,Nm)]
% Out = [dotu;dotv;dotw;dotp;dotq;dotr(rad/s/s)]

% The model is from 《6-DoF Modelling and Control of a Remotely Operated Vehicle》

u = In(1);
v = In(2);
w = In(3);
p = In(4);
q = In(5);
r = In(6);
phi = In(7);
theta = In(8);
tao = In(9:14);
V = In(1:6);

global auv;

C_RB = [0 0 0 0 auv.m*w 0;
     0 0 0 -auv.m*w 0 0;
     0 0 0 auv.m*v -auv.m*u 0;
     0 auv.m*w -auv.m*v 0 auv.Izz*r -auv.Iyy*q;
     -auv.m*w 0 -auv.m*u -auv.Izz*r 0 auv.Ixx*p;
     auv.m*v -auv.m*u 0 auv.Iyy*q -auv.Ixx*p 0];
C_A = [0 0 0 0 auv.Zdotw*w 0;
       0 0 0 -auv.Zdotw*w 0 -auv.Xdotu*u;
       0 0 0 -auv.Ydotv*v auv.Xdotu*u 0;
       0 -auv.Zdotw*w auv.Ydotv*v 0 auv.Ndotr*r auv.Mdotq*q;
       auv.Zdotw*w 0 -auv.Xdotu*u auv.Ndotr*r 0 -auv.Kdotp*p;
       -auv.Ydotv*v auv.Xdotu*u 0 -auv.Mdotq*q auv.Kdotp*p 0];

D = -diag([auv.Xu+auv.Xuu*abs(u), auv.Yv+auv.Yvv*abs(v), auv.Zw+auv.Zww*abs(w), auv.Kp+auv.Kpp*abs(p), auv.Mq+auv.Mqq*abs(q), auv.Nr+auv.Nrr*abs(r)]);

g = [(auv.W-auv.B)*sin(theta);
    -(auv.W-auv.B)*cos(theta)*sin(phi);
    -(auv.W-auv.B)*cos(theta)*cos(phi);
    auv.zg*auv.W*cos(theta)*sin(phi);
    auv.zg*auv.W*sin(theta);
    0];

Fsum = tao-C_RB*V-C_A*V-D*V-g;

Out = auv.Mni*Fsum;
end