function [ circle] = createcircle( x_pupil,y_pupil,theta,radius,im)
%Cette fonction permet d'approximer un cercle à partir de son centre et
% de son rayon et des pixels de l'image
    circle = [];
    x_circle = abs(round(radius * cos(theta) + x_pupil));
    y_circle = abs(round(radius * sin(theta) + y_pupil));
    for i=1:length(theta)
        circle = [circle im(x_circle(i)+1),im(y_circle(i)+1)];
    end

end

