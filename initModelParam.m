global auv;

% The model is from 《6-DoF Modelling and Control of a Remotely Operated Vehicle》

auv.m = 11.5; %kg
auv.W = 112.8; %N
auv.B = 114.8; %N
auv.Ixx = 0.16;
auv.Iyy = 0.16;
auv.Izz = 0.16;

auv.xg = 0; %m
auv.yg = 0;
auv.zg = 0.02;
auv.xb = 0; %m
auv.yb = 0;
auv.zb = 0;

auv.Xdotu = -5.5;
auv.Xu = -4.03;
auv.Xuu = -18.18;

auv.Ydotv = -12.7;
auv.Yv = -6.22;
auv.Yvv = -21.66;

auv.Zdotw = -14.57;
auv.Zw = -5.18;
auv.Zww = -36.99;

auv.Kdotp = -0.12;
auv.Kp = -0.07;
auv.Kpp = -1.55;

auv.Mdotq = -0.12;
auv.Mq = -0.07;
auv.Mqq = -1.55;

auv.Ndotr = -0.12;
auv.Nr = -0.07;
auv.Nrr = -1.55;

auv.M = [auv.m-auv.Xdotu,0,0,0,auv.m*auv.zg,0;
    0,auv.m-auv.Ydotv,0,-auv.m*auv.zg,0,0;
    0,0,auv.m-auv.Zdotw,0,0,0;
    0,-auv.m*auv.zg,0,auv.Ixx-auv.Kdotp,0,0;
    auv.m*auv.zg,0,0,0,auv.Iyy-auv.Mdotq,0;
    0,0,0,0,0,auv.Izz-auv.Ndotr];
auv.Mni = auv.M^-1;

% tao = T*K*u
auv.K = diag([40,40,40,40,40,40,40,40]);
auv.T = [0.707 0.707 -0.707 -0.707 0 0 0 0;
         -0.707 0.707 -0.707 0.707 0 0 0 0;
         0 0 0 0 -1 1 1 -1;
         0.06 -0.06 0.06 -0.06 -0.218 -0.218 0.218 0.218;
         0.06 0.06 -0.06 -0.06 0.120 -0.1208 0.120 -0.120;
         -0.1888 0.1888 0.1888 -0.1888 0 0 0 0];
 auv.Kni = auv.K^-1;
 auv.Tni = pinv(auv.T);