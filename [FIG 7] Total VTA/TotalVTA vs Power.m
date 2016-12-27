Red1 = [237 28 36]./255; Red2 = [2401 90 34]./255; Red3 = [246 139 31]./255;
Green1 = [0 166 81]./255; Green2 = [203 219 42]./255; Green3 = [255 242 0]./255; 
Blue1 = [82 79 161]./255; Blue2 = [0 173 220]./255; Blue3 = [109 200 191]./255;
Gray = [180 180 180]./255; DarkGray = [109 110 112]./255; Blue4 = [0 0 153]./255;

Red = [237 28 36]./255; Yellow = [253 185 19]./255; Sky = [0 173 220]./255; Blue = [82 79 161]./255; Green = [203 4019 42]./255; Gray = [180 180 180]./255;

%% Total-VTA
xAxisMax = 20;
xAxisStep = 5;

yAxisMax = 0.9;
yAxisStep = 0.2;

vElem = 0.01*0.01*0.01;
pList = [1:200]*0.1;

for mWidx = 1:200  
    
%     Iz_1_D100_NA039(mW,:) = zeros(1,401);
%     Iz_5_D100_NA039(mW,:) = zeros(1,401);
%     Iz_10_D100_NA039(mW,:) = zeros(1,401);     
    
    mW = mWidx * 0.1;
    
    for i = 1:401
        iPlane_D100_NA039 = nIrr_D100_NA039(:,:,i).*(mW);        
        idx_1_D100_NA039(mWidx, i) = numel(find (iPlane_D100_NA039 >= 1.3))*vElem;    
        idx_5_D100_NA039(mWidx, i) = numel(find (iPlane_D100_NA039 >= 5))*vElem;    
        idx_10_D100_NA039(mWidx, i) = numel(find (iPlane_D100_NA039 >= 10))*vElem;    
        
        iPlane_D200_NA039 = nIrr_D200_NA039(:,:,i).*(mW);        
        idx_1_D200_NA039(mWidx, i) = numel(find (iPlane_D200_NA039 >= 1.3))*vElem;    
        idx_5_D200_NA039(mWidx, i) = numel(find (iPlane_D200_NA039 >= 5))*vElem;    
        idx_10_D200_NA039(mWidx, i) = numel(find (iPlane_D200_NA039 >= 10))*vElem;    
        
        iPlane_D300_NA039 = nIrr_D300_NA039(:,:,i).*(mW);        
        idx_1_D300_NA039(mWidx, i) = numel(find (iPlane_D300_NA039 >= 1.3))*vElem;    
        idx_5_D300_NA039(mWidx, i) = numel(find (iPlane_D300_NA039 >= 5))*vElem;    
        idx_10_D300_NA039(mWidx, i) = numel(find (iPlane_D300_NA039 >= 10))*vElem;    
        
%         iPlane_D400_NA039 = nIrr_D400_NA039(:,:,i).*(mW);        
%         idx_1_D400_NA039(mWidx, i) = numel(find (iPlane_D400_NA039 >= 1.3))*vElem;    
%         idx_5_D400_NA039(mWidx, i) = numel(find (iPlane_D400_NA039 >= 5))*vElem;    
%         idx_10_D400_NA039(mWidx, i) = numel(find (iPlane_D400_NA039 >= 10))*vElem;    
    end
    
end

% Gray Blue4 Red1 Green1
% plot(pList, sum(idx_1_D100_NA039, 2), ':', 'Color', Blue4, 'LineWidth', 1); hold on;
% plot(pList, sum(idx_5_D100_NA039, 2), ':', 'Color', Red1, 'LineWidth', 1);
% plot(pList, sum(idx_10_D100_NA039, 2), ':', 'Color', Green1, 'LineWidth', 1);

plot(pList, sum(idx_1_D200_NA039, 2), '-', 'Color', Blue4, 'LineWidth', 2); hold on;
plot(pList, sum(idx_5_D200_NA039, 2), '-', 'Color', Red1, 'LineWidth', 2);
plot(pList, sum(idx_10_D200_NA039, 2), '-', 'Color', Green1, 'LineWidth', 2);

% plot(pList, sum(idx_1_D300_NA039, 2), '--', 'Color', Blue4, 'LineWidth', 1); hold on;
% plot(pList, sum(idx_5_D300_NA039, 2), '--', 'Color', Red1, 'LineWidth', 1);
% plot(pList, sum(idx_10_D300_NA039, 2), '--', 'Color', Green1, 'LineWidth', 1);

% plot(sum(idx_1_D400_NA039,2),'r-.'); hold on;
% plot(sum(idx_5_D400_NA039,2),'g-.');
% plot(sum(idx_10_D400_NA039,2),'b-.');

set(gcf,'color','w');
set(gca,'FontName', 'Times New Roman', 'FontSize', 21, 'FontWeight', 'bold')
xlabel('Initial power (mW)');
ylabel('VTA (mm^3)');
grid off;  box off;

ylim([0 1.5])
xlim([1 20])
set(gca,'XTick', 1:3:20)

