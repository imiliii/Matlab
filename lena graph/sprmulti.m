function [Crowidx,Ccolidx,Centrices] = sprmulti(Arowidx,Acolidx,Aentrices,Browidx,Bcolidx,Bentrices)
%n*nϡ�����ĳ˷�A*B������ԭ�ؾ���
[~,k] = size(Arowidx);%A��B����(k-1)�׷���
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
    for n = 1:k-1 %��B��ÿһ��
        for p = 1:l %B�е�p��Ԫ��
            if(Bcolidx(p) == n)
                for q = k-1:-1:1
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
        if(ent ~= 0 || i == n)
            Centrices(num) = ent;
            Ccolidx(num) = n;
            num = num + 1;
        end
        ent = 0;
    end
    Crowidx(i+1) = num;
end
Crowidx(end) = num - 1;