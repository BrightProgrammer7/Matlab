%--- Chaine de transmission numérique en bande e base
clc; close all; clear;

%--parametre de simulation
fe=200e3;%Frequence echantillange
dt=1/fe; %pad d'echantillange 
D=5e3;%debit binaire
T=1/D; %durée d 'un symbole
N=round(T/dt);%T aux d'echantillange
t=0:dt:Nb*T-dt;%axe de temps
k=3; %nb de bits
Ns =1400;
Nb=Ns*k;
modulation = "8PSK";

%--Generation  des donnes
data= rand(1,Nb)>0.5;
subplot(411);stem(data);
xlim([0 30]);grid on;


%--Signal 8PSK
% data_n = reshape(data_tx,[],k);
data_n = reshape(data_tx,k,[]);
symb_tx =  2*data_tx -1;
subplot(412); stem(symb_tx);
xlim([0 30]); grid on;

%--Conversion Binaire-Decimale
decimals = bi2de(data_n);

%--Conversion Decimale




scatterplot()

