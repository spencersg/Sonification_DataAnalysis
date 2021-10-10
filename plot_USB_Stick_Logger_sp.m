% plot_USB_Stick_Logger
% Use read_big_hex_file to bring in the data and create .mat files
% This program reads and plots the .mat files

close all;clear all;
set(0,'DefaultLineLineWidth',1.5);
LargePlots=1;% 1=make larger plots, 0=make normal Matlab plots
showFilter = 0;% 1=plot filtered result on top of unfiltered, 0= don't
smoothPSD = 0;% 1=plot a moving average version of the PSD so that levels can be read precisely
di=1;% for huge files plot every di'th point (can't see more than 1920 per plot)
dipsd=1;% for PSDs use every dipsd'th point 

Ts=1/4000;% sample rate
fp=1.0;zp=.7;% filter spec, fp=2nd order filter pole freq, zp=pole damping
fs=1/Ts/dipsd;% sample rate to be used for fft
freqResolution = 0.1;% Hz
l=1;% index to start freq, use this to ignore the first nonzero freq which often
% contains a large part of the very low freq noise, i.e., set l=2
f0 = freqResolution*100;% smooth frequencies above this freq for PSDs
r2d=180/pi;d2r=pi/180;
%gscale=16;

% Input file name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% Data file name. Files contain accel_g gyro_dps TempC
% fn='141110MPU6k_250dps_4g_CaliforniaScreamin_10min_01';
% fn='141110MPU6k_250dps_4g_CaliforniaScreamin_10min_02';
% fn='141110MPU6k_250dps_4g_CaliforniaScreamin_10min_03';
% fn='141110MPU6k_250dps_4g_CaliforniaScreamin_10min_04';
fn=uigetfile('*.*');%tstart=15;tstop=60;
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

if ~exist('fn','var')
    fn = uigetfile('*.mat');% <-- GUI input
    idot = findstr(fn,'.');
    fn = fn(1:idot-1);
end
disp(['Reading ',fn])
tic;eval(['load ',fn]);toc


n=length(TempC);
t=(0:n-1)'*Ts;% make time vector
tp=t(1:di:end);

% Integrate gyro rates
% att=detrend(trap_int(gyro_dps,Ts));
att=(trap_int(gyro_dps,Ts))*4; %180227sg TEMPORARY 4x due to repeated data at 4kHz
% att=(trap_int(gyro_dps-ones(max(size(gyro_dps)),1)*mean(gyro_dps(95/Ts:105/Ts,:)),Ts));
% att=(trap_int(gyro_dps-ones(max(size(gyro_dps)),1)*[-2.7,0,-1.74],Ts));

% Statistics
mu_accel_g=mean(accel_g);
sig_accel_g=std(accel_g);
mu_gyro_dps=mean(gyro_dps);
sig_gyro_dps=std(gyro_dps);
sig_att_deg=std(att);

% Filter data
if showFilter
    Ts1=Ts*di;
    wp=2*pi*fp;zwTp=zp*wp*Ts1;wdTp=wp*sqrt(1-zp^2)*Ts1;
    Num=[1,0,0];
    Den=[-2*exp(-zwTp)*cos(wdTp), exp(-2*zwTp)];
    Num=Num*((1+sum(Den))/sum(Num));
    accel_gf=accel_g(1:di:end,:);
    gyro_dpsf=accel_gf;
    TempCf=accel_gf(:,1);
    n1=length(tp);
    k=0;
    x=mean(accel_g(1:di:1/Ts,:))/sum(Num);% initialize to steady state based on 1st sec
    x1=x;
    y=mean(gyro_dps(1:di:1/Ts,:))/sum(Num);
    y1=y;
    z=mean(TempC(1:di:1/Ts))/sum(Num);
    z1=z;
    for i=1:di:n
        k=k+1;
        x2=x1;x1=x;
        x=accel_g(i,:)-Den(1)*x1-Den(2)*x2;
        accel_gf(k,:)=Num(1)*x+Num(2)*x1+Num(3)*x2;
        y2=y1;y1=y;
        y=gyro_dps(i,:)-Den(1)*y1-Den(2)*y2;
        gyro_dpsf(k,:)=Num(1)*y+Num(2)*y1+Num(3)*y2;
        z2=z1;z1=z;
        z=TempC(i,:)-Den(1)*z1-Den(2)*z2;
        TempCf(k,:)=Num(1)*z+Num(2)*z1+Num(3)*z2;
    end
    att_norm_dps=sqrt(att.*att*[1;1;1]);
    magaccel_gf=sqrt(accel_gf.*accel_gf*[1;1;1]);
    maggyro_dpsf=sqrt(gyro_dpsf.*gyro_dpsf*[1;1;1]);
end

% Figure size and location settings
xfig=150;yfig=300;% figure location
dx=25;dy=-25;% change in figure location for succeding figures
xsize=900;ysize=550;% figure size
datestr1=datestr(clock);
titleText=['USB Stick Logger, fileName = ',fn];
titleTextf=['USB Stick Logger, Filter: fp=',num2str(fp),', zp=',num2str(zp),', fileName = ',fn];

figure(1);clf
if LargePlots, set(1,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    plot(tp,accel_g(1:di:end,:),tp,accel_gf);grid
    title(titleTextf,'Interpreter','none')
else
    plot(tp,accel_g(1:di:end,:));grid
    title(titleText,'Interpreter','none')
end
%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
xlabel('Time (sec)');ylabel('Acceleration (g)')
legend(['x, \mu= ',num2str(mu_accel_g(1),3),', \sigma=',num2str(sig_accel_g(1),3)],...
    ['y, \mu= ',num2str(mu_accel_g(2),3),', \sigma=',num2str(sig_accel_g(2),3)],...
    ['z, \mu= ',num2str(mu_accel_g(3),3),', \sigma=',num2str(sig_accel_g(3),3)])
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

figure(2);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(2,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    subplot(311);plot(tp,accel_g(1:di:end,1),tp,accel_gf(:,1),'c');grid;
    title(titleTextf,'Interpreter','none')
else
    subplot(311);plot(tp,accel_g(1:di:end,1));grid;
    title(titleText,'Interpreter','none')
end
ylabel('x accel (g)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
if showFilter
    subplot(312);plot(tp,accel_g(1:di:end,2),tp,accel_gf(:,2),'c');grid;
else
    subplot(312);plot(tp,accel_g(1:di:end,2));grid;
end
ylabel('y accel (g)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
if showFilter
    subplot(313);plot(tp,accel_g(1:di:end,3),tp,accel_gf(:,3),'c');grid;
else
    subplot(313);plot(tp,accel_g(1:di:end,3));grid;
end
ylabel('z accel (g)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
xlabel('Time (sec)');
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

magaccel_g=sqrt(accel_g.*accel_g*[1;1;1]);
max_accel_g=max(magaccel_g)
figure(21);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(21,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    subplot(311);plot(tp,magaccel_g(1:di:end,:),tp,magaccel_gf,'c');grid;
else
    subplot(311);plot(tp,magaccel_g(1:di:end,:));grid;
end
title(titleTextf,'Interpreter','none')
ylabel('Mag Accel (g)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])

maggyro_dps=sqrt(gyro_dps.*gyro_dps*[1;1;1]);
max_gyro_dps=max(maggyro_dps)
if showFilter
    subplot(312);plot(tp,maggyro_dps(1:di:end,:),tp,maggyro_dpsf,'c');grid;
else
    subplot(312);plot(tp,maggyro_dps(1:di:end,:));grid;
end
ylabel('Mag Angular Rate (deg/sec)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])

% subplot(313);plot(tp,unwrap(att(1:di:end,:)));grid;
subplot(313);plot(tp,(att(1:di:end,:))/360);grid; 
ylabel('Attitude (Revs)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
xlabel('Time (sec)');
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');
legend('x','y','z','Orientation','Horizontal')

%%%%%%%%%%%%%%
if showFilter
%     att_norm_dps=sqrt(att.*att*[1;1;1]);
%     magaccel_gf=sqrt(accel_gf.*accel_gf*[1;1;1]);
%     maggyro_dpsf=sqrt(gyro_dpsf.*gyro_dpsf*[1;1;1]);

    figure(22);clf
    if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(22,'Position',[xfig,yfig,xsize,ysize]);end
    subplot(311);plot(tp,magaccel_gf);grid;
    title(titleTextf,'Interpreter','none')
    ylabel('Mag Accel (g)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])

    subplot(312);plot(tp,maggyro_dpsf);grid;
    ylabel('Mag Angular Rate (deg/sec)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])

    subplot(313);plot(tp,(att(1:di:end,:))/360);grid;
    ylabel('Attitude (Revs)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
    xlabel('Time (sec)');
%     text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');
    legend('x','y','z',3,'Orientation','Horizontal')
%     subplot(313);plot(tp,(att_norm_dps(1:di:end,:))/360);grid;
%     ylabel('Mag Attitude (Revs)');%v=axis;axis([v(1:2) max(v(3),-gscale) min(v(4),gscale)])
%     xlabel('Time (sec)');
%     text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');
end;

figure(3);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(3,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    plot(tp,gyro_dps(1:di:end,:),tp,gyro_dpsf);grid
    title(titleTextf,'Interpreter','none')
else
    plot(tp,gyro_dps(1:di:end,:));grid
    title(titleText,'Interpreter','none')
end
xlabel('Time (sec)');ylabel('Angular Rate (deg/sec)')
legend(['x, \mu= ',num2str(mu_gyro_dps(1),3),', \sigma=',num2str(sig_gyro_dps(1),3)],...
    ['y, \mu= ',num2str(mu_gyro_dps(2),3),', \sigma=',num2str(sig_gyro_dps(2),3)],...
    ['z, \mu= ',num2str(mu_gyro_dps(3),3),', \sigma=',num2str(sig_gyro_dps(3),3)])
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

figure(4);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(4,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    subplot(311);plot(tp,gyro_dps(1:di:end,1),tp,gyro_dpsf(:,1),'c');grid;
    title(titleTextf,'Interpreter','none')
else
    subplot(311);plot(tp,gyro_dps(1:di:end,1));grid;
    title(titleText,'Interpreter','none')
end
ylabel('x gyro (deg/sec)')
if showFilter
    subplot(312);plot(tp,gyro_dps(1:di:end,2),tp,gyro_dpsf(:,2),'c');grid;
else
    subplot(312);plot(tp,gyro_dps(1:di:end,2));grid;
end
ylabel('y gyro (deg/sec)')
if showFilter
    subplot(313);plot(tp,gyro_dps(1:di:end,3),tp,gyro_dpsf(:,3),'c');grid;
    title(titleTextf,'Interpreter','none')
else
    subplot(313);plot(tp,gyro_dps(1:di:end,3));grid;
    title(titleText,'Interpreter','none')
end
ylabel('z gyro (deg/sec)')
xlabel('Time (sec)');
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

figure(5);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(5,'Position',[xfig,yfig,xsize,ysize]);end
subplot(311);plot(tp,att(1:di:end,1));grid;
title(titleText,'Interpreter','none')
ylabel('x Attitude (deg)')
subplot(312);plot(tp,att(1:di:end,2));grid;
ylabel('y Attitude (deg)')
subplot(313);plot(tp,att(1:di:end,3));grid;
ylabel('z Attitude (deg)')
xlabel('Time (sec)');
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

figure(6);clf
if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(6,'Position',[xfig,yfig,xsize,ysize]);end
if showFilter
    subplot(211)
    plot(tp,TempC(1:di:end),tp,TempCf,'c');grid
    title(titleTextf,'Interpreter','none')
    ylabel('Temperature ( \circC)')
    subplot(212);plot(tp,TempCf*9/5+32);grid
    ylabel('Temperature ( \circF)')
else
    plot(tp,TempC(1:di:end));grid
    title(titleText,'Interpreter','none')
    ylabel('Temperature ( \circC)')
end
xlabel('Time (sec)');
% text(0.01, 0.01,[datestr1,' CDI'],'units','normalized','VerticalAlignment','Baseline');

if (0)
nfft = round(fs/freqResolution);% the size of the sample to FFT
noverlap=nfft/2;
WINDOW=hanning(nfft);%window(@blackman,nfft);%[];%ones(nfft,1);%
np=length(gyro_dps(1:dipsd:end,1));
nsamp=1+floor((np-nfft)/(nfft-noverlap));% number of FFTs averaged
nsamp_pntsUsed=[nsamp nfft+(nfft-noverlap)*(nsamp-1)];
if nsamp>0 %>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Ys=[];
    myis=[];% mean of raw data
    syis=[];% std of detrended data
    for ax=1:6
        if ax<4
            y=accel_g(1:dipsd:end,ax);
        elseif ax<7
            y=gyro_dps(1:dipsd:end,ax-3);
        end
        myi=mean(y);
        yi=detrend(y);
        syi=std(yi);
        myis=[myis,myi];
        syis=[syis,syi];
        [Y,ff] = pwelch(yi,WINDOW,noverlap,nfft,fs);
        Ys=[Ys,Y];
    end
    f = ff(2:end);
    Ys = Ys(2:end,:);
    % Generate cumulative sums 
    sY=sqrt(trap_int(Ys(l:end,:),f(1)));% 
    rsY=sqrt(flipud(trap_int(flipud(Ys(l:end,:)),f(1))));
    
    % Smooth PSDs
    if smoothPSD
        Ysmooth = movavgLog(f,Ys,f0);
    else
        Ysmooth = Ys;
    end
    
    % PSD plots
    titleText2=['fs=',num2str(fs,5),'Hz, NFFT=',int2str(nfft),', nsamp=',int2str(nsamp)];
    
    figure(11);clf
    if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(11,'Position',[xfig,yfig,xsize,ysize]);end
    subplot(211);
    loglog(f(l:end),sqrt(Ysmooth(l:end,1:3))*1e3);grid;
    v=axis;axis([v(1) f(end) max(v(3),1e-2) min(v(4),1e4)])
    ylabel('Accel PSDs (mg/\surdHz)');
    title(['Accels, ',fn],'Interpreter','none')
    legend('x','y','z','Orientation','Horizontal')
    subplot(212);
    semilogx(f(l:end),sY(:,1:3)*1e3);grid
    hold on
    semilogx(f(l:end),rsY(:,1:3)*1e3,'--')
    hold off
    v=axis;axis([v(1) f(end) v(3:4)])
    text(f(end),sY(end,1)*1e3,[' ',num2str(sY(end,1)*1e3,3)])
    text(f(end),sY(end,2)*1e3,[' ',num2str(sY(end,2)*1e3,3)])
    text(f(end),sY(end,3)*1e3,[' ',num2str(sY(end,3)*1e3,3)])
    ylabel('Accel PSD Cum Sum (mg RMS)');
    xlabel('Frequency (Hz)');
    title(titleText2)
        
    figure(12);clf
    if LargePlots, xfig=xfig+dx;yfig=yfig+dy;set(12,'Position',[xfig,yfig,xsize,ysize]);end
    subplot(211);
    loglog(f(l:end),sqrt(Ysmooth(l:end,4:6)));grid;
    v=axis;axis([v(1) f(end) max(v(3),1e-4) min(v(4),1e2)])
    ylabel('Gyro PSDs (deg/sec/\surdHz)');
    title(['Gyro Rate, ',fn],'Interpreter','none')
    legend('x','y','z','Orientation','Horizontal')
    subplot(212);
    semilogx(f(l:end),sY(:,4:6));grid
    hold on
    semilogx(f(l:end),rsY(:,4:6),'--')
    hold off
    v=axis;axis([v(1) f(end) v(3:4)])
    text(f(end),sY(end,4),[' ',num2str(sY(end,4),3)])
    text(f(end),sY(end,5),[' ',num2str(sY(end,5),3)])
    text(f(end),sY(end,6),[' ',num2str(sY(end,6),3)])
    ylabel('Gyro PSD Cum Sum (deg/sec RMS)');
    xlabel('Frequency (Hz)');
    title(titleText2)
end %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

drawnow
stop;

% Allow user to adjust graphs before saving plots to Powerpoint
disp(' ')
disp('**************************************************************************')
disp('*    Do you want to save plots to Powerpoint?                            *')
disp('*    Adjust plots as necessary before you type "y" below                 *')
disp('**************************************************************************')
yn=input('save ppt (y/n) ? ','s');
if strcmp(yn,'y')
    fntext=fn;
    fn_ppt=fntext;%[fntext,'_'];%[PathName,fntext];
    %fn_ppt='test.ppt';%[PathName,'test.ppt'];
    if 1,
        if nsamp>0
            iplot=[1:6 11 12 21];
        else
            iplot=[1:6, 21];
        end
        for i=iplot
        figure(i)
        %saveppt2(fn_ppt,'scale','title','d','meta') % this puts plots in fn_ppt
        saveppt2(fn_ppt,'scale','title','padding',[0,0,17,26],'d','meta') 
        % this makes plots the right size in a blank ppt file
        %saveas(gcf,['fig',num2str(i),'.fig']) % this saves .fig files
        end
        disp(['Results file "',fn_ppt,'.ppt" was created '])
        %disp([PathName])
    end
end

end %if(0)
