%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    median_filter_f.m                      %
% This file is a funtion to filter dataset by median  %
% filter.                                             %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [future]=median_filter_f(vector,nb_samples)
    len=length(vector);
    nb_samples=floor(nb_samples/2);
    for i=1:len
        if i<=nb_samples
            future(i,1)=median(vector(1:i+nb_samples));
        elseif i>=len-nb_samples
            future(i,1)=median(vector(i-nb_samples:len));
        else
            future(i,1)=median(vector(i-nb_samples:i+nb_samples));
        end
    end
end