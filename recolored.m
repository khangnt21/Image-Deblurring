function img = recolored(original_img, restored_img)
    min_ori = min(original_img, [], 'all');
    min_res = min(restored_img, [], 'all');
    max_ori = max(original_img, [], 'all');
    max_res = max(restored_img, [], 'all');
    img = restored_img*(max_ori-min_ori)/(max_res-min_res);
end