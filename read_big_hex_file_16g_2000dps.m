% read_big_hex_file
% Uses fgetl to read 30 min chunks at a time and save chunks as .mat files
% Use separate program to plot .mat files
close all;clear all;set(0,'DefaultLineLineWidth',1.5);
Ts=1/4000;% sample rate
accel_scale = (16/32767);% 4 g full scale
gyro_scale  = (2000/32767);% 250 deg/sec full scale
tenSec = round(10/Ts);
chunkSize = 10;% minutes
imax = round(chunkSize*60/Ts);% dimensions for chunkSize min

% Input file name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% fn = 'TCOM_12m_Octcollect.rtf';
fn = uigetfile('*.rtf');
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

idot=findstr(fn,'.');
fn_no_ext=fn(1:idot-1);

disp('*************************************************************************')
disp(['Reading and parsing file: ',fn_no_ext])
fid=fopen(fn);% open the file 
for i=1:8
    line1=fgetl(fid);% read a line, first 7 lines have info about file
    %disp(line1)
end

done=0;chunk=0;
while ~done
    chunk=chunk+1;
    disp(['Working on ',int2str(chunkSize),' min chunk ',int2str(chunk),': 10''s of sec read'])
    tic
    dat=zeros(imax,7);
    %                             1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
    %\par \cf2 00000010  \cf1 A5 06 B0 FD A0 36 C0 E8 10 FE 8F FF B7 FD 28 01
    %123456789 123456789 123456789 123456789 123456789 123456789 123456789 12345
    %         1         2         3         4         5         6         7
    n=imax;
    for i=1:imax
        line1=fgetl(fid);
        if length(line1)<72 %| (chunk==3 && i==1000)% end of file
            n=i-1;
            done=1;
            break
        end
        for k=1:7 
            kk=29+6*(k-1);
            dat(i,k)=hex2dec_jh([line1(kk:kk+1),line1(kk+3:kk+4)]);
        end
        if rem(i,tenSec)==0, 
            fprintf('%4i',round(i/tenSec))
        end
        if rem(i,20*tenSec)==0, fprintf('\n');end
    end
    fprintf('\n')
    dat=dat(1:n,:);% counts
    for i=1:7
        m=find(dat(:,i)>32768);
        dat(m,i)=dat(m,i)-65536;% 2s complement
    end
    % Scale 
    accel_g =dat(:,1:3)*accel_scale;% g's
    gyro_dps=dat(:,5:7)*gyro_scale;% deg/sec
    TempC   =dat(:,4)/340+36.53;% deg C
    toc
    
    chunkstr=int2str(chunk);
    if chunk<10, chunkstr=['0',chunkstr];end
    fnout=[fn_no_ext,'_',int2str(chunkSize),'min_',chunkstr];
    eval(['save ',fnout,' accel_g gyro_dps TempC'])
end
fclose(fid);% close the file 

