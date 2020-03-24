function imagewithnoise = noise(eyeimage,circleiris,circlepupil,ref)

rowd = double(circleiris(1));
cold = double(circleiris(2));
rd = double(circleiris(3));
%what is this
irl = round(rowd-rd); %  __
iru = round(rowd+rd); % |  | 
icl = round(cold-rd); % |  |
icu = round(cold+rd); %  ''

imgsize = size(eyeimage);

if irl < 1 
    irl = 1;
end

if icl < 1
    icl = 1;
end

if iru > imgsize(1)
    iru = imgsize(1);
end

if icu > imgsize(2)
    icu = imgsize(2);
end

imagepupil = eyeimage( irl:iru,icl:icu);
imagewithnoise = double(eyeimage);

%find top eyelid

rr = circleiris(3)-circlepupil(3);
rr = round(rr);

topeyelid = imagepupil(1:rr,:);
linest = findline(topeyelid);

if size(linest,1) > 0
    [xl yl] = linecoords(linest, size(topeyelid));
    yl = double(yl) + irl-1;
    xl = double(xl) + icl-1;
    
    yla = max(yl);
    
    y2 = 1:yla;
    
    ind3 = sub2ind(size(eyeimage),yl,xl);
    imagewithnoise(ind3) = NaN;
    imagewithnoise(y2, xl) = NaN;
    
end

cv = size(imagepupil,1);
rowp = circlepupil(1);

%find bottom eyelid
bottomeyelid = imagepupil((cv-rr):cv,:);
linesb = findline(bottomeyelid);

if size(linesb,1) > 0
    
    [xl yl] = linecoords(linesb, size(bottomeyelid));
    yl = double(yl)+ irl+cv-rr-2;
    xl = double(xl) + icl-1;
    
    yla = min(yl);
    
    y2 = yla:size(eyeimage,1);
    
    ind4 = sub2ind(size(eyeimage),yl,xl);
    imagewithnoise(ind4) = NaN;
    imagewithnoise(y2, xl) = NaN;
end

%For CASIA, eliminate eyelashes by thresholding
mark = eyeimage < ref;
imagewithnoise(mark) = NaN;
