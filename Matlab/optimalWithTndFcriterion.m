clc
clear all
%syms i
%char s
disp('Enter the plant dynamics form :')
disp('1- ODE ') 
disp('2- Transfer fnction ;' )
disp('3- SSM ;')
disp('4- Pole/zero Map ' ) 
a= input('');
if a==1
        count1 =0;
        disp ('Enter the output parameters of the ODE starting with the lowest order coefficient,when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count1=count1+1;
        end
        y=cellfun(@str2num,b(1:count1))
      
        count2 =0;
        disp ('Enter the input parameters of the ODE starting with the lowest order coefficient, when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count2=count2+1;              
        end
      u=cellfun(@str2num,b(1:count2)) 
      
      [A,B,C,D] = TF2SS(u,y);
end
 
 if a==2
        count1 =0;
        disp ('Enter the denominator parameters of the Transfer Function starting with the lowest order coefficient,when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count1=count1+1;
                     
        end
      y=cellfun(@str2num,b(1:count1))
      
        count2 =0;
        disp ('Enter the numerator parameters of the Transfer Function starting with the lowest order coefficient, when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count2=count2+1;
                     
        end
      u=cellfun(@str2num,b(1:count2))
      
     % G=tf(u,y)    
     [A,B,C,D] = TF2SS(u,y);

end

 if a==3
     disp ('Enter the size "n" of A such that A:n*n')
     n=input('');
     A=zeros(n);
     disp('Enter the A matrix coefficients row by row')
     for i=1:n
         for j=1:n
             A(i,j)=input('');
         end
     end
     disp ('Enter the column size "r" of B such that B:n*r')
     r=input('');
     B=zeros(n,r);
     disp('Enter the B matrix coefficients row by row')
     for i=1:n
         for j=1:r
             B(i,j)=input('');
         end
     end
     disp ('Enter the row size "m" of C such that C:m*n')
     m=input('');
     C=zeros(m,n);
     disp('Enter the C matrix coefficients row by row')
     for i=1:m
         for j=1:n
             C(i,j)=input('');
         end
     end
   
     D=zeros(m,r);
     disp('Enter the D matrix coefficients row by row D:m*r')
     for i=1:m
         for j=1:r
             D(i,j)=input('');
         end
     end
 end
 if a==4
        count1 =0;
        disp ('Enter the zeros,when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count1=count1+1;
                     
        end
        z=cellfun(@str2num,b(1:count1))
      
        count2 =0;
        disp ('Enter the poles, when done press q')

        for i=1:100
            b{i}=input('','s');   
                 if b{i}=='q'
                   break
                 end
            count2=count2+1;
                     
        end
        p=cellfun(@str2num,b(1:count2))
        disp ('Enter the gain factor k')
        k=input('')
        
        [A,B,C,D] = ZP2SS(z,p,k);
 end
 
 G=ss(A,B,C,D);

% Finding System's Poles to assess stability
P = eig(A);
disp('The Poles Of The System Are: ')
P

ma=max(size(A));
% Stability Test
for q=1:length(P)
    s=0;
    if real(P(q)) > 0
        s=s+1;
        fprintf('Mode %d (s = %d) is Unstable\n', q, P(q))
    else
        fprintf('Mode %d (s = %d) is Stable\n', q , P(q))
    end
end
if s==0
     fprintf('The System is Stable!\n\n')
     St=1;
     else fprintf('The System is Unstable!\n\n')
     St=0;
end
 
% Observability Test
d=0;
[rV,rD] = eig(A);
   for i=1:max(size(rV))
    test=C*rV(:,i);
    if test==0
        fprintf('Mode %d is Unobservable\n', i)
        fprintf('Mode %d is Not Detectable\n',i)
    else
        fprintf('Mode %d is Observable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Detectable\n',i)
             d=d+1;
        else
            fprintf('Mode %d is Not Detectable\n',i)
        end
    end

   end 
if d==max(size(rV))
    fprintf('The system is Detectable\n')
else
    fprintf('The system is Not Detectable\n')
end
O = obsv(A,C);
if rank(O) ~= ma
     fprintf('The System is Unobservable!\n\n')
     Ob=0;
else fprintf('The System is Observable!\n\n')
     Ob=1;
end
 
% Contrability Test
e=0;
[lV,lD] = eig(A');
for i=1:max(size(lV))
    test=(lV(:,i))'*B;
    if test==0
        fprintf('Mode %d is Uncontrollable\n', i)
        fprintf('Mode %d is Not Stabilizable\n',i)
    else
        fprintf('Mode %d is Controllable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Stabilizable\n',i)
            e=e+1;
        else
            fprintf('Mode %d is Not Stabilizable\n',i)
        end
    end
end
if e==max(size(rV))
    fprintf('The system is Stabilizable\n')
else
    fprintf('The system is Not Stabilizable\n')
end
Co=ctrb(A,B);
if rank(Co) ~= ma
     fprintf('The System is Uncontrollable!\n\n')
     CO=0;
     else fprintf('The System is Controllable!\n\n')
     CO=1;
end

% pole and zero plot
figure
pzplot(G),grid on

%Redesign and bad system
if St==1&&CO==0&&Ob==0
     fprintf('WARNING: CANNOT DESIGN A CONTROLLER FOR YOUR SYSTEM!!\n')
     return;
end
if St==0&&CO==0
     fprintf('WARNING: YOUR SYSTEM MUST BE REDESIGNED!!\n')
     return;    
end
% Changing the Performance of the Sytem
 tf = input('\nEnter the simulation period: \n');
 r = input('\nEnter the type of input "1" for "0" and "2" for "Unit Step function": \n');
 t=0:0.1:tf;
 if r==1
    r=0*t;
 else if r==2
         r=stepfun(t,0);
     end
 end
 disp('Enter Initial Conditions Xo: ')
 for i=1:max(size(A));
            xo(i)=input('');
 end
 
disp('To Change the Performance of the System Enter your choice: ')
disp('1 - State Feedback Control (SFC)')
disp('2 - State Estimation without State Feedback Control:FOO')
disp('3 - State Estimation with State Feedback Control:FOO & SFC')
disp('4 - State Estimation with State Feedback Control:ROO & SFC')
disp('5 - Optimal State Estimation with State Feedback Control:Optimal SFC & FOO')
c= input('Enter Your Choice:\n');

if c==1 % 1 - State Feedback Control (SFC)
    if CO == 0
      fprintf('WARNING: YOUR SYSTEM IS UNCONTROLLABLE!! YOU CANNOT CHANGE ITS PERFORMANCE!!\n')
      return;
    end
    disp('To Change the performance characteristics via SFC choose the method')
    disp('1 - Direct Pole Placement')
    disp('2 - Time & Frequency design criterions')
    m= input('Enter the desired methode:\n');
    if m==1  %1 - Direct Pole Placement
        disp('Enter the desired poles in complex "a+bi" form:')
        for i=1:length(P)
            a=input('Enter the real part "a" parameter: \n');
            b=input('Enter the imaginary part "b" parameter: \n');
            Pd(i)=complex(a,b);
        end
        %Pd=cellfun(@str2num,pd(1:lenght(P)))
        % State Feedback Control: Ackerman Formula 
        K=acker(A,B,Pd);
        % The Compensated System
        Ak = A-B*K;
        Gcl = ss(Ak,B,C,D);
        Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
        Gcl0sse = Gcl/Kdccl;
        % Simulation
        lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo)
    end
    
    if m==2   %2 - Time & Frequency design criterions
       c1=input('Enter your Choice "1" for "Time" and "2" for "Frequency" design criteria\n'); 
       if c1==1
          Mp = input('Enter the Overshoot factor Mp:\n');
          ts = input('Enter the Settling time ts:\n');
          x = log(Mp)^2;
          zeta = sqrt(x/(pi^2+x));
          wn = 5/(zeta*ts);
          Do=[1 2*zeta*wn wn^2];
          Pd = roots(Do); %Dominant Poles
          if max(size(Pk))<ma
            for q=1:ma-max(size(Pk))
                Pnk(q)=5*real(Pk(q));
            end
             Pk=[Pk;Pnk'];
          end
          % State Feedback Control: Ackerman Formula 
          K=acker(A,B,Pd);
          % The Compensated System
          Ak = A-B*K;
          Gcl = ss(Ak,B,C,D);
          Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
          Gcl0sse = Gcl/Kdccl;
          % Simulation        
          lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo)
       end
       if c1==2
          zeta = input('Enter the dapmping factor :\n');
          wn = input('Enter the natural frequency wn \n');
          Do=[1 2*zeta*wn wn^2];
          Pd = roots(Do); %Dominant Poles
          if max(size(Pk))<ma
            for q=1:ma-max(size(Pk))
                Pnk(q)=5*real(Pk(q));
            end
             Pk=[Pk;Pnk'];
          end
          % State Feedback Control: Ackerman Formula 
          K=acker(A,B,Pd);
          % The Compensated System
          Ak = A-B*K;
          Gcl = ss(Ak,B,C,D);
          Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
          Gcl0sse = Gcl/Kdccl;
          % Simulation        
          lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo)
       end
    end
end
if c==2 % 2 - State Estimation without State Feedback Control
    if (St==1&&CO==0&&Ob==1)||(CO==1&&Ob==1)
    ma=max(size(A));
    % FOO
    disp('Enter the Initial Conditions xo:')
    for i=1:ma
        xo(i)=input('');
    end
    %xo=xo';
    disp('Enter the estimations xho:')
    for i=1:ma
        xho(i)=input('');
    end
    xho=xho';
    disp('Enter the closed loop desired poles')
    for i=1:ma
        P(i)=input('');
    end
    % Ackerman Formula
    L = acker(A',C',P)'
    % Augmented System
    AL = [A zeros(max(size(A)));L*C A-L*C];
    BL = [B;B];
    CL = [C zeros(1,ma)];
    Ga = ss(AL,BL,CL,0);
     % Simulation
     xto = [xo;xho];
    [y,t,xk] = lsim(Ga,r,t,xto);

    figure
    for a=1:ma  
    subplot(ma,1,a), plot(t,xk(:,a),t,xk(:,a+ma),':')
    str = sprintf('x%d Vs x_%d^h',a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end
 else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED!!\n')
    return;
    end
end
if c==3 % 3 - State Estimation with State Feedback Control
   if CO==1&&Ob==1
    ma=max(size(A));
    % FOO & SFC
    disp('Enter the Initial Conditions xo:')
    for j=1:ma
        xo(j)=input('');
    end
    xo=xo';
    disp('Enter the estimations xho:')
    for j=1:ma
        xho(j)=input('');
    end
    xho=xho';

    disp('To Change the performance characteristics via SFC choose the method')
    disp('1 - Direct Pole Placement')
    disp('2 - Time & Frequency design criterions')
    m= input('Enter the desired methode:\n');
        if m==1  %1 - Direct Pole Placement
            disp('Enter the closed loop desired poles in complex "a+bi" form:')
            for i=1:ma
                a=input('Enter the real part "a" parameter: \n');
                b=input('Enter the imaginary part "b" parameter: \n');
                Pk(i)=complex(a,b);
            end
        end

        if m==2   %2 - Time & Frequency design criterions
           c1=input('Enter your Choice "1" for "Time" and "2" for "Frequency" design criteria\n'); 
           if c1==1
              Mp = input('Enter the Overshoot factor Mp:\n');
              ts = input('Enter the Settling time ts:\n');
              x = log(Mp)^2;
              zeta = sqrt(x/(pi^2+x));
              wn = 5/(zeta*ts);
              Do=[1 2*zeta*wn wn^2];
              Pk = roots(Do); %Dominant Poles
              if max(size(Pk))<ma
                for q=1:ma-max(size(Pk))
                    Pnk(q)=5*real(Pk(q));
                end
                 Pk=[Pk;Pnk'];
              end
           end
           if c1==2
              zeta = input('Enter the dapmping factor :\n');
              wn = input('Enter the natural frequency wn \n');
              Do=[1 2*zeta*wn wn^2];
              Pk = roots(Do); %Dominant Poles
              if max(size(Pk))<ma
                for q=1:ma-max(size(Pk))
                    Pnk(q)=5*real(Pk(q));
                end
                 Pk=[Pk;Pnk'];
              end
           end
        end
    Pk=Pk';
    % State Feedback Control
    K = acker(A,B,Pk);
    Ak = A-B*K;
    Ck = C-D*K;
    P = 1/(D-Ck/Ak*B);
    Bk = P*B;
    Dk = P*D;
    % Full Order Observer
    Pl = 5*real(Pk);
    L = acker(A',C',Pl)' % Ackerman Formula

    % SFC and FOO
    Al = A-B*K-L*C;
    Bl = L;
    Cl = -K;
    Alk = [A -B*K;L*C Al-L*D*K];
    Clk = [C -D*K];
    Blk = [L*D+B;B];
    Dlk = D;
    xtlko = [xo;xho];
    P = -1/(Clk/Alk*Blk+Dlk);
    Gcllk = ss(Alk,P*Blk,Clk,P*Dlk);

    [ycllk,t,xcllk] = lsim(Gcllk,r,t,xtlko);
    for j=1:ma
        x(:,j) = xcllk(:,j);
        xh(:,j) = xcllk(:,j+ma);
        %xh(j)=xh(j)'
    end

    Xh = xh';
    % The Actuating Signal
    u = -K*Xh +r;

    % Plotting
    figure
    for a=1:ma  
    subplot(ma,1,a), plot(t,x(:,a),t,xh(:,a),':')
    str = sprintf('x%d Vs x_%d^h',a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), title('The Actuating Signal');
    subplot(212), plot(t,ycllk), title('The Output Response');
   
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
  end
end

if c==4 % 4 - State Estimation with State Feedback Control:ROO & SFC
   if CO==1&&Ob==1
    ma=max(size(A));
    % ROO & SFC
    disp('Enter the Initial Conditions xo:')
    for j=1:ma
        xo(j)=input('');
    end
    xo=xo';
    disp('Enter the estimations xho:')
    for j=1:ma-1
        xoh(j)=input('');
    end
    xoh=xoh';
    disp('To Change the performance characteristics via SFC choose the method')
        disp('1 - Direct Pole Placement')
        disp('2 - Time & Frequency design criterions')
        m= input('Enter the desired methode:\n');
            if m==1  %1 - Direct Pole Placement
                disp('Enter the closed loop desired poles in complex "a+bi" form:')
                for i=1:ma
                    a=input('Enter the real part "a" parameter: \n');
                    b=input('Enter the imaginary part "b" parameter: \n');
                    Pk(i)=complex(a,b);
                end
            end

            if m==2   %2 - Time & Frequency design criterions
               c1=input('Enter your Choice "1" for "Time" and "2" for "Frequency" design criteria\n'); 
               if c1==1
                  Mp = input('Enter the Overshoot factor Mp:\n');
                  ts = input('Enter the Settling time ts:\n');
                  x = log(Mp)^2;
                  zeta = sqrt(x/(pi^2+x));
                  wn = 5/(zeta*ts);
                  Do=[1 2*zeta*wn wn^2];
                  Pk = roots(Do); %Dominant Poles
                  if max(size(Pk))<ma
                    for q=1:ma-max(size(Pk))
                        Pnk(q)=5*real(Pk(q));
                    end
                     Pk=[Pk;Pnk'];
                  end
               end
               if c1==2
                  zeta = input('Enter the dapmping factor :\n');
                  wn = input('Enter the natural frequency wn \n');
                  Do=[1 2*zeta*wn wn^2];
                  Pk = roots(Do); %Dominant Poles
                  if max(size(Pk))<ma
                    for q=1:ma-max(size(Pk))
                        Pnk(q)=5*real(Pk(q));
                    end
                     Pk=[Pk;Pnk'];
                  end
               end
            end

    Pk=Pk';
    disp('Enter the desired ROO poles')
    for j=1:ma-1
        Pd(j)=input('');
    end
    Pd=Pd';

    % ROO

     Nm = [1];
     Nu = [2:ma];
     m = length(Nm);
     u = length(Nu);
     n = m + u;
     Amm = A(Nm,Nm);
     Amu = A(Nm,Nu);
     Aum = A(Nu,Nm);
     Auu = A(Nu,Nu);
     L = acker(Auu',Amu',Pd)';
     xot = xo(2:ma) - xoh;

     % SFC

    K = acker(A,B,Pk);
    Ku = K(Nu);
    Km = K(Nm);

    % Augmented System

    Aa = [A-B*K B*Ku;zeros(u,n) Auu-L*Amu];
    Ba = [B;zeros(size(B(Nu)))];
    Ca = [C zeros(size(B(Nu)))'];
    Ga = ss(Aa,Ba,Ca,0);
    xoa = [xo;xot];

    % Simulation
    [ya,t,xa] = lsim(Ga,r,t,xoa);
    % Plotting
    figure
    subplot(ma,1,1), plot(t,xa(:,1)), title('x1')
    for a=1:ma  
        subplot(ma,1,a), plot(t,xa(:,a),t,xa(:,a+ma-1),':')
        str = sprintf('x%d Vs x_%d^h',a,a);
        title(str);
        ylabel ('Amplitude')
        xlabel('Time')
    end
   
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
     end
end
if c==5 %5 - Optimal State Estimation with State Feedback Control:Optimal SFC & FOO
   if CO==1&&Ob==1
    ma=max(size(A));
    % Optimal SFC/FOO Design

    [y,t,x] = lsim(G,r,t,xo);

    % Optimal SFC
    Q = C'*C;
    R=10;
    [K,P] = lqr(A,B,Q,R);

    % Optimal FOO
    [L,PL] = lqr(A',C',Q,R);
    L=L';
    PL=PL';

    Akl = [A -B*K;L*C A-B*K-L*C];
    Gkl = ss(Akl, zeros(max(size(Akl)),1), [C zeros(1,ma)],[])

    [ykl,tkl,xkl] = lsim(Gkl,r,t,[xo;-xo]);
    u= -K*xkl(:,ma+1:2*ma)';

    % Plotting
    figure
    for a=1:ma  
        subplot(ma,1,a), plot(t,x(:,a)), 
        str1 = sprintf('x%d Uncompensated',a);
        title(str1);
        ylabel ('Amplitude')
        xlabel('Time')
    end
    figure
    for b=1:ma
        subplot(ma,1,b), plot(t,xkl(:,b),t,xkl(:,b+ma),':')
        str2 = sprintf('Compensated x%d Vs x_%d^h',b,b);
        title(str2);
        ylabel ('Amplitude')
        xlabel('Time')
    end
    figure
    subplot(211), plot(t,ykl), title('Compensated System output y')
    subplot(212), plot(t,u), title('Optimal Control effort u^*')    

    else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
     end
end       
          
          
       

        
