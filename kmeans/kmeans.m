close all;
clear all;
clc;
features=4;

filename='iris.data.txt';
input=dlmread(filename);
input=[input zeros(size(input,1),1) zeros(size(input,1),1)]
cluster_center1=input(randperm(50,1),:);
cluster_center2=input(50+randperm(50,1),:);
cluster_center3=input(100+randperm(50,1),:);
cluster_center1(1,features+3)=1;
cluster_center2(1,features+3)=2;
cluster_center3(1,features+3)=3;
update=1;
itr=0;
while update==1
    itr=itr+1;
update=0;
input(:,features+2)=input(:,features+3);

cluster1=[];
cluster2=[];
cluster3=[];
for i=1:size(input,1)
    fprintf('data set number=%d\n',i);
    d1=sqrt(sum((input(i,1:features)-cluster_center1(1,1:features)).^2))
    d2=sqrt(sum((input(i,1:features)-cluster_center2(1,1:features)).^2))
    d3=sqrt(sum((input(i,1:features)-cluster_center3(1,1:features)).^2))
    d=[d1 d2 d3];
    clusteringAt=find(d==min(d'));
    if clusteringAt==1
        cluster1=[cluster1;input(i,:)];
    end
    if clusteringAt==2
        cluster2=[cluster2;input(i,:)];
    end
    if clusteringAt==3
        cluster3=[cluster3;input(i,:)];
    end
    
    
    if clusteringAt~=input(i,features+2)
        input(i,features+3)=clusteringAt;
        update=1;
    end
     

end
    cluster_center1=sum(cluster1)/size(cluster1,1);
    cluster_center2=sum(cluster2)/size(cluster2,1);
    cluster_center3=sum(cluster3)/size(cluster3,1);
    itr
    cluster_center1
cluster1
cluster_center2
cluster2
cluster_center3
cluster3
confusion = confusionmat(input(:,features+1),input(:,features+2))
accuracy=sum(max(confusion))*100/size(input,1)

end


