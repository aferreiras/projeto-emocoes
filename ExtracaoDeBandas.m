
%Com Laplaciano
for subject_number = 1:15
% subject_number = "1";
eeg_csd_path = "EEG com CSD\Subject" + subject_number + "_CSD.mat";
load(char(eeg_csd_path));

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
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\CSD\teta\Subject"+subject_number+"_teta.mat"),'eeg_teta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\CSD\alfa\Subject"+subject_number+"_alfa.mat"),'eeg_alfa');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\CSD\beta\Subject"+subject_number+"_beta.mat"),'eeg_beta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\CSD\gama\Subject"+subject_number+"_gama.mat"),'eeg_gama');
end

eegPlot(0:(length(eeg_teta.bloco_ternura1.ternura1)-1),eeg_teta.bloco_ternura1.ternura1,63,200);
% eegPlot(0:(length(sinal_filtrado_teste)-1),sinal_filtrado_teste,63,200);
% eegPlot(0:(length( eeg_teta.bloco_ternura1.ternura1)-1), eeg_teta.bloco_ternura1.ternura1,63,200);
%%
% Sem Laplaciano
for subject_number = 1:15
% subject_number = "1";
eeg_file_path = "EEG dividido em períodos\periodos_EEG_Subject" + subject_number + ".mat";
load(char(eeg_file_path));

fs = 250;
fn = fs/2;
%Teta
[b_teta, a_teta] = butter(4, [4, 8] /fn, 'bandpass');
eeg_teta = periodos;
blocos = fieldnames(periodos);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(periodos.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_teta.(char(bloco)).(char(trecho))= filtfilt(b_teta, a_teta, periodos.(char(bloco)).(char(trecho)));
    end    
end

%Alfa
[b_alfa, a_alfa] = butter(4, [8, 13] /fn, 'bandpass');
eeg_alfa = periodos;
blocos = fieldnames(periodos);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(periodos.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_alfa.(char(bloco)).(char(trecho))= filtfilt(b_alfa, a_alfa, periodos.(char(bloco)).(char(trecho)));
    end    
end

%Beta
[b_beta, a_beta] = butter(4, [13, 30] /fn, 'bandpass');
eeg_beta = periodos;
blocos = fieldnames(periodos);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(periodos.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_beta.(char(bloco)).(char(trecho))= filtfilt(b_beta, a_beta, periodos.(char(bloco)).(char(trecho)));
    end    
end

%Gama
[b_gama, a_gama] = butter(4, [30, 45] /fn, 'bandpass');
eeg_gama = periodos;
blocos = fieldnames(periodos);
for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(periodos.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j);
        eeg_gama.(char(bloco)).(char(trecho))= filtfilt(b_gama, a_gama, periodos.(char(bloco)).(char(trecho)));
    end    
end

% [filename, path] = uiputfile('*.mat','Salvar como');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\Original\teta\Subject"+subject_number+"nocsd_teta.mat"),'eeg_teta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\Original\alfa\Subject"+subject_number+"nocsd_alfa.mat"),'eeg_alfa');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\Original\beta\Subject"+subject_number+"nocsd_beta.mat"),'eeg_beta');
save(char("C:\Users\andre\André\Projeto Emoções\EEG-SUBAMOSTRADO\Bandas\Original\gama\Subject"+subject_number+"nocsd_gama.mat"),'eeg_gama');
end