%Test distortion resistance (Demo on picture patterns)

clc, clear
pict

x = [p1; p2; p3];
[npatterns, units] = size(x);

%% Learn
w = x' * x; %/units;

%%%Add noise
noise = [0:0.01:1];
xd = [];
for i = noise
    p1dist = flip(p1, units * i);
    p2dist = flip(p2, units * i);
    p3dist = flip(p3, units * i);
    xd = [xd; p1dist; p2dist; p3dist];
end
    
itr = 50;

%Little Model
for i = 1:itr
    xd = sgn(w * xd')';
end 

%% calculate noise
noise = []
for i = 1: size(xd,1)
    noise = [noise, sum(abs(xd(i,:)-x(mod(i+2,3)+1,:)))/2];
end

noise = noise / units
noise = reshape(noise,3,101);

for i = 1:npatterns
    subplot(1,3,i);
    plot(1:size(noise,2), noise(i,:));
    title(['Picture',i]);
end

