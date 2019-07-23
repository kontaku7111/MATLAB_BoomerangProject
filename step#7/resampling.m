%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    resampling.m                            %
% This file is a funtion to resample dataset.        %
%                                                    %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x_re,y_re,z_re]=resampling(x,y,z,Fs,reFs)
    [p,q]=rat(reFs/Fs);
    x_re=resample(x,p,q);
    y_re=resample(y,p,q);
    z_re=resample(z,p,q);
end