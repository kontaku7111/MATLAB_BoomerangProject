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