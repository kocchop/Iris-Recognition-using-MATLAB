function deco_img = wave_deco(x)


[xa,xh,xv,xd] = dwt2(x,'haar');

[xaa,xhh,xvv,xdd] = dwt2(xa,'haar');

[xaaa,xhhh,xvvv,xddd] = dwt2(xaa,'haar');

%[xaaaa,xhhhh,xvvvv,xdddd] = dwt2(xaaa,'haar');

temp3 = max(max(xaaa));
%disp(temp3);

deco_img = xaaa/temp3;

%figure,imshow(deco_img/temp3);

%[r,c,s] = size(xaaa)
