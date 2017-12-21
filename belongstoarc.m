function [ boolean ] = belongstoarc( x,xc,y,yc,r,startangle,endangle )
%Cette fonction vérifie qu'un point de coordonnées (x,y) appartient à un arc 
% de centre (xc,yc), de rayon r et d'angle de départ et de fin : startangle/endangle 
boolean = false;
theta = atan((y-yc)/(x-xc));
distance = sqrt((x-xc)^2+(y-yc)^2);

b1 = theta >= startangle & theta <= endangle;
b2 = distance <= r;

if (b1& b2)
    boolean = true;
end

end

