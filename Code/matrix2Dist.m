function distMatrix = matrix2Dist(dist)

t = 1;
for i = 1 : size(dist,1)
    for j = 1 : size(dist,2)
        distMatrix(t,1) = i;
        distMatrix(t,2) = j;
        distMatrix(t,3) = dist(i,j);
        t = t + 1;
    end
end