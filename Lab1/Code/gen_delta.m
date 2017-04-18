[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
itr = 150;
hidden = 1;

%initial data & weights
x = [patterns; ones(1, ndata)];
w = [randn(hidden,insize), zeros(hidden,1)];
v = [randn(outsize,hidden), zeros(outsize,1)];
eta = 0.05;
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
    
    %plot seperation?
    plot_pattern(w, patterns, targets);
    %save error
    error = [error; sum(sum(abs(sign(out) - targets)./2))];
end

plot(error);
axis([0, itr, 0, 120]);