Red1 = [237 28 36]./255; Red2 = [2401 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; DarkGray = [109 110 112]./255; Blue4 = [0 0 153]./255;

Red = [237 28 36]./255; Yellow = [253 185 19]./255; Sky = [0 173 220]./255; Blue = [82 79 161]./255; Green = [203 4019 42]./255; Gray = [180 180 180]./255;

colorList = [Green1; Red1; Blue4; Gray];

%% Total-VTA
xAxisMax = 20;
xAxisStep = 5;

yAxisMax = 0.9;
yAxisStep = 0.2;

vElem = 0.01*0.01*0.01;
for mW = 4:4:16;
    criterianList = [1:100]*0.1;
    for criterianIdx = 1:100
        criterian = criterianIdx * 0.1;
        for i = 1:401
            iPlane_D100_NA039 = nIrr_D100_NA039(:,:,i).*(mW);        
            idx_D100_NA039(criterianIdx, i) = numel(find (iPlane_D100_NA039 >= criterian))*vElem;    

            iPlane_D200_NA039 = nIrr_D200_NA039(:,:,i).*(mW);        
            idx_D200_NA039(criterianIdx, i) = numel(find (iPlane_D200_NA039 >= criterian))*vElem;    

            iPlane_D300_NA039 = nIrr_D300_NA039(:,:,i).*(mW);        
            idx_D300_NA039(criterianIdx, i) = numel(find (iPlane_D300_NA039 >= criterian))*vElem;    

            iPlane_D400_NA039 = nIrr_D400_NA039(:,:,i).*(mW);        
            idx_D400_NA039(criterianIdx, i) = numel(find (iPlane_D400_NA039 >= criterian))*vElem;    
        end

    end
    % Gray Blue4 Red1 Green1
    % plot(criterianList, sum(idx_D100_NA039,2), ':', 'Color', Gray, 'LineWidth', 1); hold on;
    semilogy(criterianList, sum(idx_D200_NA039,2), '-', 'Color', colorList(round(mW/4),:), 'LineWidth', 2); hold on;
    % plot(criterianList, sum(idx_D300_NA039,2), '-', 'Color', Gray, 'LineWidth', 1); hold on;

    set(gcf,'color','w');
    set(gca,'FontName', 'Times New Roman', 'FontSize', 21, 'FontWeight', 'bold')
    xlabel('Criterian (mW/mm^2)');
    ylabel('VTA (mm^3)');
    grid off;  box off;

    xlim([1 10])
    set(gca,'XTick', 1:2:10)

    % set(gca,'YTick', 0:yAxisStep:yAxisMax)
    % ylim([0 0.8]);
    % yt = get(gca,'YTick');
    % set(gca,'YTickLabel', sprintf('%.1f|',yt))
    % 
    % set(gca,'XTick', 1:3:xAxisMax)
    % xlim([1 19]);
    % set(h, 'Position', [100, 100, 650, 450]);

    % yL = get(gca,'YLim');
    % line([15.5 15.5],yL,'LineStyle', '--', 'Color', Green1, 'LineWidth', 2.5);
    % line([17 17],yL,'LineStyle', '-', 'Color', Green1, 'LineWidth', 2.5);
    % line([18.5 18.5],yL,'LineStyle', ':', 'Color', Green1, 'LineWidth', 2.5);
end

% ylim([0 3.5])
