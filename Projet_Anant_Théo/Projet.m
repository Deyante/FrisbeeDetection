clear all;
close all;



% Chargement de la vidéo et extraction des images que l'on range dans une
% matrice
[liste_im, nombre_frame] = f_extraction('Foret.mp4');

% Image initiale
im = liste_im{1};

% Position initiale du frisbee (à définir manuellement ou avec un clic)
% [x_initial, y_initial] = f_position_initiale(im); % Si vous voulez
% definir vous même la position du frisbee
[x_initial,y_initial] = f_position_initiale(im);    % Position initiale du frisbee en X
   % Position initiale du frisbee en Y

u = 20; % taille de la boite pour l'analyse des features
v = 30; % taille du rectangle de detection à la fin

% Définition de la zone carrée de recherche initiale autour du frisbee
x_min = x_initial - u;
x_max = x_initial + u;
y_min = y_initial - u;
y_max = y_initial + u;

% Calcul de l'image du Laplacien autour du frisbee
[im_lap,cccc,ccccs] = f_laplacien(im, x_initial, y_initial);
% im_lap_reduit = im_lap(x_min:x_max, y_min:y_max, :);
% im_lap_reduit = im_lap_reduit > 0.1;

% Mise en mémoire du laplacien precedent, afin de faire des differences par
% la suite
prev_im_lap = im_lap;

% Définition d'une boîte autour du frisbee
x_min1 = x_initial - v;
x_max1 = x_initial + v;
y_min1 = y_initial - v;
y_max1 = y_initial + v;

% Initialisation des coordonnées du barycentre du frisbee
x_bary = x_initial;
y_bary = y_initial;

% ----------- Affichage du premier cadre -------------------

imshow(im);
hold on;

% Création du rectangle autour de la zone de suivi
rectangle('Position', [y_min1, x_min1, (y_max1 - y_min1), (x_max1 - x_min1)], 'EdgeColor', 'r', 'LineWidth', 3);

hold off;

% -------------------------------------------------------------

% Boucle permettant de parcourir toutes les frames de la vidéo
for t = 2:nombre_frame
    % Définition de la nouvelle image de travail
    im = liste_im{t};

    % Utilisation du laplacien orienté pour definir l'orientation du frisbee
    [im_lap, x_initial, y_initial] = f_laplacien(im, x_initial, y_initial);

    % Création de l'image definissant la diffèrence des laplaciens entre
    % l'image actuelle et la precèdente ainsi on obtient le seul objet
    % detecté par le laplacien qui a bougé (=notre frisbee)
    im_diff_lap = im_lap - prev_im_lap;
    % Actualisation de l'image precèdente
    prev_im_lap = im_lap;

    if (x_bary ~= 0) && (y_bary ~=0) %Condition pour que si le frisbee sort de l'image, on puisse le redetecter lorsqu'il reviendra dans l'image
        s=size(im_diff_lap);
        b=100;
        for h=1:s(1)
            for l=1:s(2)
                if (h<x_bary-b) || (h>x_bary+b) || (l<y_bary-b) || (l>y_bary+b)
                    im_diff_lap(h,l)=0;
                end
            end
        end
    end

    % Seuillage de la différence du Laplacien
    im_diff_lap = im_diff_lap > 0.1;

    % Calcul du barycentre de la différence du Laplacien
    [y_bary, x_bary] = f_barycentre(im_diff_lap); %x et y sont inversés à cause de la fonctoin barycentre qui a la convention opposé pour x et y

    % Définition de la zone autour du barycentre pour l'affichage
    x_min = x_bary - v;
    x_max = x_bary + v;
    y_min = y_bary - v;
    y_max = y_bary + v;

    % Affichage de l'image avec le rectangle de suivi autour du barycentre
    imshow(im);
    hold on;
    rectangle('Position', [y_min, x_min, (y_max - y_min), (x_max - x_min)], 'EdgeColor', 'r', 'LineWidth', 3);
    hold off;
    getframe(gca); % Capture de la trame
end
close(outputVideo);