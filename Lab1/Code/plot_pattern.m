function [ junk ] = plot_pattern( w, patterns, targets )
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
[wsize, para] = size(w);

plot(patterns(1, find(targets>0)), patterns(2,find(targets>0)),'*', ...
     patterns(1, find(targets<0)), patterns(2,find(targets<0)),'+');
hold on

for i = 1:wsize
    p = w(i,1:2);
    k = -w(i, insize+1) / (p*p');
    l = sqrt(p*p');
    plot([p(1),p(1)]*k + [-p(2),p(2)]/l, ...
         [p(2),p(2)]*k + [p(1),-p(1)]/l, '-');
end
hold off

axis([-2, 2, -2, 2],'square');
%axis([-2, 2, -1, 1]);
drawnow;
end

