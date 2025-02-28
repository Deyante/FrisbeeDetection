function [xb, yb] = f_barycentre(I)
    % Fonction qui calcule le barycentre d'une image binaire
    % I : image binaire (matrice de 0 et 1)
    
    [h, w] = size(I);  % Taille de l'image
    xi = 0;  % Coordonnée x du barycentre
    yi = 0;  % Coordonnée y du barycentre
    nix = 0; % Compteur des pixels pour les colonnes
    niy = 0; % Compteur des pixels pour les lignes
    
    % Calcul du barycentre pour les lignes (yb) et les colonnes (xb)
    for l = 1:h
        for m = 1:w
            if I(l, m) > 0  % Si le pixel est 1
                % Calcul pour les lignes
                yi = yi + l;
                niy = niy + 1;
                
                % Calcul pour les colonnes
                xi = xi + m;
                nix = nix + 1;
            end
        end
    end
    
    % Calcul des barycentres
    if niy > 0
        yb = yi / niy;  % Barycentre des lignes
    else
        yb = 0;  % Aucun pixel trouvé, donc le barycentre est nul
    end
    
    if nix > 0
        xb = xi / nix;  % Barycentre des colonnes
    else
        xb = 0;  % Aucun pixel trouvé, donc le barycentre est nul
    end
end
