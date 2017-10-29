function lab02_main
%=== Дисципліна: Основи обробки біомедичної інформації ===
%--- Лабораторна робота #2 ФІЛЬТРАЦІЯ БІОСИГНАЛІВ ФІЛЬТРАМИ З СІХ
%
% Використовуйте файли даних: 
% ecg117.dat - сигнал EКГ 
% ecg_2х60.dat - сигнал ЕКГ з мережевою перешкодою частотою 60 Гц
%----------------------------------------------------------
 
clear, clc, close all
disp('Лабораторна робота #2');
disp('ФІЛЬТРАЦІЯ БІОСИГНАЛІВ ФІЛЬТРАМИ З СІХ');
disp('Виконав: Шелемба П.В., група БМ-462, ННІІДС');
 
%=== Завдання #1.1 ===
% Реалізація фільтру Хеннінга, обчислення АЧХ та ФЧХ
fs = 1000;
b = [1 2 1]/4; % коефіцієнти різницевого рівняння 
a = 1;
n = 512; % кількість точок, що розраховуються
figure(1);
[h,w] = freqz(b, a, n);
mag = abs(h);
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(w/(2*pi)*fs, mag), grid on;
title('АЧХ'); ylabel('Підсилення');
subplot(2, 1, 2); plot(w/(2*pi)*fs,unwrap(phase)), grid on;
title('ФЧХ'); xlabel('Частота'); ylabel('Фаза');

%=== Завдання #1.2 ===
% Обчислення нулів фільтру
disp('Нулі фільтра Хеннінга:');
x = roots(b);
disp(x);

%=== Завдання #1.3 ===
% Фільтрація ЕКГ, файл ecg117.dat
fs = 1000;
ecg1 = load('ecg117.dat'); % сигнал ЕКГ
ecg = detrend(ecg1);  
ecgf = filter(b, a, ecg);
t1 = (0:length(ecgf)-1)/fs;
figure(2);
subplot(2, 1, 1); plot(t1, ecg1), grid on;
title('Нефільтрований сигнал ЕКГ');
xlim([0 1]);
ylabel('Амплітуда');
subplot (2, 1, 2); plot (t1, ecgf); grid on;
title('Відфільтрований сигнал ЕКГ');
xlim([0 1]);
ylabel('Амплітуда'); xlabel('Відліки');

%=== Завдання #2.1 ===
%Реалізація фільтру поліноміального згладжування
fs = 1000;
bp = [-3, 12, 17, 12, -3]/35; % коефіцієнти різницевого рівняння
ap = 1;
n = 5; % кількість точок, що розраховуються
figure(3);
[h,w] = freqz(bp, ap, n);
mag = abs(h);
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(w/(2*pi)*fs, mag), grid on;
title('АЧХ'); ylabel('Підсилення');
subplot(2, 1, 2); plot(w/(2*pi)*fs,unwrap(phase)), grid on;
title('ФЧХ'); xlabel('Частота'); ylabel('Фаза');

% Обчислення нулів фільтру
disp('Нулі фільтра поліноміального згладжування:');
y = roots(bp);
disp(y);

% Карта нулів та полюсів фільтру
figure(4);
z = zplane(bp);
title('Карта нулів та полюсів поліноміального фільтру');

%=== Завдання #2.2 ===
%Фільтрація ЕКГ файл ecg117.dat з використанням фільтру 
%поліноміального згладжування
ecg = load('ecg117.dat');
ecg2 = detrend(ecg);
ecgf5 = filter(bp,ap,ecg2);
t2 = (0:length(ecgf5)-1)/fs;
figure(5);
subplot(2, 1, 1); plot (t2, ecg); 
title('Нефільтрований сигнал ЕКГ');
xlim([0 1]);
ylabel('Амплітуда');
subplot(2, 1, 2); plot (t2, ecgf5);
title('Відфільтрований сигнал ЕКГ');
xlim([0 1]);
xlabel('Відліки'); ylabel('Амплітуда');

%=== Завдання #2.3 ===
%Порівняння властивостей згладжування сигналу фільтром Хеннінга 
%і поліноміальним фільтром
figure(6);
subplot(2, 1, 1); plot(t1, ecgf); grid on;
title('Згладжування сигналу фільтром Хеннінга');
xlim([0 1]);
ylabel('Амплітуда');
subplot(2, 1, 2); plot(t2, ecgf5); grid on;
title('Згладжування сигналу поліноміальним фільтром');
xlim([0 1]);
xlabel('Відліки');
ylabel('Амплітуда');

%=== Завдання #3.1 ===
% Дослідження властивостей простого режекторного фільтру
br = [1,0.618, 1]; % коефіцієнти різницевого рівняння 
ar = 1; 
n = 512; % кількість точок, що розраховуються
fs = 200;
[h,f] = freqz(br, ar, n, fs);
figure(7);
mag = abs(h);
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(f/(2*pi)*fs, mag), grid on;
title('АЧХ'); ylabel('Підсилення');
subplot(2, 1, 2); plot(f/(2*pi)*fs,unwrap(phase)), grid on;
title ('ФЧХ'); xlabel('Частота'); ylabel('Фаза');

% Обчислення нулів фільтру
disp('Нулі режекторного фільтру:');
xx = roots(br);
disp(xx);

% Карта нулів та полюсів фільтру
figure(8);
yy = zplane(br);
title('Карта нулів та полюсів режекторного фільтру');

%=== Завдання #3.2 ===
% Фільтрація сигналу ЕКГ (файл ecg2х60.dat) режекторним фільтром
fs = 250;
ecg = load('ecg2x60.dat'); % сигнал ЕКГ
ecgd = detrend(ecg);
ecgf = filter(br, ar, ecgd);
t3 = (0:length(ecgf)-1)/fs;  
figure(9);
subplot(2, 1, 1); plot(t3, ecg), grid on;
title('Невідфільтрований сигнал ЕКГ');
xlim([0 1]);
ylabel('Амплітуда');
subplot(2, 1, 2); plot(t3, ecgf); grid on;
title('Відфільтрований сигнал ЕКГ');
xlim([0 1]);
ylabel('Амплітуда'); xlabel('Відліки');

%=== Завдання #4.1 ===
% Дослідження властивостей диференціаторів
% N = 1
fs = 1000; 
bd1 = [1,-1]; % коефіцієнти різницевого рівняння 
ad1 = 1;
n = 512; % кількість точок, що розраховуються
figure(10);
[h,f] = freqz(bd1,ad1,n,fs);
mag = abs(h);
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(f/(2*pi)*fs, mag), grid on;
title('АЧХ диференціатору при N=1'); ylabel('Підсилення');
subplot(2, 1, 2); plot(f/(2*pi)*fs,unwrap(phase)), grid on;
title('ФЧХ диференціатору при N=1'); xlabel('Частота'); ylabel('Фаза');

% N = 2
fs = 1000; 
bd2 = ([1,-1])/2; % коефіцієнти різницевого рівняння 
ad2 = 1;
n = 512; % кількість точок, що розраховуються
figure(11);
[h,f] = freqz(bd2, ad2, n, fs);
mag = abs(h);
phase = angle(h)*180/pi;
subplot(2, 1, 1); plot(f/(2*pi)*fs, mag), grid on;
title('АЧХ диференціатору при N=2'); ylabel('Підсилення');
subplot(2, 1, 2); plot(f/(2*pi)*fs,unwrap(phase)), grid on;
title('ФЧХ диференціатору при N=2'); xlabel('Частота'); ylabel('Фаза');

%=== Завдання #4.2 ===
% Дослідження процесу диференціювання ЕКГ з шумом (файл ecg117.dat)
% N = 1
fs = 300;
ecg = load('ecg117.dat'); % сигнал ЕКГ
ecgd1 = filter(bd1, ad1, ecg);
ecgdd = detrend(ecgd1);
t4 = (0:length(ecgdd)-1)/fs;

% N = 2
ecgd2 = filter(bd2, ad2, ecg);
t5 = (0:length(ecgdd)-1)/fs;
figure(12);
subplot (2, 1, 1); plot(t4, ecgd1), grid on;
title('Сигнал з використанням диференціатору при N=1');
xlim([0 1]);
ylabel('Амплітуда');
subplot (2, 1, 2); plot (t5, ecgd2); grid on;
title('Сигнал з використанням диференціатору при N=2');
xlim([0 1]);
xlabel('Відліки'); ylabel('Амплітуда');