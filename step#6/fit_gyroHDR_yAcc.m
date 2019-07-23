%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    fit_gyroHDR_yAcc.m                      %
% This file is intended to make a estimation formula %
% of gyro HDR using polynomial approach               %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax=xAcc_mpu;
ay=yAcc_mpu;
az=zAcc_mpu;

%extract data from throw to catch
index_throw=find(abs(gyro_hdr)>1000);

gf=median_filter_f(gyro_hdr(index_throw),25);
ayf=median_filter_f(ay(index_throw),25);

[max_a , max_i]=max(ayf);
index_throw(1:max_i)=[];
ayf(1:max_i)=[];
gf(1:max_i)=[];

%Extract flight start
index_2=find(ayf<max_a);
%Extract flight end
index_3=find(diff(ayf(index_2))>-10);

hold off;
subplot(3,1,1);
plot(ayf(index_2(1):index_3(end)),gf(index_2(1):index_3(end)));
title('quadratic fitting of HDR gyro value by ACC Y value during flight only');

ft = fittype('poly2');
[c1,gof1] = fit(ayf(index_2(1):index_3(end)) , gf(index_2(1):index_3(end)) , 'poly2');
stats = datastats(gf-c1(ayf));
stats.rms = (sum((gf-c1(ayf)).^2)/length(gf))^0.5
[stats.mae stats.mape]=mean_error(c1(ayf),gf);
stats_all = datastats(gyro_hdr-c1(ay));
stats_all.rms = (sum((gyro_hdr-c1(ay)).^2)/length(gyro_hdr))^0.5

hold on;
plot(c1);
legend('raw data' , 'quadratic estimation');
xlabel('ACC Y');
ylabel('GYRO Z');

subplot(3,1,2);
plot(time(index_throw),gf);hold on;plot(time(index_throw),c1(ayf));
legend('HDR Gyro Z','gyro z estimated by acc Y');
xlabel('Time');
ylabel('GYRO Z');
title('Original gyro value and estimated value from throw to catch');

subplot(3,1,3);
plot(time,gyro_hdr);hold on;plot(time,c1(ay));
legend('HDR Gyro Z','gyro z estimated by acc Y');
xlabel('Time');
ylabel('GYRO Z');
title('Original gyro value and estimated value among whole data set');
