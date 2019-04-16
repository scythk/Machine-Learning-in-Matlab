function [pmv, p0] = baye(v)

m = [0.1,0.3,0.5,0.7,0.8];
pm = [0.01,0.04,0.03,0.02,0.9];

leng = length(v);
numof1 = length(v(v>0));

pvm = nchoosek(leng,numof1).* (1-m).^numof1.* m.^(leng-numof1);

pv = sum(pvm.*pm);

pmv = pvm.*pm./pv;

p0 = (leng-numof1)/leng;

end

