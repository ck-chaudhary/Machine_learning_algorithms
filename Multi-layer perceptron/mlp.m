close all;
clearvars;
clc;
simulation=10;
percentage=10;
%Random Initial weights
xmin=-0.3;
xmax=0.3;
n=5;
nh=8;
no=3;
nclass=3;
w1=xmin+rand(nh-1,n)*(xmax-xmin);
w2=xmin+rand(no,nh)*(xmax-xmin);

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

a_train
a_test


%learning rate
alpha=0.01;

% error threshold
del=0.001;
% Iteration threshold 10000
itr=100;

%selected_data1=input(randperm(50,5),:);
%selected_data2=input(50+randperm(50,5),:);
%selected_data3=input(100+randperm(50,5),:);
%a=selected_data;

%selected data for training
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

b;
c;
w1;
w2;


error=0;
for i=1:itr
    fprintf('iteration=%d\n',i);
    for j=1:size(b,1)
        fprintf('iteration=%d\tdata_set=%d\n',i,j);
        
        %input to hidden layer
        v=b(j,:)*w1';
       % sum(j)=h;
       h=zeros(size(v));
       for k=1:size(v,2)
            h(k)=1/(1+exp(-v(k)));
       end
       
       h=[ones(1,1);h'];
       h=h';
       %hidden to output layer
       y=h*w2';
       for k=1:size(y,2)
         o(k)=1/(1+exp(-y(k)));
       end
       o;
       
       
       for k=1:size(o,2)
       delta2(k)=(c(j,k) - o(k))*o(k)*(1-o(k));
       end
       
       
       for k=1:size(v,2)
       delta1(k)=(w2(:,k)' * delta2')*h(k+1)*(1-h(k+1));
       end
       
       w1;
       w2;
       
 
    % w2=w2';
       for k=1:size(v,2)
           w1(k,:)=w1(k,:) + alpha*delta1(k) * b(j,:);
       end
       w1;
   % w=w';
       for k=1:size(y,2)
           w2(k,:)=w2(k,:) + alpha*delta2(k) * h;
       end
       w2;
   
    end
       
end

%training complete


correct=0;
 fprintf('Training simulation=%d\n',sim);
    for j=1:size(b,1)
        fprintf('iteration=%d\tdata_set=%d\n',i,j);
        
        %input to hidden layer
        v=b(j,:)*w1';
       % sum(j)=h;
       h=zeros(size(v));
       for k=1:size(v,2)
            h(k)=1/(1+exp(-v(k)));
       end
       
       h=[ones(1,1);h'];
       h=h';
       %hidden to output layer
       y=h*w2';
       for k=1:size(y,2)
         o(k)=1/(1+exp(-y(k)));
       end
       o;
       p=max(o);
       ind=find(o==p);
       if(c(j,ind)==1)
           correct=correct+1;
       end
       c(j,:);
       

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

correct=0;
 fprintf('Testing simulation=%d\n',sim);
    for j=1:size(b,1)
        fprintf('iteration=%d\tdata_set=%d\n',i,j);
        
        %input to hidden layer
        v=b(j,:)*w1';
       % sum(j)=h;
       h=zeros(size(v));
       for k=1:size(v,2)
            h(k)=1/(1+exp(-v(k)));
       end
       
       h=[ones(1,1);h'];
       h=h';
       %hidden to output layer
       y=h*w2';
       for k=1:size(y,2)
         o(k)=1/(1+exp(-y(k)));
       end
       o;
       p=max(o);
       ind=find(o==p);
       if(c(j,ind)==1)
           correct=correct+1;
       end
       c(j,:);
       

    end

    testing_percentage=correct*100/size(b,1);
    accuracy(sim,2)=testing_percentage;
    fprintf('Testing accuracy for simulation%d = %f',sim,testing_percentage);


end
fprintf('Training accuracy\tTesting accuracy\n');
y_axis(percent_test,:)=sum(accuracy)/simulation

end

x=10:10:10*percent_test;
bar(x,y_axis)
alpha
itr
nh

dlmwrite('accuracy2',y_axis,',',0,0);
csvwrite('myFile2',y_axis,0,0);
