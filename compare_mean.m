% compare_mean.m
load SonAcc_TennisSwingIdeal_ideal.mat;

% stime = [6.4, 18.2];%seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonAcc_IdealGolfSwingTwo_ideal
% stime = [15.5, 21];%seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonAcc_IdealGolfSwing_ideal
stime = [53, 60];%seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonAcc_TennisSwingIdeal_ideal      USED
% stime = [3, 7.5, 11.5]; %seg_sec=1;vg=12;vr=1050;vgs=2;vrs=200; %SonAcc_SonAccSpenGolfSwing_ideal
% stime = [16, 22, 27, 34, 47, 63.5, 71.5, 79.5];%seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonAcc_MikeIdealGolfSwing_ideal
% stime = [14, 19, 24, 30, 36, 42, 48, 54.5, 60, 65.5]; %seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonG_MikeIdealGolfSwing_ideal     USED
% stime = [11, 13, 16, 18.5, 21, 23.5, 26, 28]; %seg_sec=3;vg=8;vr=950;vgs=2;vrs=200; %SonG_MomIdealTennisSwing_ideal


magaccel_gf=sqrt(accel_gf.*accel_gf*[1;1;1]);
magaccel_g=sqrt(accel_g_ideal.*accel_g_ideal*[1;1;1]);
max_accel_g=max(magaccel_g);
maggyro_dpsf=sqrt(gyro_dpsf.*gyro_dpsf*[1;1;1]);
maggyro_dps=sqrt(gyro_dps_ideal.*gyro_dps_ideal*[1;1;1]);
max_gyro_dps=max(maggyro_dps);
filter_on=boolean(0);
if (filter_on)
    magaccel_g=magaccel_gf;
    maggyro_dps=maggyro_dpsf;
end

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
mn_g_ideal=mean(seg_acc_g,2);
mn_dps_ideal=mean(seg_gyr_dps,2);




figure(33);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(23,'Position',[xfig,yfig,xsize,ysize]);end
subplot(3,1,1:2);
plot(tp(1:nseg),mn_g_ideal,tp(1:nseg),mn_g,'.k');grid; 
% title(titleTextf,'Interpreter','none')
% title(fn,'Interpreter','none')
ylabel('Mag Accel (g)');
legend('ideal','mean');
v=axis;v(3)=0;v(4)=vg;axis(v);
% text(tp(nseg)*0.01,v(4)*0.9,['mean=',num2str(mn_g_avg,3),'g-rms']);
subplot(3,1,3)
std_g_ideal=std(seg_acc_g,0,2);
std_g_avg_ideal=mean(std_g_ideal);
%disp((mn_g-mn_g_ideal)./ std_g_avg_ideal);
%z_acc_g=(mn_g_ideal-mn_g)./ std_g;
z_acc_g = abs(mn_g_ideal-mn_g);
plot(tp(1:nseg),z_acc_g);grid;
ylabel('Absolute Deviation');
xlabel('Time (sec)');
v=axis;v(3)=0;v(4)=vgs;axis(v);
% text(tp(1),v(4)*0.9,['Mean Absolute Deviation=',num2str(mean(abs(z_acc_g),1),3), 'g-rms']);

for i=1:nst
    tv=find(tp>=stime(i));
    idx_st(i)=tv(1);
    [maxg_seg(i),idx_maxg(i)]=max(maggyro_dps(idx_st(i):idx_st(i)+nseg));
    idx_start(i)=idx_st(i)+idx_maxg(i)-nseg_half;
    idx_end(i)=idx_st(i)+idx_maxg(i)+nseg_half-1;
    seg_acc_g(:,i)=magaccel_g(idx_start(i):idx_end(i),:);
    seg_gyr_dps(:,i)=maggyro_dps(idx_start(i):idx_end(i),:);
end
mn_dps_ideal=mean(seg_gyr_dps,2);


figure(34);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(24,'Position',[xfig,yfig,xsize,ysize]);end
subplot(3,1,1:2);
plot(tp(1:nseg),mn_dps_ideal,tp(1:nseg),mn_dps,'.k');grid; 
% title(titleTextf,'Interpreter','none')
% title(fn,'Interpreter','none')
ylabel('Mag Angular Rate (deg/sec)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
legend('ideal','mean');
v=axis;v(3)=0;v(4)=vr;axis(v);
% text(tp(nseg)*0.01,v(4)*0.9,['mean=',num2str(mn_dps_avg,3),'deg/sec-rms']);
subplot(3,1,3)
std_dps_ideal=std(seg_gyr_dps,0,2);
std_dps_avg_ideal=mean(std_dps_ideal);
z_gyr_dps=abs(mn_dps_ideal-mn_dps);
plot(tp(1:nseg),z_gyr_dps);grid;
ylabel('Absolute Deviation');
xlabel('Time (sec)');
v=axis;v(3)=0;v(4)=vrs;axis(v);
% text(tp(1),v(4)*0.9,['Mean Absolute Debiation=',num2str(mean(abs(z_gyr_dps),1),3), 'deg/sec-rms']);
