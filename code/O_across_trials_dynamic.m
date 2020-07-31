clear;clc
load spikes;load LMH;
[time,n_neur,ntrials]=size(spikes);
for t_ind=1:52
    t_index=indH(t_ind);
    ndmax=10;%maximum size of the multiplet
    step=1;
    time=1:step:time;
    for itime=19:31
        disp([t_index itime]);
        spike_instant=squeeze(spikes(itime,:,:));
        spike_instant1=squeeze(spikes(itime+1,:,:));
        t=copnorm(spike_instant1(t_index,:)');
        dt=copnorm(spike_instant(t_index,:)');
        ind=setdiff(1:n_neur,t_index);
        X=copnorm(spike_instant(ind,:)');
        
        [N, nvar]=size(X);
        % we explore all the pairs and get those with highest o_inf
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        o=-100;
        for i=1:nvar
            for j=1+i:nvar
                o1=o_if_1(t,dt,X(:,[i j]));
                if o1>o
                    o=o1;
                    dbest=[i j];
                end
            end
        end
        %now we add variables to the multplet by maximizing o_inf
        drivers=setdiff(1:nvar,dbest);
        nvar=nvar-2;
        nd=2;
        
        h=1;
        oif(h,itime-18,t_index)=o;
        while nd < ndmax
            o1=zeros(nvar,1);
            h=h+1;
            for k=1:nvar
                o1(k)=o_if_1(t,dt,X(:,[dbest drivers(k)]));
            end
            [o, i]=max(o1);oif(h,itime-18,t_index)=o;
            dbest=[dbest drivers(i)];drivers=setdiff(drivers,drivers(i));nd=nd+1;nvar=nvar-1;
            dd{itime-18,t_index}=dbest;
        end
        
        
        
        [N, nvar]=size(X);
        % we explore all the pairs and get those with lowest o_inf
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        o=100;
        for i=1:nvar
            for j=1+i:nvar
                o1=o_if_1(t,dt,X(:,[i j]));
                if o1<o
                    o=o1;
                    dbest=[i j];
                end
            end
        end
        %we add variables to the multiplet minimizing the o_inf
        drivers=setdiff(1:nvar,dbest);
        nvar=nvar-2;
        nd=2;
        %ndmax=10; %%%% max number of target variables
        h=1;
        oif1(h,itime-18,t_index)=o;
        while nd < ndmax
            o1=zeros(nvar,1);
            h=h+1;
            for k=1:nvar
                o1(k)=o_if_1(t,dt,X(:,[dbest drivers(k)]));
            end
            [o, i]=min(o1);oif1(h,itime-18,t_index)=o;
            dbest=[dbest drivers(i)];drivers=setdiff(drivers,drivers(i));nd=nd+1;nvar=nvar-1;
            dd1{itime-18,t_index}=dbest;
        end
    end
    
end

save results_full