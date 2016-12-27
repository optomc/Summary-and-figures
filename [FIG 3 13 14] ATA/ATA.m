Red1 = [237 28 36]./255; Red2 = [241 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; Blue4 = [0 0 153]./255; Black = [50 50 50]./255;

tGray = [205 205 205]./255; tBlue = [204 204 235]./255; tRed = [251 210 211]./255; tGreen = [204 237 220]./255;

red = [0.9294 0.1098 0.1412]; yellow = [1.0000 0.8706 0.0902]; green = [0 0.6314 0.2941]; blue = [0.1294 0.2510 0.6039]; pupple = [0.4980 0.2471 0.5961]; color = [red; yellow; green; blue; pupple];
dRed = [0.6314 0.1137 0.1686]; dYellow = [ 0.9686 0.5804 0.1176]; dGreen = [0 0.4078 0.2196]; dBlue = [0.0941 0.0745 0.2745]; dPupple = [ 0.2510 0.1412 0.4000]; dColor = [dRed; dYellow; dGreen; dBlue; dPupple];

analArea_D100 = pi*0.05^2;
analArea_D200 = pi*0.1^2;
analArea_D300 = pi*0.15^2;
analArea_D400 = pi*0.2^2;
lineIdxList = [1 2 1 2];
criteria = 10;
step = 2;
close all;

for mW = 4:4:8
    lineIdx = lineIdxList(mW/4);

    xAxisMax = 2;
    xAxisStep = 0.5;

    yAxisMax = 0.25;
    yAxisStep = 0.05;

    ATA_D100_NA039 = zeros(1,401);
    ATA_D200_NA039 = zeros(1,401);
    ATA_D300_NA039 = zeros(1,401);
    ATA_D400_NA039 = zeros(1,401);

    volumeElem = 0.01*0.01*0.01;
    areaElem = 0.01*0.01;

    z = [0:0.01:4];
    zGeoTick = 0:1/MC.mus:5;
    zOpdTick = zGeoTick*MC.mus;
    opticalDepth = 0:MC.mus*1e-2*step:4;  
    
    maxDepthIdx = 201;
    for i = 1:401 
        % NA039
        sIrr_D100_NA039 = nIrr_D100_NA039(:,:,i).*mW;
        sIrr_D200_NA039 = nIrr_D200_NA039(:,:,i).*mW;
        sIrr_D300_NA039 = nIrr_D300_NA039(:,:,i).*mW;
        sIrr_D400_NA039 = nIrr_D400_NA039(:,:,i).*mW;

        idx_D100_NA039 = numel(find (sIrr_D100_NA039 >= criteria))*areaElem;
        idx_D200_NA039 = numel(find (sIrr_D200_NA039 >= criteria))*areaElem;
        idx_D300_NA039 = numel(find (sIrr_D300_NA039 >= criteria))*areaElem;
        idx_D400_NA039 = numel(find (sIrr_D400_NA039 >= criteria))*areaElem;

        ATA_D100_NA039(i) = sum(idx_D100_NA039);
        ATA_D200_NA039(i) = sum(idx_D200_NA039);
        ATA_D300_NA039(i) = sum(idx_D300_NA039);
        ATA_D400_NA039(i) = sum(idx_D400_NA039);    
    end

    % h = figure(round(criteria));
    h = figure(5);
    
    if lineIdx == 1
        lineType = '--';
    else
        lineType = '-';
    end

    plot(z(1:maxDepthIdx), ATA_D400_NA039(1:maxDepthIdx), lineType, 'Color', Gray, 'LineWidth', lineIdx); hold on; grid on;
    plot(z(1:maxDepthIdx), ATA_D300_NA039(1:maxDepthIdx), lineType, 'Color', Blue4, 'LineWidth', lineIdx); hold on; grid on;
    plot(z(1:maxDepthIdx), ATA_D200_NA039(1:maxDepthIdx), lineType, 'Color', Red1, 'LineWidth', lineIdx); hold on; grid on;
    plot(z(1:maxDepthIdx), ATA_D100_NA039(1:maxDepthIdx), lineType, 'Color', Green1, 'LineWidth', lineIdx); hold on; grid on;

    set(gcf,'color','w');
    set(gca,'FontName', 'Times New Roman', 'FontSize', 21, 'FontWeight', 'bold')
    xlabel('Depth {\itz} (mm)');
    ylabel('ATA (mm^2)');

    xlim([0 1.1])
    ylim([0 0.3])

    set(gca,'xtick', [0:0.2:1.1]);
    set(gca, 'ytick', [0:0.1:0.3]);
    grid off;  box off;

    xL = get(gca,'XLim'); hold on;
    line(xL, [analArea_D100 analArea_D100], 'Color', Black, 'LineStyle', ':');
    line(xL, [analArea_D200 analArea_D200], 'Color', Black, 'LineStyle', ':');
    line(xL, [analArea_D300 analArea_D300], 'Color', Black, 'LineStyle', ':');
    line(xL, [analArea_D400 analArea_D400], 'Color', Black, 'LineStyle', ':');

    LinkTopAxisData(zGeoTick, zOpdTick, 'Optical depth (\it{\mu_s z}\rm\bf)'); % Add a top axis
    set(gca,'FontName', 'Times New Roman', 'FontSize', 20, 'FontWeight', 'bold')
    xlabel('Optical depth (\it{\mu_s z}\rm\bf)');
    grid off;  box off;

    set(gcf,'Units','normal')
    set(gca,'Position',[.18 .155 .75 .67])
end