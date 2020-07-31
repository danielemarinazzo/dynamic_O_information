clear;clc
clear;clc;
load H_neurons_full; load LMH; load te_results;
load spikes;
[time,n_neur,ntrials]=size(spikes);


t_index=7;% the target neuron that we consider

th=indH(t_index);
itime=24; %corresponding to 300 ms, the peak
nrun=300000;%the number of surrogates
    spike_instant=squeeze(spikes(itime,:,:));
    spike_instant1=squeeze(spikes(itime+1,:,:));
    t=copnorm(spike_instant1(th,:)');
    dt=copnorm(spike_instant(th,:)');
    ind=setdiff(1:n_neur,th);
    X=copnorm(spike_instant(ind,:)');
    
    indici_red=ddf{6,t_index};
    indici_syn=ddf1{6,t_index};
    
    [N, nvar]=size(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for j=3:10
    
        RR0(j)=o_if_1(t,dt,X(:,indici_red(1:j)));
        SS0(j)=o_if_1(t,dt,X(:,indici_syn(1:j)));
        for i=1:nrun
        Y=X(:,indici_red(j));b=4+1000*rand;b=round(b);Y=circshift(Y,b);
        RR(i,j)=o_if_1(t,dt,[X(:,indici_red(1:j-1)) Y]);
        Y=X(:,indici_syn(j));b=4+1000*rand;b=round(b);Y=circshift(Y,b);
        SS(i,j)=o_if_1(t,dt,[X(:,indici_syn(1:j-1)) Y]);
    end
 end

figure(1)
plot(RR0,'k*');hold on; plot(R','*r')
figure(2)
plot(S','*r');hold on;plot(SS0,'k*')

for h=3:10
    ps(h)=length(find(S(:,h)<SS0(h)))/nrun;
    pr(h)=length(find(R(:,h)>RR0(h)))/nrun;
end
%kkk
%end

%compute quantiles

for h=3:10
    x=RR(:,h);rm(h)=quantile(x,0.5);rn(h)=quantile(x,0.008);rp(h)=quantile(x,0.992);
    x=SS(:,h);sm(h)=quantile(x,0.5);sn(h)=quantile(x,0.008);sp(h)=quantile(x,0.992);
end
figure(1)
plot(3:10,RR0(3:10),'k*');hold on; errorbar(3:10,rm(3:10),rm(3:10)-rn(3:10),rp(3:10)-rm(3:10),'*r')
figure(2)
plot(3:10,SS0(3:10),'k*');hold on; errorbar(3:10,sm(3:10),sm(3:10)-sn(3:10),sp(3:10)-sm(3:10),'*r')

