function [In] = f_normal(Im)
%2024 9 12 by Anant KAKA/Théo PIPI
Im=double(Im);
M=max(max(Im)) ;
m=min(min(Im));
In= (Im-m)./(M-m);  % ./ permet de faire une division terme à terme
end