function [Xtest Ytest] = fetchTest()

imset = imageSet('testing','recursive');

totalPersons = size(imset,2);
%imgPerPerson = imset(1).Count;


for i=1:totalPersons
    for j=1:imset(i).Count
        x = read(imset(i),j);
        
        x = imadjust(x);
        
        temp = (wave_deco(x))'; %transposing the image
        
        temp = 2*temp - 1; %mapping into [-1 1]
        
        if(i==1 && j==1)
            testData = array2table((temp(:))');
            testData.label = imset(i).Description;
        else
            idx = size(testData,1)+1;
            testData(idx,1:512) = array2table((temp(:))');
            testData(idx,513) = {imset(i).Description};
        end
        
    end
end

%% so far ok

up_until = size(testData,1);

Xtest = testData(:,1:end-1);
Ytest = testData.label;

% guess = predict(model,Xtest);
% 
% testAccuracy = Xtest;


