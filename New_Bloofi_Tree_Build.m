


function [MOVIESID,Bloofi_Tree,Bank,AVAIL_tree,AVAIL_Bank,Root]=New_Bloofi_Tree_Build

degree=input('Insert Degree of Bloofi tree: ');

DataSet_Name=input('Please enter the address and bloom filter dataset name: ','s');
h=load(DataSet_Name);
c = struct2cell(h);
DS_bloomfilter=c{1,1};

s=size(DS_bloomfilter);
bf=DS_bloomfilter(1:2,1:s(2));
D=s(1)*2+2;

[MOVIESID,Bloofi_Tree,Bank,AVAIL_tree,AVAIL_Bank,Root] =Bloofi_tree_start(degree,bf,D);


for i=3:s(1)
    node=findMatches(Bloofi_Tree,DS_bloomfilter(i,1:s(2)),Root,Bank);
    [MOVIESID,Bloofi_Tree,Bank,Root,AVAIL_tree,AVAIL_Bank]=New_Insert_Bloomfilter(MOVIESID,i,Bloofi_Tree,Bank,node,Root,DS_bloomfilter(i,1:s(2)),AVAIL_tree,AVAIL_Bank);
    fprintf("Counter =%d\n",i);
end %end of for

end% end of function