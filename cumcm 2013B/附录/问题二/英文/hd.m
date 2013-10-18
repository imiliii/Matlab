function [po] = hd (a1,a2);

[h,l1] = size(a1);
[h,l2] = size(a2);

aa = [a1,a2];   %a1,a2����ƴ��
co = [aa(:,(l1-59):(l1+60))];   %ȡ�����Ӳ��� size(co)=[h,120]

for i = 1:h
    for j = 1:120
        if(co(i,j) < 64)   %�Ҷȵ��ڣ�������
           co(i,j) = 0;
        else co(i,j) = 255;
        end
    end
end

edge = zeros(h,1);
ee = 0;
for i = 1:h
    if (co(i,60) + co(i,61) == 0)
        edge(i) = 1;
        ee = ee + 1;
    end
end

if (ee > 0)
d = zeros(h,1);
for i = 1:h
    for j = 1:120
        if (co(i,j) == 0)
            d(i) = 1;
            break;
        end
    end
end

% ���в���

l = 0;
maxl = 0;
up = 0;
down = 0;
for i =1:h
    if (d(i) == 1) 
        l = l + 1;
    else if (l > maxl)
            maxl = l;
            down = i - 1;
            up = down - l + 1;
        end
         l = 0;
    end
end
ll = floor((up+down)/2) + 32;
if (ll>h) 
    ll=ll-64;
end

%ȡ���߽����������Ե�һ��
tl = mod(ll,64);
tt = 0;
tmax = 0;
ttemp = 0;
for i = 1:h
    if (mod(abs(i-tl),64) == 0)
        if (ttemp > tmax)
            tmax = ttemp;
            ttemp = 0;
            tt = i;
        end
    else
        if (edge(i) == 1)
            ttemp = ttemp + 1;
        end
    end
end

down = tt;
up = tt - 64;
if (up<=0) 
    up = 1;
end
oo = [co(up:down,:)];    
else
    up = 0;
    down = 0;
    oo = 0;
end
%imwrite(oo,'oo.bmp');

if (oo == 0)
    po=1;
else    
%ȡ��
left = 60;
right = 61;
[hh,~] = size(oo);
col = zeros(1,120);

for i = 1:120
    for j = 1:hh
        if (oo(j,i) == 0)
            col(1,i) = 1;
            break;
        end
    end
end

while(col(1,left) == 1)
    left = left - 1;
end
while(col(1,right) == 1)
    right = right + 1;
end

ch = [oo(:,left:right)];
[ii,jj] = size(ch);
%imshow(ch);
%imwrite(ch,'ch1.bmp');

distance = hausdorff(ch);
    if (distance < 50)
         po = 1;
    else po = 0;
    end
end
end

%
function [currentlow] = hausdorff(i1);
%i1=imread('1.bmp') ;  ����
currentlow=1000;    %��ǰ��СHD����
currentlength=0;    %��ǰ������СHD������ĸ�ĳ���
currentnum=1;
[~,length]=size(i1);    %��������
for num=1:52    %��ÿ��ģ�����ƥ��ȼ��
    imageName=strcat(num2str(num),'.bmp');
    i2=imread(imageName);   %����ģ��
    
    [~,testlength]=size(i2);    %����ģ��ĳ���
    j1=edge(i1,'canny');
    jj1=edge(i2,'canny');
    [aa,cc]=size(j1);
    [aaa,ccc]=size(jj1);
%
for m1=1:aa
    for n1=1:cc
        if j1(m1,n1)>0
            j1(m1,n1)=1;
        else
            j1(m1,n1)=0;
        end   
    end
end
k1=zeros(aa,cc);
k1(1,1)=j1(1,1);
for m2=2:aa-1
    for n2=2:cc-1              
        z=zeros(1,5);
        z(1,1)=j1(m2-1,n2-1)+4;
        z(1,2)=j1(m2-1,n2)+3;
        z(1,3)=j1(m2-1,n2+1)+4;
         z(1,4)=j1(m2,n2-1)+3;
         z(1,5)=j1(m2,n2);
        for x=1:4
           mini=z(1,5); 
            if(mini>z(1,x))
                mini=z(1,x);
            end
        end
         k1(m2,n2)=mini;
    end
end
for mm1=1:aaa
    for nn1=1:ccc
        if jj1(mm1,nn1)>0
            jj1(mm1,nn1)=1;
        else
            jj1(mm1,nn1)=0;
        end   
    end
end
kk1=zeros(aaa,ccc);
kk1(1,1)=jj1(1,1);
for mm2=2:aaa-1
    for nn2=2:ccc-1
        zz=zeros(1,5);
        zz(1,1)=jj1(mm2-1,nn2-1)+4;
        zz(1,2)=jj1(mm2-1,nn2)+3;
        zz(1,3)=jj1(mm2-1,nn2+1)+4;
        zz(1,4)=jj1(mm2,nn2-1)+3;
        zz(1,5)=jj1(mm2,nn2);
        for xx=1:4
           mini2=zz(1,5); 
            if(mini2>zz(1,x))
                mini2=zz(1,x);
            else
                continue
            end   
        end
         kk1(mm2,nn2)=mini2;
    end
end
t=0;
for t1=1:aa
    for t2=1:cc
        if(k1(t1,t2)==1)
            t=t+1;
        end
    end
end
 w=zeros(t,2);
  p=0;
  for t1=1:aa
      for t2=1:cc
            
          if k1(t1,t2)==1
              p=p+1;
              w(p,:)=[t1 t2];
          else
              continue
          end
      end
  end
  tt=0;
for tt1=1:aaa
    for tt2=1:ccc
        if(kk1(tt1,tt2)==1)
            tt=tt+1;
        end
    end
end
 ww=zeros(tt,2);
  pp=0;
  for tt1=1:aaa
      for tt2=1:ccc
            
          if kk1(tt1,tt2)==1
              pp=pp+1;
              ww(pp,:)=[tt1 tt2];
          else
              continue
          end
      end
  end
b=zeros(1,t);
 min_a=((w(1,1)-ww(1,1)).^2+(w(1,2)-ww(1,2)).^2).^(1/2);
for i=1:t
    for j=1:tt
        if ((w(i,1)-ww(j,1)).^2+(w(i,2)-ww(j,2)).^2)<min_a     
            min_a=(w(i,1)-ww(j,1)).^2+(w(i,2)-ww(j,2)).^2;
        end
b(1,i)=min_a;
    end            
end             % �������b
max_a=b(1,1);   %�ҳ����ֵ
for i=1:t
    if max_a<b(1,i)
        max_a=b(1,i);    
    end
end
c=zeros(1,tt);
for l=1:tt 
    for k=1:t
        min_b=(ww(1,1)-w(1,1)).^2+(ww(1,2)-w(1,2)).^2;       
        if ((ww(l,1)-w(k,1)).^2+(ww(l,2)-w(k,2)).^2)<min_b
            min_b=(ww(l,1)-w(k,1)).^2+(ww(l,2)-w(k,2)).^2;
        end
c(1,l)=min_b;
    end       
end             %�������c
max_b=c(1,1);   %�ҳ����ֵ
for l=1:tt
    if max_b<c(1,l)
        max_b=c(1,l);
    end
end
if max_a>max_b
    max_hausdorff=max_a;
else
    max_hausdorff=max_b;
end

if (max_hausdorff<currentlow)
    currentlow=max_hausdorff;
    currentlength=testlength;
    currentnum=num;
else if (max_hausdorff==currentlow)
        if ((abs(testlength-length))<(abs(currentlength-length)))
            currentlength=testlength;
            currentnum=num;
        end
      end
end
end
end