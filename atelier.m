%---Chaine de transmission numérique en bande de base
clc;close all; clear;

%----Paramétre de simulation---
fe=200e3;%Frequence d'echantillonnage
dt= 1/fe;%pas d'echantillonnage
D=5e3 ;%Debit binaire
T= 1/D;%Durée d'un symbole
N=round(T/dt);%Taux d'echantillonnage
Nb=1200; %nombre de Data
t = 0:dt:Nb*T - dt ;

%--Generation des Données--
data_tx=rand(1,Nb) > 0.5;
subplot(411);stem(data_tx);
xlim([0 30]); grid on;
%----Mappage(BPSK)----
symboles =2 * data_tx-1 ;
subplot(412);stem(symboles);
xlim([0 30]); grid on;

%---Upsampling(sur echantillonnage)---
Symb_tx=upsample(symboles,N);
subplot(413);stem(t/T ,Symb_tx);
xlim([0 30]); grid on;

%---Filtre d'emission--
g=ones(1,N); %Reponse impulsionnelle du filtre d'emission
sig_bb =filter(g,1,Symb_tx);%Mise en forme rectangulaire
subplot(414);plot(t/T , sig_bb);
xlim([0 30]);grid on; ylim([-2 2 ]);

%----canal-----

%---Filtre de reception--
A0 =1/N;
h=A0*g; %Reponse impulsionnelle du filtre de reception
sig_rx =filter(h,1,sig_bb);%filtrage de reception
figure ;subplot(411);plot(t/T , sig_rx);
xlim([0 30]);grid on; ylim([-2 2 ]);
%-----Downsampling (Echantillonnage)---
Symb_rx = sig_rx(N:N:end);
subplot(412);stem(Symb_rx);
xlim([0 30]);grid on;% ylim([-2 2 ]);
%----Demappage(BPSK)---
data_rx =  Symb_rx >0 ;
subplot(413);stem(data_rx);
xlim([0 30]);grid on;

%-----Comparaison des données et calcul du TEB-----
vec_err= xor(data_tx,data_rx);
subplot(414);stem(vec_err);
xlim([0 30]);grid on;
Nerr = sum(vec_err)%nombre de données erronnées
TEB = Nerr/Nb  %Taux d'Erreur binaire (BER)
%----Diagramme en oeil-----
eyediagram(sig_rx(N:end) , N , 1);grid on;


