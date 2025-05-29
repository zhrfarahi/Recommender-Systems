
%chec shode
function Node=findMatches(tree,bf,root,Bank)

m=size(bf);
D=size(tree);
cunter=1;
while cunter==1
    i=4;
    
    while tree(root,i)~=0   %Calculate Hamming distance bf(new bloom filter) with all root childs
        A=Bank(tree(tree(root,i),2),1:m(2)); 
        hd(i-3)=Hamming_Distance_new(A,bf);
        i=i+1;
        if i>D(2)
            break;
        end
    end %end of while
%-----------------------------------------------
%   min haming distance
%-----------------------------------------------
    [~,minnode]=max(hd);
%----------------------------------------------
    if tree(tree(root,minnode+3),4)==0
        cunter=0;
    else
        root=tree(root,minnode+3);
    end %end of else if

end % end of while

Node=root;

end %end of function