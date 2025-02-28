function [liste_image, n] = f_extraction(video)
% Cette fonction prend en argument un video et en extrait toutes les frames
% qu'elle met dans une liste. Elle renvoie aussi le nombre total de frame

v = VideoReader(video); %import la video

%On veut maintenant toutes les images de cette video
numero_image=1;
liste_image = {};

while hasFrame(v)
    img=readFrame(v);
    liste_image{numero_image} = img;
    numero_image=numero_image+1;
end

n = numero_image - 1;

end

