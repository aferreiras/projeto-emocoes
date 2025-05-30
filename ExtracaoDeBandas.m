
for subject_number = 1:15
% subject_number = "1";
eeg_file_path = "EEG com CSD\Subject" + subject_number + "_CSD.mat";
load(char(eeg_file_path));

fs = 250;
fn = fs/2;
%Teta
[b_teta, a_teta] = butter(4, [4, 8] /fn, 'bandpass');
eeg_teta = eeg_csd;
blocos = fieldnames(eeg_csd);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(eeg_csd.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_teta.(char(bloco)).(char(trecho))= filtfilt(b_teta, a_teta, eeg_csd.(char(bloco)).(char(trecho)));
    end    
end

%Alfa
[b_alfa, a_alfa] = butter(4, [8, 13] /fn, 'bandpass');
eeg_alfa = eeg_csd;
blocos = fieldnames(eeg_csd);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(eeg_csd.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_alfa.(char(bloco)).(char(trecho))= filtfilt(b_alfa, a_alfa, eeg_csd.(char(bloco)).(char(trecho)));
    end    
end

%Beta
[b_beta, a_beta] = butter(4, [13, 30] /fn, 'bandpass');
eeg_beta = eeg_csd;
blocos = fieldnames(eeg_csd);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(eeg_csd.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_beta.(char(bloco)).(char(trecho))= filtfilt(b_beta, a_beta, eeg_csd.(char(bloco)).(char(trecho)));
    end    
end

%Gama
[b_gama, a_gama] = butter(4, [30, 45] /fn, 'bandpass');
eeg_gama = eeg_csd;
blocos = fieldnames(eeg_csd);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(eeg_csd.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_gama.(char(bloco)).(char(trecho))= filtfilt(b_gama, a_gama, eeg_csd.(char(bloco)).(char(trecho)));
    end    
end

% [filename, path] = uiputfile('*.mat','Salvar como');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\teta\Subject"+subject_number+"_teta.mat"),'eeg_teta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\alfa\Subject"+subject_number+"_alfa.mat"),'eeg_alfa');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\beta\Subject"+subject_number+"_beta.mat"),'eeg_beta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\gama\Subject"+subject_number+"_gama.mat"),'eeg_gama');
end

eegPlot(0:(length(eeg_teta.bloco_ternura1.ternura1)-1),eeg_teta.bloco_ternura1.ternura1,63,200);
% eegPlot(0:(length(sinal_filtrado_teste)-1),sinal_filtrado_teste,63,200);
% eegPlot(0:(length( eeg_teta.bloco_ternura1.ternura1)-1), eeg_teta.bloco_ternura1.ternura1,63,200);