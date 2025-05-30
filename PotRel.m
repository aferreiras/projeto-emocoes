banda = "alfa";
for subject_number = 1:15

eeg_file_path = "Bandas\"+ banda + "\psd\Subject" + subject_number + "_" + banda + "_psd.mat";
load(eeg_file_path);

freq = linspace(0, 125, length(sinal_psd.bloco_ternura1.ternura1)); %125 é o máximo pois atende a fs/2 p/ fs=250Hz
sinal_potrel = sinal_carregado;
blocos = fieldnames(sinal_carregado);
janela = 250; % Janela em 1 segundo
noverlap = janela*0.5; % Sobreposição em 50%
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(sinal_carregado.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j); 
        sinal_potrel.(char(bloco)).(char(trecho))= pwelch(sinal_carregado.(char(bloco)).(char(trecho)), janela, noverlap);
    end    
end

save(char("EEG-SUBAMOSTRADO\Bandas\"+banda+"\psd\Subject"+subject_number+"_"+ banda+"_psd.mat"),'sinal_psd')
end

faixa = (freq >= 8 & freq <= 12);
pot_banda = sum(sinal_psd.bloco_ternura1.ternura1(faixa,:));
pot_total = sum():%avaliar como fica a potência total extraída do sainal_psd