function [h,mu,sigma] = GetImgSpatiogram_hy(imgclip,bins,mask)
if (nargin < 3)
    mask=1;
end

xs = size(imgclip,2);
ys = size(imgclip,1);
binno = zeros(ys,xs);
imgclip=double(imgclip);
binno = binno + floor(imgclip*bins/256);
f=bins;

xf = 2/(xs-1);
yf = 2/(ys-1);
[xp,yp] = meshgrid(-1:xf:1, -1:yf:1);

kdist = ones(ys,xs) / (xs*ys);
kdist = kdist .* mask;
kdist = kdist / sum(sum(kdist));
MK = min(min(kdist));

h = zeros(1,f);
mu = zeros(1,f);
sigma = zeros(1,1,f);

binno = makelinear(binno);
yp = makelinear(yp);
kdist = makelinear(kdist);

binno = binno+1;
h = accumarray(binno, kdist)';
extra = f-length(h);
h = [h zeros(1,extra)];

wsum = h;
wsum = wsum + (wsum==0);
mu1(1,:) = [accumarray(binno, yp.*kdist)' zeros(1,extra)];
mu(1,:) = mu1(1,:) ./ wsum;

tmpy1 = [accumarray(binno, yp.^2.* kdist)' zeros(1,extra)] ./ wsum;
tmpy = tmpy1 - mu(1,:).^2;
tmpy(tmpy<0)=0;
sigma(1,1,:) = permute(tmpy, [1 3 2]);
sigma(1,1,:) = sigma(1,1,:) + (MK-sigma(1,1,:)).*(sigma(1,1,:)<MK);

function data = makelinear(im)
data = zeros(numel(im),1);
data(:) = im(:);






