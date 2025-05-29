

%chek shode
function [MOVIESID,tree,Bank,root,AVAIL_tree,AVAIL_Bank]=New_Insert_Bloomfilter(MOVIESID,ID,tree,Bank,parent_node,root,bf,AVAIL_tree,AVAIL_Bank)

m=size(bf);
D=size(tree);
j=-1;
for i=4:D(2) 
    if tree(parent_node,i)==0
        j=i;
        break;
    end  %end of if
end %end of for
%--------------------------------------------------------------------
% Where the capacity of the parent has been completed.
if j==-1 
    gh=0;
    [MOVIESID,tree,root,Bank,AVAIL_tree,AVAIL_Bank]=New_Divide_Children(MOVIESID,ID,tree,Bank,root,bf,gh,parent_node,AVAIL_tree,AVAIL_Bank);
%--------------------------------------------------------------------
%Parent has empty capacity
else                    
    tree(parent_node,j)=AVAIL_tree;
    
    tree(AVAIL_tree,2)=AVAIL_Bank;
    
    tree(AVAIL_tree,3)=parent_node; %Father's Node Address
    
    tree(AVAIL_tree,4:D(2))=zeros(1,D(2)-3);%Empty the capacity of the childs.
    
    MOVIESID(AVAIL_tree,1)=ID;
    
    dd=AVAIL_tree;
    AVAIL_tree=tree(AVAIL_tree,1);
    tree(dd,1)=-2; %Exit, from linked list
    
    Bank(AVAIL_Bank,2:m(2)+1)=bf;
        
    dd=AVAIL_Bank;
    AVAIL_Bank=Bank(AVAIL_Bank,1);
    Bank(dd,1)=-2;%Exit, from linked list
    
    [Bank,tree]=Update_Bloomfi_Tree(tree,Bank,root,parent_node);
end %end of if else
%-------------------------------------------------------------------

end %end of function