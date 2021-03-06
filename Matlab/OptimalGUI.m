function varargout = OptimalGUI(varargin)
% OPTIMALGUI MATLAB code for OptimalGUI.fig
%      OPTIMALGUI, by itself, creates a new OPTIMALGUI or raises the existing
%      singleton*.
%
%      H = OPTIMALGUI returns the handle to a new OPTIMALGUI or the handle to
%      the existing singleton*.
%
%      OPTIMALGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIMALGUI.M with the given input arguments.
%
%      OPTIMALGUI('Property','Value',...) creates a new OPTIMALGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptimalGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptimalGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptimalGUI

% Last Modified by GUIDE v2.5 18-Jan-2013 22:14:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptimalGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OptimalGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before OptimalGUI is made visible.
function OptimalGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OptimalGUI (see VARARGIN)

% Choose default command line output for OptimalGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OptimalGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OptimalGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton21, 'Enable', 'on');
clc 
clear all
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
save();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton21, 'Enable', 'on');
clc 
clear all
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
save();


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton21, 'Enable', 'on');
clc 
clear all
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
% A=[0 1 0 0;0 -0.00263 0.255437 0; 0 0 0 1;0 -0.00326 12.45255 0];
% B=[0;0.26309;0;0.032581];
% C=[1 0 0 0];
% D=0;
% A=[0 1;-2 -3];
% B=[0;1];
% C=[1 2];
% D=0;
A
B
C
D
 save();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton21, 'Enable', 'on');
clc 
clear all
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
save();

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
if CO == 0
      fprintf('WARNING: YOUR SYSTEM IS UNCONTROLLABLE!! YOU CANNOT CHANGE ITS PERFORMANCE!!\n')
      return;
end
disp('Enter the desired poles in complex "a+bi" form:')
for i=1:length(P)
    a=input('Enter the real part "a" parameter: \n');
    b=input('Enter the imaginary part "b" parameter: \n');
    Pd(i)=complex(a,b);
end
Pd
% State Feedback Control: Ackerman Formula 
K=acker(A,B,Pd);
% The Compensated System
Ak = A-B*K;
Gcl = ss(Ak,B,C,D);
Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
if Kdccl<1
    Kdccl=1;
end
Gcl0sse = Gcl/Kdccl;
tf(Gcl0sse)
% Simulation
figure
% lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo')
subplot(2,1,1);lsim(G,'b',r,t,xo')
str1= sprintf('%s Uncompensated system',sp);
title(str1)
subplot(2,1,2);lsim(Gcl0sse,'b',r,t,xo')
str2= sprintf('%s Compensated system with zero steady state error',sp);
title(str2)
save();
    

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
if CO == 0
      fprintf('WARNING: YOUR SYSTEM IS UNCONTROLLABLE!! YOU CANNOT CHANGE ITS PERFORMANCE!!\n')
      return;
end
Mp = input('Enter the Overshoot factor Mp:\n');
ts = input('Enter the Settling time ts:\n');
x = log(Mp)^2;
zeta = sqrt(x/(pi^2+x));
wn = 5/(zeta*ts);
Do=[1 2*zeta*wn wn^2];
Pd = roots(Do); %Dominant Poles
if max(size(Pd))<max(size(A))
    for q=1:(max(size(A))-size(Pd))
        Pnd(q)=5*real(Pd(q));
    end
    
  Pd=[Pd;Pnd']
end
% State Feedback Control: Ackerman Formula 
K=acker(A,B,Pd);
% The Compensated System
Ak = A-B*K;
Gcl = ss(Ak,B,C,D);
Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
if Kdccl<1
    Kdccl=1;
end
Gcl0sse = Gcl/Kdccl;
tf(Gcl0sse)
% Simulation  
figure
% lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo')
subplot(2,1,1);lsim(G,'b',r,t,xo')
str1= sprintf('%s Uncompensated system',sp);
title(str1)
subplot(2,1,2);lsim(Gcl0sse,'b',r,t,xo')
str2= sprintf('%s Compensated system with zero steady state error',sp);
title(str2)
save()

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
if CO == 0
      fprintf('WARNING: YOUR SYSTEM IS UNCONTROLLABLE!! YOU CANNOT CHANGE ITS PERFORMANCE!!\n')
      return;
end
zeta = input('Enter the dapmping factor :\n');
wn = input('Enter the natural frequency wn \n');
Do=[1 2*zeta*wn wn^2];
Pd = roots(Do); %Dominant Poles
if max(size(Pd))<max(size(A))
for q=1:(max(size(A))-size(Pd))
    Pnd(q)=5*real(Pd(q));
end

Pd=[Pd;Pnd']
end
% State Feedback Control: Ackerman Formula 
K=acker(A,B,Pd);
% The Compensated System
Ak = A-B*K;
Gcl = ss(Ak,B,C,D);
Kdccl = -C/Ak*B; % Pre-Filter N=1/Kdccl
if Kdccl<1
    Kdccl=1;
end
Gcl0sse = Gcl/Kdccl;
% Simulation     
figure
subplot(2,1,1);lsim(G,'b',r,t,xo')
str1 = sprintf('%s Uncompensated system',sp);
title(str1)
subplot(2,1,2);lsim(Gcl0sse,'b',r,t,xo')
str2= sprintf('%s Compensated system with zero steady state error',sp);
title(str2)
% lsim(G,':k',Gcl,'-.k',Gcl0sse,'k',r,t,xo')    

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
if (St==1&&CO==0&&Ob==1)||(CO==1&&Ob==1)
    ma=max(size(A));
    % FOO
    disp('Enter the initial estimations xho one by one followed by return:')
    for i=1:ma
        xho(i)=input('');
    end
    xho=xho';
    disp('Enter the closed loop desired poles in a+bj form one by one followed by return')
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
        if a==1
            stv=('Cart''s Position');
        else if a==2
                stv=('Cart''s Velocity');
            else 
                if a==3
                    stv=('Pendulum''s Angular Position');
                else if a==4
                        stv=('Pendulum''s Angular Velocity');
                    end
                end
            end
        end
                 
    subplot(ma,1,a), plot(t,xk(:,a),t,xk(:,a+ma),':')
    str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end

    
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED!!\n')
    return;
end

save()
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % FOO & SFC
    disp('Enter the inital estimations xho one by one followed by return:')
    for j=1:ma
        xho(j)=input('');
    end
    xho=xho';

   
   disp('Enter the closed loop desired poles in complex "a+bi" form:')
   for i=1:ma
        a=input('Enter the real part "a" parameter: \n');
        b=input('Enter the imaginary part "b" parameter: \n');
        Pk(i)=complex(a,b);
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
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end   
    subplot(ma,1,a), plot(t,x(:,a),t,xh(:,a),':')
    str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ycllk), str2=sprintf('The Output Response for %s',sp);
    title(str2)
   
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end

save()
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % FOO & SFC
    disp('Enter the initial estimations xho one by one followed by return:')
    for j=1:ma
        xho(j)=input('');
    end
    xho=xho';
          
    Mp = input('Enter the Overshoot factor Mp:\n');
    ts = input('Enter the Settling time ts:\n');
    x = log(Mp)^2;
    zeta = sqrt(x/(pi^2+x));
    wn = 5/(zeta*ts);
    Do=[1 2*zeta*wn wn^2];
    Pk = roots(Do); %Dominant Poles
    if max(size(Pk))<ma
        for q=1:ma-max(size(Pk))
        Pnk(q)=5*real(Pk(1));
        end
        Pk=[Pk;Pnk']
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

    Xh = (xcllk(:,1:ma))';
    
    % The Actuating Signal
    u = -K*Xh +r;

    % Plotting
    figure
    for a=1:ma 
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end   
    subplot(ma,1,a), plot(t,xcllk(:,a),t,xcllk(:,a+ma),':')
    str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ycllk), str2=sprintf('The Output Response for %s',sp);
    title(str2)
   
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % FOO & SFC
    disp('Enter the inital estimations xho one by one followed by return:')
    for j=1:ma
        xho(j)=input('');
    end
    xho=xho';

    zeta = input('Enter the dapmping factor :\n');
    wn = input('Enter the natural frequency wn \n');
    Do=[1 2*zeta*wn wn^2];
    Pk = roots(Do); %Dominant Poles
    if max(size(Pk))<ma
      Pn=5*real(Pk(1));
      Pk=[Pk;Pnk];
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

    Xh = (xcllk(:,1:ma))';
    
    % The Actuating Signal
    u = -K*Xh +r;

    % Plotting
    figure
    for a=1:ma  
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end   
    subplot(ma,1,a), plot(t,xcllk(:,a),t,xcllk(:,a+ma),':')
    str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
    title(str);
    ylabel ('Amplitude')
    xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ycllk), str2=sprintf('The Output Response for %s',sp);
    title(str2)
   
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % ROO & SFC
    disp('The first state is considered measured and the remaing ones are unmeasured')
    disp('Enter the initial estimations xho one by one followed by return:')
    for j=1:ma-1
        xoh(j)=input('');
    end
    xoh=xoh';
    
    disp('Enter the closed loop desired poles in complex "a+bi" form:')
    for i=1:ma
        a=input('Enter the real part "a" parameter: \n');
        b=input('Enter the imaginary part "b" parameter: \n');
        Pk(i)=complex(a,b);
    end
            
    Pk=Pk';
    disp('Enter the desired ROO poles one by one followed by return')
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
    
     Xh = (xa(:,1:ma))';
    
    % The Actuating Signal
    u = -K*Xh +r;
    
    % Plotting
    figure
    subplot(ma,1,1), plot(t,xa(:,1)), title('x1')
    for a=1:ma  
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end  
        subplot(ma,1,a), plot(t,xa(:,a),t,xa(:,a+ma-1),':')
        str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
        title(str);
        ylabel ('Amplitude')
        xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ya), str2=sprintf('The Output Response for %s',sp);
    title(str2)
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end

save()
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % ROO & SFC
    disp('The first state is considered measured and the remaing ones are unmeasured')
    disp('Enter the initial estimations xho one by one followed by return:')
    for j=1:ma-1
        xoh(j)=input('');
    end
    xoh=xoh';
    
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

    Pk=Pk';
    disp('Enter the desired ROO poles one by one followed by return:')
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
    
     Xh = (xa(:,1:ma))';
    
    % The Actuating Signal
    u = -K*Xh +r;
    
    % Plotting
    figure
    subplot(ma,1,1), plot(t,xa(:,1)), title('x1')
    for a=2:ma
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end  
        subplot(ma,1,a), plot(t,xa(:,a),t,xa(:,a+ma-1),':')
        str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
        title(str);
        ylabel ('Amplitude')
        xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ya), str2=sprintf('The Output Response for %s',sp);
    title(str2)
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load()
 if CO==1&&Ob==1
    ma=max(size(A));
    % ROO & SFC
    disp('The first state is considered measured and the remaing ones are unmeasured')
    disp('Enter the initial estimations xho one by one followed by return:')
    for j=1:ma-1
        xoh(j)=input('');
    end
    xoh=xoh';
    
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
               
    Pk=Pk';
    disp('Enter the desired ROO poles one by one followed by return:')
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
    
     Xh = (xa(:,1:ma))';
    
    % The Actuating Signal
    u = -K*Xh +r;
    % Plotting
    figure
    subplot(ma,1,1), plot(t,xa(:,1)), title('x1')
    for a=2:ma 
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end  
        subplot(ma,1,a), plot(t,xa(:,a),t,xa(:,a+ma-1),':')
        str = sprintf('%s x%d Vs x_%d^h',stv,a,a);
        title(str);
        ylabel ('Amplitude')
        xlabel('Time')
    end
    figure
    subplot(211), plot(t,u), str1=sprintf('The Actuating Signal for %s',sp);
    title(str1)
    subplot(212), plot(t,ya), str2=sprintf('The Output Response for %s',sp);
    title(str2)
else
     fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
     return;
end



% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Finding System's Poles to assess stability
%data = daqread('OptimalGUI')
load()
set(handles.pushbutton5, 'Enable', 'on');
set(handles.pushbutton6, 'Enable', 'on');
set(handles.pushbutton7, 'Enable', 'on');
set(handles.pushbutton8, 'Enable', 'on');
set(handles.pushbutton9, 'Enable', 'on');
set(handles.pushbutton10, 'Enable', 'on');
set(handles.pushbutton11, 'Enable', 'on');
set(handles.pushbutton12, 'Enable', 'on');
set(handles.pushbutton13, 'Enable', 'on');
set(handles.pushbutton14, 'Enable', 'on');
set(handles.pushbutton15, 'Enable', 'on');
set(handles.pushbutton22, 'Enable', 'on');

P = eig(A);
disp('The Poles Of The System Are: ')
P
 
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

ma=max(size(A));
% Contrability Test
e=0;
[lV,lD] = eig(A');
[rV,rD] = eig(A);
for i=1:max(size(lV))
    test=(lV(:,i))'*B;
    if test==0
        fprintf('Mode %d is Uncontrollable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Not Stabilizable\n',i)
        end
    else
        fprintf('Mode %d is Controllable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Stabilizable\n',i)
            e=e+1;
        end
    end
end
if e==max(size(rV))
    fprintf('The system is Stabilizable\n')
else
    fprintf('The system is Not Stabilizable\n')
end
Co=ctrb(A,B);
if rank(Co)~= ma
     fprintf('The System is Uncontrollable!\n\n')
     CO=0;
     else fprintf('The System is Controllable!\n\n')
         CO=1;
end
 

% Observability Test
d=0;
   for i=1:max(size(rV))
    test=C*rV(:,i);
    if test==0
        fprintf('Mode %d is Unobservable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Not Detectable\n',i)
        end
    else
        fprintf('Mode %d is Observable\n', i)
        if real(P(i)) > 0
            fprintf('Mode %d is Detectable\n',i)
             d=d+1;
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
 

%Redesign and bad system
if St==1&&CO==0&&Ob==0
     fprintf('WARNING: CANNOT DESIGN A CONTROLLER FOR YOUR SYSTEM!!\n')
     return;
end
if St==0&&CO==0
     fprintf('WARNING: YOUR SYSTEM MUST BE REDESIGNED!!\n')
     return;    
end

save();

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load();
 G=ss(A,B,C,D); 
 tf(G)
 if C(1)==1
     sp = sprintf('Cart''s Position');
 else
     sp = sprintf('Pendulum''s Angular Position');
 end
 % pole and zero plot
figure
pzplot(G),grid on

%initial iputs
 ft = input('\nEnter the simulation final time: \n');
 r = input('\nEnter the type of input "1" for "0 input" and "2" for "Unit Step function": \n');
 t=0:0.1:ft;
 if r==1
    r=0*t;
 else if r==2
         r=stepfun(t,0);
     end
 end
 disp('Enter Initial Conditions Xo one by one followed by return: ')
 for i=1:max(size(A));
            xo(i)=input('');
 end
 xo=xo';
save();


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load();

if CO==1&&Ob==1
ma=max(size(A));
% Optimal SFC/FOO Design

[y,t,x] = lsim(G,r,t,xo);

% Optimal SFC
Q = C'*C;
R=1;
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
    if a==1
        stv=('Cart''s Position');
    else if a==2
            stv=('Cart''s Velocity');
        else 
            if a==3
                stv=('Pendulum''s Angular Position');
            else if a==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end  
    subplot(ma,1,a), plot(t,x(:,a)), 
    str1 = sprintf('%s x%d Uncompensated',stv,a);
    title(str1);
    ylabel ('Amplitude')
    xlabel('Time')
end
figure
for b=1:ma
    if b==1
        stv=('Cart''s Position');
    else if b==2
            stv=('Cart''s Velocity');
        else 
            if b==3
                stv=('Pendulum''s Angular Position');
            else if b==4
                    stv=('Pendulum''s Angular Velocity');
                end
            end
        end
    end  
    subplot(ma,1,b), plot(t,xkl(:,b),t,xkl(:,b+ma),':')
    str2 = sprintf('%s Compensated x%d Vs x_%d^h',stv,b,b);
    title(str2);
    ylabel ('Amplitude')
    xlabel('Time')
end
figure
subplot(211), plot(t,ykl), str1=sprintf('Compensated System output y for %s',sp);
title(str1)
subplot(212), plot(t,u), str2=sprintf('Optimal Control effort u^* for %s',sp);
title(str2)

else
 fprintf('WARNING: YOUR SYSTEM CANNOT BE ESTIMATED AND ITS PERFORMANCE CANNOT BE CHANGED\n')
 return;
end
 save()
       
