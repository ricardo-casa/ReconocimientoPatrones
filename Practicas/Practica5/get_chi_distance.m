function chi_distance = get_chi_distance(counts1, counts2)
%GET_CHI_DISTANCE Mide la distancia entre dos histogramas 
%   utilizando la distancia CHI

%   $Author Jimena Olveres
%   $Date: 2013/19/04$

%  counts1 = counts1(1:9); %histograma1
%  counts2 = counts2(1:9);%histograma2

L = length(counts1);

% counts1(counts1 == 0) = 1;
% counts2(counts2 == 0) = 1;
% counts1 = counts1 / sum(counts1);
% counts2 = counts2 / sum(counts2);

chi_distance = 0;

for index = 1:L
    chi_distance = chi_distance+((counts1(index)-counts2(index)).^2)/(counts1(index)+counts2(index)+0.0001);% the decimal is to
    %avoid indetermination in the division
end

end
