function [n_sinal, x_sinal] = getBloco(Sinal,Sinal_H,corte)
index = find(Sinal_H > corte(1) & Sinal_H < corte(end));
n_sinal=Sinal(index,:);
x_sinal=Sinal_H(index,:);%eixo x do bloco
end