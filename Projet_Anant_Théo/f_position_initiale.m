function [x, y] = f_position_initiale(im)
% Fonction qui demande la position initiale du frisbee à l'utilisateur
% Charger et afficher l'image
imshow(im);
title('Cliquez sur la position initiale du frisbee');

% Utilisation de la souris pour obtenir les coordonnées
[y, x] = ginput(1);

% Marquer la position choisie sur l'image
hold on;
plot(x, y, 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Cercle rouge à la position
hold off;

% Afficher les coordonnées choisies
fprintf('Position initiale du frisbee : (%.2f, %.2f)\n', x, y);
end
