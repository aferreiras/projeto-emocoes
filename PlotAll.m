close all;
clear all;
clear marcadores;

fs_sub = 250;
for i = 1:15
    subject_number = string(i);
    marc_file_path = "Marcsubject" + subject_number + "_segundos.mat";
    eeg_file_path = "EEGsubject" + subject_number + "_subamostrado.mat";
    load(char(marc_file_path));
    load(char(eeg_file_path));
    t_sub = ((0:length(sinal_filtrado_final)-1)*(1/fs_sub))';
    
    [~,num_canais] = size(sinal_filtrado_final);
    eegPlot(t_sub, sinal_filtrado_final, num_canais , 200);
    hold on
    plot(marcadores,ones(1, length(marcadores)),'r+');
    title(['Sinal Filtrado',subject_number, 'Canais', num_canais]);
    xlabel('Tempo (s)'); ylabel('Amplitude');
    hold off    
end

