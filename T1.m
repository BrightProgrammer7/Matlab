%--- Chaine de transmission numerique en bande de base--%
clc; close all; clear;

%--Prm de simulation--%
fe=200e3; %freq ech
dt=1/fe;
D=5e3;
Nb=1200;
T=1/D;
N=round(T/dt);
t=0:dt:Nb*T-dt;


%--Gnrt des donnees--%
data = rand(1,Nb)>0.5;
subplot(411); stem(data);
xlim([0 30]); grid on;


%--Mappage (BPSK)--%
symboles = 2*data-1;
subplot(412); stem(symboles);
xlim([0 30]); grid on;

%--Upsampling sur echantillonnage--%
symb_up = upsample(symboles,N);
subplot(413); stem(t/T, symb_up);
xlim([0 30]); grid on;
subplot(513); stem(symb_up);
xlim([0 30*N]);grid on;
subplot(513);stem(t,symb_up);
xlim([0 30*T]);grid on;


%--Filtre d'emission--%
g = ones(1,N);
sig_bb=filter(g,1,symb_up);
subplot(414); plot(t/T, sig_bb);
xlim([0 30]); grid on; ylim([-2 2]);


%--Filtre de reception
A0=1/N;
h=A0*g; %reponse implusionnelle du filtred'teception
sig_rx=filter(g,1,symb_up);%filtre de reception
figure;
subplot(511);plot(t/T,sig_rx);
xlim([0 30]);grid on; ylim([-2 2]);

%---Downsampling (Echantillange)
symb_rx=sig_rx(N:N:end);
subplot(512);plot(symb_rx);
xlim([0 30]);grid on;





