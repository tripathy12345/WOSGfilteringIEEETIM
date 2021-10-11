function [xa, xd1, xd2, xd3, xd4, xd5]=waveletdecompose(kk)
[C,L] = wavedec(kk, 5, 'db4');
xa= wrcoef('a',C,L,'db4',5);
xd1= wrcoef('d',C,L,'db4',5);
xd2= wrcoef('d',C,L,'db4',4);
xd3= wrcoef('d',C,L,'db4',3);
xd4= wrcoef('d',C,L,'db4',2);
xd5= wrcoef('d',C,L,'db4',1);
end
