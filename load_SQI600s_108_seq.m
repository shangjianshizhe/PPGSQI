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
    
    t = (1:length(s)-1)/fs; %ʱ����
    f = 0:fs/2; %Ƶ����
  
    % tfrΪ3751*3752
    tfr = tfrstft(s); % s' -> s
    tfr = tfr(1:floor(length(s)/2), :);
    f_lim = 1;  %��ֹƵ��
    y_lim = round(f_lim/fs*length(s)); %�����Ӧ�Ľ�ֹ������Ƶ��
    tfr1 = tfr(1:y_lim,:); %���¼���
    f1 = f/max(f)*f_lim; %���¹�һ��Ƶ��
%     figure
    imagesc(t, f, abs(tfr));  %ӳ��ͼ
%     imagesc(t, f, abs(tfr));  %ӳ��ͼ

    %colormap(jet) %����ɫ
    set(gca,'YDir','normal')
    
    xlabel('ʱ�� t/s');
    ylabel('Ƶ�� f/Hz');
    ylim([0 8])
    
    %�ر�������
    axis off
    % �洢
    %ȥ���ױ� 
    set(gca, 'looseInset', [0 0 0 0]);
    %��ʾͼƬʱ����ʾ�����ἰ��̶�
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
    
    % save
    %����ͼƬ
    frame = getframe(fig); % ��ȡframe
    img = frame2im(frame); % ��frame�任��imwrite��������ʶ��ĸ�ʽ
    path_im = [num2str(row),'.png'];
    imwrite(img,[path1,num2str(label_sel),'\',path_im]); % ���浽����Ŀ¼�£�����Ϊ"a.png"
    
    % resize 
    savepath = [path1,num2str(label_sel),'\',path_im];
    RGB = imread(savepath);
    % �� RGB ͼ��Ĵ�С����Ϊ 250 �С�imresize ���Զ�����������
    RGB2 = imresize(RGB, [250 NaN]);
    
    axis off
    % �洢
    %ȥ���ױ� 
    set(gca, 'looseInset', [0 0 0 0]);
    %��ʾͼƬʱ����ʾ�����ἰ��̶�
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
   
    imwrite(RGB2,savepath); % save
end 

%% sub
function STFT_plot12(s,fs)
    global row
    global label_sel
    global fig 
    path1 = 'D:\Work\Simit\Matlab Pulse\SQI_GUI_vital_PPGECG600s\TF\Test108_seq\';
    
    t = (1:length(s)-1)/fs; %ʱ����
    f = 0:fs/2; %Ƶ����
  
    % tfrΪ3751*3751
    tfr = tfrstft(s); % s' -> s
    tfr = tfr(1:floor(length(s)/2), :);
    f_lim = 1;  %��ֹƵ��
    y_lim = round(f_lim/fs*length(s)); %�����Ӧ�Ľ�ֹ������Ƶ��
    tfr1 = tfr(1:y_lim,:); %���¼���
    f1 = f/max(f)*f_lim; %���¹�һ��Ƶ��
%     figure
    imagesc(t, f, abs(tfr));  %ӳ��ͼ
%     imagesc(t, f, abs(tfr));  %ӳ��ͼ

    %colormap(jet) %����ɫ
    set(gca,'YDir','normal')
    
    xlabel('ʱ�� t/s');
    ylabel('Ƶ�� f/Hz');
    ylim([0 8])
    
    %�ر�������
    axis off
    % �洢
    %ȥ���ױ� 
    set(gca, 'looseInset', [0 0 0 0]);
    %��ʾͼƬʱ����ʾ�����ἰ��̶�
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
    
    % save
    % ����path  0->0000, 10->0010
    if row < 10
        row3 = ['000',num2str(row)]; % 0->0000
    elseif row < 100
        row3 = ['00',num2str(row)]; % 10->0010
    elseif row < 1000  
        row3 = ['0',num2str(row)]; % 100->0100
    else
        row3 = num2str(row); % 1000->1000
    end 
   
    %����ͼƬ
    frame = getframe(fig); % ��ȡframe
    img = frame2im(frame); % ��frame�任��imwrite��������ʶ��ĸ�ʽ
%     path_im = [num2str(row),'.png'];
    path_im = [row3,'.png'];
    imwrite(img,[path1,num2str(label_sel),'\',path_im]); % ���浽����Ŀ¼�£�����Ϊ"a.png"
    
    % resize 
    savepath = [path1,num2str(label_sel),'\',path_im];
    RGB = imread(savepath);
    % �� RGB ͼ��Ĵ�С����Ϊ 250 �С�imresize ���Զ�����������
    RGB2 = imresize(RGB, [250 NaN]);
    
    axis off
    % �洢
    %ȥ���ױ� 
    set(gca, 'looseInset', [0 0 0 0]);
    %��ʾͼƬʱ����ʾ�����ἰ��̶�
    set(gca, 'xtick', [], 'ytick',[],  'xcolor', 'w', 'ycolor', 'w')
   
    imwrite(RGB2,savepath); % save
end 


