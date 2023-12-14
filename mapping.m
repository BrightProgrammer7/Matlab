function [ symboles ] = mapping( data,modulation )

[ constellation,k ] = alphabet( modulation);
%---conversion serie parallèle-----
data_m = reshape(data,k,[])'; %--les crochès permet de reorganiser les lignes sous forme d'une matrice 

%----conversion binaire decimal---
decimals = bi2de(data_m);

%---conversion dicimal to complexe ---
symboles = constellation(decimals +1); % +1 parceque matlab ne connais pas 0 c-a-d ne commence pas par 0  



end