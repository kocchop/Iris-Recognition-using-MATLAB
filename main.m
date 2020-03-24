clear all;
close all;
clc;



%% train data to fit the model
tic
imset = imageSet('training','recursive');

totalPersons = size(imset,2);
%imgPerPerson = imset(1).Count;


for i=1:totalPersons
    for j=1:imset(i).Count
        x = read(imset(i),j);
        
        x = histeq(x); %streching contrast or the histogram 
        
        temp = (wave_deco(x))'; %transposing the image
        
        temp = 2*temp - 1; %mapping into [-1 1]
        
        if(i==1 && j==1)
            trainData = array2table((temp(:))');
            trainData.label = imset(i).Description;
        else
            idx = size(trainData,1)+1;
            trainData(idx,1:512) = array2table((temp(:))');
            trainData(idx,513) = {imset(i).Description};
        end
        
    end
end

%[model, trainAccuracy] = trainClassifier(trainData);

%disp(acc);
   
[X Y] = fetchTest();
toc
%% train model

tic

guess = predict(trainedClassifier, X{:,trainedClassifier.PredictorNames});

guess = cellstr(guess);
Y = cellstr(Y);

a = strcmp(guess,Y);

n = sum(a);
d = size(a,1);

testAccuracy = n/d;

%disp(trainAccuracy);
disp(testAccuracy);

toc