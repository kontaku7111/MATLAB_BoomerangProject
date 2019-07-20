%% compare filtered signal and raw signal
ax=xAcc_mpu;
ay=yAcc_mpu;
az=zAcc_mpu;
mg=median_filter_f(gyro_hdr,25);

subplot(211);
plot(time,gyro_hdr,'linewidth',2);
title("Original HDR gyro value");
xlabel("time [s]");
ylabel("Angular velocity [degree/s]");

subplot(212);
plot(time,mg,'linewidth',2);
ylim([-6000 8000]);
title("Filtered signal");
title("Filtered HDR gyro value");
xlabel("time [s]");
ylabel("Angular velocity [degree/s]");

%% extract flight period and remove saturation period from fright period
ax=xAcc_mpu;
ay=yAcc_mpu;
az=zAcc_mpu;

gf=median_filter_f(gyro_hdr,25);
ayf=median_filter_f(ay,25);

plot(time,ayf);

%extract data from throw to catch
index_throw=find(abs(gf)>2000);
tf=time(index_throw);
gf=gf(index_throw);
ayf=ayf(index_throw);

[max_a , max_i]=max(ayf);
index_throw(1:max_i)=[];
tf(1:max_i)=[];
ayf(1:max_i)=[];
gf(1:max_i)=[];

%Extract flight start
index_2=find(ayf<max_a);
%Extract flight end
index_3=find(diff(ayf(index_2))>-10);
hold on;
plot(tf(index_2(1):index_3(end)),ayf(index_2(1):index_3(end)),'linewidth',2);
hold off;
xlim([9 14]);
legend('filtered yAcc','extracted period');
title('extracted flight period and removed saturation');
ylabel('Acceleration [m/s^2]');
xlabel('Time [s]');

%%
ax=xAcc_mpu; ay=yAcc_mpu; az=zAcc_mpu;

gf=median_filter_f(gyro_hdr,25);
ayf=median_filter_f(ay,25);

gf_whole=gf;
ayf_whole=ayf;

%extract data from throw to catch
index_throw=find(abs(gf)>2000);
tf=time(index_throw);
gf=gf(index_throw);
ayf=ayf(index_throw);

[max_a , max_i]=max(ayf);
index_throw(1:max_i)=[];
tf(1:max_i)=[];
ayf(1:max_i)=[];
gf(1:max_i)=[];

%Extract flight start
index_2=find(ayf<max_a);
%Extract flight end
index_3=find(diff(ayf(index_2))>-10);

% estimate high dynamic gyroscope using y axis acc
ft = fittype('poly2');
[c1,gof1] = fit(ayf(index_2(1):index_3(end)) , gf(index_2(1):index_3(end)) , 'poly2');
stats = datastats(gf-c1(ayf));
stats.rms = (sum((gf-c1(ayf)).^2)/length(gf))^0.5
[stats.mae stats.mape]=mean_error(c1(ayf),gf);

stats_all = datastats(gf_whole-c1(ayf_whole));
stats_all.rms = (sum((gf_whole-c1(ayf_whole)).^2)/length(gf_whole))^0.5
[stats_all.mae stats_all.mape]=mean_error(c1(ayf_whole),gf_whole);

subplot(211)
plot(tf(index_2(1):index_3(end)),gf(index_2(1):index_3(end)));
hold on;
plot(tf(index_2(1):index_3(end)),c1(ayf(index_2(1):index_3(end))));
hold off;
xlabel("time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis accelero from throw to catch"...
     +newline+"MAE ="+stats.mae+", MAPE = "+stats.mape);
%     +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")

subplot(212);
plot(time,gf_whole);
hold on;
plot(time,c1(ayf_whole));
xlabel("time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis accelero among whole data"...
     +newline+"MAE ="+stats_all.mae+", MAPE = "+stats_all.mape);
%     +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")

%% FFT  <<<THIS SECTION WAS NOT USED>>>
clf;
ax=xAcc_mpu; ay=yAcc_mpu; az=zAcc_mpu;

gf=median_filter_f(gyro_hdr,25);
ayf=median_filter_f(ay,25);
axf=median_filter_f(ax,25);

gf_whole=gf;
ayf_whole=ayf;

%extract data from throw to catch
index_throw=find(abs(gf)>2000);
tf=time(index_throw);

gf=gf(index_throw);
ayf=ayf(index_throw);

[max_a , max_i]=max(ayf);
index_throw(1:max_i)=[];
tf(1:max_i)=[];
ayf(1:max_i)=[];
gf(1:max_i)=[];

%Extract flight start
index_2=find(ayf<max_a);
%Extract flight end
index_3=find(diff(ayf(index_2))>-10);

gf=gf(index_2(1):index_3(end));
ayf=ayf(index_2(1):index_3(end));
tf=tf(index_2(1):index_3(end));


for i=1:3
    figure(1);
    dft=fft(gf_whole(index_throw((i-1)*1000+1:i*1000)));
    Pdft=abs(dft).^2;
    Pdft=10*log10(Pdft);
    fscale=linspace(0,Fs,length(dft));
    Pdft(1)=0;
    subplot(3,1,i);
    plot(fscale(1:500),Pdft(1:500));
    ylim([20 110]);
    title("HDR gyro"...
        +newline+"Frequency analysis from "+time(index_throw((i-1)*1000+1))+" to "+time(index_throw(i*1000)));
    xlabel("Frequency [Hz]");
    ylabel("Power Spectral [dB]");
    [pks1,locs1]=findpeaks(Pdft(1:500),fscale(1:500),'MinPeakDistance',20,'SortStr','descend','MinPeakProminence',5);
    hold on;
    feature_point=find(locs1(1:5)>80&locs1(1:5)<100)
    plot(locs1(feature_point),pks1(feature_point),'o');
    hold off;
    legend("Power Spectral","Peak: "+locs1(feature_point)+" Hz");
    
    figure(2);
    dft=fft(ayf_whole(index_throw((i-1)*1000+1:i*1000)));
    Pdft=abs(dft).^2;
    Pdft=10*log10(Pdft);
    fscale=linspace(0,Fs,length(dft));
    Pdft(1)=0;
    
    subplot(3,1,i);
    plot(fscale(1:500),Pdft(1:500));
%     plot(fscale,Pdft);
    ylim([20 110]);
    title("MPU y axis acceleration"...
        +newline+"Frequency analysis from "+time(index_throw((i-1)*1000+1))+" to "+time(index_throw(i*1000)));
    xlabel("Frequency [Hz]");
    ylabel("Power Spectral [dB]");

%     [pks,locs]=findpeaks(Pdft(1:500),fscale(1:500),'MinPeakDistance',10,'SortStr','descend');
%     hold on;
%     plot(locs(1:5),pks(1:5),'o');
    
    
    figure(3);
    dft=fft(axf(index_throw((i-1)*1000+1:i*1000)));
    Pdft=abs(dft).^2;
    Pdft=10*log10(Pdft);
    fscale=linspace(0,Fs,length(dft));
    Pdft(1)=0;
    subplot(3,1,i);
    plot(fscale(1:500),Pdft(1:500));
    ylim([20 110]);
    title("MPU x axis acceleration"...
        +newline+"Frequency analysis from "+time(index_throw((i-1)*1000+1))+" to "+time(index_throw(i*1000)));
    xlabel("Frequency [Hz]");
    ylabel("Power Spectral [dB]");
%     [pks,locs]=findpeaks(Pdft(1:500),fscale(1:500),'MinPeakDistance',10,'SortStr','descend');
%     hold on;
%     plot(locs(1:5),pks(1:5),'o');
   
    
end
    dft=fft(ayf_whole(index_2(1):index_3(end)));
    Pdft=abs(dft).^2;
    Pdft=10*log10(Pdft);
    fscale=linspace(0,Fs,length(dft));
    Pdft(1)=0;
    index_rm_fq=find(90>fscale|(fscale>100&(Fs-100)>fscale)|(Fs-90)<fscale);
    dft(index_rm_fq)=0;
    Y=ifft(dft);
    figure(5);
    subplot(211);
    plot(tf,Y);
    subplot(212);
    plot(tf,ayf);
    