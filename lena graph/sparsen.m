function [Amatr] = sparsen(Arowidx,Acolidx,Aentrices)
%ϡ�����ԭ�ؾ���
[~,m] = size(Aentrices);
[~,n] = size(Arowidx);
Amatr = zeros(n-1,n-1);
for i = 1:n-1
    if(i == n-1)
        j = Arowidx(i+1) - Arowidx(i) + 1;%A�ĵ�i�еĸ���
    else
        j = Arowidx(i+1) - Arowidx(i);%A�ĵ�i�еĸ���
    end
    for k = 1:j
        Amatr(i,Acolidx(Arowidx(i) - 1 + k)) = Aentrices(Arowidx(i) - 1 + k);
    end
end