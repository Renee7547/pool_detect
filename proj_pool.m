function Output=proj_pool(picture, thred_hold)
%%picture='testX.png'
%%cell 20*20
Cell_yes=0;
cell_origin=zeros(20,20);
cell_origin(4:17,4:17)=ones(14,14);
pix = imread(picture);
pix_new=im2double(pix);
[x,y,~]=size(pix);
Total_cell=x*y/400;
Cell_no=Total_cell;
for i=0:1:x/20-1
    for j=0:1:y/20-1
        if pooldetect(pix(i*20+1:(i+1)*20,j*20+1:(j+1)*20,:)) >= thred_hold
           Cell_yes = Cell_yes+1;
           pix_new(i*20+1:(i+1)*20,j*20+1:(j+1)*20,2)=pix_new(i*20+1:(i+1)*20,j*20+1:(j+1)*20,2).*cell_origin;
           pix_new(i*20+1:(i+1)*20,j*20+1:(j+1)*20,3)=pix_new(i*20+1:(i+1)*20,j*20+1:(j+1)*20,3).*cell_origin;
           Cell_no=Cell_no-1;
        end
    end  
end
imshow(pix_new);
Output=[Total_cell, Cell_no, Cell_yes];
end

function sum_spot=pooldetect(pix)
red = (70<pix(:,:,1)).*(pix(:,:,1)<160);
green = (150<pix(:,:,2)).*(pix(:,:,2)<224);
blue = (170<pix(:,:,3)).*(pix(:,:,3)<250);
sum_spot=sum(sum(red.*green.*blue));
end