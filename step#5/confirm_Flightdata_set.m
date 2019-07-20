clear;
% change path
path_dataset="C:\Users\TakumiKONDO\Documents\boomerang\data_set_3\";

% Sampling frequency is 500 Hz 
Fs=1000;

% Accelero_HDR
acc_HDR=dlmread(path_dataset+"AccGD.csv",";",1,0);
acc_HDR=acc_HDR*9.81/1000;
xAcc_hdr=acc_HDR(:,1); yAcc_hdr=acc_HDR(:,2); zAcc_hdr=acc_HDR(:,3);
clear acc_HDR;

% Accelero_MPU
acc_Mpu=dlmread(path_dataset+"AccPD.csv",";",1,0);
% convert unit: mGÅ®m/s2
acc_MPU=acc_Mpu*9.81/1000;
xAcc_mpu=acc_MPU(:,1);
yAcc_mpu=acc_MPU(:,2);
zAcc_mpu=acc_MPU(:,3);
% clear acc_MPU;

% Gyro_HDR unit: Åã/s
gyro_HDR=dlmread(path_dataset+"GyroGD.csv",";");
offset_gyroHDR=170;
gyro_hdr=gyro_HDR-offset_gyroHDR;
% gyro_Hdr=median_filter_f(gyro_hdr,window_size);
clear gyro_HDR;

% Gyro_MPU: unit: Åã/s
gyro_MPU=dlmread(path_dataset+"GyroPD.csv",";",1,0);
xGyro_mpu=gyro_MPU(:,1);
yGyro_mpu=gyro_MPU(:,2);
zGyro_mpu=gyro_MPU(:,3);
% clear gyro_MPU;

% Magneto unit: É T
magnet=dlmread(path_dataset+"magneto.csv",";",1,0);
xMag=magnet(:,1);
yMag=magnet(:,2);
zMag=magnet(:,3);
% clear magnet;

time=(0:length(gyro_hdr)-1)/Fs;

