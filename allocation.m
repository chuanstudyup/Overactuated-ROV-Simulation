function u = allocation(tao)
%out = [u1;u2;u3;u4;u5;u6;u7;u8]

global auv;

u = auv.Kni*(auv.Tni*tao);

end