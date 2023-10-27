%--- Chaine de transmission numérique en bande e base
clc;close all;
%--parametre de simulation
fe=200e3;%Frequence echantillange
dt=1/fe; %pad d'echantillange 
D=5e3;%debit binaire
T=1/D; %durée d 'un symbole
N=round(T/dt);%T aux d'echantillange
Nb=1200; %nombre de data
t=0:dt:Nb*T-dt;%axe de temps
%--Generation  des donnes
data= rand(1,Nb)>0.5;
subplot(411);stem(data);
xlim([0 30]);grid on;
%---Mappage BPSK
symb_tx = 2*data-1;
subplot(412);stem(symb_tx);
xlim([0 30]);grid on;
%-----Upsmpling (sur echantillange)
symb_up=upsample(symb_tx,N);
subplot(413);stem(t/T,symb_up);
xlim([0 30]);grid on;
%subplot(513);stem(symb_up);xlim([0 30*N]);grid on;subplot(513);stem(t,symb_up);xlim([0 30*T]);grid on;
%--Filtre d'emission
g=ones(1,N); %reponse implusionnelle du filtred'emission
sig_bb=filter(g,1,symb_up);%mise en forme rectangulaire
subplot(414);plot(t/T,sig_bb);
xlim([0 30]);grid on;ylim([-2 2]);


%--canal
%--Filtre Reception
A0=1;
h=A0*g; %reponse implusionnelle du filtred'teception
sig_rx=filter(g,1,symb_up);%filtre de reception
figure;
subplot(411);plot(t/T,sig_rx);
xlim([0 30]);grid on; ylim([-2 2]);

%---Downsampling (Echantillange)
symb_rx=sig_rx(N:N:end);
subplot(412);plot(symb_rx);
xlim([0 30]); grid on;


%--Comparaison des donnees et clacul de TEB--%
vec_err =xor(data_tx, data_tx);
subplot(411); stem(t/T, data_rx);
xlim([0 30]); grid on;

Nerr = sum(vec_err);
TEB =Nerr / Nb;

%--Comparaison des donnees et clacul de TEB--%
eyediagram(sig_rx(N:end), N, 1); grid on;

