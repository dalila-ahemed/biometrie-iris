function boolean = belongstocircle(x,xc,y,yc,r)
    a = (x-xc)^2 +(y-yc)^2;
    b = r^2;
    boolean = false;
    if(a <= b )
        boolean = true;
    end
     
end
