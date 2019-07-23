%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    madgwick.m                             %
% This file is intended to calculate Euler angle     %
% using Madgwick and save Euler dataset resampled    %  
% into csv file.                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('quaternion_library');      % include quaternion library

AHRS = MadgwickAHRS('SamplePeriod', 1/500, 'Beta', 0.1);

% unit: degree/s
Gyroscope=gyro_MPU;
% Gyroscope(:,3)=-gyro_hdr;

% unit: G
Accelerometer=acc_MPU;

%unit: Flux (1É TÅ®0.01G)
Magnetometer=magnet*100;

quaternion = zeros(length(xAcc_mpu), 4);
for t = 1:length(xAcc_mpu)
    AHRS.Update(Gyroscope(t,:) * (pi/180), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end

time=linspace(0,length(xAcc_mpu)/Fs,length(xAcc_mpu));

euler = quatern2euler(quaternConj(quaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.

% Plot
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

% resampling
reFs=60;
[a,b,c]=resampling(euler(:,1),euler(:,2),euler(:,3),Fs,reFs);
% save euler into csv file
csvwrite("euler_01.csv",[a,b,c]);
