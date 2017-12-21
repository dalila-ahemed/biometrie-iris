
function normalizedimage=Normalizing(img,radiis,angles,xc,yc,irisradius,pupilradius)
% Cette fonction permet de dérouler l'iris 
img = im2double(img);
normalizedimage = zeros(radiis,angles);
angle_sampling = 2*pi/angles;
  
for x= 1:radiis
    for y = 1:angles
        r = x/radiis;
        theta = y*angle_sampling;
        [xi,yi]= pol2cart(theta,irisradius);
        [xp,yp]= pol2cart(theta,pupilradius);
          x_old = round( r*(xi+xc)+(1-r)*(xp+xc));
          y_old = round( r*(yi+yc)+(1-r)*(yp+yc)); 
         %Problème de bords
         if x_old <=0
             x_old = 1;
         end
         if y_old <=0
             y_old = 1;
         end
         
         if x_old > size(img,2)
             x_old = size(img,2);
         end
         
         if y_old > size(img,1)
            y_old = size(img,1);
         end

          normalizedimage(x,y) = img(y_old,x_old);

    end
end
% figure;
% normalizedimage = histeq(normalizedimage);
% imshow(normalizedimage);title('Image normalisée ');
end





