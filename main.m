img=section1;
oImg=img;
modValue=200;
%IM2BW 
xsize=size(img,1);
ysize=size(img,2);
bw=im2bw(img,.93);
triPic=zeros(xsize,ysize,3);

xsize=xsize-mod(size(img,1),modValue);
ysize=ysize-mod(size(img,2),modValue);

img=img(1:xsize,1:ysize,1:3);

%0 is black, 1 is white
bw=im2bw(img,.93);

xBeginValues=zeros(1,xsize/modValue);
xBeginValues(1)=1;
for i=2:size(xBeginValues,2)
    xBeginValues(i)=(i-1)*modValue
end

yBeginValues=zeros(1,ysize/modValue);
yBeginValues(1)=1;
for i=2:size(yBeginValues,2)
    yBeginValues(i)=(i-1)*modValue
end

numGoodPix=zeros(xsize/modValue,ysize/modValue);
numRedPix=zeros(xsize/modValue,ysize/modValue);

for x1=1:xsize/modValue
    for y1=1:ysize/modValue 
        numPix=0;
        redPix=0;
        for x=xBeginValues(x1):xBeginValues(x1)+modValue
            
            for y=yBeginValues(y1):yBeginValues(y1)+modValue
             if(bw(x,y)==0)
                 numPix=numPix+1;
             end
                
            %Display Collagen as Red
            if getPercent(img,x,y,'red')>.45
                triPic(x,y,1)=255;
                triPic(x,y,2)=0;
                triPic(x,y,3)=0;
                redPix=redPix+1;
            %Display void as black
            elseif getPercent(img,x,y,'red')-getPercent(img,x,y,'blue')<.08
                triPic(x,y,1)=0;
                triPic(x,y,2)=0;
                triPic(x,y,3)=0;
            %Display muscle as blue
            else
                triPic(x,y,1)=255;
                triPic(x,y,2)=255;
                triPic(x,y,3)=255;
            end
            end
            if(numPix>modValue^2)
                numPix=modValue^2;
            end
            numGoodPix(x1,y1)=numPix;
            numRedPix(x1,y1)=redPix;
        end
    end
end

percentCollagen=numRedPix./numGoodPix;
disp(percentCollagen);


subplot(2,1,1)
imshow(oImg);
subplot(2,1,2)
imshow(triPic);

