function [col] = genermatr2()

col = zeros(22,22);
tempcol = 0;
temp = 0;

A = zeros(180,1368,22);
for i = 1:22
    A(:,:,i) = imread(['graph',num2str(i)],'bmp');
end

for i = 1:22
    for j = 1:1368
        if (A(1,j,i) ~= 255) 
            A(1,j,i) = 0;
        end
        if (A(180,j,i) ~= 255)
            A(180,j,i) = 0;
        end
    end
end

for i = 1:22
    for j = 1:22
        if(i == j)
            col(i,j) = 0;
        else
            for h = 1:1368
                if(A(180,h,i) == 0 && A(1,h,j) == 0)
                    tempcol = tempcol + 1;
                end
                if(A(180,h,i) == 0) 
                    temp = temp + 1; 
                end
                if(A(1,h,j) == 0) 
                    temp = temp + 1; 
                end
            end
            if(temp == 0) 
                col(i,j) = 1;   %���߶��޺ڵ㣬ƥ���Ϊ0
            else
                col(i,j) = 2 * tempcol / temp;
            end
        end
        tempcol = 0;
        temp = 0;
    end
end

for i = 1:22
    for j = 1:22
        if(i ~= j)
            col(i,j) = col(i,j) + rand()*0.01;
        end
    end
end
%����ÿ����ͼ�����������ĺڵ�����

