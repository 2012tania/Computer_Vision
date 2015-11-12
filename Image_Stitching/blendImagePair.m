function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)

if(strcmp(mode,'overlay')==1)
    out_img = wrapped_imgs;
    [column, row] = find(maskd == 255);
    height = size(row,1);
    for i=1:height
         out_img(column(i), row(i),1) = wrapped_imgd(column(i),row(i),1);
         out_img(column(i), row(i),2) = wrapped_imgd(column(i),row(i),2);
         out_img(column(i), row(i),3) = wrapped_imgd(column(i),row(i),3);
    end
else
    wrapped_imgs = double(wrapped_imgs);
    wrapped_imgd = double(wrapped_imgd);
    
    weighted_masks = bwdist(~masks);
    new_masks = cat(3,weighted_masks,weighted_masks,weighted_masks);
    
    weighted_maskd = bwdist(~maskd);
    new_maskd = cat(3,weighted_maskd,weighted_maskd,weighted_maskd);

    out_img = (new_masks.*wrapped_imgs + new_maskd.*wrapped_imgd)./(new_masks+new_maskd);
    out_img = uint8(out_img);
end

end