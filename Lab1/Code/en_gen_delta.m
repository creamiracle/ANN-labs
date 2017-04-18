global patterns targets
patterns = eye(8) * 2 - 1;
targets = patterns;

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
itr = 0;
hidden = 3;

%initial data & weights
x = [patterns; ones(1, ndata)];

w = [randn(hidden,insize), zeros(hidden,1)];
v = [randn(outsize,hidden), zeros(outsize,1)];
eta = 0.01;
alpha = 0.9;
dw = 0;
dv = 0;

error = [];

% for i = 1:itr
e = inf;
while(e>0)
    itr = itr+1;
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
    
    %save error
    e = sum(sum(abs(sign(out) - targets)./2));
    disp(e)
    error = [error; e];
end
disp(itr)
