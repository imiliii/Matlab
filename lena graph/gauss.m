function X = gauss(rowidx,colidx,entries,b,t)
% gauss
[~,m] = size(rowidx);
rowidx(m) = rowidx(m) + 1;
X = zeros(1,m-1);
sum = 0;
for j = 1:t %����һ��
    for i = 1:m-1 %�ָ�A�ĵ�i��
        for k  =rowidx(i):rowidx(i+1)-1
            if(colidx(k) == i)
                a = entries(k); %��a��ʱ�洢��ĸA��i,i)��ֵ
                if(a == 0) %����a=0
                    a = 0.001;
                end
            else
            sum = sum + X(colidx(k)) * entries(k);
            end
        end
        X(i) = (b(i)-sum)/a;
        sum = 0;
    end
end