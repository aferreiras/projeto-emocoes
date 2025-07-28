banda = "teta";
for subject_number = 1:15
eeg_file_path = "Bandas\"+ banda + "\psd\Subject" + subject_number + "_" + banda + "_psd.mat";
load(eeg_file_path);

freq = linspace(0, 125, length(sinal_psd.bloco_ternura1.ternura1)); %125 é o máximo pois atende a fs/2 p/ fs=250Hz
sinal_potrel = sinal_psd;
blocos = fieldnames(sinal_psd);
limites_bandas = struct('teta', struct('fmin',4,'fmax',8),'alfa', struct('fmin',8,'fmax',12),'beta', struct('fmin',12,'fmax',30),'gama', struct('fmin',30,'fmax',45));

for i=1:length(blocos)
    bloco = blocos{i};
    trechos = fieldnames(sinal_psd.(char(bloco)));
    for j=1:length(trechos)
        trecho = trechos(j); 
        idx_total = (freq>=4) & (freq<=45);
        idx_banda = (freq>=limites_bandas.(banda).fmin)&(freq<=limites_bandas.(banda).fmax);
        pot_total = zeros(1,63);
        pot_banda = zeros(1,63);
        pot_rel = zeros(1,63);
        for channel = 1:63
            pot_total(channel) = trapz(freq(idx_total),sinal_psd.(char(bloco)).(char(trecho))(idx_total,channel));
            pot_banda(channel) = trapz(freq(idx_banda),sinal_psd.(char(bloco)).(char(trecho))(idx_banda,channel));
            pot_rel(channel) = pot_banda(channel)/pot_total(channel);
        end        
        sinal_potrel.(char(bloco)).(char(trecho))= pot_rel;
    end    
end

save(char("EEG-SUBAMOSTRADO\Bandas\"+banda+"\potrel\Subject"+subject_number+"_"+ banda+"_potrel.mat"),'sinal_potrel')
end
