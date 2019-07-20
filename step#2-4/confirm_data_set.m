clear;
path_dataset="C:\Users\TakumiKONDO\Documents\boomerang\data_set_1\";
% path_dataset="C:\Users\TakumiKONDO\Documents\boomerang\data_set_2\";

% Sampling frequency is 500 Hz 
Fs=500;

% Accelero_HDR unit: mG
acc_HDR=dlmread(path_dataset+"Accelero_HDR.csv",";");
acc_HDR=acc_HDR/1000;
xAcc_hdr=acc_HDR(:,1); yAcc_hdr=acc_HDR(:,2); zAcc_hdr=acc_HDR(:,3);

clear acc_HDR;

% Accelero_MPU unit: mG
acc_MPU=dlmread(path_dataset+"Accelero_MPU.csv",";");
acc_MPU=acc_MPU/1000;
xAcc_mpu=acc_MPU(:,1);yAcc_mpu=acc_MPU(:,2);zAcc_mpu=acc_MPU(:,3);
% clear acc_MPU;

% Gyro_HDR unit: Åã/s
gyro_HDR=dlmread(path_dataset+"Gyro_HDR.csv",";");
offset_gyroHDR=170;
gyro_hdr=gyro_HDR-offset_gyroHDR;
clear gyro_HDR;

% Gyro_MPU: unit: Åã/s
gyro_MPU=dlmread(path_dataset+"Gyro_MPU.csv",";");
xGyro_mpu=gyro_MPU(:,1);yGyro_mpu=gyro_MPU(:,2);zGyro_mpu=gyro_MPU(:,3);
% clear gyro_MPU;

% Magneto unit: É T
magnet=dlmread(path_dataset+"magneto.csv",";");
xMag=magnet(:,1);yMag=magnet(:,2);zMag=magnet(:,3);

% convert É T to G
% magnet=magnet*1000;
% xMag=magnet(:,1);yMag=magnet(:,2);zMag=magnet(:,3);
% clear magnet;
