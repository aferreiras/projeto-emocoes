function [n_sinal, x_sinal] = getBloco(Sinal,Sinal_X,corte)
index = find(Sinal_X > corte(1) & Sinal_X < corte(end));
n_sinal=Sinal(index,:);
x_sinal=Sinal_X(index,:);%eixo x do bloco
end