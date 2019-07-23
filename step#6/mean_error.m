%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    mean_error.m                            %
% This file is a funtion to evaluate predicted data  %
% using true data.                                   %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mae_,mape_]=mean_error(predict, truth)
mae_=0;
for i=1:length(truth)
    mae_=mae_+abs(predict(i)-truth(i));
end
mae_=mae_/length(truth)

mape_=0;
for i=1:length(truth)
    mape_=mape_+abs((predict(i)-truth(i))/truth(i));
end
mape_=mape_*100/length(truth)
% mape_=0;
% for i=1:length(result)
%     mape_=mape_+abs((result(i)-gyro_hdr(i))/gyro_hdr(i))
% end
% mape_=mape_*100/length(result)