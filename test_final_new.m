clc
clear all
close all

tic

radial_res = 64;
angular_res = 512;

sigmaOnf=0.5;

imset = imageSet('Dataset','recursive');
totalPersons = size(imset,2);


for i=1:totalPersons
    a = sprintf('now is folder... %d; remaining %d folders',i,totalPersons-i);
    disp(a);
    cd('Normalized\training\');
    mkdir(imset(i).Description);
    cd(imset(i).Description);
    dir = pwd;
    dir(end+1) = '\';
    cd ..;
    cd ..;
    cd ..;
    for j=1:5
        x = read(imset(i),j);
        eyeimage=x(:,:,1);
        
        [circleiris,circlepupil,ring] = thresh(eyeimage,100,300);
        x = imhist(ring);
        b = find(x>0);
        ref = b(1)+8;

        imagewithnoise = noise(eyeimage,circleiris,circlepupil,ref);
        [polar_array noise_array] = normaliseiris(imagewithnoise, circleiris(2),...
            circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3),eyeimage, radial_res, angular_res);

      
        filename = num2str(j);
        imwrite(polar_array,[dir,filename,'-normal.jpg'],'jpg');
    end
end

for i=1:totalPersons
    a = sprintf('now is folder... %d; remaining %d folders',i,totalPersons-i);
    disp(a);
    cd('Normalized\testing\');
    mkdir(imset(i).Description);
    cd(imset(i).Description);
    dir = pwd;
    dir(end+1) = '\';
    cd ..;
    cd ..;
    cd ..;
    for j=6:imset(i).Count
        x = read(imset(i),j);
        eyeimage=x(:,:,1);
        
        [circleiris,circlepupil,ring] = thresh(eyeimage,100,300);
        x = imhist(ring);
        b = find(x>0);
        ref = b(1)+8;

        imagewithnoise = noise(eyeimage,circleiris,circlepupil,ref);
        [polar_array noise_array] = normaliseiris(imagewithnoise, circleiris(2),...
            circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3),eyeimage, radial_res, angular_res);

      
        filename = num2str(j);
        imwrite(polar_array,[dir,filename,'-normal.jpg'],'jpg');
    end
end


toc
