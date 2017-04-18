[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

%initial weight
x = [patterns; ones(1, ndata)];
w = [randn(outsize,insize), zeros(outsize,1)];
eta = 0.001;
itr = 50;

e = [];
%update weight
for i = 1:itr
    delta_w = -eta * (w * x - targets) * x';
    w = w + delta_w;   
    plot_pattern(w, patterns, targets);
    e = [e sum(sum(abs(sign(w * x) - targets)./2))];
end
plot(error)
