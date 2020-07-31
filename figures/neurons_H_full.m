clear;clc;
load H_neurons_full; load LMH; load te_results;
[M T n]=size(redundancyf);

figure(1) % incoming transfer entropy for H neurons as a function of time
imagesc(mean(te,3)')
figure(2) %average transfer entropy to H neurons from H, L and M neurons
plot(times,mean(mean(te(:,:,indH),3),2)','k')
hold on
plot(times,mean(mean(te(:,:,indL),3),2)','b')
plot(times,mean(mean(te(:,:,indM),3),2)','r')

% M è imax multiplet size. Start with the pair, then triplet, etc. 

% T total number of times; 
% n=number of H neurons

%averaged behavior

figure(3);subplot(2,1,1);plot(times,mean(redundancyf,3)')
%figure(4);
subplot(2,1,2);plot(times,mean(synergyf,3)')

gg=ones(169,1);gg(indL)=2;gg(indM)=3;
for t=1:13
    for g=1:52
        A(t,g,1:10)=gg(ddf{t,g});
    end
end
for t=1:13
    for g=1:52
        A1(t,g,1:10)=gg(ddf1{t,g});
    end
end

%find max
for i=1:52
    rr=squeeze(sum(redundancyf(:,:,i),1));
    [gr(i), deltar(i)]=max(rr);
    ss=squeeze(sum(synergyf(:,:,i),1));
    [gs(i), deltas(i)]=max(ss);
end

deltar(4)=6;deltar(10)=6;deltar(49)=6;deltar(21)=9;deltar(24)=5;
figure(4)
%hist(deltar,13) latencies of max red
x=[4 5 6 7  9];y=[4    13    29     4        2 ];subplot(1,2,1);bar(times(x),y)
%figure(6)
%hist(deltas,6) latencies of max syn
x=[4 5 6 7 8 9];y=[4     9    28     7     2     2];subplot(1,2,2);bar(times(x),y)
%now all the maxima

for i=1:52
    dr(i,:)=ddf{deltar(i),i};
    red(i,:)=squeeze(redundancyf(:,deltar(i),i))';
    syn(i,:)=squeeze(synergyf(:,deltas(i),i))';
    ds(i,:)=ddf1{deltas(i),i};
end

vv=ones(169,1);vv(indL)=2;vv(indM)=3;
for i=1:52;for j=1:10
    dr(i,j)=vv(dr(i,j));
    ds(i,j)=vv(ds(i,j));
    end
end

for h=1:10;RR(1,h)=length(find(dr(:,1:h)==1))/(52*h);end
for h=1:10;RR(2,h)=length(find(dr(:,1:h)==2))/(52*h);end
for h=1:10;RR(3,h)=length(find(dr(:,1:h)==3))/(52*h);end

for h=1:10;SS(1,h)=length(find(ds(:,1:h)==1))/(52*h);end
for h=1:10;SS(2,h)=length(find(ds(:,1:h)==2))/(52*h);end
for h=1:10;SS(3,h)=length(find(ds(:,1:h)==3))/(52*h);end

figure(5);subplot(1,2,1);plot(2:10,RR(1,2:10)','k');hold on;plot(2:10,RR(2,2:10)','b');plot(2:10,RR(3,2:10)','r');
subplot(1,2,2);plot(2:10,SS(1,2:10)','k');hold on;plot(2:10,SS(2,2:10)','b');plot(2:10,SS(3,2:10)','r');



clear;clc;load figura_multipletto
figure(6)
subplot(1,2,1);
xlim([2.5 8.5]);xticks([3 4 5 6 7 8]);
plot(3:8,RR0(3:8),'k*');hold on; plot(3:8,R(:,3:8)','*r');
subplot(1,2,2);
xlim([2.5 6.5]);xticks([3 4 5 6]);
plot(3:6,SS0(3:6),'k*');hold on; plot(3:6,S(:,3:6)','*r');
