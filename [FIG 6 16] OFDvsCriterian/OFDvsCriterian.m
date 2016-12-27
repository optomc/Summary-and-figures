Red1 = [237 28 36]./255; Red2 = [241 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; DarkGray = [109 110 112]./255; Blue4 = [0 0 153]./255;

Red = [237 28 36]./255; Yellow = [253 185 19]./255; Sky = [0 173 220]./255; Blue = [82 79 161]./255; Green = [203 419 42]./255; Gray = [180 180 180]./255;

% close all; 

maxDepth_D400_NA048 = zeros(1, 20);
maxDepth_D400_NA039 = zeros(1, 20);
maxDepth_D400_NA022 = zeros(1, 20);

maxDepth_D300_NA048 = zeros(1, 20);
maxDepth_D300_NA039 = zeros(1, 20);
maxDepth_D300_NA022 = zeros(1, 20);

maxDepth_D200_NA048 = zeros(1, 20);
maxDepth_D200_NA039 = zeros(1, 20);
maxDepth_D200_NA022 = zeros(1, 20);

maxDepth_D100_NA048 = zeros(1, 20);
maxDepth_D100_NA039 = zeros(1, 20);
maxDepth_D100_NA022 = zeros(1, 20);

colorList = [Green1; Blue4; Red1; Gray];
cAxis= [0.1:0.1:10];

for mW = 4:4:16
    
    for criteriaIdx = 1:100
        criteria = criteriaIdx*0.1;
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
            sIrr_D100_NA039 = nIrr_D100_NA039(:,:,i).*mW;
            sIrr_D200_NA039 = nIrr_D200_NA039(:,:,i).*mW;
            sIrr_D300_NA039 = nIrr_D300_NA039(:,:,i).*mW;
            sIrr_D400_NA039 = nIrr_D400_NA039(:,:,i).*mW;

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
        [maxVal_D200_NA039, maxIdx_D200_NA039] = max(Iz_D200_NA039);
        [maxVal_D300_NA039, maxIdx_D300_NA039] = max(Iz_D300_NA039);
        [maxVal_D100_NA039, maxIdx_D100_NA039] = max(Iz_D100_NA039);

        eval(['maxDepth_D400_NA039(' num2str(criteriaIdx) ') = z(maxIdx_D400_NA039);']);
        eval(['maxDepth_D200_NA039(' num2str(criteriaIdx) ') = z(maxIdx_D200_NA039);']);
        eval(['maxDepth_D300_NA039(' num2str(criteriaIdx) ') = z(maxIdx_D300_NA039);']);
        eval(['maxDepth_D100_NA039(' num2str(criteriaIdx) ') = z(maxIdx_D100_NA039);']);
    end

    h = figure(2);
    
    % Raw data
    % plot(cAxis, maxDepth_D400_NA039, '-o', 'Color', Gray, 'LineWidth', 2, 'MarkerSize', 5);  hold on;
    % plot(cAxis, maxDepth_D300_NA039, '-o', 'Color', Blue2, 'LineWidth', 2, 'MarkerSize', 5);  hold on;
    plot(cAxis, maxDepth_D200_NA039, '-', 'Color', colorList(round(mW/4),:), 'LineWidth', 2, 'MarkerSize', 5);  hold on;
    ylim([0.3 0.8]);
    [ax, hr] = plot2axes(cAxis, maxDepth_D100_NA039, ':', 'Color', 'yscale', MC.mus, colorList(round(mW/4),:), 'LineWidth', 1, 'MarkerSize', 5);  hold on;
    ylabel(ax(2), 'Optical depth (\it{\mu_s z}\rm\bf)','FontName', 'Times New Roman', 'FontSize', 22, 'FontWeight', 'bold');
    set(ax,'FontName', 'Times New Roman', 'FontSize', 22, 'FontWeight', 'bold')
    set(ax,'YTick', [0:1:11]);
    % % fitting
    % [fit_maxDepth_D400_NA039, gof_maxDepth_D400_NA039] = createFit2(cAxis, maxDepth_D400_NA039);
    % [fit_maxDepth_D300_NA039, gof_maxDepth_D300_NA039] = createFit2(cAxis, maxDepth_D300_NA039);
    % [fit_maxDepth_D200_NA039, gof_maxDepth_D200_NA039] = createFit2(cAxis, maxDepth_D200_NA039);
    % [fit_maxDepth_D100_NA039, gof_maxDepth_D100_NA039] = createFit2(cAxis, maxDepth_D100_NA039);
    % 
    % plot(x, fit_maxDepth_D400_NA039.a * x.^fit_maxDepth_D400_NA039.b + fit_maxDepth_D400_NA039.c, '-', 'Color', DarkGray, 'LineWidth', 2.5); hold on;
    % plot(x, fit_maxDepth_D300_NA039.a * x.^fit_maxDepth_D300_NA039.b + fit_maxDepth_D300_NA039.c, '-', 'Color', Blue4, 'LineWidth', 2.5); hold on;
    % plot(x, fit_maxDepth_D200_NA039.a * x.^fit_maxDepth_D200_NA039.b + fit_maxDepth_D200_NA039.c, '-', 'Color', Red1, 'LineWidth', 2.5); hold on;
    % plot(x, fit_maxDepth_D100_NA039.a * x.^fit_maxDepth_D100_NA039.b + fit_maxDepth_D100_NA039.c, '-', 'Color', Green1, 'LineWidth', 2.5); hold on;
  
    set(gcf,'color','w');
    set(gca,'FontName', 'Times New Roman', 'FontSize', 22, 'FontWeight', 'bold')
    xlabel('Criterian (mW/mm^2)');
    ylabel('Target distance (mm)');
    grid off;  box off;

    set(gca,'YTick', 0.3:0.1:0.8)
    set(gca,'XTick', 1:3:20)
    ylim([0.3 0.8]);
    xlim([0.99 10]);

%     set(h, 'Position', [100, 100, 650, 450]);  
    set(gcf,'Units','normal')
    set(ax,'Position',[.15 .2 .725 .73])
    set(gca,'Position',[.15 .2 .725 .73])    
end

