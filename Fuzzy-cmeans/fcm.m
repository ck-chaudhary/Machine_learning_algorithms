% You should implement the stopping creteria by yourself....it  has been
% implemented on the iteration basis.
%Although the results coming fine.......
close all;
clear all;
clc;
features=4;
ncluster=3;
iterations=100;
%degree of fuzzification
m=2;
filename='iris.data.txt';
input=dlmread(filename);
input=[input zeros(size(input,1),1)];

u=zeros(size(input,1),ncluster);
for i=1:size(input,1)
    r=rand(1,3);
    r=r/sum(r);
    u(i,:)=r;
end
u;

for itr=1:iterations
for i=1:ncluster
    c(i,:)=(u(:,i)'.^m * input(:,1:features))/sum(u(:,i)'.^m);
    
end
for i=1:size(input,1)
    for j=1:ncluster
        d(i,j)=1/sqrt(sum(input(i,1:features)-c(j,:)).^2/(m-1));
        
    end
    u(i,:)=d(i,:)/sum(d(i,:));
    
end

end

    
for i=1:size(input,1)
    p=max(u(i,:));
    ind=find(u(i,:)==p);
    input(i,features+2)=ind;
    
end
u
confusion = confusionmat(input(:,features+1),input(:,features+2))
accuracy=sum(max(confusion))*100/size(input,1)

