function [const,k] = alphabet(modulation)
%alphabet Summary of this function goes here

%   Detailed explanation goes here
switch modulation
    case 'BPSK'
        k=1;
        const = [-1 1];

    case 'OOK'
        k=1;
        const = [0 1];

    case 'OPSK'
        k=2;
        const = [-1-j -1+j 1-j 1+j];

    case '8PSK'
        k=3;
        alpha = pi/8 : pi/4: 15*pi/8;
        const = exp(j*alpha);

    case '16QAM'
        k=4;
        const = [-1-j -1+j 1-j 1+j -1-3j -1+3j 1-3j 1+3j -3-j -3+j 3-j 3+j -3-3j -3+3j 3-3j 3+3j];


k = const;

end