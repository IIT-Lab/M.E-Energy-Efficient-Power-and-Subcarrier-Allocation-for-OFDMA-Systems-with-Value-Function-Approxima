%%%%%%%%���ڵ�����ͬ�û�ʵʱ�İ��������ʣ��Կ��ٴﵽ�ȶ���״̬��Ѱ�Һ��ʵ�������%%%%%%%%%%%%%

function lamda_k=adjust_lamda_k(lamda_k,N_Q,I,tao,l,inter_gene_counter)
inter_l_counter=0;
            if inter_gene_counter>I
                if ((lamda_k(1)*tao<0.99)&&(lamda_k(2)*tao<0.99))%��ֹ�����ʹ���
                temp_1=ceil((N_Q+1)/3);
                temp=(temp_1+1)^2;
           %%%%%%%%%%�ֲ��ϵ�%%%%%%%%%%%%%%%%
           for micro_row=1:temp
               inter_l_counter=inter_l_counter+l(micro_row);
           end
           
           if (inter_l_counter/(sum(l)))>0.2
               lamda_k=lamda_k+0.3;%0.05
           end
           
           temp=l(1)+l(2)+l(5)+l(10)+l(17);
           if (temp/(sum(l)))>0.07%�û�2�����ʲ���ʱ���������ʿ�������
               lamda_k(1)=lamda_k(1)+0.1;%0.02
           end
           
           temp=l(1)+l(3)+l(7)+l(13)+l(21);
           if (temp/(sum(l)))>0.07%�û�1�����ʲ���ʱ���������ʿ�������
               lamda_k(2)=lamda_k(2)+0.1;%0.02
           end
           
           if ((lamda_k(1)>5)&&(lamda_k(2)>5)) 
               temp=l(36)+l(42)+l(55)+l(48)+l(49)+l(56)+l(63)+l(62)+l(64);
           if (temp/(sum(l)))>0.16%�û�1�����ʹ������ʱ���������ʿ��ټ�С
               lamda_k=lamda_k-0.3;%0.06
           end
           
                temp=l(50)+l(51)+l(52)+l(53)+l(54)+l(55)+l(56)+l(64);
           if (temp/(sum(l)))>0.17%�û�2�����ʹ������ʱ���������ʿ��ټ�С
               lamda_k(2)=lamda_k(2)-0.2;%0.03
           end
           
                temp=l(1)+l(3)+l(7)+l(13)+l(21)+l(31)+l(43)+l(57);
           if (temp/(sum(l)))>0.17%�û�1�����ʹ������ʱ���������ʿ��ټ�С
               lamda_k(1)=lamda_k(1)-0.2;%0.03
           end
     %%%%%%%%���½ǣ����Ͻǵ����ʵ��Ż�%%%%%%%%%
              temp=l(37)+l(38)+l(50)+l(51);
           if (temp/(sum(l)))>0.1%�û�1�����ʹ������ʱ���������ʿ��ټ�С
               lamda_k(1)=lamda_k(1)+0.2;%0.03
               lamda_k(2)=lamda_k(2)-0.2;%0.03
           end
           
              temp=l(57)+l(58)+l(43)+l(44);
           if (temp/(sum(l)))>0.1%�û�1�����ʹ������ʱ���������ʿ��ټ�С
               lamda_k(1)=lamda_k(1)-0.2;%0.03
               lamda_k(2)=lamda_k(2)+0.2;%0.03
           end 
           end
           
       %%%%%%%%%%�����ʹ��ߵĳͷ�%%%%%%%%%%%%%%%% 
                if (lamda_k(1)*tao)>0.96
                    lamda_k(1)=lamda_k(1)-30;%10
                end
                if (lamda_k(2)*tao)>0.96
                    lamda_k(2)=lamda_k(2)-30;%10
                end          
           %%%%%%%%%%�ֲ��µ�������%%%%%%%%%%%%%%%% 
               %%%%%%%%%%�����ʹ��͵Ĳ���%%%%%%%%%%%%%%%% 
                if (lamda_k(1)*tao)<0.05
                    lamda_k(1)=lamda_k(1)+5;
                end
                if (lamda_k(2)*tao)<0.05
                    lamda_k(2)=lamda_k(2)+5;
                end
           %%%%%%%%%%�ֲ��µ�%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%������ǰ���״̬��ʱ��Ϊ0���޲�%%%%%%%%%%%%%%%%%%% 
        if inter_gene_counter>1.5*I
            [l_max l_max_index]=max(l);
            [l_min l_min_index]=min(l);
            if (((l_min/l_max)==0)&&(l_min_index<l_max_index))
               lamda_k=lamda_k-0.6; 
            end
        end
        %%%%%%%%%%%%%%%%%�޲�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end