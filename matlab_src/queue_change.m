
%����--���ʡ����ز�����󣬸����û����г���

function Q_return=queue_change(s,p,h,Q,Arrival,K,N_F,N_Q,tao,N_k_aver,B_W)

%----����ÿ���û�����������rate
% i �к�--�û�
% j �к�--���ز�
rate=zeros(1,K);
RA=zeros(K,N_F);
 for i=1:K
   for j=1:N_F
       RA(i,j)=s(i,j)*B_W*log2(1+p(i,j)*abs(h(i,j))^2);   
   end
    rate(i)=sum(RA(i,:));
end
    
 %-----���¶��г���  
 queue=zeros(1,K);
 Q_return=zeros(1,K);
    for i=1:K
        if i==1
            chuli=1;%floor((rate(i)*tao)/N_k_aver);
        else
          chuli=1;
        end
        queue_med=Q(i)-chuli;%floor��������
        queue(i)=max(queue_med,0);
          Q_med=queue(i)+Arrival(i);
         Q_return(i)=min(Q_med,N_Q);
    end