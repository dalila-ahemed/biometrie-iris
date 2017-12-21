function [boolean ] = belongstosquare( x,xc,y,yc,r,angle )
%BELONGSTOSQUARE Summary of this function goes here
%   Detailed explanation goes here
boolean = false;
% a = (x<= xc+(r/(sqrt(2)))& x>= xc-(r/(sqrt(2))));
% b = (y<= yc+(r/(sqrt(2)))& y>= yc-(r/(sqrt(2))));
width = r*cos(angle); 
height = r*sin(angle); 
a = (x<= xc+width & x>= xc-width);
b = (y<= yc+height & y>= yc-height);

if(a&b)
    boolean = true;
end

end

