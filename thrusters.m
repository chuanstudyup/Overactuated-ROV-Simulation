function tao = thrusters(u)
global auv;

tao = auv.T*(auv.K*u);

end