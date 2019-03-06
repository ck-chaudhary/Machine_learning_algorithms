close all;
clear all;
clc;
features=4;

filename='iris.data.txt';
input=dlmread(filename);
input=[input zeros(size(input,1),1)];
p=zeros(150,150);

for i=1:150
    for j=1:150
        if i==j
            p(i,j)=100;
        else
        p(i,j)=sqrt(sum((input(i,1:features)-input(j,1:features)).^2));
        end
    end
end
p
[row col]=find(p==min(min(p)))

cluster1=[input(row(1,1),:) ; input(col(1,1),:)];
input1=input;
input1([row(1,1) col(1,1)],:)=[];
avg=zeros(50,1);
for k=1:48
for i=1:size(input1,1)
    for j=1:size(cluster1,1)
    d(j,1)=sqrt(sum((input1(i,1:features)-cluster1(j,1:features)).^2));
    end
    d
    avg(i,1)=sum(d)/size(cluster1,1)
end
row1=find(avg==min(avg))
cluster1=[cluster1;input1(row1,:)]
input1(row1,:)=[];
end
cluster1
size(cluster1)



%cluster2


for i=1:100
    for j=1:100
        if i==j
            p(i,j)=100;
        else
        p(i,j)=sqrt(sum((input1(i,1:features)-input1(j,1:features)).^2));
        end
    end
end
p
[row col]=find(p==min(min(p)))

cluster2=[input1(row(1,1),:) ; input1(col(1,1),:)];
input2=input1;
input2([row(1,1) col(1,1)],:)=[];
avg=zeros(50,1);
for k=1:48
for i=1:size(input2,1)
    for j=1:size(cluster2,1)
    d(j,1)=sqrt(sum((input2(i,1:features)-cluster2(j,1:features)).^2));
    end
    d
    avg(i,1)=sum(d)/size(cluster2,1)
end
row1=find(avg==min(avg))
cluster2=[cluster2;input2(row1,:)]
input2(row1,:)=[];
end
cluster1
size(cluster1)
cluster2
size(cluster2)
cluster3=input2;


% calculating centers
center1=sum(cluster1);
center1=center1/50;
for i=1:50
    d(i,1)=sqrt(sum((cluster1(i,1:features)-center1(1:features)).^2));
end
d
index1=find(d==min(d));
center1=cluster1(index1,:)

center2=sum(cluster2);
center2=center2/50;
for i=1:50
    d(i,1)=sqrt(sum((cluster2(i,1:features)-center2(1:features)).^2));
end
d
min(d)
index1=find(d==min(d));
center2=cluster2(index1,:)


center3=sum(cluster3);
center3=center3/50;
for i=1:50
    d(i,1)=sqrt(sum((cluster3(i,1:features)-center3(1:features)).^2));
end
d
min(d)
index1=find(d==min(d));
center3=cluster3(index1,:)

center1
cluster1


center2
cluster2

center3
cluster3




% kmeans on found out centers



input=[input zeros(size(input,1),1) ]
%cluster_center1=input(randperm(50,1),:);
%cluster_center2=input(50+randperm(50,1),:);
%cluster_center3=input(100+randperm(50,1),:);
cluster_center1=center1;
cluster_center2=center2;
cluster_center3=center3;
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
    cluster_center1(:,1:features+1)
cluster1(:,1:features+1)
cluster_center2(:,1:features+1)
cluster2(:,1:features+1)
cluster_center3(:,1:features+1)
cluster3(:,1:features+1)
confusion = confusionmat(input(:,features+1),input(:,features+2))
accuracy=sum(max(confusion))*100/size(input,1)

end


