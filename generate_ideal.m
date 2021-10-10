%generate_ideal.m
fn='SonAcc_SonAccSpenGolfSwing';
eval(['load ',fn,'_10min_01']);
accel_g_ideal=accel_g;
gyro_dps_ideal=gyro_dps;
Ts=1/4000;% sample rate
n=length(accel_g);
t=(0:n-1)'*Ts;% make time vector
t_ideal=t;
filter_on=boolean(1);

if (filter_on)
    tp=t;
    fp=1.0;zp=.7;% filter spec, fp=2nd order filter pole freq, zp=pole damping
    di=1;% for huge files plot every di'th point (can't see more than 1920 per plot)
    Ts1=Ts*di;
    wp=2*pi*fp;zwTp=zp*wp*Ts1;wdTp=wp*sqrt(1-zp^2)*Ts1;
    Num=[1,0,0];
    Den=[-2*exp(-zwTp)*cos(wdTp), exp(-2*zwTp)];
    Num=Num*((1+sum(Den))/sum(Num));
    accel_gf=accel_g(1:di:end,:);
    gyro_dpsf=accel_gf;
    n1=length(tp);
    k=0;
    x=mean(accel_g(1:di:1/Ts,:))/sum(Num);% initialize to steady state based on 1st sec
    x1=x;
    y=mean(gyro_dps(1:di:1/Ts,:))/sum(Num);
    y1=y;
    for i=1:di:n
        k=k+1;
        x2=x1;x1=x;
        x=accel_g(i,:)-Den(1)*x1-Den(2)*x2;
        accel_gf(k,:)=Num(1)*x+Num(2)*x1+Num(3)*x2;
        y2=y1;y1=y;
        y=gyro_dps(i,:)-Den(1)*y1-Den(2)*y2;
        gyro_dpsf(k,:)=Num(1)*y+Num(2)*y1+Num(3)*y2;
    end
end

eval(['save ',fn,'_ideal  t_ideal accel_g_ideal gyro_dps_ideal accel_gf gyro_dpsf']);