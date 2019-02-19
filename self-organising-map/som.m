close all;
clear all;
clc;
features=4;

filename='iris.data.txt';
input=dlmread(filename);
input=[input zeros(size(input,1),1)];
cluster_center=[1 2 3];
itr=1000;
sig=1;
alpha=0.01;
ncluster=3;
xmin=-0.1;
xmax=0.1;
w=xmin+rand(ncluster,features)*(xmax-xmin);


while itr > 0
    itr=itr-1;

for i=1:size(input,1)
    fprintf('data set number=%d\n',i);
    input(i,:)
    d1=sqrt(sum((input(i,1:features)-w(1,1:features)).^2));
    d2=sqrt(sum((input(i,1:features)-w(2,1:features)).^2));
    d3=sqrt(sum((input(i,1:features)-w(3,1:features)).^2));
    d=[d1 d2 d3];
    clusteringAt=find(d==min(d'));
    
   lateral_dist=abs(cluster_center-clusteringAt);
   h=exp(-(lateral_dist.^2)/(2*sig*sig));
   
   for j=1:ncluster
         w1(j,:)=w(j,:) + alpha*h(1,j)*(input(i,1:features)-w(j,:));
   end
   if abs(w1-w)<0.001
       break
   end
   w;
   w1;
   w=w1
   
end
w;

itr;

for i=1:size(input,1)
     d1=sqrt(sum((input(i,1:features)-w(1,1:features)).^2));
    d2=sqrt(sum((input(i,1:features)-w(2,1:features)).^2));
    d3=sqrt(sum((input(i,1:features)-w(3,1:features)).^2));
    d=[d1 d2 d3];
    clusteringAt=find(d==min(d'));
    input(i,features+2)=clusteringAt;
    
end
    

confusion = confusionmat(input(:,features+1),input(:,features+2))
accuracy=sum(max(confusion))*100/size(input,1)
w;

end
