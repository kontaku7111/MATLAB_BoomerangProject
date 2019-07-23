%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    compare_gyro_estimation.m              %
% This file is intended to compare combinations of   %
% 2 sensor values                                    %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compare combinations of 2 sensor values
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
