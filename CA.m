clc;
clear;
pc=0.85;
pb=0.15;
t=300;
n=200;
carnum=100;
sum=0;
vmax=[7,5,2];
blag=0;
road=n*rand(3,n);
num=zeros(1,1000);
ave=zeros(1,1000);
tong1=zeros(1.20);
carn=0;
vomax=0;
road_new=zeros(3,n);
cars=zeros(3,2);
datal=zeros(3000,n);
for b=1:3
for i=1:n
    if road(b,i)<(n-carnum)
        road(b,i)=0;
    elseif road(b,i)<pc*carnum+(n-carnum)
        road(b,i)=1;
    elseif road(b,i)<(pc+pb)*carnum+(n-carnum)
        road(b,i)=2;
    elseif road(b,i)<n
        road(b,i)=3;
    end         
end
end
speed=zeros(3,n);
for b=1:3
for i=1:n
    if road(b,i)==1
        speed(b,i)=vmax(1)*rand;
    elseif road(b,i)==2
        speed(b,i)=vmax(2)*rand;
    elseif road(b,i)==3
        speed(b,i)=vmax(3)*rand;
    end         
end
end
speed=round(speed);
speed_new=zeros(3,n);
for b=1:3
for i=1:n;
    if road(b,i)==0;
        speed(b,i)=0;
    end
end
end
speed=round(speed);
for m=1:1000
    m
    carn=0;
    for b=1:3
        for i=1:n
            if road(b,i)>0                
            carn=carn+1;
            end
        end
    end
    if m==1
    sum(m)=carn;
    else
    sum(m)=carn+sum(m-1);
    end
    num(m)=carn/(3*n);
    cal=0;
    for b=1:3
        for i=1:n
            if road(b,i)~=0
            ave(m)=ave(m)+speed(b,i);
            end
        end
    end
    ave(m)=ave(m)/(3*n);
    for j=1:3
        for i=1:n
            if road(j,i)~=0
                cars(j,1)=i;
            end
        end
        for i=n:-1:1
            if road(j,i)~=0
                cars(j,2)=i;
            end
        end
    end
    for b=1:3
    for i=0:n-1
        j=n-i;
        if road(b,j)~=0
            v=speed(b,j);
            k=j+v;
            if k>n
                road_new(b,j)=0;
                speed_new(b,j)=0;
            else
                    flag=0;
                    for i=j+1:n;
                        if i==n+1
                            up1=vmax(1);
                            break;
                        end
                        if road(1,i)~=0
                            up1=i-j;
                            flag=1;
                        end
                        if flag==0
                            up1=vmax(1);                  %此处注意vmax要进行修改
                        end
                    end
                    flag=0;
                    for i=j-1:-1:1;
                        if i==2
                            back1=vmax(1);
                            break
                        end
                        if road(1,i)~=0
                            back1=j-i;
                            flag=1;
                        end
                        if flag==0
                            back1=vmax(1);
                        end
                    end
                    flag=0;
                    for i=j+1:n;
                        if i==n+1
                            up2=vmax(1);
                            break;
                        end
                        if road(2,i)~=0
                            up2=i-j;
                            flag=1;
                        end
                        if flag==0
                            up2=vmax(1);                  %此处注意vmax要进行修改
                        end
                    end
                    flag=0;
                    for i=j-1:-1:1;
                        if i==2
                            back2=vmax(1);
                            break
                        end
                        if road(2,i)~=0
                            back2=j-i;
                            flag=1;
                        end
                        if flag==0
                            back2=vmax(1);
                        end
                    end
                    flag=0;
                    for i=j+1:n;
                        if i==n+1
                            up3=vmax(1);
                            break;
                        end
                        if road(3,i)~=0
                            up3=i-j;
                            flag=1;
                        end
                        if flag==0
                            up3=vmax(1);                  %此处注意vmax要进行修改
                        end
                    end
                    flag=0;
                    for i=j-1:-1:1;
                        if i==2
                            back3=vmax(1);
                            break
                        end
                        if road(3,i)~=0
                            back3=j-i;
                            flag=1;
                        end
                        if flag==0
                            back3=vmax(1);
                        end
                    end
                    if road(b,j)==1
                        vomax=vmax(1);
                    end
                    if road(b,j)==2
                        vomax=vmax(2);
                    end
                    if road(b,j)==3
                        vomax=vmax(3);
                    end
                if b==1
                    if up1<min(speed(1,j)+1,vomax) && up2>up1 && back2>vomax-speed(b,j) && road(2,j)==0
                        road(2,j)=1;
                        speed(2,j)=speed(1,j);
                        road(1,j)=0;
                        speed(1,j)=0;
                        blag=1;
                    end
                end
                    if b==2
                        if up2<min(speed(2,j)+1,vomax) && up1>up2 && back1>vomax-speed(2,j) && road(1,j)==0
                            road(1,j)=1;
                            speed(1,j)=speed(2,j);
                            road(2,j)=0;
                            speed(2,j)=0;
                            blag=2;
                    elseif up2<min(speed(b,j)+1,vomax) && up3>up2 && back3>vomax-speed(b,j) && road(3,j)==0
                        road(3,j)=1;
                        speed(3,j)=speed(b,j);
                        road(b,j)=0;
                        speed(b,j)=0;
                        blag=3;
                        end
                    end
                    if b==3
                        if up3<min(speed(b,j)+1,vomax) && up2>up3 && back2>vomax-speed(b,j) && road(2,j)==0
                            road(2,j)=1;
                            speed(2,j)=speed(b,j);
                            road(b,j)=0;
                            speed(b,j)=0;
                            blag=4;
                        end
                    end
                road_new(b,j)=0;
                road_new(b,k)=1;
                speed_new(b,j)=0;
                speed_new(b,k)=min(v+1,vomax);
                if b==1
                    speed_new(b,k)=min(speed_new(b,k),up1);
                elseif b==2
                    speed_new(b,k)=min(speed_new(b,k),up2);
                elseif b==3
                    speed_new(b,k)=min(speed_new(b,k),up3);
                end
                gai=rand;
                if gai>0.3
                    if speed_new(b,k)>0
                       speed_new(b,k)=speed_new(b,k);
                    else
                        speed_new(b,k)=0;
                    end
                end
            end
        end
    end
    end
    for b=1:3
    if road(b,1)==0
        p=rand;
        if p>0.01
            road_new(b,1)=1;
            speed_new(b,1)=round(5*rand);
        end
    end
    end
    for i=1:n
            datal(3*m-2,i)=road(1,i);
            datal(3*m-1,i)=road(2,i);
            datal(3*m,i)=road(3,i);
    end
   speed=speed_new;
   road=road_new;
end
for i=1:20
    if i==1
    tong1(i)=sum(i*50);
    tong1(i)=tong1(i)/50;
    continue;
    end
    tong1(i)=sum(i*50)-sum(i*50-50);
    tong1(i)=tong1(i)/50;
end
xlswrite('D:\data85 pb',tong1)
