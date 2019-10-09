clear all
load('results.mat')
x_0 = [3; 0; 0; 0; 0; 0];
x_actual = [x_0, x_actual];
step = size(x_actual,2);
for i = 1:step

% background information
hold on
background = imread('map.png');
fig = figure('units','normalized','outerposition',[0 0 1 1]);
ax1 = axes('Position',[0 0 1 1]);
imagesc(background)
axis equal
axis off

bin = imread('trash_bin_2.jpg');
bin_size = 0.07;

waste_pos = [0.35, 0.442, 0.61, 0.37, 0.64; 0.745, 0.59, 0.442, 0.34, 0.13];

% A bin
A_axes = axes('Position',[waste_pos(:,1)', bin_size, bin_size]);
imshow(bin)
level = num2str(x_actual(2,i));
level = strcat('level: ', level);
Level = text(0, 0, level);
Level.FontSize = 15; Level.FontWeight = 'bold'; Level.Color = make_color(x_actual(2,i));

% B bin
B_axes = axes('Position',[waste_pos(:,2)', bin_size, bin_size]);
imshow(bin)
level = num2str(x_actual(3,i));
level = strcat('level: ', level);
Level = text(0, 0, level);
Level.FontSize = 15; Level.FontWeight = 'bold'; Level.Color = make_color(x_actual(3,i));

% C bin
C_axes = axes('Position',[waste_pos(:,3)', bin_size, bin_size]);
imshow(bin)
level = num2str(x_actual(4,i));
level = strcat('level: ', level);
Level = text(0, 0, level);
Level.FontSize = 15; Level.FontWeight = 'bold'; Level.Color = make_color(x_actual(4,i));


% D bin
D_axes = axes('Position',[waste_pos(:,4)', bin_size, bin_size]);
imshow(bin)
level = num2str(x_actual(5,i));
level = strcat('level: ', level);
Level = text(0, 0, level);
Level.FontSize = 15; Level.FontWeight = 'bold'; Level.Color = make_color(x_actual(5,i));


% E bin
E_axes = axes('Position',[waste_pos(:,5)', bin_size, bin_size]);
imshow(bin)
level = num2str(x_actual(6,i));
level = strcat('level: ', level);
Level = text(0, 0, level);
Level.FontSize = 15; Level.FontWeight = 'bold'; Level.Color = make_color(x_actual(6,i));



% cart
cart_pos = x_actual(1,i);

cart = im2double(imread('cart.jpg'));
cart_size = 0.1;
cart_axes = axes('Position', [waste_pos(1,cart_pos)+bin_size*(2/3), waste_pos(2, cart_pos), cart_size, cart_size]);
imshow(cart)

dot = imread('dot.png');
time_size = 0.0005;
cart_axes = axes('Position', [0.32 0.9, time_size, time_size]);
imshow(dot)
time = num2str(i);
ttl = strcat('Waste collection Vehicle animation, at time step: ', time);
title = text(0,0,ttl);
title.FontSize = 15; title.FontWeight = 'bold';

drawnow
frame = getframe(fig);
im{i} = frame2im(frame);

clf('reset')
close

end

filename = 'testAnimated.gif'; % Specify the output file name
for idx = 1:step
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end

function color = make_color(level)
if level <= 0
    color = 'g';
else if level <= 2
        color = 'y';
    else
        color = 'r';
    end
end
end