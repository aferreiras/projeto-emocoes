banda = "gama";
for subject_number = 1:15

eeg_file_path = "Bandas\"+ banda + "\Subject" + subject_number + "_" + banda + ".mat";
load(eeg_file_path);

sinal_carregado = eval("eeg_" + banda);
sinal_psd = sinal_carregado;
blocos = fieldnames(sinal_carregado);
janela = 250; % Janela em 1 segundo
noverlap = janela*0.5; % Sobreposição em 50%
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(sinal_carregado.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j); 
        sinal_psd.(char(bloco)).(char(trecho))= pwelch(sinal_carregado.(char(bloco)).(char(trecho)), janela, noverlap);
    end    
end

save(char("EEG-SUBAMOSTRADO\Bandas\"+banda+"\psd\Subject"+subject_number+"_"+ banda+"_psd.mat"),'sinal_psd')
end
%%
% [sinal_psd_teste, w] = pwelch(eeg_teta.bloco_ternura1.ternura1, janela, noverlap);
freq = linspace(0, 125, length(sinal_psd_teste));
% Plot em escala logarítmica (dB/Hz)
figure;
plot(freq, 10*log10(sinal_psd.bloco_ternura1.ternura3)); %Colocando em dB
xlabel('Frequência (Hz)');
ylabel('Densidade Espectral (dB/Hz)');
title('PSD Welch');
grid on;