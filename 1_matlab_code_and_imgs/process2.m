function jbn = process2(a, dam, elevation)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
a_tmp = a;
ind_water = find(a == elevation);       % ��ˮ��
ind_other = find(a ~= elevation);       % �����ߵ�

a_tmp0 = zeros(size(a_tmp));
a_tmp0 = im2uint8(a_tmp0);
a_tmp0(ind_water) = 255;                % ���ڱ�ʾ��ɫ����������cat�����У����������ɫ���� 

a_tmp1 = zeros(size(a_tmp));
a_tmp1 = im2uint8(a_tmp1);
a_tmp1(ind_other) = a(ind_other);

jbn = cat(3, a_tmp1 + dam, a_tmp1 + dam, a_tmp1 + dam + a_tmp0);  % ˮ�Ӻ͸ߵ�3ͨ����Ҫ����ˮ����Ҫ��ɫ����

end

