function [ ent,variance,CV,contraste,energy ] = Iriscode( normalisedimage )
%Cette fonction permet de réaliser une signature de l'iris à partir 
% 5 descripteurs de texture
[row column values] = find(normalisedimage);

ent = entropy(values);
variance = var(values);
variance = variance * 500;
CV = mean(values)/sqrt(variance);
CV = CV*10;
contraste = (max(values)-min(values))/(max(values)+min(values));
contraste = contraste*10;
square = values.*values;
energy = sum(square);
energy = energy/1000;
end

