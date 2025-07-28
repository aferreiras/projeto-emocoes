load('labels');
M = ExtractMontage('TCC\CSDtoolbox\10-5-System_Mastoids_EGI129.csd',labels');
[G,H] = GetGH(M);
%%
for subject_number = 1:15
%     subject_number = "1";
    eeg_file_path = "EEG dividido em períodos\periodos_EEG_Subject" + subject_number + ".mat";
    load(char(eeg_file_path));
    eeg_csd = periodos;
    blocos = fieldnames(periodos);
    for i=1:length(blocos)
       bloco = blocos{i};
        trechos = fieldnames(periodos.(char(bloco)));
        for j=1:length(trechos)
            trecho = trechos(j);
            X = CSD(periodos.(char(bloco)).(char(trecho))',G,H);
          eeg_csd.(char(bloco)).(char(trecho))= X';
        end    
    end
    subject_number
    [filename, path] = uiputfile('*.mat','Salvar como');
    save(fullfile(path,filename),'eeg_csd');
end
%%
subject_number = "1";
eeg_csd_path = "EEG com CSD\Subject" + subject_number + "_CSD.mat";
load(char(eeg_csd_path));
eeg_sem_csd_path = "EEG dividido em períodos\periodos_EEG_Subject" + subject_number + ".mat";
load(char(eeg_sem_csd_path));
load('locations');
load('labels');
csd_data = eeg_csd.bloco_angustia1.angustia1;% Sinal pós filtro espacial
tempo_selecionado = 44; % s
t = ((0:length(csd_data)-1)*(1/250));
[~, idx_tempo] = min(abs(t' - tempo_selecionado));

topoplot(csd_data(idx_tempo,:), locations, ...
    'style', 'fill', ...       % Colorido
    'electrodes', 'labelpoint',... % Rótulos
    'maplimits', 'absmax');    % Escala simétrica
title(['Topografia do CSD em ' num2str(tempo_selecionado) ' s']);

% canais = [14,49,6,26,27,29];
% eegPlot(t(idx_tempo-5:idx_tempo),csd_data(idx_tempo-5:idx_tempo,canais), length(canais), 0,labels(canais));

data = periodos.bloco_angustia1.angustia1; % Sinal sem filtro espacial para comparação
t = ((0:length(data)-1)*(1/250));
[~, idx_tempo] = min(abs(t' - tempo_selecionado));
figure;
topoplot(data(idx_tempo,:), locations, ...
    'style', 'fill', ...        % Colorido
    'electrodes', 'labelpoint', ... % Rótulos
    'maplimits', 'absmax');    % Escala simétrica
title(['Topografia original em ' num2str(tempo_selecionado) ' ms']);

% E = labels';

% M = ExtractMontage('TCC\CSDtoolbox\10-5-System_Mastoids_EGI129.csd',E);
% M2 = ExtractMontage('EEG-RAW_DATA\channel_locations_converted.csd',E);

% MapMontage(M);
% MapMontage(M2);

% [G,H] = GetGH(M);
% [G2,H2] = GetGH(M2);

% X = CSD(periodos.bloco_ternura1.ternura1', G, H);
% X2 = CSD(periodos.bloco_ternura1.ternura1', G2, H2);

% t_sub = ((0:length(periodos.bloco_ternura1.ternura1)-1)*(1/250))';
% 
% eegPlot(t_sub,periodos.bloco_ternura1.ternura1,63,200);
% eegPlot(t_sub,X',63,200);
% eegPlot(t_sub,X2',63,200);
% 
% X_full = CSD(sinal_filtrado_final', G, H);
% 
% t_sub = ((0:length(sinal_filtrado_final)-1)*(1/250))';
% 
% tempo_selecionado = 1000; % ms
% [~, idx_tempo] = min(abs(t_sub - tempo_selecionado));
% 
% locations_converted = locations;
% X_full = X_full';
% topoplot(X_full(idx_tempo,:), EEG.chanlocs, ...
%     'style', 'fill', ...       % Preenchimento colorido
%     'electrodes', 'labelpoint', ... % Mostra rótulos dos eletrodos
%     'maplimits', 'absmax');    % Escala simétrica (recomendado para CSD)
% title(['Topografia do CSD em ' num2str(tempo_selecionado) ' s']);

% X_raw = CSD(EEG,G,H);
% 
% t = ((0:length(EEG)-1)*(1/1000))';
% 
% eegPlot(t,EEG',63,200);
% eegPlot(t,X_raw',63,200);

% E_exem = textread('TCC\CSDtoolbox\exam\E31.asc','%s');
% M = ExtractMontage('TCC\CSDtoolbox\10-5-System_Mastoids_EGI129.csd',E_exem);
% [G_exem,H_exem] = GetGH(M);
% D = textread('TCC\CSDtoolbox\exam\NR_C66_trr.dat');
% 
% X_exem = CSD(D',G_exem,H_exem);
% 
% t_exem = (0:length(D)-1)';
% eegPlot(sinal_filtrado_final);
% eegPlot(t_exem,D,31,0);
% eegPlot(t_exem,X_exem',31,0);
