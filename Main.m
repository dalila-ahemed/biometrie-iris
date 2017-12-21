clc ;
clear all ;
dossier = 'learningdb';
extension = 'jpg';
filelist = dir([dossier,'/*',extension]);

dossier2 = 'test db';
extension2 = 'jpg';
filelist2 = dir([dossier2,'/*',extension2]);
n = length(filelist);


res = zeros(10,6);
for i=1:10
    file = strcat(dossier,string('/'),filelist(i).name);
    [segmentediris,x_pupil,y_pupil,irisradius,pupilradius] = Segmentation(char(file));
    img = Normalizing(segmentediris,80,120,x_pupil,y_pupil,irisradius,pupilradius);
    [ent,var,cv,contraste,energy] = Iriscode(img);
    name = filelist(i).name;
    classe = name(5);
    
    res(i,1)= str2double(classe);
    res(i,2)=var;
    res(i,3)= ent;
    res(i,4)= cv;
    res(i,5)= contraste;
    res(i,6)= energy;
end
disp(res);

n=0;
dist = zeros(10,2);
res2 = zeros(10,6);
taux = zeros(24,2);
for k=1:24
    file = strcat(dossier2,string('/'),filelist2(k).name);
    name = filelist2(k).name;
    classe = name(5);
    taux(k,1)= str2double(classe);
    for i=1:10
        [segmentediris,x_pupil,y_pupil,irisradius,pupilradius] = Segmentation(char(file));
        img = Normalizing(segmentediris,80,120,x_pupil,y_pupil,irisradius,pupilradius);
        [ent,var,cv,contraste,energy] = Iriscode(img);
        dist(i,1)= sqrt((res(i,2)-ent)^2+(res(i,3)-var)^2+(res(i,4)-cv)^2+(res(i,5)-contraste)^2+(res(i,6)-energy)^2);
        dist(i,2)= res(i,1);
        n=n+1;
        if n==10
            [val,indice] = min(dist);
            disp(dist(indice(1),2));
            taux(k,2)= dist(indice(1),2);
        end
        
    end
    n=0;
end
count = 0;
for i=1:size(taux,1)
    if taux(i,1)== taux(i,2)
        count = count+1;
    end
    
end
count = round (count/0.24);
strcat('Taux de réussite : ', ' ',int2str(count), ' %')











