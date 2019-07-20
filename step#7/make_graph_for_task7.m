%% zGyro (estimated while z gyro mpu achieved 2000)
Accelerometer=acc_MPU;

zGyro=zGyro_mpu;
may=median_filter_p(yAcc_mpu,25);
for i=1:length(may)
    if abs(zGyro_mpu(i))==2000
        zGyro(i)=-estimate_gyroHDR(may(i));
    end
end
subplot(211);
plot(time,zGyro_mpu);
title("raw z gyro hdr");
subplot(212);
plot(time,zGyro);
title("z gyro mpu + estimated");
%% extract flight period
norm=sqrt(xAcc_mpu.^2+yAcc_mpu.^2+zAcc_mpu.^2);
index_flight=find(abs(norm)>50);
time_flight=time(index_flight);

subplot(211);
plot(time,norm);
hold on;
plot([time_flight(1) time_flight(1)],[0 max(norm)],'c',"linewidth",2);
plot([time_flight(end) time_flight(end)],[0 max(norm)],'c',"linewidth",2);
hold off;
title("Norm of Accelerometor");
xlabel("time [s]");
ylabel("Amplitude");

subplot(212);
plot(time,acc_MPU);
hold on;
plot([time_flight(1) time_flight(1)],[-200 200],'c',"linewidth",2);
plot([time_flight(end) time_flight(end)],[-200 200],'c',"linewidth",2);
hold off;
title("Accelerometor");
xlabel("time [s]");
ylabel("Accelerometor [m/s^2]");
legend("x acc","y acc","z acc");


%% save resampled file
zGyro=zGyro_mpu;
may=median_filter_p(yAcc_mpu,25);
for i=1:length(may)
    if abs(zGyro_mpu(i))==2000
        zGyro(i)=-estimate_gyroHDR(may(i));
    end
end
Accelerometer=acc_MPU;
Gyroscope=gyro_MPU;
Gyroscope(:,3)=zGyro;

reFs=60;
[xa,ya,za]=resampling(Accelerometer(:,1),Accelerometer(:,2),Accelerometer(:,3),Fs, reFs);
csvwrite("Acc_03.csv",[xa,ya,za]);
[xg,yg,zg]=resampling(Gyroscope(:,1),Gyroscope(:,2),Gyroscope(:,3),Fs, reFs);
csvwrite("Gyro_03.csv",[xg,yg,zg]);
[xm,ym,zm]=resampling(magnet(:,1),magnet(:,2),magnet(:,3),Fs, reFs);
csvwrite("Mag_03.csv",[xm,ym,zm]);

%% detect throwing speed
norm=sqrt(xAcc_mpu.^2+yAcc_mpu.^2+zAcc_mpu.^2);
% extract flight period
index_flight=find(abs(norm)>50);
time_flight=time(index_flight);

% estimate HDR gyro value
zGyro=zGyro_mpu;
may=median_filter_p(yAcc_mpu,25);
for i=1:length(may)
    if abs(zGyro_mpu(i))==2000
        zGyro(i)=-estimate_gyroHDR(yAcc_mpu(i));
    end
end
zGyro_flight=zGyro(index_flight);
[throwing_speed,index_throw]=max(abs(zGyro_flight));

plot(time_flight,zGyro_flight);
hold on;
plot(time_flight(index_throw),zGyro_flight(index_throw),'o','LineWidth',2,'MarkerSize',12);
title("Detect throwing speeed using z gyro"+newline+"Throwing speed: "+throwing_speed+"degree/s");
xlabel("time [s]");
ylabel("Gyroscope [degree/s]");
%%
addpath('quaternion_library');      % include quaternion library
AHRS = MadgwickAHRS('SamplePeriod', 1/1000, 'Beta', 0.1);
% unit: G
Accelerometer=acc_MPU/9.81; %convert ms/(s^2) into G
Accelerometer(:,1)=median_filter_p(Accelerometer(:,1),25);
Accelerometer(:,2)=median_filter_p(Accelerometer(:,2),25);
Accelerometer(:,3)=median_filter_p(Accelerometer(:,3),25);

% unit: degree/s
Gyroscope=gyro_MPU;
% estimate high dynamic value
for i=1:length(Accelerometer(:,3))
    if abs(Gyroscope(i,3))==2000
        % convert Acc unit 
        Gyroscope(i,3)=-estimate_gyroHDR(Accelerometer(i,2)*9.81);
        Gyroscope(i,3)=Gyroscope(i,3);
    end
end

%unit: G (1É TÅ®0.01G)
Magnetometer=magnet*100;

quaternion = zeros(length(xAcc_mpu), 4);
for t = 1:length(xAcc_mpu)
    AHRS.Update(Gyroscope(t,:) * (pi/180), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end
euler = quatern2euler(quaternConj(quaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.


figure('Name', 'Euler Angles');
hold on;
plot(time, euler(:,1), 'r');
plot(time, euler(:,2), 'g');
plot(time, euler(:,3), 'b');
title('Euler angles');
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('\phi', '\theta', '\psi');
hold off;

% plot(time, smooth(magnet(:,3),100));
reFs=60;
[a,b,c]=resampling(euler(:,1),euler(:,2),euler(:,3),Fs,reFs);
csvwrite("euler_03.csv",[a,b,c]);

%% estimate euler angle using reasampled sensor data
acc=dlmread("C:\Users\TakumiKONDO\Documents\boomerang\Boomerang project\Assets\Resources\csv\Acc_03.csv",",");
gyro=dlmread("C:\Users\TakumiKONDO\Documents\boomerang\Boomerang project\Assets\Resources\csv\gyro_03.csv",",");
mag=dlmread("C:\Users\TakumiKONDO\Documents\boomerang\Boomerang project\Assets\Resources\csv\Mag_03.csv",",");

addpath('quaternion_library');      % include quaternion library
acc=acc/9.81;
AHRS = MadgwickAHRS('SamplePeriod', 1/60.0, 'Beta', 0.1);
q = zeros(length(mag), 4);
for t = 1:length(mag)
    AHRS.Update(gyro(t,:) * (pi/180), acc(t,:), mag(t,:));	% gyroscope units must be radians
    q(t, :) = AHRS.Quaternion;
end
e = quatern2euler(quaternConj(q)) * (180/pi);
unity=dlmread("C:\Users\TakumiKONDO\Documents\boomerang\euler.csv",",");
subplot(211);
plot(e);
subplot(212);
plot(unity);
ylim([-200 200]);

%% compare filtered and non-filtered
axf=median_filter_p(xAcc_mpu,25);
ayf=median_filter_p(yAcc_mpu,25);
azf=median_filter_p(zAcc_mpu,25);
subplot(211);
plot(time,axf);
hold on;
plot(time,ayf);
plot(time,azf);
hold off;
title("filtered acc signal");
subplot(212);
plot(time,acc_MPU);
title("raw acc signal"); 
