function [ Mcorrpseudo ] = calccolortransform( col,gam,colact )
%CALCCOLORTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
if nargin==0
    load col;
    col=uint8(col(:,end:-1:1,:));
end
if nargin<3
    colact = [
    243 243 242;
    56 61 150;
    214 126 44;
    115 82 68;

    200 200 200;
    70 148 73;
    80 91 166;
    194 150 130;

    160 160 160;
    175 54 60;
    193 90 99;
    98 122 157;

    122 122 121;
    231 199 31;
    94 60 108;
    87 108 67;

    85 85 85;
    187 86 149;
    157 188 64;
    133 128 177;

    52 52 52;
    8 133 161;
    224 163 46;
    103 189 170;    
    ];
    size(colact)
    size(col)

colact=permute(reshape(colact,[6,4,3]),[2 1 3]);
col = permute(reshape(col,[6,4,3]),[2 1 3]);
end
if nargin<2
    gam=1;
end

sz=size(col);Nsample = sz(1)*sz(2);
if ~all(sz==size(colact))
    error('test and reference data must be same size and shape');
end
% do gamma correction

colactG = gammacorrection(colact);
colG = gammacorrection(col);

% reshape to 3x24 or 4x24 vector
MactAll = double(squeeze(reshape(permute(colactG,[2 1 3]),[Nsample,1,3]))');
MrawAll = double(squeeze(reshape(permute(colG,[2 1 3]),[Nsample 1 3]))');

%MactAll = [MactAll;ones(1,24)];
%MrawAll = [MrawAll;ones(1,24)];

% calc correction matrix
Mcorrpseudo = MactAll * MrawAll' * inv(MrawAll * MrawAll')
Mcorrpseudo2 = (MactAll * MrawAll') / (MrawAll * MrawAll')
end



%     colact = [115 82 68;
%     194 150 130;
%     98 122 157;
%     87 108 67;
%     133 128 177;
%     103 189 170;
%     214 126 44;
%     80 91 166;
%     193 90 99;
%     94 60 108;
%     157 188 64;
%     224 163 46;
%     56 61 150;
%     70 148 73;
%     175 54 60;
%     231 199 31;
%     187 86 149;
%     8 133 161;
%     243 243 242;
%     200 200 200;
%     160 160 160;
%     122 122 121;
%     85 85 85;
%     52 52 52];
% 
