clear;
path_dataset="C:\Users\TakumiKONDO\Documents\boomerang\data_set_06\";
filenum="04";

% Sampling frequency is 500 Hz 
Fs=500;

% Accelero_HDR
acc_HDR=dlmread(path_dataset+"Accelero_HDR_0"+filenum+".csv",";");
acc_HDR=acc_HDR*9.81/1000;
xAcc_hdr=acc_HDR(:,1); yAcc_hdr=acc_HDR(:,2); zAcc_hdr=acc_HDR(:,3);
clear acc_HDR;

% Accelero_MPU
acc_Mpu=dlmread(path_dataset+"Accelero_MPU_0"+filenum+".csv",";");
% convert unit: mGÅ®m/s2
acc_MPU=acc_Mpu*9.81/1000;
xAcc_mpu=acc_MPU(:,1);
yAcc_mpu=acc_MPU(:,2);
zAcc_mpu=acc_MPU(:,3);
% clear acc_MPU;

% Gyro_MPU: unit: Åã/s
gyro_MPU=dlmread(path_dataset+"Gyro_MPU_0"+filenum+".csv",";");
xGyro_mpu=gyro_MPU(:,1);
yGyro_mpu=gyro_MPU(:,2);
zGyro_mpu=gyro_MPU(:,3);
% clear gyro_MPU;

% Magneto unit: É T
magnet=dlmread(path_dataset+"Magneto_0"+filenum+".csv",";");
xMag=magnet(:,1);
yMag=magnet(:,2);
zMag=magnet(:,3);
% clear magnet;

time=(0:length(xGyro_mpu)-1)/Fs;
