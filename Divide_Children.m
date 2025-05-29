%-------------------------------------------------------------------------------------
%
%     Define Variables:
%       tree:Bloomfi tree
%       Bank:(Bloom Filters) for each node tree.
%       root:The root of the tree.
%       bf:New bloom filter, that wants to be insert to the tree.
%       parent_node:Parent Node, which is a new bloom filter to be insert.
%       AVAIL_tree,AVAIL_Bank:The pointer to the linked list of empty node
%       of "tree" and "Bank".
%
%     Output Function:
%       tree:Bloomfi tree
%       Bank:(Bloom Filters) for each node tree.
%       root:The root of the tree.
%       AVAIL_tree,AVAIL_Bank:The pointer to the linked list of empty node
%       of "tree" and "Bank".
%-------------------------------------------------------------------------------------
function [MOVIESID,tree,root,Bank,AVAIL_tree,AVAIL_Bank]=Divide_Children(MOVIESID,ID,tree,Bank,root,bf,gh,parent_node,AVAIL_tree,AVAIL_Bank)
D=size(tree);
m=size(Bank);
d=(D(2)-3)/2;


new_parent=AVAIL_tree;
dd=AVAIL_tree;
AVAIL_tree=tree(AVAIL_tree,1);
tree(dd,1)=-2;

tree(new_parent,4:d+3)=tree(parent_node,d+4:D(2));
tree(parent_node,d+4:D(2))=zeros(1,d);
tree(new_parent,d+4:D(2))=zeros(1,d);
for i=1:d
    tree(tree(new_parent,i+3),3)=new_parent;
end % end of for

%--------------------------------------------------------------------------
child=zeros(d,m(2)-1);
for i=1:d
    child(i,1:m(2)-1)=Bank(tree(tree(parent_node,i+3),2),2:m(2));
end %end of for
newparent1=New_Parent(child);
Bank(tree(parent_node,2),2:m(2))=newparent1;
%--------------------------------------------------------------------------
child=zeros(d,m(2)-1);
for i=1:d
    child(i,1:m(2)-1)=Bank(tree(tree(new_parent,i+3),2),2:m(2));
end %end of for
newparent2=New_Parent(child);
tree(new_parent,2)=AVAIL_Bank;
Bank(AVAIL_Bank,2:m(2))=newparent2;

dd=AVAIL_Bank;
AVAIL_Bank=Bank(AVAIL_Bank,1);
Bank(dd,1)=-2;
%--------------------------------------------------------------------------
distance1=Hamming_Distance(bf,newparent1);
distance2=Hamming_Distance(bf,newparent2);

if distance2<distance1
    
    if gh>0
        tree(new_parent,d+4)=gh;
    
        tree(gh,3)=new_parent;
    
    else
        tree(new_parent,d+4)=AVAIL_tree;
    
        tree(AVAIL_tree,4:D(2))=zeros(1,D(2)-3);
    
        tree(AVAIL_tree,3)=new_parent;
        MOVIESID(AVAIL_tree,1)=ID;
    
        tree(AVAIL_tree,2)=AVAIL_Bank;
    
        Bank(AVAIL_Bank,2:m(2))=bf;
    
        dd=AVAIL_Bank;
        AVAIL_Bank=Bank(AVAIL_Bank,1);
        Bank(dd,1)=-2;
    
        dd=AVAIL_tree;
        AVAIL_tree=tree(AVAIL_tree,1);
        tree(dd,1)=-2;
        
    end % end of if else
    
        
    child=zeros(d+1,m(2)-1);
    for i=1:d+1
        child(i,1:m(2)-1)=Bank(tree(tree(new_parent,i+3),2),2:m(2));
    end %end of for
    newparent=New_Parent(child);
    Bank(tree(new_parent,2),2:m(2))=newparent;
    
else
    
    if gh>0
        
        tree(parent_node,d+4)=gh;
    
        tree(gh,3)=parent_node;
    
    else
        
        tree(parent_node,d+4)=AVAIL_tree;
    
        tree(AVAIL_tree,4:D(2))=zeros(1,D(2)-3);
    
        tree(AVAIL_tree,3)=parent_node;
        MOVIESID(AVAIL_tree,1)=ID;
    
        tree(AVAIL_tree,2)=AVAIL_Bank;
    
        Bank(AVAIL_Bank,2:m(2))=bf;
    
        dd=AVAIL_Bank;
        AVAIL_Bank=Bank(AVAIL_Bank,1);
        Bank(dd,1)=-2;
    
        dd=AVAIL_tree;
        AVAIL_tree=tree(AVAIL_tree,1);
        tree(dd,1)=-2;
    end %end of if else
    
        
    child=zeros(d+1,m(2)-1);
    for i=1:d+1
        child(i,1:m(2)-1)=Bank(tree(tree(parent_node,i+3),2),2:m(2));
    end %end of for
    newparent=New_Parent(child);
    Bank(tree(parent_node,2),2:m(2))=newparent;
    
end %end of if else
%==========================================================================

    


if root==parent_node
    
    root=AVAIL_tree;
    tree(parent_node,3)=root;
    tree(new_parent,3)=root;
    tree(root,3)=0;
    tree(root,4)=parent_node;
    tree(root,5)=new_parent;
    tree(root,6:D(2))=zeros(1,D(2)-5);
    c1=Bank(tree(parent_node,2),2:m(2));
    c2=Bank(tree(parent_node,2),2:m(2));
    c=[c1;c2];
    newroot=New_Parent(c);
    tree(root,2)=AVAIL_Bank;
    Bank(AVAIL_Bank,2:m(2))=newroot;
    AVAIL_Bank=Bank(AVAIL_Bank,1);
    AVAIL_tree=tree(AVAIL_tree,1);
    [Bank,tree]=Update_Bloomfi_Tree(tree,Bank,root,root);
else
    
    if tree(tree(parent_node,3),D(2))~= 0
        
        gh=new_parent;
        bf=Bank(tree(new_parent,2),2:m(2));
        [MOVIESID,tree,root,Bank,AVAIL_tree,AVAIL_Bank]=Divide_Children(MOVIESID,ID,tree,Bank,root,bf,gh,tree(parent_node,3),AVAIL_tree,AVAIL_Bank);
        
    else
        tree(new_parent,3)=tree(parent_node,3);
        for j=4:D(2)
            if tree(tree(parent_node,3),j)==0
                index=j;
                break
            end %end of if
        end % end of for
        tree(tree(parent_node,3),index)=new_parent;
        child=zeros(index-3,m(2)-1);
        for i=1:index-3
            child(i,1:m(2)-1)=Bank(tree(tree(tree(parent_node,3),i+3),2),2:m(2));
        end %end of for
        newparent=New_Parent(child);
        Bank(tree(tree(parent_node,3),2),2:m(2))=newparent;
        [Bank,tree]=Update_Bloomfi_Tree(tree,Bank,root,tree(parent_node,3));
    end %end of if else  
    
end % end of if else
%--------------------------------------------------------------------------


end %end of function