close all;
clear all;
clc;
features=4;

filename='iris.data.txt';
input=dlmread(filename);

input=[input zeros(size(input,1),1)];
cluster_center1=input(randperm(50,1),:);
cluster_center2=input(50+randperm(50,1),:);
cluster_center3=input(100+randperm(50,1),:);


pre_minsum=0;
minsum=0;

%input(:,features+2)=input(:,features+3);
itr=0;
cluster1=[];
cluster2=[];
cluster3=[];
medoid=[cluster_center1;cluster_center2;cluster_center3]
for s=1:size(input,1)
    if cluster_center1 == input(s,:)
        index(1,1)=s;
    end
    if cluster_center2 == input(s,:)
        index(1,2)=s;
    end
    if cluster_center3 == input(s,:)
        index(1,3)=s;
    end
end
   
pre_index=index;
%index=[find(input==cluster_center1(1,:)) find(input==cluster_center2(1,:)) find(input==cluster_center3(1,:))];
no_update=0;
while 1
    no_update
    if no_update > 5
        no_update
        break;
    end
random_medoid=randi(3,1)
random_data=randi(150,1)
while 1
    if(find(random_data~=index))
        break;
    end
    random_data=randi(150,1);
end
random_medoid
random_data
medoid

pre_random_data=index(1,random_medoid);
medoid(random_medoid,:)=input(random_data,:);
for s=1:size(input,1)
    if medoid(1,:) == input(s,:)
        index(1,1)=s;
    end
    if medoid(2,:) == input(s,:)
        index(1,2)=s;
    end
    if medoid(3,:) == input(s,:)
        index(1,3)=s;
    end
end
%index=[find(input==medoid(1,:)) find(input==medoid(2,:)) find(input==medoid(3,:))] 

 i=index(1,1);  
 j=index(1,2);
 k=index(1,3);

            pre_minsum=minsum;
            minsum=0;
            itr=itr+1;
             fprintf('iteration=%d\n',itr);
            for p=1:size(input,1)
                if p~=i && p~=j && p~=k
                    d1=sqrt(sum((input(p,1:features)-medoid(1,1:features)).^2));
                    d2=sqrt(sum((input(p,1:features)-medoid(2,1:features)).^2));
                    d3=sqrt(sum((input(p,1:features)-medoid(3,1:features)).^2));
                    d=[d1 d2 d3];
                    minsum=minsum+min(d);
                    
                   
                end
            end
            
                    if minsum < pre_minsum
                        no_update=0 ;
                    else
                        medoid(random_medoid,:)=input(pre_random_data,:);
                        index(1,random_medoid)=pre_random_data;
                        no_update=no_update+1;
                    end

            
 end
        

cluster_center1=input(index(1,1),:);
cluster_center2=input(index(1,2),:);
cluster_center3=input(index(1,3),:);
for i=1:size(input,1)
    fprintf('data set number=%d\n',i);
    d1=sqrt(sum((input(i,1:features)-cluster_center1(1,1:features)).^2))
    d2=sqrt(sum((input(i,1:features)-cluster_center2(1,1:features)).^2))
    d3=sqrt(sum((input(i,1:features)-cluster_center3(1,1:features)).^2))
    d=[d1 d2 d3];
    clusteringAt=find(d==min(d));
    if clusteringAt==1
        cluster1=[cluster1;input(i,:)];
        input(i,features+2)=1;
    end
    if clusteringAt==2
        cluster2=[cluster2;input(i,:)];
        input(i,features+2)=2;
    end
    if clusteringAt==3
        cluster3=[cluster3;input(i,:)];
        input(i,features+2)=3;
    end
     

end
    
    
  %{
  dist1=[];
    for i=1:size(cluster1,1)
    dist1(i)=sqrt(sum((cluster1(i,1:features)-cluster_center1(1,1:features)).^2))
    end
    ind=find(dist1==min(dist1));
    cluster_center1=cluster1(ind,:)
    
    dist2=[];
    for i=1:size(cluster2,1)
    dist2(i)=sqrt(sum((cluster2(i,1:features)-cluster_center2(1,1:features)).^2))
    end
    ind=find(dist2==min(dist2));
    cluster_center2=cluster2(ind,:);
    
    dist3=[];
    for i=1:size(cluster3,1)
    dist3(i)=sqrt(sum((cluster3(i,1:features)-cluster_center3(1,1:features)).^2))
    end
    ind=find(dist3==min(dist3));
    cluster_center3=cluster3(ind,:);
    
    %}
    itr
cluster_center1
size(cluster1)
cluster1
cluster_center2
size(cluster2)
cluster2
cluster_center3
size(cluster3)
cluster3

confusion = confusionmat(input(:,features+1),input(:,features+2))
accuracy=sum(max(confusion))*100/size(input,1)




