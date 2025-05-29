

%chek shode

function [Bank,tree]=Update_Bloomfi_Tree(tree,Bank,root,parent_node)

D=size(tree);
m=size(Bank);

if parent_node==root
    if tree(root,D(2))~=0
        index=D(2);
    else
        for j=4:D(2)
            if tree(root,j)==0
                index=j-1;
                break
            end %end of if
        end % end of for
    end %end of if else
        
    child=zeros(index-3,m(2)-1);
    for i=1:index-3
        child(i,1:m(2)-1)=Bank(tree(tree(root,i+3),2),2:m(2));
    end %end of for
    newparent=New_Parent(child);
    Bank(tree(root,2),2:m(2))=newparent;
else
    index=D(2);
    for j=4:D(2)
        if tree(parent_node,j)==0
            index=j-1;
            break
        end %end of if
    end % end of for
        
    child=zeros(index-3,m(2)-1);
    
    for i=1:index-3
        child(i,1:m(2)-1)=Bank(tree(tree(parent_node,i+3),2),2:m(2));
    end %end of for
    newparent=New_Parent(child);
    
    Bank(tree(parent_node,2),2:m(2))=newparent;
    
    [Bank,tree]=Update_Bloomfi_Tree(tree,Bank,root,tree(parent_node,3));
    
end % end of if else

end % end of function