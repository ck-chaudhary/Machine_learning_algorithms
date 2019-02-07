close all;
clear all;
clc;
features=4;
filename='iris.data.txt';
input=dlmread(filename);
input=input(randperm(150),:);
[idx,C,sumd,D]=kmedoids(input(:,1:features),3)
confusion = confusionmat(idx,input(:,features+1))
accuracy=sum(max(confusion))*100/size(input,1)
