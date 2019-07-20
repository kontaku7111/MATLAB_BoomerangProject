function [past] =median_filter_p(vector, nb_samples)
    len=length(vector);
    for i=1:len
        if i<= nb_samples
            past(i,1)=median(vector(1:i));
        else
            past(i,1)=median(vector(i-nb_samples+1:i));
        end
    end
end
