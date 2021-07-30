clear;
close all

path1 = 'D:\Work\Simit\Matlab Pulse\SQI_GUI_vital_PPGECG600s\vital_test108.csv'; % vital_data37
path2 = 'D:\Work\Simit\Matlab Pulse\SQI_GUI_vital_PPGECG600s\vital_train108.csv'; % vital_label37

Test_data = csvread(path1);
Train_data = csvread(path2);

global row
global label_sel
global fig    
%% Train
Fs = 100;
fig = figure


data = Train_data(:,2:end);
label = Train_data(:,1);
for row = 1:length(label)
    data_sel = data(row,:);
    data_sel = normxy(data_sel); % norm
    data_sel = data_sel - mean(data_sel); % remove dc

    label_sel = label(row);
    
    test = false;
    if test
        figure
        plot(data_sel,'linewidth',1.5)
        title(num2str(label_sel))
    end 
    
      %plot
    STFT_plot11(data_sel',Fs) 
    
    %update
    row
end 

%% Test 
Fs = 100;
fig = figure

data = Test_data(:,2:end);
label = Test_data(:,1);
for row = 1:length(label)
% for row = 1:12
    data_sel = data(row,:);
    data_sel = normxy(data_sel); % norm
    data_sel = data_sel - mean(data_sel); % remove dc

    label_sel = label(row);
    
    test = false;
    if test
        figure
        plot(data_sel,'linewidth',1.5)
        title(num2str(label_sel))
    end 
    
      %plot
    STFT_plot12(data_sel',Fs) 
    
    %update
    row
end 

%% sub
% stft plot
function STFT_plot11(s,fs)
    global row
    global label_sel
    global fig 
    path1 = 'D:\Work\Simit\Matlab Pulse\SQI_GUI_vital_PPGECG600s\TF\Train108\';
    
    t = (1:length(s)-1)/fs; %时间轴
    f = 0:fs/2; %频率轴
  
    % tfr为3751*3752
    tfr = tfrstft(s); % s' -> s
    tfr = tfr(1:floor(length(s)/2), :);
    f_lim = 1;  %截止频率
    y_lim = round(f_lim/fs*length(s)); %算出对应的截止纵坐标频率
    tfr1 = tfr(1:y_lim,:); %重新计算
    f1 = f/max(f)*f_lim; %重新归一化频率
%     figure
    imagesc(t, f, abs(tfr));  %映射图
%     imagesc(t, f, abs(tfr));  %映射图

    %colormap(jet) %换颜色
    set(gca,'YDir','normal')
    
    xlabel('时间 t/s');
    ylabel('频率 f/Hz');
    ylim([0 8])
    
    %关闭坐标轴
    axis off
    % 存储
    %去除白边 
    set(gca, 'looseInset', [0 0 0 0]);
    %显示图片时不显示坐标轴及其刻度
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
    
    % save
    %保存图片
    frame = getframe(fig); % 获取frame
    img = frame2im(frame); % 将frame变换成imwrite函数可以识别的格式
    path_im = [num2str(row),'.png'];
    imwrite(img,[path1,num2str(label_sel),'\',path_im]); % 保存到工作目录下，名字为"a.png"
    
    % resize 
    savepath = [path1,num2str(label_sel),'\',path_im];
    RGB = imread(savepath);
    % 将 RGB 图像的大小调整为 250 行。imresize 会自动计算列数。
    RGB2 = imresize(RGB, [250 NaN]);
    
    axis off
    % 存储
    %去除白边 
    set(gca, 'looseInset', [0 0 0 0]);
    %显示图片时不显示坐标轴及其刻度
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
   
    imwrite(RGB2,savepath); % save
end 

%% sub
function STFT_plot12(s,fs)
    global row
    global label_sel
    global fig 
    path1 = 'D:\Work\Simit\Matlab Pulse\SQI_GUI_vital_PPGECG600s\TF\Test108_seq\';
    
    t = (1:length(s)-1)/fs; %时间轴
    f = 0:fs/2; %频率轴
  
    % tfr为3751*3751
    tfr = tfrstft(s); % s' -> s
    tfr = tfr(1:floor(length(s)/2), :);
    f_lim = 1;  %截止频率
    y_lim = round(f_lim/fs*length(s)); %算出对应的截止纵坐标频率
    tfr1 = tfr(1:y_lim,:); %重新计算
    f1 = f/max(f)*f_lim; %重新归一化频率
%     figure
    imagesc(t, f, abs(tfr));  %映射图
%     imagesc(t, f, abs(tfr));  %映射图

    %colormap(jet) %换颜色
    set(gca,'YDir','normal')
    
    xlabel('时间 t/s');
    ylabel('频率 f/Hz');
    ylim([0 8])
    
    %关闭坐标轴
    axis off
    % 存储
    %去除白边 
    set(gca, 'looseInset', [0 0 0 0]);
    %显示图片时不显示坐标轴及其刻度
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
    
    % save
    % 处理path  0->0000, 10->0010
    if row < 10
        row3 = ['000',num2str(row)]; % 0->0000
    elseif row < 100
        row3 = ['00',num2str(row)]; % 10->0010
    elseif row < 1000  
        row3 = ['0',num2str(row)]; % 100->0100
    else
        row3 = num2str(row); % 1000->1000
    end 
   
    %保存图片
    frame = getframe(fig); % 获取frame
    img = frame2im(frame); % 将frame变换成imwrite函数可以识别的格式
%     path_im = [num2str(row),'.png'];
    path_im = [row3,'.png'];
    imwrite(img,[path1,num2str(label_sel),'\',path_im]); % 保存到工作目录下，名字为"a.png"
    
    % resize 
    savepath = [path1,num2str(label_sel),'\',path_im];
    RGB = imread(savepath);
    % 将 RGB 图像的大小调整为 250 行。imresize 会自动计算列数。
    RGB2 = imresize(RGB, [250 NaN]);
    
    axis off
    % 存储
    %去除白边 
    set(gca, 'looseInset', [0 0 0 0]);
    %显示图片时不显示坐标轴及其刻度
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
   
    imwrite(RGB2,savepath); % save
end 


