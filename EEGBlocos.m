close all;
clear all;
clear marcadores;
subject_number = "15";
marc_file_path = "Marcsubject" + subject_number + "_segundos.mat";
eeg_file_path = "EEGsubject" + subject_number + "_subamostrado.mat";
load(char(marc_file_path));
load(char(eeg_file_path));

fs_sub = 250;
t_sub = ((0:length(sinal_filtrado_final)-1)*(1/fs_sub))';
%%
blocos = struct();

%Cortes de blocos
marcBt1=marcadores(2:10);%bloco de ternura 1
marcBa1=marcadores(11:19);%bloco de angústia 1
marcBt2=marcadores(20:28);
marcBa2=marcadores(29:37);
marcBt3=marcadores(38:46);
marcBa3=marcadores(47:55);
marcBt4=marcadores(56:64);
marcBa4=marcadores(65:73);

marcBt1 = [marcBt1 marcBt1(end)+12];
marcBt2 = [marcBt2 marcBt2(end)+12];
marcBt3 = [marcBt3 marcBt3(end)+12];
marcBt4 = [marcBt4 marcBt4(end)+12];
marcBa1 = [marcBa1 marcBa1(end)+12];
marcBa2 = [marcBa2 marcBa2(end)+12];
marcBa3 = [marcBa3 marcBa3(end)+12];
marcBa4 = [marcBa4 marcBa4(end)+12];

%getBloco pega um bloco selecionado do sinal, +12 é adicionado para incluir
%o último período de neutro do bloco
[blocos.bloco_ternura1,blocos.t_bloco_ternura1]=getBloco(sinal_filtrado_final,t_sub,marcBt1);
[blocos.bloco_ternura2,blocos.t_bloco_ternura2]=getBloco(sinal_filtrado_final,t_sub,marcBt2);
[blocos.bloco_ternura3,blocos.t_bloco_ternura3]=getBloco(sinal_filtrado_final,t_sub,marcBt3);
[blocos.bloco_ternura4,blocos.t_bloco_ternura4]=getBloco(sinal_filtrado_final,t_sub,marcBt4);
[blocos.bloco_angustia1,blocos.t_bloco_angustia1]=getBloco(sinal_filtrado_final,t_sub,marcBa1);
[blocos.bloco_angustia2,blocos.t_bloco_angustia2]=getBloco(sinal_filtrado_final,t_sub,marcBa2);
[blocos.bloco_angustia3,blocos.t_bloco_angustia3]=getBloco(sinal_filtrado_final,t_sub,marcBa3);
[blocos.bloco_angustia4,blocos.t_bloco_angustia4]=getBloco(sinal_filtrado_final,t_sub,marcBa4);

blocos.marcBt1=marcBt1;
blocos.marcBt2=marcBt2;
blocos.marcBt3=marcBt3;
blocos.marcBt4=marcBt4;
blocos.marcBa1=marcBa1;
blocos.marcBa2=marcBa2;
blocos.marcBa3=marcBa3;
blocos.marcBa4=marcBa4;
%%

%usando getBloco para separar os períodos

periodos = struct();

for bloco = 1:4
    periodos.("bloco_ternura"+bloco).neutro1 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(1:2));
    periodos.("bloco_ternura"+bloco).ternura1 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(2:3));
    periodos.("bloco_ternura"+bloco).neutro2 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(3:4));
    periodos.("bloco_ternura"+bloco).ternura2 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(4:5));
    periodos.("bloco_ternura"+bloco).neutro3 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(5:6));
    periodos.("bloco_ternura"+bloco).ternura3 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(6:7));
    periodos.("bloco_ternura"+bloco).neutro4 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(7:8));
    periodos.("bloco_ternura"+bloco).ternura4 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(8:9));
    periodos.("bloco_ternura"+bloco).neutro5 = getBloco(blocos.("bloco_ternura"+bloco), blocos.("t_bloco_ternura"+bloco), blocos.("marcBt"+bloco)(9:10));
    periodos.("bloco_angustia"+bloco).neutro1 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(1:2));
    periodos.("bloco_angustia"+bloco).angustia1 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(2:3));
    periodos.("bloco_angustia"+bloco).neutro2 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(3:4));
    periodos.("bloco_angustia"+bloco).angustia2 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(4:5));
    periodos.("bloco_angustia"+bloco).neutro3 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(5:6));
    periodos.("bloco_angustia"+bloco).angustia3 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(6:7));
    periodos.("bloco_angustia"+bloco).neutro4 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(7:8));
    periodos.("bloco_angustia"+bloco).angustia4 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(8:9));
    periodos.("bloco_angustia"+bloco).neutro5 = getBloco(blocos.("bloco_angustia"+bloco), blocos.("t_bloco_angustia"+bloco), blocos.("marcBa"+bloco)(9:10));
end
