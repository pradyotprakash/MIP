function [integral] = myIntegration(image,t,theta,deltas)
%MYINTEGRATION Integrates on image along the line parametrized t, theta
theta=deg2rad(theta);

[dimx,dimy] = size(image);
center = [t*cos(theta)+dimx/2+0.5,t*sin(theta)+dimy/2+0.5];
integral=0;

point=center;
while point(1)<=dimx && point(2)<=dimy && point(1)>=1 && point(2)>=1
    integral = integral + interp2(image,point(1),point(2))*deltas;
    point(1) = point(1)+deltas*sin(theta);
    point(2) = point(2)-deltas*cos(theta);
end

point=center;
point(1) = point(1)-deltas*sin(theta);
point(2) = point(2)-deltas*cos(theta);
while point(1)<=dimx && point(2)<=dimy && point(1)>=1 && point(2)>=1
    integral = integral + interp2(image,point(1),point(2))*deltas;
    point(1) = point(1)-deltas*sin(theta);
    point(2) = point(2)+deltas*cos(theta);
end
end

