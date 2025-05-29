
%chek shode
function [parent]=New_Parent(child)
m=size(child);
p=zeros(1,m(2));
for i=1:m(2)
    p(i)=sum(child(1:m(1),i));
end % end of for

parent=p/m(1);
%parent=floor(parent);
end %end of function