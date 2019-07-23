%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2019 Darwin Boomerangs                         %
% Smart -Boomerang Project                           %
% In partnership with :                              %
%   - University of St Etienne, France               %
%   - Aoyama Gakuin University / Lopez lab, Japan    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename    formula_estimation.m                    %
% This file is a funtion to calculate gyro HDR value %
% using estimation formula and 2 sensor value.        %  
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v1.0  Date July 23th, 2019     Author Takumi Kondo %
% Modifications from previous version...             %
% ...                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function result=formula_estimation(sfs_c,x,y)
    name_coef=coeffnames(sfs_c);
    formula_sfs=formula(sfs_c);
    value_coef=coeffvalues(sfs_c);
    str=formula_sfs;
    for i=1:length(value_coef)
        str=strrep(str,name_coef(i),num2str(value_coef(i)));
    end
    str
%     v=genvarname(name_coef);
%     for i=1:length(value_coef)
%         eval([char(name_coef(i)),'=',num2str(value_coef(i))]);
%     end
    str=strrep(str,"x*y","x.*y");
    str=strrep(str,"x^","x.^");
    str=strrep(str,"y^","y.^");
    str=strrep(str,"2*","2.*");
    str=strrep(str,"3*","3.*");
    result=eval(str);
end