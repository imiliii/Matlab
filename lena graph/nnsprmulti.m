function [c] = nnsprmulti(Arowidx,Acolidx,Aentrices,b)
%AΪn*n�ľ���bΪn*1�ľ��󡣲���A��ԭ�ؾ���ֱ����ϡ���������b��ˣ��õ�c
[n,~] = size(b);
c = zeros(n,1);
for i = 1:n
    if(i == n)
        k = Arowidx(i+1) - Arowidx(i) + 1;
    else
        k = Arowidx(i+1) - Arowidx(i);
    end
    for j = 1:k
        c(i,1) = c(i,1) + b(Acolidx(Arowidx(i) - 1 + j)) * Aentrices(Arowidx(i) - 1 + j);
    end
end