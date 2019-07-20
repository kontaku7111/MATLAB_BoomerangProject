n
orm=sqrt(xAcc_mpu.^2+yAcc_mpu.^2+zAcc_mpu.^2);
threshold=1.5*10^4;
% [flight_start]=find(norm>=threshold&-zGyro_mpu>=2000,1);
% [flight_end]=find((norm>=threshold)&(-zGyro_mpu>=2000),1,'last');
[flight_end]=find((-zGyro_mpu>=2000),1,'last');
[flight_start]=find((-zGyro_mpu>=2000),1);
% gyro_Hdr=median_filter_p(gyro_hdr,250);
gyro_Hdr=gyro_hdr;
% flight_end=flight_start+250;
% flight_start=flight_end;
% flight_end=flight_end+250;

time_=time(flight_start:flight_end);

xAcc_mpu_=xAcc_mpu(flight_start:flight_end);
yAcc_mpu_=yAcc_mpu(flight_start:flight_end);
zAcc_mpu_=zAcc_mpu(flight_start:flight_end);

xMag_=xMag(flight_start:flight_end);
yMag_=yMag(flight_start:flight_end);
zMag_=zMag(flight_start:flight_end);

xGyro_mpu_=xGyro_mpu(flight_start:flight_end);
yGyro_mpu_=yGyro_mpu(flight_start:flight_end);
zGyro_mpu_=zGyro_mpu(flight_start:flight_end);

gyro_hdr_=gyro_Hdr(flight_start:flight_end);
norm_=sqrt(xAcc_mpu_.^2+yAcc_mpu_.^2+zAcc_mpu_.^2);
% norm_=sqrt(xMag_.^2+yMag_.^2+zMag_.^2);

yPower=sqrt(yAcc_mpu_.^2);
plot(yPower)
max(yPower)

% [flight_start]=find(yPower==max(yPower),1,'last');
%%
flight_start=177;
flight_end=3157;

time_=time_(flight_start:flight_end);
xAcc_mpu_=xAcc_mpu_(flight_start:flight_end);
yAcc_mpu_=yAcc_mpu_(flight_start:flight_end);
zAcc_mpu_=zAcc_mpu_(flight_start:flight_end);
xMag_=xMag_(flight_start:flight_end);
yMag_=yMag_(flight_start:flight_end);
zMag_=zMag(flight_start:flight_end);
xGyro_mpu_=xGyro_mpu_(flight_start:flight_end);
yGyro_mpu_=yGyro_mpu_(flight_start:flight_end);
zGyro_mpu_=zGyro_mpu_(flight_start:flight_end);
gyro_hdr_=gyro_hdr_(flight_start:flight_end);
norm_=sqrt(xAcc_mpu_.^2+yAcc_mpu_.^2+zAcc_mpu_.^2);
plot(gyro_hdr_)

%%
% subplot(211);
% [ppx_xAcc,Fx_acc]=pwelch(xAcc_mpu,[],[],[],Fs);
% plot(Fx_acc(Fx_acc<50),ppx_xAcc(Fx_acc<50));
% subplot(212);
% [ppx_yAcc,Fy_acc]=pwelch(yAcc_mpu,[],[],[],Fs);
% plot(Fy_acc(Fy_acc<50),ppx_yAcc(Fy_acc<50));
% figure(2);
% [ppx_gyro,F_gyro]=pwelch(gyro_hdr,[],[],[],Fs);
% plot(F_gyro(F_gyro<50),ppx_gyro(F_gyro<50));


%%
figure(1);
x=zMag_;y=xAcc_mpu_;
[c1, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(311);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c1,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by z axis magneto and x axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation");
set(gca,'FontSize',14);


x=zMag_;y=yAcc_mpu_;
[c2, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(312);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c2,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by z axis magneto and y axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

x=zMag_;y=zAcc_mpu_;
[c3, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(313);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c3,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by z axis magneto and z axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

%%
figure(2);
x=xMag_;y=xAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(311);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by x axis magneto and x axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

y=yAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(312);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by x axis magneto and y axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

y=zAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(313);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by x axis magneto and z axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

%%
figure(3);
x=yMag_;y=xAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(311);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis magneto and x axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

y=yAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(312);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis magneto and y axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

y=zAcc_mpu_;
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
subplot(313);
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis magneto and z axis accelero"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

%% 
figure(4);
% gyro_hdr_=gyro_hdr;
% time_=time;
% xAcc_mpu_=xAcc_mpu;yAcc_mpu_=yAcc_mpu;
x=xAcc_mpu_;y=yAcc_mpu_;
% c=fit(norm_,gyro_hdr_,'poly3');
% [c gof]=fit(y ,gyro_hdr_,'poly2');
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,y ,0);
[MAE,MAPE]=mean_error(result,gyro_hdr_);
plot(time_,result);
% plot(time_,polyval(c,norm_));
% plot(c,norm_,gyro_hdr_);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
% title("Estimation used by x axis accelero and y axis accelero"...
title("Estimation used by y axis accelero"...
     +newline+"MAE ="+MAE+", MAPE = "+MAPE);
%     +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

% figure(3);
% a=c(x,y);
% a.Rsquared.Adjusted
% plot(c(x,y))

%%
figure(5);
x=xMag_;y=yMag_;
subplot(311);
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by x axis magneto and y axis magneto"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

y=zMag_;
subplot(312);
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by x axis magneto and z axis magneto"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);

x=yMag_;
subplot(313);
[c, gof]=fit([x, y],gyro_hdr_,'poly23');
plot(time_,gyro_hdr_);
hold on;
result=formula_estimation(c,x,y);
plot(time_,result);
hold off;
xlabel("Time [s]");
ylabel("Angular velocity [degree/s]");
title("Estimation used by y axis magneto and z axis magneto"...
    +newline+"Adjrsquare: "+gof.adjrsquare);
legend("gyro HDR","estimation")
set(gca,'FontSize',14);
