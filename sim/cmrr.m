clc
close all
clear

Ad5 = [10 10 10 10 10 10 10.39]
Ad25 = [50 50 50 50 50 49.98 47.13]
Ad50 = [100 100 100 100 100 99.3 63.13]

Acm5 = [499e-6 499e-6 499e-6 499e-6 499e-6 499e-6 532e-6]
Acm25 = [2.49e-3 2.49e-3 2.49e-3 2.49e-3 2.49e-3 2.49e-3 2.42e-3]
Acm50 = [5e-3 5e-3 5e-3 5e-3 5e-3 4.96e-3 3.29e-3]

f = [0.1 1 10 100 1e3 10e3 100e3]

CMRR5 = 20 * log10(Ad5 ./ Acm5)
CMRR25 = 20* log10(Ad25 ./ Acm25)
CMRR50 = 20*log10(Ad50 ./ Acm50)

figure(1)
plot(log10(f), CMRR5);
grid;
title('CMRR');
xlabel('log(f)');
ylabel('CMRR[dB]');
axis([-1 6 85.9 86.1]);
hold on
plot(log10(f), CMRR25);
plot(log10(f), CMRR50);
legend('RG = 5K', 'RG = 25K', 'RG = 50K');
