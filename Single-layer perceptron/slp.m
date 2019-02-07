close all;
clear all;
clc;
simulation=10;
percentage=10;
%Random Initial weights
xmin=-0.3;
xmax=0.3;
n=5;
w=xmin+rand(3,n)*(xmax-xmin);
%w=zeros(1,n);
nclass=3;
for percent_test=1:6
    percentage=10*percent_test;
filename='iris.data.txt';
input=csvread(filename);
class1_data=input(1:50,:);
class2_data=input(51:100,:);
class3_data=input(101:150,:);

ndata=percentage*0.5;
accuracy=zeros(simulation,2);

for sim=1:simulation
    
    
 cv=cvpartition(size(class1_data,1),'HoldOut',0.1*percent_test);
index=cv.test;
class1_train=class1_data(index,:);
class1_test=class1_data(~index,:);

cv=cvpartition(size(class2_data,1),'HoldOut',0.1*percent_test);
index=cv.test;
class2_train=class2_data(index,:);
class2_test=class2_data(~index,:);

cv=cvpartition(size(class3_data,1),'HoldOut',0.1*percent_test);
index=cv.test;
class3_train=class3_data(index,:);
class3_test=class3_data(~index,:);

a_train=[class1_train ; class2_train];
a_train=[a_train ; class3_train];
a_test=[class1_test ; class2_test];
a_test=[a_test ; class3_test];



%learning rate
alpha=0.01;

% error threshold
del=0.01;
% Iteration threshold 10000
itr=1000;

%selected_data1=input(randperm(50,5),:);
%selected_data2=input(50+randperm(50,5),:);
%selected_data3=input(100+randperm(50,5),:);


%selected data for training
%a=selected_data;
%a_train=a_train(randperm((percentage*1.5),(percentage*1.5)),:);
a=a_train;
b=ones(size(a,1),size(a,2));
c=zeros(3*ndata,3);
for i=1:size(a,1)
    if i < ndata
        class=1;
    end
    if i>ndata && i<2*ndata
        class=2;
    end
    if i>2*ndata && i< 3*ndata
        class=3;
    end
    c(i,class)=1;
    for j=2:size(a,2)
        b(i,j)=a(i,j-1);
    end
end

%b;
%c;
%w;

error=0;
for i=1:itr
    fprintf('iteration=%d\n',i);
    for j=1:size(b,1)
        h=b(j,:)*w';
       % sum(j)=h;
       for k=1:3
           if h(k) <= 0
               h(k)=0;
           end
           if h(k) > 0
               h(k)=1;
           end
       end
    %   h
       % weight updation
       w=w';
       for k=1:n
           w(k,:)=w(k,:) + alpha*(c(j,:) - h) * b(j,k);
       end
    w=w';
   
    end
   
%
        
    
end

correct=0;
    fprintf('Training Simuation=%d\n',sim);
    for j=1:size(b,1)
        h=b(j,:)*w';
       % sum(j)=h;
       for k=1:3
           if h(k) <= 0
               h(k)=0;
           end
           if h(k) > 0
               h(k)=1;
           end
       end
       if h == c(j,:)
           correct=correct+1;
       end
    end
    training_percentage=correct*100/size(b,1);
    accuracy(sim,1)=training_percentage;
    fprintf('Training accuracy for this simulation=%f',training_percentage);
 
%a_test=a_test(randperm(((100-percentage)*1.5),((100-percentage)*1.5)),:);
a=a_test;
b=ones(size(a,1),size(a,2));
each_class_data=size(a,1)/3;
c=zeros(each_class_data,3);
for i=1:size(a,1)
    if i < each_class_data
        class=1;
    end
    if i>each_class_data && i<2*each_class_data
        class=2;
    end
    if i>2*each_class_data && i< 3*each_class_data
        class=3;
    end
    c(i,class)=1;
    for j=2:size(a,2)
        b(i,j)=a(i,j-1);
    end
end
%a;
%b;
%c;

correct=0;
    fprintf('\ntesting_Simuation=%d\n',sim);
    for j=1:size(b,1)
        h=b(j,:)*w';
       % sum(j)=h;
       for k=1:3
           if h(k) <= 0
               h(k)=0;
           end
           if h(k) > 0
               h(k)=1;
           end
       end
       if h == c(j,:)
           correct=correct+1;
       end
    end
    testing_percentage=correct*100/size(b,1);
    accuracy(sim,2)=testing_percentage;
    fprintf('Testing accuracy for this simulation=%f',testing_percentage);
end
accuracy
y(percent_test,:)=sum(accuracy)/simulation
end

%d={'training_accuracy','testing_accuracy';accuracy}
%s = xlswrite('result.xlsx', accuracy, 'Simuations', 'E1')


x=10:10:60;
bar(x,y)

dlmwrite('accuracy2',y,',',0,0);
csvwrite('myFile2',y,0,0);

