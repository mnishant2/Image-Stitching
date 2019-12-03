function homography= getHomography(points1,points2)
n=size(points1,1);
A=zeros(2*n,9);
for i=1:n
%     [points1(i,:) 1]
    A(2*i-1,1:3)=[points1(i,:) 1];
    A(2*i-1,end-2:end)= -1*points2(i,1).*[points1(i,:) 1];
    A(2*i,4:6)=[points1(i,:) 1];
    A(2*i,end-2:end)= -1*points2(i,2).*[points1(i,:) 1];
end
% A
[U,S,V] = svd(A);
H=V(:,end);
homography=reshape(H,[3,3]);