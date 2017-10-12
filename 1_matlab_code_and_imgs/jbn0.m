clear all;
close all;
% ori = imread('x1.jpg');
ori = imread('x2.jpg');
% ori = imread('x3.jpg');
% ori = imread('pollen.tif');
% ori = imread('ly_tmp.jpg');
ori = im2uint8(ori);
a = ori;
figure,imshow(a,[]);

[M, N] = size(a);
se = ones(3);

lowestBasin = min(a(:));
higestPeak = max(a(:));
index = find(a == lowestBasin);         % �ҳ� a ����ͺ���
b = false(size(a));                     
b(index) = 1;                           % һ��ʼ����ͨ��


figure(1),dis_start = show_process0(a,b);          % ��ʾ����ˮ��ʱ�ľ���

con = max(max(bwlabel(b)));             % �ҳ�����ˮ��ʱ����ͨ��ĸ���

a(index) = lowestBasin + 1;     

dam = false(size(a));
dam = im2uint8(dam);                    % ˮ��

c = b;

% ���濪ʼ��ˮ
for i = lowestBasin + 1 : 254
    b = false(size(a));
    index = find(a == i);
    b(index) = 1;  
    
    if(max(max(bwlabel(b))) >= con) 
        con = max(max(bwlabel(b)));         % �����ͨ�����ӻ򲻱䣬�������ͨ��ĸ���
        c = b;
    elseif(max(max(bwlabel(b))) < con)      % �����ͨ����٣���һ����ˮ�ݺϲ��ˣ�ͨ�� c ������һ��
        d = c;                          
        while(1)
            e = d;                          % e����һ����d    
            d = imdilate(d,se);             % ��������d
            if(max(max(bwlabel(d))) < con)  % ֱ������ͨ�����
                break;
            end
        end
        g = bwlabel(e);                     % �ص���һ������ e �ĸ�����ͨ��
        
        max(max(g))
        
        tmp = zeros(size(a));           
        tmp = im2double(tmp);
        for m = 1:con                    % ���κ�һ����ͨ��
            h = false(size(a));
            ind1 = find(g==m);                  
            h(ind1) = 1;               % ���䵥����������
            tmp =  tmp + imdilate(h,se) - h;            % ��ȡ��߽磬�ӵ�tmp��
        end
        ind = find(tmp > 1);            % �ж���߽��ཻ��������ѽ�����ȡ��������Ҫ��ˮ�ӵĵط�
        a(ind) = 255;                   
        dam(ind) = 255;    
        
        p = false(size(a));
        del = find(a == i);
        p(del) = 1;
        c = p;                          % ��ͨ����ٵ������c ���޹�ˮ�ӵ� a ��������õ���ֵͼ
        
        
    end
    
    figure(1),dis_process = show_process1(ori,c,dam); 
  
    % figure(3)��Ӧ��figure(1)չʾ��3DЧ�������к���figure_rgb��show_process1������ͬ
    figure3_rgb = figure_rgb(ori,c,dam);
    figure3_gray = rgb2gray(figure3_rgb);
    cmap = colormap;
    xxcolormap = double(rgb2ind(figure3_rgb,cmap));
    figure3_gray = double(figure3_gray);
    figure(3), mesh(figure3_gray,xxcolormap); 
    % figure(3)��Ӧ��figure(1)չʾ��3DЧ�������к���figure_rgb��show_process1������ͬ
    
    figure(2), imshow(process2(a,dam,i));       % չʾ���ս��
    
    % figure(4)��Ӧ��figure(2)չʾ��3DЧ��
    figure4_rgb = process2(a,dam,i);
    figure4_gray = rgb2gray(figure4_rgb);
    cmap = colormap;
    xxcolormap = double(rgb2ind(figure4_rgb,cmap));
    figure4_gray = double(figure4_gray);
    figure(4), mesh(figure4_gray,xxcolormap);
    % figure(4)��Ӧ��figure(2)չʾ��3DЧ��
    
    if(i == 254)
        ee = e - imerode(e,se);
        dam(find(ee)) = 255;                    % �����յĸ���ͨ��ı߽�ӵ�ˮ����
        figure(2), imshow(process2(a,dam,i));
    end
    
    for u = 1 : numel(index)
        if(a(index(u)) ~= 255)
            a(index(u)) = i+1;              % �� a �е�ˮλ̧��1����
        end
    end
    i
    con
end
  
figure(1),dis_final = show_process1(ori, c, dam);
