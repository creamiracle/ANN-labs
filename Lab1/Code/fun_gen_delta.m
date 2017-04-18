%original function
X = [-5:1:5]';
Y = X;
Z = exp(-X .* X * 0.1) * exp(-Y .* Y * 0.1)' - 0.5;
mesh (X, Y, Z);
axis([-5 5 -5 5 -0.7 0.7]);

%reshape function
[gridsize, gridsize] = size(Z);
ndata = gridsize * gridsize;
targets = reshape (Z, 1, ndata);
[xx, yy] = meshgrid(X, Y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

permute = randperm(ndata);
[junk,pos]=sort(permute);
patterns = patterns(:,permute);
targets = targets(:,permute);

% BP ANN
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
itr = 500;
layer = 2;
hidden = 65;

%initial data & weights
x = [patterns; ones(1, ndata)];
w = [randn(hidden,insize), zeros(hidden,1)];
v = [randn(outsize,hidden), zeros(outsize,1)];
eta = 0.1;
alpha = 0.9;
dw = 0;
dv = 0;

error = [];

for i = 1:itr
    %forward pass
    hin = w * x;
    hout = [2./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

    oin = v * hout;
    out = 2./ (1+exp(-oin)) - 1;

    %backward pass
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :); %removing extra row

    %weight update
    dw = (dw .* alpha) - (delta_h * x') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
    %plot seperation
    zz = out(:,pos);
    zz = reshape(zz, gridsize, gridsize);
    mesh(X, Y, zz);
    axis([-5 5 -5 5 -0.7 0.7]);
    drawnow;
end

