%180224 Overlay Segmentation Code
%Science Fair Project 2018

%Input start time points
% stime=[22.06,23.85,25.48,27,28.5,30,31.5,33,34.5,36,37.5];seg_sec=1.5; %160402MPU6k_SpenStrapBar_3

% stime=[3.6,6.4,9.3,12.3,15.5,18.7,21.5,24.6,27.4,30.1];seg_sec=1;vg=10;vr=1500;vgs=2;vrs=300; %180224Bat_NoSound
% stime=[4,6.3,8.8,11.3,13.9,16.4,19,21.4,24.1,26.6];seg_sec=1;vg=10;vr=1500;vgs=2;vrs=300; %180224Bat_SonAcc
% stime=[3.6,6.5,9.1,11.7,14.4,17.1,19.9,22.5,25.4,28.0];seg_sec=1;vg=10;vr=1500;vgs=2;vrs=300; %180224Bat_SonG

% stime=[12.9,21.8,31.5,40,50,59.3,67.6,75.9,83.25,91.6];seg_sec=1;vg=14;vr=2200;vgs=2;vrs=400; %180224Golf_NoSound
% stime=[7.7,15.1,23,31,39.6,49.1,56.9,66.5,77,86.8];seg_sec=1;vg=14;vr=2200;vgs=2;vrs=400; %180224Golf_SonAcc
% stime=[6.5,14.5,21.4,29.1,36.8,53.7,61.3,68.7,76.4];seg_sec=1;vg=14;vr=2200;vgs=2;vrs=400; %180224Golf_SonG

% stime=[12.4,17.4,22.3,27.2,32.2,36.9,41.9,47.2,52.8,58.3];seg_sec=1;vg=25;vr=660;vgs=5;vrs=120; %180225Bat_NoSoundDad
% stime=[7.7,13,18,23.2,28.6,34,40.2,46,51.5,57.4];seg_sec=1;vg=25;vr=660;vgs=5;vrs=120; %180225Bat_SonAccDad
% stime=[10,15.4,20,24.6,29.9,35.9,41.5,47.3,52.7,58.1];seg_sec=1;vg=25;vr=660;vgs=5;vrs=120; %180225Bat_SonGDad

% stime=[10.2,15,19.9,25,30,35.7,45.7,50.7,55.6,60.8];seg_sec=1;vg=20;vr=500;vgs=4;vrs=100; %180225Golf_NoSoundDad
% stime=[8.7,14.1,19.1,24.6,30.1,35.9,41.5,47.3,53.3,60.2];seg_sec=1;vg=20;vr=500;vgs=4;vrs=100; %180225Golf_SonAccDad
% stime=[9.57,14.55,20.23,26.29,32.18,38.61,44.19,50.61,56.57,62.32,67.65,73.32,78.96,85.28];seg_sec=1;vg=20;vr=500;vgs=4;vrs=100; %180225Golf_SonGDad

% stime=[3.7,7.7,11.8,15.3,19.0,22.2,25.3,28.1,31.1,34.3];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_NoSound_Brady
% stime=[7.1,9.3,11.5,13.9,16.3,18.9,21.8,24.6,27.2,30.7];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_SonAcc_Brady
% stime=[4.4,6.69,8.789,10.85,12.95,15.03,17.12,19.36,21.3,24.97];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_SonG_Brady

% stime=[2.046,4.849,7.7,10.54,13,15.76,18.67,21.2,24.03,26.64];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_NoSound_Jack
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_SonAcc_Jack
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Bat_SonG_Jack

% stime=[20,25.3,30.6,36.77,42.3,49,55.9,61.9,67.4,74.1];seg_sec=1;vg=20;vr=600;vgs=4;vrs=100; %180225Golf_NoSound_Dave
% stime=[11.26,16.98,23.92,29.02,33.96];seg_sec=1;vg=20;vr=600;vgs=4;vrs=100; %180225Golf_SonAcc_Dave
% stime=[57.29,63.46,69.1,75.5,81.6,87.5,93.4,99.99,105.5,124.6,129.2];seg_sec=1;vg=20;vr=600;vgs=4;vrs=100; %180225Golf_SonG_Dave

% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Golf_NoSound_Vanessa
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Golf_SonAcc_Vanessa
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180225Golf_SonG_Vanessa

% stime=[9.3,12,15.3,18.6,21.7,25.2,28,31.1,33.9,37];seg_sec=1;vg=8;vr=450;vgs=2;vrs=150; %180225Golf_NoSound_Sierra
% stime=[4.5,7.6,11.2,14.7,18.6,22.5,27.2,30.7,37,41.6];seg_sec=1;vg=8;vr=450;vgs=2;vrs=150; %180225Golf_SonAcc_Sierra

% stime=[21.69,23.85,27.84,29.79,31.86,34.18,36.53,];seg_sec=1;vg=15;vr=300;vgs=2;vrs=50; %180227StrapBar_NoSound
% stime=[18.19,20.65,22.88,25.18,27.53,29.83,32.04,34.39,37.14,40,42.41];seg_sec=1;vg=15;vr=300;vgs=2;vrs=50; %180227StrapBar_SonAcc
% stime=[22.36,24.62,26.72,31.07,33.31,35.69,37.77,40.1,42.19,44.75];seg_sec=1;vg=15;vr=300;vgs=2;vrs=50; %180227StrapBar_SonG
% stime=[43.61,45.44,47.41,50.41,54.14,56.33];seg_sec=1;vg=15;vr=300;vgs=2;vrs=50; %180227StrapBarFast_SonG

% stime=[3,3.8,5.1,6,7,8,8.8,9.8,10.8];seg_sec=1.2;vg=10;vr=300;vgs=2;vrs=60; %180227Pommel_NoSound
% stime=[2.8,3.6,4.6,6.5,8.35,9.3,10.3];seg_sec=1.2;vg=10;vr=300;vgs=2;vrs=60; %180227Pommel_SonAcc
% stime=[6.4,7.3,8.3,9.3,12.12,13.2];seg_sec=1.2;vg=10;vr=300;vgs=2;vrs=60; %180227Pommel_SonG
% stime=[3,4,5,6.8,7.6,8.8];seg_sec=1.2;vg=10;vr=300;vgs=2;vrs=60; %180227PommelFlair_SonG

% stime=[3,10.3,12.7,15.5,19.37,24.8,35.2,39.2,61,74];seg_sec=1;vg=15;vr=300;vgs=5;vrs=60; %180227Tramp_SonG

% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180227Pommel_NoSound
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180227Pommel_SonAcc
% stime=[];seg_sec=1;vg=20;vr=700;vgs=5;vrs=200; %180227Pommel_SonG

% stime = [5.5]; seg_sec=3;vg=6;vr=800;vgs=2;vrs=60; %201102IdealArmSwing_SonAcc
% stime = [5.5, 14.5, 24, 30.5]; seg_sec=3;vg=15;vr=1600;vgs=2;vrs=60; %201102IdealGolfSwing_SonAcc2
% stime = [6.4, 18.2]; seg_sec=3;vg=15;vr=1600;vgs=2;vrs=60; %201102IdealGolfSwing_SonAcc2
% stime = [3.5, 13.5, 20.5, 29.2, 35.8, 43.5, 51, 59.45, 66.5]; seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %201102ArmSwing_NoSound
% stime = [7.7, 15.7, 24, 31, 38, 44.5, 58, 65, 71.5, 77.5, 83.5, 89, 95, 100.5]; seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %201102ArmSwing_SonAcc

% stime = [18, 24, 30, 38, 44, 50, 57.5, 64, 69.5, 76, 82.5, 90, 98, 104, 110, 116, 124.5, 134, 142, 150, 156, 162, 166.5, 174.3, 180, 185, 190, 196, 204, 209, 214.5]; seg_sec=1.5;vg=8;vr=950;vgs=2;vrs=200; %201117NoSoundGolfMax_SonAcc IMPORTANT: MULTIPLY NSEG BY 2 IN [maxg_seg(i),idx_maxg(i)]=max(magaccel_g(idx_st(i):idx_st(i)+nseg*2)); (Also multiply acc graph by 1.06)
% stime = [14, 22, 30, 38, 46, 56, 64, 71, 79, 88, 96, 104, 112, 121, 131, 142, 152.5, 163.5, 179, 187.5, 197, 205.5, 215, 228.5, 237, 246, 254.5, 263, 272, 280, 292, 300, 309, 318, 326, 334.5, 346, 354.5, 362.5, 371.5, 381, 389.5, 398.5, 409.5, 419.5]; seg_sec=1.5;vg=8;vr=950;vgs=2;vrs=200; %201117SonAccGolfMax_SonAcc (Also multiply dps graph by .85)
% stime = [179, 187.5, 197]; seg_sec=1.5;vg=8;vr=950;vgs=2;vrs=200; %201117SonAccGolfMax_SonAcc FINAL 3 ONLY
% stime = [16, 22, 27, 34, 47, 63.5, 71.5, 79.5]; seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonAcc_MikeIdealGolfSwing


% stime = [11, 13, 16, 18.5, 21, 23.5, 26, 28]; seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonG_MomIdealTennisSwing
% stime = [53, 60];seg_sec=3;vg=8;vr=950;vgs=2;vrs=200;




%FINAL DATA

% GOLF:
% stime = [14, 19, 24, 30, 36, 42, 48, 54.5, 60, 65.5]; seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonG_MikeIdealGolfSwing USED
% stime = [3, 10, 16, 22, 28.5, 35, 42, 53, 59, 65, 72, 78, 84, 90, 96, 104, 112, 117, 124, 130, 136, 143, 150, 155, 162, 167, 172, 177, 182, 187, 192, 197, 201]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %NoSoundMaxGolfSwing_SonAcc 
% stime = [3, 7.5, 11.5, 16, 21, 26, 43.5, 48.5, 58.5, 78.5, 82.5, 101, 96.5, 111, 116, 120.5, 131.5, 138.5, 144.5, 150.5, 156, 161, 169.5, 184.5, 189.5, 195, 200, 205.5, 211, 216.5, 222.5, 234.5, 240]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %SonAccMaxGolfSwing 
% stime = [3, 7, 11, 15, 20, 24.5, 29, 34, 38, 42, 46, 50, 56, 60.5, 65.5, 71, 75.5, 80.5, 85, 89.8, 94, 99, 104.5, 110, 116.5, 121.5, 126, 132, 137, 141.5, 147, 152, 157.5, 162.5, 168]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %NoSoundMaxGolfSwing_SonG 
% stime = [2, 7, 23, 32, 38, 44, 49, 65.5, 71, 78, 84, 90, 95.5, 104, 110, 131, 140, 145, 151, 157, 163, 169, 188, 194, 199, 205, 210, 217, 222, 229, 236, 242, 248, 254, 261]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %SonGMaxGolfSwing 
% stime = [1.5, 6, 10, 15, 33, 37, 41, 45, 50, 51, 61, 66, 71, 76, 81, 99, 103, 107.5, 112, 117, 121, 126, 130, 144, 148.5, 154, 160, 165, 171.5, 177, 181, 186, 191, 196, 201, 206, 211, 216, 242.5]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %Dan_ControlGolfOne
% stime = [2, 7, 16.5, 26.5, 44, 64, 89.5, 104.5, 110, 115.5, 121.5, 127.5, 133.5, 151, 156, 162, 168.5, 174.5, 181, 199, 210, 220.5, 226, 242]; seg_sec=1;vg=12;vr=1300;vgs=4;vrs=500; %Dan_ControlGolfTwo

% TENNIS:
% stime = [53, 60];seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %TennisSwingIdeal
% stime = [10, 12, 14, 17, 19, 21, 23, 25, 28, 30, 32, 34, 36, 39, 41, 43, 45, 48, 59, 61, 63.5, 66, 68.5, 71, 73, 76, 87, 89, 91, 94, 96, 98, 100, 102]; seg_sec=1.5;vg=8;vr=1300;vgs=4;vrs=450; %SonG_NoSound_TennisSwing
% stime = [4, 8, 11, 15, 17, 22, 26, 30, 33.6, 42, 45.5, 49.5, 53, 56.5, 65.5, 70.5, 74, 78, 82, 85.5, 89, 92.5, 96.5, 100.5, 104, 107.5, 111.5, 115, 119, 122.5, 123.5]; seg_sec=1.5;vg=8;vr=1300;vgs=4;vrs=450; %SonAcc_TennisSwing
stime = [2, 5.5, 9.5, 21, 25, 29.3, 40, 44, 48, 52.5, 56.5, 61, 65, 71, 76, 88, 92, 96, 101, 106, 110, 114.6, 123, 128, 131.5, 136, 144.3, 148.3, 153, 157, 161.5, 170, 176.5]; seg_sec=1.5;vg=8;vr=1300;vgs=4;vrs=450; %SonG_TennisSwing
% stime = [2, 3.5, 5, 7, 9.5, 11.5, 13.5, 23, 24.5, 27, 51, 55.5, 57, 59, 61, 63, 65, 67, 69.5, 71.5, 73.5, 75.5, 77.5, 79.5, 82, 84, 86.5, 88.5]; seg_sec=1.5;vg=8;vr=1300;vgs=4;vrs=450; %SonAcc_NoSound_Tennis


%Define parameters
% seg_sec=1.5;   %segment length
cps=4000;       %sample rate
nst=max(size(stime));
nseg_half=round(seg_sec*cps/2);
nseg=2*nseg_half;

%find index for each start time
idx_st=zeros(nst,1);
idx_maxg=zeros(nst,1);  %center of segment
maxg_seg=zeros(nst,1);
idx_start=zeros(nst,1);       %precision start of each segment
idx_end=zeros(nst,1);
seg_acc_g=zeros(nseg,nst);
seg_gyr_dps=zeros(nseg,nst);
for i=1:nst
    tv=find(tp>=stime(i));
    idx_st(i)=tv(1);
    [maxg_seg(i),idx_maxg(i)]=max(magaccel_g(idx_st(i):idx_st(i)+nseg));
    idx_start(i)=idx_st(i)+idx_maxg(i)-nseg_half;
    idx_end(i)=idx_st(i)+idx_maxg(i)+nseg_half-1;
    seg_acc_g(:,i)=magaccel_g(idx_start(i):idx_end(i),:);
    seg_gyr_dps(:,i)=maggyro_dps(idx_start(i):idx_end(i),:);
end

%compute mean segment and its standard deviation
mn_g=mean(seg_acc_g,2);
mn_g_avg=mean(mn_g);
%soundsc(mn_g);
std_g=std(seg_acc_g,0,2);
std_g_avg=mean(std_g);


figure(23);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(23,'Position',[xfig,yfig,xsize,ysize]);end
subplot(3,1,1:2);
plot(tp(1:nseg),seg_acc_g,tp(1:nseg),mn_g,'.k');grid;
% title(titleTextf,'Interpreter','none')
title(fn,'Interpreter','none')
ylabel('Mag Accel (g)');
v=axis;v(3)=0;v(4)=vg;axis(v);
text(tp(nseg)*0.75,v(4)*0.9,['mean=',num2str(mn_g_avg,3),'g-rms']);
subplot(3,1,3)
plot(tp(1:nseg),std_g);grid;
ylabel('STD Accel (g)');
xlabel('Time (sec)');
v=axis;v(3)=0;v(4)=vgs;axis(v);
text(tp(1),v(4)*0.9,['average std dev=',num2str(std_g_avg,3),'g-rms']);


for i=1:nst
    tv=find(tp>=stime(i));
    idx_st(i)=tv(1);
    [maxg_seg(i),idx_maxg(i)]=max(maggyro_dps(idx_st(i):idx_st(i)+nseg));
    idx_start(i)=idx_st(i)+idx_maxg(i)-nseg_half;
    idx_end(i)=idx_st(i)+idx_maxg(i)+nseg_half-1;
    seg_acc_g(:,i)=magaccel_g(idx_start(i):idx_end(i),:);
    seg_gyr_dps(:,i)=maggyro_dps(idx_start(i):idx_end(i),:);
end

mn_dps=mean(seg_gyr_dps,2);
mn_dps_avg=mean(mn_dps);
std_dps=std(seg_gyr_dps,0,2);
std_dps_avg=mean(std_dps);

figure(24);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(24,'Position',[xfig,yfig,xsize,ysize]);end
subplot(3,1,1:2);
plot(tp(1:nseg),seg_gyr_dps,tp(1:nseg),mn_dps,'.k');grid;
% title(titleTextf,'Interpreter','none')
title(fn,'Interpreter','none')
ylabel('Mag Angular Rate (deg/sec)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
v=axis;v(3)=0;v(4)=vr;axis(v);
text(tp(nseg)*0.75,v(4)*0.9,['mean=',num2str(mn_dps_avg,3),'deg/sec-rms']);
subplot(3,1,3)
plot(tp(1:nseg),std_dps);grid;
ylabel('STD Rate (deg/sec)');
xlabel('Time (sec)');
v=axis;v(3)=0;v(4)=vrs;axis(v);
text(tp(1),v(4)*0.9,['average std dev=',num2str(std_dps_avg,3),'deg/sec-rms']);




% Allow user to adjust graphs before saving plots to Powerpoint
% disp(' ')
% disp('**************************************************************************')
% disp('*    Do you want to save plots to Powerpoint?                            *')
% disp('*    Adjust plots as necessary before you type "y" below                 *')
% disp('**************************************************************************')
% yn=input('save ppt (y/n) ? ','s');
% if strcmp(yn,'y')
%     fntext=fn;
%     fn_ppt=fntext;%[fntext,'_'];%[PathName,fntext];
%     fn_ppt='test.ppt';%[PathName,'test.ppt'];
%     if 1,
%         if nsamp>0
%             iplot=[23,24];
%         else
%             iplot=[23,24];
%         end
%         for i=iplot
%         figure(i)
%         %saveppt2(fn_ppt,'scale','title','d','meta') % this puts plots in fn_ppt
%         saveppt2(fn_ppt,'scale','title','padding',[0,0,17,26],'d','meta') 
%         % this makes plots the right size in a blank ppt file
%         %saveas(gcf,['fig',num2str(i),'.fig']) % this saves .fig files
%         end
%         disp(['Results file "',fn_ppt,'.ppt" was created '])
%         %disp([PathName])
%     end
% end

