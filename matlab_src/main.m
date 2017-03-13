%����---������
clc;
clear all;
[K,N_F,N_Q,tao,lamda_k,N_k_aver,belta,garma,I,delta_pre_thres,LOOPTIME,B_W,max_value]=parameters;
%K---�û�
%N_F---���ز�
%N_Q---����
%tao---ʱ϶���
%lamda_k---ҵ�񵽴�����
%N_k_aver---����ƽ������
%belta---�û�ʱ��Ȩ��(����)
%garma---lagrange multiplier
%I---I=(1+N_Q)^K
%delta_pre_thres---Ǳ�������������
%LOOPTIME---���ѭ������
%B_W---����
%max_value---ֵ����V������ֵ
%V_init_save---ֵ����V��ʼ���ı���
%h---�ŵ�����
%cixu---QSI��V�Ķ�Ӧ��ϵ
%endle_flag---����������־λ
%counter---����������ִ�еĴ���
%Q_next---t+1ʱ�̶��г���
%Arrival---�����û���ǰʱ϶����İ�������
%inter_gene_counter---�ڲ�ѭ������ͳ����
%micro_row---΢���������ʵ�ɨ����
%inter_l_counter---L�ķ�����ͳ��
%total_counter---ȫ�ֵ�������ͳ����
%remain_bits---һ���Ե�������ݱ��أ������ʣ�µĲ���һ���������ݣ��������´�����һ�������������
%
%
%

Q=floor(rand(1,2)*N_Q);
h=zeros(K,N_F);
for i=1:K
    for j=1:N_F
        aaa=GenerateRayleighChannel1;%��һ���ĸ������ŵ�
        h(i,j)=abs(aaa);%ȡ�ŵ�����
    end
end

%%%%%%%%%%%%ֵ���������ʼ��%%%%%%%%%%%%%%%%%%%%
%V_esti_1=rand(1,I)*max_value;
%V_esti=V_esti_1(randperm(length(V_esti_1)));
%V_esti(1)=0;

%V_esti=[0,279.463668183702,1710.07489190540,1578.44570185540,810.771773247104,1328.73643772950,1669.80481178555,1797.65903178103,1164.24495545234,370.550392795944,1541.35696449488,1555.87203971743,1280.20749597106,189.390208213976,1912.31670001309,751.425083093636,646.547959210641,1913.15275075484,1933.64850756216,666.969400181822,640.105488816475,1119.50510803526,352.232054952211,1292.38544763375,41.1546345503429,1778.25196913198,1797.51717930616,186.715248825780,1362.70060850537,799.816821399726,577.407580405499,327.688657734806,691.078089252745,363.091510175174,1111.03587016180,840.280287117567,1512.71646595267,1994.55476391157,1719.83218177439,1912.86960967610,600.278784705041,1912.34346229919,1139.00727334717,1704.34062767202,35.5505386965029,1898.33802459098,1536.51594788444,559.820748566301,282.706504609986,939.139108425858,1497.14729178105,805.850006693957,618.343201986542,1401.83707451021,63.9938374674660,1488.76932839357,1726.44366980837,295.330548047797,1635.42334779270,145.600866052693,1098.28697581901,328.333292818636,1504.67963235097,1739.82960993967];
V_esti=[0,279.463668183702,1710.07489190540,1578.44570185540,810.771773247104,1328.73643772950,1669.80481178555,1797.65903178103,1164.24495545234,370.550392795944,1541.35696449488,1555.87203971743,1280.20749597106,189.390208213976,1912.31670001309,751.425083093636,646.547959210641,1913.15275075484,1933.64850756216,666.969400181822,640.105488816475,1119.50510803526,352.232054952211,1292.38544763375,41.1546345503429];
V_init_save=V_esti;
%%%%%%%%��ʼ��V��״̬�Ķ�Ӧ����%%%%%%%%%%%
cixu=1:I;
endle_flag=0;
inter_gene_counter=0;
inter_l_counter=0;
total_counter=0;
remain_bits=[0 0];
Q_ave_2=zeros(1,300);
P_ave_2=zeros(1,300);
S_ave_2=zeros(1,300);
V_ave_2=zeros(1,300);
Q_ave_1=zeros(1,300);
P_ave_1=zeros(1,300);
S_ave_1=zeros(1,300);
V_ave_1=zeros(1,300);
for loop=1:LOOPTIME%���ѭ��
    
counter=0;%����Ǳ�������ĸ��¾���


%--Ǳ������С������ֵ������
    for gg=1:200%while(1)
    S_g_esti=zeros(1,I);
    S_V_esti=zeros(1,I);
    l=zeros(1,I);
    power_1=0;%һ�������������ڵ�ƽ������
    power_2=0;
    subcarrier_1=0;%һ�������������ڵ�ƽ�����ز�����
    subcarrier_2=0;
    Q_1=0;%ÿ�������������ڵ�ƽ���ӳ�
    Q_2=0;
    %--һ������������ִ�й���
        while(1)       
            [s,p,power,subcarriers]=allo_policy(Q,h,V_esti,cixu,K,N_F,tao,N_k_aver,garma);
           s;
           p;
           Q;
           
           Q_1=Q_1+Q(1);
           Q_2=Q_2+Q(2);
           power;
           subcarriers;
           l
           counter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ͬ��С�ķ������֮����������buffer����ƽ��N_k_aver�Ĵ�С�������
total_counter=total_counter+1;
%%%%%%%%΢�������û����ĵ�����%%%%%%%%%%%
%lamda_k=adjust_lamda_k(lamda_k,N_Q,I,tao,l,inter_gene_counter);
%%%%%%%%%΢������%%%%%%%%%%%%%%%%%%%%%%%            
            Arrival=zeros(1,K);%�����û����ĵ�������
            for i=1:K
                Arrival_pck=randsrc(1,1,[1,0;lamda_k(i)*tao,1-lamda_k(i)*tao]);%��lamda_k*tao�ĸ�������1����1-lamda_k*tao�ĸ�������0
                pck_size=exprnd(N_k_aver,1,1);%���ɷ���ָ���ֲ��������,exprnd(MU��m��n)����m��n��ʽ��ָ���ֲ������������
         %%%%%%%%%%%%%��������Ż������ε�������ݣ����ʣ��bits�����´�������ͣ�������һ����ȫ������������˷���Դ%%%%%%%%%%%%
         if Arrival_pck~=0%ֻ�е�ǰʱ϶�����ݵ���Ž��м��㣬���
 %               full_packets=floor((pck_size+remain_bits(i))/N_k_aver);
 %               remain_bits(i)=mod((pck_size+remain_bits(i)),N_k_aver);
                if i==1
                    Arrival(i)=2;
                else 
                    Arrival(i)=2;
                end     
         end
         %%%%%%%%%%%%%����Ż�����%%%%%%%%%%%%                  
            end
   %%%%%%%%%%%%%%%%%%%%%��ͼ���û�ʣ��bits%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
   %         user1_pac(total_counter)=remain_bits(1);
   %         user2_pac(total_counter)=remain_bits(2);
   %         figure(5);
   %         plot(user1_pac,'r');
   %         hold on;
   %         plot(user2_pac,'b');
   %         hold off;
   %         legend('\ituser1 bits remaind','\ituser2 bits remaind');
   %         title('Delay-Optimal Power and Subcarrier Allocation for OFDMA Systems');
   %         xlabel('slots');
   %         ylabel('user1&2 bits remaind with slots');
   %         grid on; 
            
            Q_next=queue_change(s,p,h,Q,Arrival,K,N_F,N_Q,tao,N_k_aver,B_W);
            index=tran_qstate_to_index(Q,cixu);
            index_next=tran_qstate_to_index(Q_next,cixu);
            

            g=sum(belta.*(Q./(lamda_k)))+garma*sum(sum(p));%--��������
            l(index)=l(index)+1;
            S_g_esti(index)=S_g_esti(index)+g;
            S_V_esti(index)=S_V_esti(index)+V_esti(index_next);
            
            Q=Q_next;
            
           for i=1:K
                for j=1:N_F
                    aaa=GenerateRayleighChannel1;
                    h(i,j)=abs(aaa);
                end
           end
           inter_gene_counter=inter_gene_counter+1; 
           power_1=power_1+power(1);
           power_2=power_2+power(2);
           subcarrier_1=subcarrier_1+subcarriers(1);
           subcarrier_2=subcarrier_2+subcarriers(2);
            if (((isempty(find(l==0))))&(endle_flag==0))
            %if (((isempty(find(l==0)))&&(isempty(find(l==1)))&&(isempty(find(l==2)))&&(isempty(find(l==3)))&&(isempty(find(l==4)))&&(isempty(find(l==5))))&(endle_flag==0))%isempty����Ϊ�գ�������ֵ                
                break;
            end
        end%end of while(1),����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        power_1=power_1/inter_gene_counter;%һ�������������ڵ�ƽ������
        power_2=power_2/inter_gene_counter;%һ�������������ڵ�ƽ������
        
        subcarrier_1=subcarrier_1/inter_gene_counter;%һ�������������ڵ�ƽ������
        subcarrier_2=subcarrier_2/inter_gene_counter;%һ�������������ڵ�ƽ������
        
        Q_1=Q_1/inter_gene_counter;%һ�������������ڵ�ƽ���Գ�
        Q_2=Q_2/inter_gene_counter;
        inter_gene_counter=0;%�����������ڣ�ͳ��������
        lamda_k=[1 1]*(lamda_k(1)+lamda_k(2))/2;
            if endle_flag==0
                step=50;        
                V_esti_med=V_esti;
                Y=zeros(1,I);
                [V_value V_index]=min(abs(V_esti-(sum(V_esti)/I)));
                referance_state=V_index;
                  for i=1:I
                     Y_ref(i)=S_g_esti(referance_state(1))/l(referance_state(1))+S_V_esti(referance_state(1))/l(referance_state(1))-V_esti(referance_state(1));
                     Y(i)=(S_g_esti(i)/l(i)+S_V_esti(i)/l(i)-V_esti(i))-Y_ref(i);
                     V_esti_med(i)=V_esti(i)+1/step*Y(i);  
                     
                     VV(i)=V_esti(referance_state(1))-V_esti(i);
                     S_G(i)=S_g_esti(i)/l(i)-S_g_esti(referance_state(1))/l(referance_state(1));
                     S_V(i)=S_V_esti(i)/l(i)-S_V_esti(referance_state(1))/l(referance_state(1));
 
                  end
               
%%%%%%%%%%%%%%%%��ͼ��ʼ%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure(2);                 
        x=1:I;

        plot(x,VV,'b',x,S_V,'k',x,S_G,'y',x,Y,'g',x,V_esti_med,'r');
        legend('\itVV','\itS_V','\itS_G','\itY');
        title('Delay-Optimal Power and Subcarrier Allocation for OFDMA Systems');
        xlabel('1:64');
        ylabel('Online Value Iteration');
 %       grid on;  
%%%%%%%%%%%%%%%%��ͼ����%%%%%%%%%%%%%%%%%%%%%%%%%%        
            end%end of(if endle_flag==0)

        delta_V_esti=norm((V_esti_med-V_esti),'fro');
        counter=counter+1;%�����������ۼ�
        
        
 %%%%%%%%%%%%%%%%��ͼ��ʼ%%%%%%%%%%%%%%%%%%%%%%%%%%       
        if endle_flag==0
            figure(3);
            delta_V_figure(counter)=delta_V_esti;  
%            p3=polyfit(counter,delta_V_figure,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3);
            plot(delta_V_figure);
            title('Value function''s minus between two adjacent generations');
            xlabel('generations');
            ylabel('\DeltaV');
  %          grid on; 
%%%%%%%%%%%%%%%%��ͼ����%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ʷ���ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            power_11(counter)=power_1;
            power_22(counter)=power_2;
            figure(1);
            
 %           p3=polyfit(counter,power_11,3);
 %           s3=polyval(p3,counter);
 %           plot(counter,s3,'r');
            
            plot(power_11,'r');
            hold on;
%            p3=polyfit(counter,power_22,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3,'b');
            plot(power_22,'b');
            hold off;
            legend('\itUser1','\ituser2');
 %           title('Power allocation of the two users.');
            xlabel('generations');
            ylabel('Power allocation of the two users');
  %          grid on;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%���ʷ���ͼ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ز�����ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            subcarrier_11(counter)=subcarrier_1;
            subcarrier_22(counter)=subcarrier_2;
            figure(4);
            
%            p3=polyfit(counter,subcarrier_11,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3,'r');
            
            plot(subcarrier_11,'r');
            hold on;
            
%            p3=polyfit(counter,subcarrier_22,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3,'b');
            
            plot(subcarrier_22,'b');
            hold off;
            legend('\itUser1','\ituser2');
%            title('Subcarriers allocation of the two users.');
            xlabel('generations');
            ylabel('Subcarriers allocation of the two users');
  %          grid on;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ز�����ͼ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%ʱ��ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Q_11(counter)=Q_1;
            Q_22(counter)=Q_2;
            figure(5);
            
%            p3=polyfit(counter,Q_11,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3,'r');
            
            plot(Q_11,'r');
            hold on;
            
%            p3=polyfit(counter,Q_22,3);
%            s3=polyval(p3,counter);
%            plot(counter,s3,'b');
            
            plot(Q_22,'b');
            hold off;
            legend('\itUser1','\ituser2');
%            title('Average delay of the two users.');
            xlabel('generations');
            ylabel('Average delay of the two users');
  %          grid on;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%ʱ��ͼ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            V_esti=V_esti_med;%*****%
        end
        
        
            if delta_V_esti<=delta_pre_thres%��������㷨ʱ�̣���־λ��1���������У�������
                endle_flag=1;
            %   break;
            end             
            
    end%end of while(1)    
end%end of for