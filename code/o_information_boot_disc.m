function o=o_information_boot_disc(X,indsample,indvar)
X=X(indsample,indvar);
% this function takes thw whole X as input, and additionally the indices
% convenient for bootstrap
%X size is N (samples) x M(variables)
[N, M]=size(X);

XX=X(:,1);
for icond=2:M
     XX=mergemultivariables(XX,X(:,icond));
end
o = (M-2)*entropy(XX);
for j=1:M
     X1=X;X1(:,j)=[];
     XX=X1(:,1);
     for icond=2:M-1
         XX=mergemultivariables(XX,X1(:,icond));
     end
     o=o+entropy(X(:,j))- entropy(XX);
end