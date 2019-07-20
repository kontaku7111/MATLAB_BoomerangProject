function [x_re,y_re,z_re]=resampling(x,y,z,Fs,reFs)
    [p,q]=rat(reFs/Fs);
    x_re=resample(x,p,q);
    y_re=resample(y,p,q);
    z_re=resample(z,p,q);
end