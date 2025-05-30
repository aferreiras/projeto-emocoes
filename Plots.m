%% Plotando os sinais
%%
%original
[~,num_canais] = size(sinal);
eegPlot(t, sinal,num_canais,200)
hold on
plot(marcadores,ones(1, length(marcadores)),'b+');
title(['Sinal Original',subject_number]);
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off
%%
%filtrado e subamostrado
[~,num_canais] = size(sinal_filtrado_final);
eegPlot(t_sub, sinal_filtrado_final, num_canais , 200);
hold on
plot(marcadores,ones(1, length(marcadores)),'r+');
title(['Sinal Filtrado',subject_number]);
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off
%%
%fft
[~,num_canais] = size(Fsinal_filtrado);
eegPlot(f, Fsinal_filtrado,num_canais,10^10);
title(['FFT do sinal filtrado',subject_number]);
xlabel('Frequência (Hz)'); ylabel('Amplitude');
hold off

%%
%blocos cortados
[~,num_canais] = size(sinal_filtrado_final);
eegPlot(blocos.t_bloco_ternura1,blocos.bloco_ternura1,num_canais,200); %bloco ternura 1
hold on
plot(blocos.marcBt1,ones(1,length(blocos.marcBt1)),'b+');
title('Bloco Ternura 1');
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off


eegPlot(blocos.t_bloco_angustia1,blocos.bloco_angustia1,num_canais,200); %bloco angústia 1
hold on
plot(blocos.marcBa1,ones(1,length(blocos.marcBa1)),'b+');
title('Bloco Angustia 1');
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off

%%
%periodos cortados
plot_sinal = periodos.bloco_ternura1.ternura1;
[~,num_canais] = size(plot_sinal);
fs_plot = 250;
t_plot = ((0:length(plot_sinal)-1)*(1/fs_sub))';
eegPlot(t_plot,plot_sinal,num_canais,200); %bloco ternura 1
title('Bloco Ternura 1');
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off
%%
%PSD
freq = linspace(0, 125, length(sinal_psd));
% Plot em escala logarítmica (dB/Hz)
figure;
plot(freq, 10*log10(sinal_psd.bloco_ternura1.ternura3)); %Colocando em dB
xlabel('Frequência (Hz)');
ylabel('Densidade Espectral (dB/Hz)');
title('PSD Welch');
grid on;