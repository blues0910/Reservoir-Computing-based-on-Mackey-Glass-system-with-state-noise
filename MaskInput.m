function J = MaskInput(I,M)
%MASKINPUT 此处显示有关此函数的摘要
%   此处显示详细说明
[tmpi,tmpj]=size(I);
J=cell(1,tmpj);
for i=1:tmpi
    for j=1:tmpj
        if i==1
            J{j}=I(i,j)*M(tmpi,:);
        else
            J{j}=J{j}+I(i,j)*M(tmpi,:);
        end
    end
end
end

