%---chaine de transmission en bande de base--------
clc; close all ; clear;
%----les paramètres de simulation-----
fe = 200e3; %Fréquence d'echantilonnage
dt = 1/fe ; %le pas d'echantillonnage
Ns = 1400; %nombre de symboles a transmettre
modulation  = 'QPSK';%type de modulation
[ constellation,k ] = alphabet( modulation);% la constellationn et k le nombre de bit par symbole
Nb = Ns*k; %nombre de data
D = 5e3;% le débit binaire 
T = k/D ;% la durée d'un symbole
N = round(T/dt);% le taux d'echantillonnage 
t = 0 : dt :Ns*T - dt ;% l'axe de temps
SNR = 1;%rapport signal sur bruit


%---génération des données 
data_tx = rand(1,Nb)>0.5 ; %--pour rendre les donnèes binaire (0,1)
subplot(411) ; stem(real(data_tx));
xlim([0 30]); grid on ;

             
%----le mappage(rendre les donnèes des -1 et des 1(BPSK))--
symb_tx = mapping( data_tx,modulation );
subplot(412) ; stem(real(symb_tx));
xlim([0 30]); grid on ;

%--------upsampling (surechantillonnage)----------
symb_up = upsample(symb_tx, N);
%subplot(413) ; stem(t/T ,symb_up);
%xlim([0 30]); grid on ; %on a multiplier par N car le trassage va arreter a 30 y compris les 0 ajouter 

%-------filtrage d'emission --------
g = ones (1,N);% le reponse impulsionelle rectangulaire du filtre d'emission 
signale_bb = filter(g,1,symb_up);% mise en forme rectangulaire 
subplot(413) ; plot(t/T ,signale_bb);
xlim([0 30]); grid on ; %ylim([-2 2]); comme ça si on change le type de modulation l'axe des y va pas etre limitée entre -2 et 2

%----Canal bruité----
sig_rx = awgn(signale_bb,SNR,'measured');
subplot(414) ; plot(t/T , sig_rx);
xlim([0 30]); grid on ;ylim([-2 2])



%-------filtrage de reception --------
A0 = 1/N; %- juste un coefficient qui represente l'affaiblissement
h = A0*g;% le reponse impulsionelle rectangulaire du filtre de receprion
signale_rx = filter(h,1,sig_rx);% mise en forme rectangulaire 
figure ; subplot(411) ; plot(t/T , signale_rx);
xlim([0 30]); grid on ; ylim([-2 2]); 


%----downsampling(echantillonnage)-----
symb_rx = signale_rx(N : N :end);
subplot(412) ; stem(real(symb_rx));
xlim([0 30]); grid on ;

%-----Constellation---
scatterplot(symb_tx,1,0,'ro'); grid on
scatterplot(symb_rx,1,0,'bo'); grid on

%-----le demappage(BPSK) ----
for n=1 : length(symb_rx) 
    distances = abs(symb_rx(n) - constellation);
    [dmin, indice] = min(distances);

end
data_m = de2bi(indice-1,k);
data_rx = symb_rx > 0 ;
subplot(413) ; stem(data_rx);
xlim([0 30]); grid on ;

%-----Comparaison des donnèes et calcul de TEB(taux d'erreur)--
vect_err = xor(data_tx , data_rx) ;
subplot(414) ; stem(vect_err);
grid on ;

Nerr = sum(vect_err) % nombre des données erronnées
TEB = Nerr / Nb  % le taux d'erreur binaire

%----diagrammme en oeil-------

eyediagram(signale_rx(N:end) ,N, 1); grid on