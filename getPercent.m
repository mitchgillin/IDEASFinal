function percent=getPercent(img,x,y,color)

    r=double(img(x,y,1));
    g=double(img(x,y,2));
    b=double(img(x,y,3));
    
    if color==string('red')
        percent=r^2/(r^2+g^2+b^2);
    end
    
    if color==string('blue')
        percent=b^2/(r^2+g^2+b^2);
    end
    
    if color==string('green')
        percent=g^2/(r^2+g^2+b^2);
    end 
end