Red1 = [237 28 36]./255; Red2 = [241 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; DarkGray = [109 110 112]./255; Blue4 = [0 0 153]./255;

Red = [237 28 36]./255; Yellow = [253 185 19]./255; Sky = [0 173 220]./255; Blue = [82 79 161]./255; Green = [203 419 42]./255; Gray = [180 180 180]./255;

maxDepth_D200_NA039 = zeros(1, 191);

power = [1:0.1:20];
for mW_index = 10:201
    criteria = 5;

    xAxisMax = 2;
    xAxisStep = 0.5;

    yAxisMax = 0.25;
    yAxisStep = 0.05;

    Iz_D200_NA039 = zeros(1,401);

    vElem = 0.01*0.01*0.01;
    z = [0:0.01:2];
    for i = 1:401  
        sIrr_D200_NA039 = nIrr_D200_NA039(:,:,i).*mW_index*0.1;
        idx_D200_NA039 = numel(find (sIrr_D200_NA039 >= criteria))*vElem;
        Iz_D200_NA039(i) = sum(idx_D200_NA039);
    end
    
    [maxVal_D200_NA039, maxIdx_D200_NA039] = max(Iz_D200_NA039);
    eval(['maxDepth_D200_NA039(' num2str(mW_index) ') = z(maxIdx_D200_NA039);']);
end
h = figure(2);

x = 1:0.1:20;
% Raw data
plot(power, maxDepth_D200_NA039(10:200)*MC.mus, '-', 'Color', Blue1, 'LineWidth', 2.5, 'MarkerSize', 5);  hold on;
grid off;

set(gcf,'color','w');
set(gca,'FontName', 'Times New Roman', 'FontSize', 25, 'FontWeight', 'bold')
xlabel('Fiber power output (mW)');
ylabel('Optical depth (\it{\mu_s z}\rm\bf)');
grid off;  box off;

set(gca,'YTick', 0:1:8)
set(gca,'XTick', 1:3:20)
ylim([2 8]);
xlim([1 20]);

set(h, 'Position', [100, 100, 650, 450]);