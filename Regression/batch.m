close all;
clear all;
clc;

%Random Initial weights
xmin=-0.3;
xmax=0.3;
n=3;
w=xmin+rand(1,n)*(xmax-xmin);
%w=zeros(1,3);

%learning rate
alpha=0.00001;

% error threshold
del=0.000001;
% Iteration threshold 
itr=12700;

formatSpec = '%d %d %d';
size_a=[3 Inf];
fileID = fopen('input.txt','r');
p = fscanf(fileID,formatSpec,size_a)
a=p';
b=ones(size(a,1),size(a,2));
for i=1:size(a,1)
    c(i)=a(i,n);
    for j=2:size(a,2)
        b(i,j)=a(i,j-1);
    end
end
b
c
w
%fprintf(fileID,'%4.4f\n',x);
error=0;
for i=1:itr
    fprintf('iteration=%d\n',i);
    for j=1:size(b,1)
        h=b(j,:)*w';
        sum(j)=h;
   
    end
    w
        for k=1:n
            for l=1:size(b,1)
                sum2=(c(l)-sum(l))*b(l,k);
            end
            
            
           w(k)= w(k) + alpha*sum2;
        end
        w
    pre_error=error;
    error=0;
    for j=1:size(b,1)
        error=error+0.5*(sum(j)-c(j))*(sum(j)-c(j));
    end
    pre_error
    error
    if (max(pre_error,error)-min(pre_error,error)) < del
        break;
    end
%
        
    
end

fclose(fileID);
