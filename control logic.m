close all;
fclose(port);
port=serial('COM3','Baudrate',9600);
display('KURUKSHETRA 13');
prg=input('1.RUN       2.MASTER CONTROL   ','s');
if (isequal(prg,'2'))
display('MASTER CONTROL PANEL ACCESSED');
uname=input('Enter the username: ','s');
pass=input('Enter the password: ','s');
if (isequal(uname,'k')&isequal(pass,'13'))
display('access granted');
for i=1:3
    display('.')
end
display('master control unlocked');
display('1.MODE SELECT');
display('2.shut down');
opt=input('enter choice  :  ','s');
if (isequal(opt,'1'))
    display('mode selected');
    display('1.PRIORITY AUTO');
    display('2.PRIORITY MANUAL');
    display(' ');
    prsel=input('','s');
        if (isequal(prsel,'1'))
            display('auto is set as default');
            display('priority order:'); 
            display('1.joystick');
            display('2.gesture');
            display('3.tongue');
            display('4.head');
            display('5.eye ball');
            txt='1';
        elseif (isequal(prsel,'2'))
            display('manual is selected  ');
            display('priority order:'); 
            display('1.joystick');
            display('2.gesture');
            display('3.tongue');
            display('4.head');
            display('5.eye ball');
            txt=input('type the priority   : ','s');
            display('priority set as......');disp(txt);
        end
        elseif (isequal(opt,'2'))
button = questdlg('Ready to quit?', ...
        'Exit Dialog','Yes','No','No');
switch button
            case 'Yes',
              disp('Exiting MATLAB');
              exit;
            case 'No',
              display('resumed');
end
end
end
elseif (isequal(prg,'1'))
    if (txt=='2')                         %gesture control
    display('running in gesture mode');
    vid= videoinput('winvideo',1,'YUY2_320x240'); 
preview(vid);
pause(2); %COM port annd baudrate designation
fopen(port);
while(1)
    img = getsnapshot(vid);
    rgb=ycbcr2rgb(img);
    [a b c]=size(rgb);
    
    
    rgb1=rgb(:,:,1); rgb2=rgb(:,:,2); rgb3=rgb(:,:,3);
    
  y=a;
  x=b;
    for m=1:a
        for n=1:b
            if ((rgb1(m,n)>8 && rgb1(m,n)<=150) && (rgb2(m,n)>=14 &&rgb2(m,n)<=220) && (rgb3(m,n)>=0 && rgb3(m,n)<35)) 
                I(m,n)=1;
            else 
                I(m,n)=0;
            end
       end
    end

  imshow(I);
k=1;
count=0;
for j = 1:y
      if (count<5 || k==1)
           for i = 1:x
               if (count<5 || k==1)
                   x1=0;y1=0; 
                   if((I(j,i)==1)) 
                        x1=i; y1=j;
                        k=0;
                       count=count+1;
                    end
                end
           end  
      end
end

count=0;
if y1>0
    for k = y1:y
          if((I(k,x1)==1))         % variable parameter to change depends upon the finger colour
             count=count+1;
          end
    end
end

if count>5
count=count/2;
count=round(count);
y1=y1+count;

X1=x/2+30; % center region of the frame
Y1=y/2+30;
X2=x/2-30;
Y2=y/2-30;
a=0;

end
if count>5
if (x1>X2 && x1<X1) 
    if (y1<Y2 && y1>Y1)
    a=1;
    fprintf(port,'s');
 display('stop');   
    elseif (y1<Y1)
    a=2;
   fprintf(port,'f');
 display('forward');      
    elseif (y1>Y2)
    a=3;
    fprintf(port,'b');
display('backward');
    end 
end
    
if (y1<y/2)
    if (x1>X1)                             % 1st Quadrant
    a=4;
    fprintf(port,'r');
   display('right'); 
    elseif (x1<X2)                         % 2nd Quadrant
    a=5;
    fprintf(port,'l');
    display('left');
    end

if (y1>y/2)
    if (x1<X2)              % 3rd Quadrant
    a=6;
    fprintf(port,'r');
    display('right');      
    elseif ((x1>X2) && (y1>y/2))              % 4th Quadrant
    a=7;
    fprintf(port,'l'); 
    display('left');
    end
end
end
%fclose(port);
    end
end
fclose(port);
    elseif(txt=='1')                        %joystick control
    
        display('running in joystick mode');
        joy = vrjoystick(1);
        %joy = vrjoystick(1,'forcefeedback');
        fopen(port);
        while (1)
        [axes, buttons, povs] = read(joy);
        
        if (axis(joy,1)==1)
         fprintf(port,'r');
         %fclose(port);
        display('right');
          elseif(axis(joy,1)==-1)
        %fopen(port);
        fprintf(port,'l');
        display('left');
        %fclose(port);
        elseif(axis(joy,2)==1)
          %fopen(port);
            fprintf(port,'b');
           % fclose(port);
            display('backward');
            elseif(axis(joy,2)==-1)
            % fopen(port);
                fprintf(port,'f');   
             display('front');
             %fclose(port);
        else
            %fopen(port);
    fprintf(port,'s');
    %fclose(port);
    display('stop');
       
    end
   %fclose(port);
end
fclose(port);
    
    elseif(txt=='3')                            %tongue control
        display('running in tongue control')
        fopen(port);
        while(1)
        fprintf(port,'h');
        end
    elseif(txt=='4')                            %head control
        display('running in head control mode')
        fopen(port);
        while(1)
        fprintf(port,'m');
        end
        fclose(port);
    elseif(txt=='5')
        display('running on eyeball motion')%eyeball motion
        fopen(port);        %obstacle detection

vid=videoinput('winvideo',1,'YUY2_320x240');
preview(vid);
while(1)
arenaa=getsnapshot(vid);
arena=imcrop(arenaa,[0 0 150 120]);
%figure;
%imshow(arena);
arena_rgb=ycbcr2rgb(arena);
   % figure;
  
   % imshow(arena_rgb);
    arena_gray=rgb2gray(arena_rgb);
   % figure;
   % imshow(arena_gray);
    BW=roicolor(arena_gray,0,50);
   % figure;
    %imshow(BW);
    arena_patch=medfilt2(BW);
    %figure;
    %imshow(arena_patch);
    
    %figure;
    imshow(arena_patch);
%     patch=regionprops(arena_patch,'centroid');
%     patch_centroids=cat(1,patch.Centroid);
%     area_patch_structure=regionprops(arena_patch,'area');
%     area_patch=cat(1,area_patch_structure.Area);
    
        if(arena_patch(24,63)==1)
            display('forward');
            fprintf(port,'f');
        else if(arena_patch(5,5)==1)
                display('right');
                fprintf(port,'r');
        else if(arena_patch(14,106)==1)
                display('left');
                fprintf(port,'l')
            end
        end
    end
end
   
end
fclose(port);
    else
        display('invalid option')
    end


      fclose(port);                                            %motor control to arduino


    
        
    
    


