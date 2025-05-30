close all;
clear marcadores;
subject_number = "15";
if ismember(subject_number,["10","11","12","13","14","15"])
    subject_number0 = subject_number;
else
    subject_number0 = "0" + subject_number;
end
marc_file_path = "SUBJ0" + subject_number0 + "\Marcsubject" + subject_number + ".mat";
eeg_file_path = "SUBJ0" + subject_number0 + "\EEGsubject" + subject_number + ".mat";
load(char(marc_file_path));
load(char(eeg_file_path));


marcadores = marcadores([true, diff(marcadores)>1]);% diff remove o erro de marcadores repetidos
if subject_number == "1"
    fs=5000;
    marcadores = marcadores/fs; %Ajustando para segundos
elseif subject_number == "15"
    fs=500;
    marcadores = marcadores/fs; %Ajustando para segundos
else
    fs=1000;
    marcadores = marcadores/fs; %Ajustando para segundos
end
fn = fs/2; %Frequência normalizada
sinal = double(detrend(EEG,1))';
dt = 1/fs; %Tempo de amostragem
t = ((0:length(sinal)-1)*dt)';

% Filtro Notch em 60 Hz
% wo = 60/(fs/2); % Frequência notch normalizada
% bw = wo/35; % Largura de banda do notch
% [num_notch, den_notch] = iirnotch(wo, bw); %Precisa do DSP Toolbox
% freqz(num_notch,den_notch,[],fs);
num_notch = [0.9946,-1.8496,0.9946];% Valores resultado do iirnotch
den_notch = [1,-1.8496,0.9893]; % Valores resultado do iirnotch
sinal_filtrado_notch = filtfilt(num_notch, den_notch, sinal);

%Subamostragem
fs_sub = 250; %Frequência de subamostragem
fn_sub = fs_sub/2; %Frequência normalizada
%Filtro Passa-Baixa para evitar aliasing
[b, a] = butter(4, fn_sub/fn, 'low');
sinal_filtrado_aliasing = filtfilt(b, a, sinal_filtrado_notch);

sinal_subamostrado = downsample(sinal_filtrado_aliasing, fs/fs_sub);
t_sub = ((0:length(sinal_subamostrado)-1)*(1/fs_sub))';

Fsinal_sub = abs(fft(sinal_subamostrado)).^2;
res = 1/t(end);
f = (0:length(Fsinal_sub(:,1))-1)*res;

% figure
% plot(f,Fsinal_sub);
% figure
% hold on
% plot(t,sinal_filtrado_notch,'r',t_sub, sinal_subamostrado, 'b');

% Filtro Passa-Alta em 1.5 Hz
[num_pa, den_pa] = butter(4, 1.5/fn_sub, 'high');
% freqz(num_pa,den_pa,[],fs_sub);
sinal_filtrado_pa = filtfilt(num_pa, den_pa, sinal_subamostrado);

% Fsinal_pa = abs(fft(sinal_subamostrado)).^2;
% res = 1/t(end);
% f = (0:length(Fsinal_pa(:,1))-1)*res;
% plot(f,Fsinal_pa);

% Filtro Passa-Baixa em 50 Hz
[num_pb, den_pb] = butter(4, 50/fn_sub, 'low');
% freqz(num_pb,den_pb,[],fs_sub);
sinal_filtrado_final = filtfilt(num_pb, den_pb, sinal_filtrado_pa);

Fsinal_filtrado = abs(fft(sinal_filtrado_final)).^2;
res = 1/t(end);
f = (0:length(Fsinal_filtrado(:,1))-1)*res;

% figure
% plot(f,Fsinal_filtrado);
% figure
% hold on
% eegPlot(t_sub,sinal_filtrado_final,63,200);

%filtrado e subamostrado
[~,num_canais] = size(sinal_filtrado_final);
offset = 200;
eegPlot(t_sub, sinal_filtrado_final, num_canais, offset);
hold on
plot(marcadores,ones(1, length(marcadores)),'b+');
title(['Sinal Filtrado',subject_number]);
xlabel('Tempo (s)'); ylabel('Amplitude');
hold off

%fft
[~,num_canais] = size(Fsinal_filtrado);
eegPlot(f, Fsinal_filtrado,num_canais,10^10);
title(['FFT do sinal filtrado',subject_number]);
xlabel('Frequência (Hz)'); ylabel('Amplitude');
hold off