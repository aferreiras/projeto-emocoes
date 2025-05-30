function eegPlot(Sinal_H,Sinal,num_canais,offset_n)
figure
hold on
offset = linspace(0, num_canais-1, num_canais) * -offset_n; % Define separação entre os canais
    for i = 1:num_canais
        plot(Sinal_H, Sinal(:,i) + offset(i));  % Soma o offset a cada canal
    end
hold off
end