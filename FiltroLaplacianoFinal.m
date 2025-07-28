load('labels');% nome dos canais
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
    [filename, path] = uiputfile('*.mat','Salvar como');
    save(fullfile(path,filename),'eeg_csd');
end