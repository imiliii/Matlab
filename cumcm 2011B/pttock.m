function [distance] = pttock(juli,churukou)
    distance = zeros(20,13);
    for i = 1:20 %��i��ƽ̨����j�����ڵľ���
        for j = 1:13
            [d,path] = floydb(juli,i,churukou(j));
            distance(i,j) = d;
        end
    end
end

