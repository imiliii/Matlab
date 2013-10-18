function [startmatr] = gener22matr()

A = zeros(180,72,418);

for i = 0:2
    for j = 0:9
        for k = 0:9
            if(i * 100 + j * 10 + k <= 208)
                A(:,:,(i * 100 + j * 10 + k + 1) * 2 - 1) = imread([num2str(i),num2str(j),num2str(k),'a'],'bmp');
                A(:,:,(i * 100 + j * 10 + k + 1) * 2) = imread([num2str(i),num2str(j),num2str(k),'b'],'bmp');
            end
        end
    end
end
%��ȡͼ��

for i = 1:418
    for j = 1:180
        for k = 1:72
            if(A(j,k,i) ~= 0 && A(j,k,i) ~= 255)
            A(j,k,i) = 0;
            end
        end
    end
end
%���ҵ�ĳɺڵ�

w = [28 72 182 212 287 12 19 109 168 273 346 158 179 199 293 332 374 400 8 48 178 229]; % 22������
Q = getblack(); % ÿ��ͼ������

startmatr = zeros(22,22);

for i = 1:22
    for j = 1:22
        if(mod(Q(w(i)) - Q(w(j)),64) < 32)
            startmatr(i,j) = mod(Q(w(i)) - Q(w(j)),64);
            startmatr(j,i) = mod(Q(w(i)) - Q(w(j)),64);
        else
            startmatr(i,j) = 64 - mod(Q(w(i)) - Q(w(j)),64);
            startmatr(i,j) = 64 - mod(Q(w(i)) - Q(w(j)),64);
        end
    end
end

for i = 1:22
    startmatr(i,i) = 32;
end

end

