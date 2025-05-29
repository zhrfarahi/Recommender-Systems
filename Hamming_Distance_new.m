
%chek shode
function distance =Hamming_Distance_new(A,B)


s=size(A);
distance=0;

for i=1:s(2)
%     if A(i)==0 && B(i)==0
%         distance=distance+1;
%     else
        D=A(i)*B(i);
        distance=distance+D;
%     end
end