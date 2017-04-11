img=sec2;

xsize=size(img,1);
ysize=size(img,2);

triPic=zeros(xsize,ysize,3);

for x=1:xsize
    for y=1:ysize
        %Display Collagen as Red
        if getPercent(img,x,y,'red')>.45
            triPic(x,y,1)=255;
            triPic(x,y,2)=0;
            triPic(x,y,3)=0;
        %Display void as black
        elseif getPercent(img,x,y,'red')-getPercent(img,x,y,'blue')<.08
            triPic(x,y,1)=0;
            triPic(x,y,2)=0;
            triPic(x,y,3)=0;
        %Display muscle as blue
        else
            triPic(x,y,1)=0;
            triPic(x,y,2)=0;
            triPic(x,y,3)=255;
        end
    end
end

subplot(2,1,1)
imshow(img);
subplot(2,1,2)
imshow(triPic);

