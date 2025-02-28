function [response_sum, x_initial, y_initial] = f_laplacien(im, x_initial, y_initial)
% Fonction qui prend en agrument une image et une position et qui renvoie
% l'image du laplacien appliqué à l'image, ainsi que la position du
% barycentre du frisbee

s = size(im);
imgray = rgb2gray(im); % Conversion en niveaux de gris

% Paramétrage de base du filtre elliptique
n = 33; % Grosseur de  notre objet en terme de grosseur de la matrice (il faut que l'objet soit contenu dans 2*n+1 pixel en longeur)
a = 50; % Largeur du frisbee
b = 5; % Hauteur du frisbee
[x, y] = meshgrid(-n:n, -n:n); % matrice de taille (2n+1)x(2n+1)
h_base =- (4 * ((x.^2 / (2 * a^2)) + (y.^2 / (2 * b^2))) - 2) ... 
    .* exp(-((x.^2 / (2 * a^2)) + (y.^2 / (2 * b^2)))); %MATRICE CONTENANT LES VALREURS DU FILTRE A LA POSITION (x,y)

%Permet de visualiser le filtre
% figure, surf(x, y, h_base);
% title('Noyau de convolution');
% xlabel('x');
% ylabel('y');
% zlabel('Amplitude'); 

% Rotation du filtre
theta = pi/2;
h_rot = imrotate(h_base, theta, 'bilinear', 'crop');

% Convolution de l'image avec le filtre tourné
response = imfilter(double(imgray), h_rot, 'same');

% Utilisation de la réponse max, response contient des valeurs negatives
response_sum = zeros(size(imgray));
response_sum = max(response_sum, response);
t=100;
Ibary=response_sum; %pour pas modifier notre image de base
for h=1:s(1)
    for l=1:s(2)
        if (h<x_initial-t) || (h>x_initial+t) || (l<y_initial-t) || (l>y_initial+t)
            Ibary(h,l)=0;
        end
    end
end

response_sum = f_normal(response_sum);
[y_initial, x_initial] = f_barycentre(response_sum);

end

