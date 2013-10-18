function [Crowidx,Ccolidx,Centrices] = mnsprmulti(Arowidx,Acolidx,Aentrices,Browidx,Bcolidx,Bentrices,m)
%(k-1)*(n-1)��ϡ�����A��(n-1)*m��ϡ�����B�ĳ˷�A*B������ԭ�ؾ���
[~,k] = size(Arowidx);%A��(k-1)��(n-1)�о���
[~,n] = size(Browidx);%B��(n-1)�о���
[~,l] = size(Bentrices);%B�ܹ���l��Ԫ��
Crowidx = zeros(1,k);
Crowidx(1) = 1;
Centrices = [];
Ccolidx = [];
num = 1;
ent = 0;
for i = 1:k-1 %�ӵ�1�е���k-1��
    if(i ~= k-1)
        j = Arowidx(i+1) - Arowidx(i);
    else
        j = Arowidx(i+1) - Arowidx(i) + 1;
    end %��i����j��Ԫ��
    for h = 1:m %��B��ÿһ��
        for p = 1:l %B�е�p��Ԫ��
            if(Bcolidx(p) == h)
                for q = n-1:-1:1
                    if(Browidx(q) <= p)
                        break;
                    end
                end
                for t = 1:j
                    if(q == Acolidx(Arowidx(i)-1+t))
                        ent = ent + Bentrices(p) * Aentrices(Arowidx(i)-1+t);
                    end
                end     
            end
        end
        if(ent ~= 0 || i == h)
            Centrices(num) = ent;
            Ccolidx(num) = h;
            num = num + 1;
        end
        ent = 0;
    end
    Crowidx(i+1) = num;
end
Crowidx(end) = num - 1;