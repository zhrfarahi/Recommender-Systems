
% Function for creat Bloomfi Tree



function [MOVIESID,bloofi_tree,Bank,AVAIL_Node,AVAIL_Bank,RooT_Node] =Bloofi_tree_start(degree,bf,D)

MOVIESID=zeros(D,1);
bloofi_tree=zeros(D,(2*degree+3));
%tree(D,1)  linked list of NULL
%tree(D,2)  Address (Bloom Filter) relevant in the Bank
%tree(D,3)  Address for parent node in the tree
%tree(D,4:2*degree+3) The Address of the Children in the Tree

%If no child is available, it will be zero in tree


m=size(bf);
Bank=zeros(D,m(2)+1);

bloofi_tree=bloofi_tree-1;  %creat tree of NULL

%____________________________________________________
% creat linked list for NULL node of tree and Bank
%____________________________________________________

for i=1:D-1
    bloofi_tree(i,1)=i+1;
    Bank(i,1)=i+1;
end  %end of for
bloofi_tree(D,1)=0;
Bank(D,1)=0;
%AVAIL_Bank=1;   %Address of start for NULL linked list of Bank
AVAIL_Node=1;   %Address of start for NULL linked list of Bloofi tree
    
%____________________________________________________
%       Start of Bloomfi Tree
%____________________________________________________

RooT_Node=AVAIL_Node;
AVAIL_Node=bloofi_tree(3,1);
AVAIL_Bank=Bank(3,1);

Bank(2,2:m(2)+1)=bf(1,1:m(2));
Bank(3,2:m(2)+1)=bf(2,1:m(2));
Bank(1,2:m(2)+1)=(bf(1,1:m(2))+bf(2,1:m(2)))/2;

bloofi_tree(1,1)=-2; %Exit, from linked list
bloofi_tree(2,1)=-2;
bloofi_tree(3,1)=-2;
Bank(1,1)=-2;
Bank(2,1)=-2;
Bank(3,1)=-2;

bloofi_tree(1,2)=1;  %Bloom filter address in the bank.
bloofi_tree(2,2)=2;
bloofi_tree(3,2)=3;

bloofi_tree(1,3)=0;  %Parent's Node Address
bloofi_tree(2,3)=1;
bloofi_tree(3,3)=1;

bloofi_tree(1,4)=2; %Children's Node Address
bloofi_tree(1,5)=3;

bloofi_tree(1,6:2*degree+3)=0;
bloofi_tree(2,4:2*degree+3)=0;
bloofi_tree(3,4:2*degree+3)=0;

MOVIESID(2,1)=1;
MOVIESID(3,1)=2;
%____________________________________________________

end