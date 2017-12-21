function [segmentediris,center_pupil_x,center_pupil_y,iris_radius,pupil_radius] = Segmentation(file)
%Cette fonction permet de segmenter l'iris en maximisant différents
%gradients circulaires
im = imread(file);

%% Prétraitement
%Première étape: Redimensionnement
im = im2double(im);
im = imresize(im,0.6);
% figure;
% imshow(im);
% title('Image originale');

%Seconde étape : Supression de l'illumination
complement = imcomplement(im);
filledpupil = imfill(complement,'holes');
correctedpupil = imcomplement(filledpupil);
% figure;
% imshow(correctedpupil);
% title('Image sans artéfacts');

%Troisième étape : Seuillage dynamique de 20% des pixels les plus sombres 
[counts, color]= imhist(correctedpupil);
darkpixels = (find(counts,ceil(256*0.2),'first'))/256;


%% Détection de la pupille
%Création d'une zone d'intérêt
pupil = roicolor(correctedpupil,min(darkpixels),max(darkpixels));
% figure,imshow(pupil);

%Création d'une bounding box autour de la pupille
box = regionprops(pupil,'boundingbox');

%Détection du centre de la bounding box (et donc de la pupille)
centers = regionprops(pupil,'Centroid','Area','MajorAxisLength','MinorAxisLength');
maxarea = max([centers.Area]);
maxindex = [centers.Area] == maxarea;
center = centers(maxindex);
diameter = mean([center.MajorAxisLength center.MinorAxisLength]);
pupil_radius = diameter/2;
center_pupil_x = center.Centroid(1);
center_pupil_y = center.Centroid(2);


%% Détection de l'iris
% theta = 0:0.01:2*pi;
% Création de deux arcs de cercles
angle = pi/4;
theta1 = 0:0.01:angle;
theta2 = -angle:0.01:0;
theta= union(theta1,theta2);
gradients = [];
x_iris = [];
y_iris = [];
iris_radii = [];
% Calcul du gradient circulaire pour différents centres et rayons
for r = diameter:pupil_radius*2.5
    for x=center_pupil_x-5:center_pupil_x+5
        for y=center_pupil_y-5:center_pupil_y+5
            x_iris = [x_iris x];
            y_iris = [y_iris y];
            iris_radii = [iris_radii r];
            circle = createcircle(x,y,theta,r,correctedpupil);
            h=fspecial('prewitt');
            imx = imfilter(circle,-h);
            imy = imfilter(circle,-h');
            gradient = sqrt(imx.^2 + imy.^2);                      
            gradients = [gradients mean(gradient)];
        end
    end
end

%Selection du centre et du rayon du cercle maximisant le gradient
max_gradient = max(gradients);
indice = find(gradients == max_gradient,1,'first');
final_x_iris = round(x_iris(indice));
final_y_iris = round(y_iris(indice));
iris_radius = round(iris_radii(indice));

n=size(im,1);
m=size(im,2);
segmentediris = zeros(n,m);
% Segmentation en supprimant les occlusions
for x=1: n
    for y=1:m
          if (belongstosquare( x,final_x_iris,y,final_y_iris,iris_radius,angle)|| belongstoarc(x,final_x_iris,y,final_y_iris,iris_radius,-angle,angle))
                segmentediris(y,x)= correctedpupil(y,x);           
          end
    end
end

% 
% figure;
% imshow(segmentediris);
% title('Segmentation de l iris');


end


