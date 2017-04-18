function [ error ] = plot_pattern( w, v, hidden, patterns, targets)

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

%initial data & weights
x = [patterns; ones(1, ndata)];

error = [];

%forward pass
hin = w * x;
hout = [2./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

oin = v * hout;
out = 2./ (1+exp(-oin)) - 1;

%plot seperation?
plot_pattern(w, patterns, targets);

%save error
error = [error; sum(sum(abs(sign(out) - targets)./2))];

