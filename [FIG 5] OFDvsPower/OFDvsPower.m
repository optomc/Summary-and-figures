Red1 = [237 28 36]./255; Red2 = [241 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; DarkGray = [109 110 112]./255; Blue4 = [0 0 153]./255;

Red = [237 28 36]./255; Yellow = [253 185 19]./255; Sky = [0 173 220]./255; Blue = [82 79 161]./255; Green = [203 419 42]./255; Gray = [180 180 180]./255;

close all; 

maxDepth_D400_NA039 = zeros(1, 191);
maxDepth_D200_NA039 = zeros(1, 191);
maxDepth_D300_NA039 = zeros(1, 191);
maxDepth_D100_NA039 = zeros(1, 191);

power = [1:0.1:20];
for mW_index = 10:201
    criteria = 10;

    xAxisMax = 2;
    xAxisStep = 0.5;

    yAxisMax = 0.25;
    yAxisStep = 0.05;

    Iz_D100_NA039 = zeros(1,401);
    Iz_D200_NA039 = zeros(1,401);
    Iz_D300_NA039 = zeros(1,401);
    Iz_D400_NA039 = zeros(1,401);

    vElem = 0.01*0.01*0.01;
    z = [0:0.01:2];
    for i = 1:401  
        sIrr_D100_NA039 = nIrr_D100_NA039(:,:,i).*mW_index*0.1;
        sIrr_D200_NA039 = nIrr_D200_NA039(:,:,i).*mW_index*0.1;
        sIrr_D300_NA039 = nIrr_D300_NA039(:,:,i).*mW_index*0.1;
        sIrr_D400_NA039 = nIrr_D400_NA039(:,:,i).*mW_index*0.1;

        idx_D100_NA039 = numel(find (sIrr_D100_NA039 >= criteria))*vElem;
        idx_D200_NA039 = numel(find (sIrr_D200_NA039 >= criteria))*vElem;
        idx_D300_NA039 = numel(find (sIrr_D300_NA039 >= criteria))*vElem;
        idx_D400_NA039 = numel(find (sIrr_D400_NA039 >= criteria))*vElem;

        Iz_D100_NA039(i) = sum(idx_D100_NA039);
        Iz_D200_NA039(i) = sum(idx_D200_NA039);
        Iz_D300_NA039(i) = sum(idx_D300_NA039);
        Iz_D400_NA039(i) = sum(idx_D400_NA039);
    end

    [maxVal_D400_NA039, maxIdx_D400_NA039] = max(Iz_D400_NA039);
    [maxVal_D300_NA039, maxIdx_D300_NA039] = max(Iz_D300_NA039);
    [maxVal_D200_NA039, maxIdx_D200_NA039] = max(Iz_D200_NA039);
    [maxVal_D100_NA039, maxIdx_D100_NA039] = max(Iz_D100_NA039);
  
    eval(['maxDepth_D400_NA039(' num2str(mW_index) ') = z(maxIdx_D400_NA039);']);
    eval(['maxDepth_D300_NA039(' num2str(mW_index) ') = z(maxIdx_D300_NA039);']);
    eval(['maxDepth_D200_NA039(' num2str(mW_index) ') = z(maxIdx_D200_NA039);']);
    eval(['maxDepth_D100_NA039(' num2str(mW_index) ') = z(maxIdx_D100_NA039);']);
end

h = figure(3);

x = 1:0.1:20;

% Raw data
plot(power, maxDepth_D400_NA039(10:200), '-', 'Color', Gray, 'LineWidth', 2.5, 'MarkerSize', 5);  hold on;

yMaxLim = 0.7;
yMinLim = 0.0;

ylim([yMinLim yMaxLim]);
xlim([1 20]);
plot(power, maxDepth_D300_NA039(10:200), '-', 'Color', Blue4, 'LineWidth', 2.5, 'MarkerSize', 5);  hold on;
plot(power, maxDepth_D200_NA039(10:200), '-', 'Color', Red1, 'LineWidth', 2.5, 'MarkerSize', 5);  hold on;
[ax, hr] = plot2axes(power, maxDepth_D100_NA039(10:200), '-', 'yscale', MC.mus, 'Color', Green1, 'LineWidth', 2.5, 'MarkerSize', 5);  hold on;
set(ax,'FontName', 'Times New Roman', 'FontSize', 25, 'FontWeight', 'bold')
set(gca,'FontName', 'Times New Roman', 'FontSize', 25, 'FontWeight', 'bold')
ylabel(ax(2), 'Optical depth (\it{\mu_s z}\rm\bf)','FontName', 'Times New Roman', 'FontSize', 25, 'FontWeight', 'bold');

set(gcf,'color','w');
set(ax,'YTick', [0:1:10])
set(gca,'YTick', [0.0:0.1:yMaxLim])
set(gca,'XTick', [1:3:20])
xlabel('Fiber power output (mW)');
ylabel('Target distance (mm)');
grid off;  box off;

set(h, 'Position', [100, 100, 650, 450]);
set(gcf,'Units','normal')
set(ax,'Position',[.14 .18 .72 .67])
set(gca,'Position',[.14 .18 .72 .67])