% tarea 1 ondas en sismologia
%ley de gutenberg-richter describe la distribucion frecuencia-magnitud de
%los terremotos, la relacion establece que el numero de terremotos (N) con
%una magnitud igual o mayor a un determinaddo valor (M) se puede expresar:
%log(N)= a -bM , donde a y b son constantes empiricas.
%el parametro b es una medida de frecuencia relativa de los terremotos
%pequeños y grandes.En un contexto de evaluación sismica un valor b más bajo indica una mayor frecuencia de
%teremotos más grandes, mientras que un valor b más alto indica una mayor
%frecuencia de terremotos más pequeños. En otros contextos el valor b se
%puede utilizar para interprestar los procesos fisicos subyacentes a la
%ocurrencia de los terremotos, por ejemplo, los cambios en el valor b a
%lo largo del tiempo o el espacio pueden reflejar cambios en llas
%condiciones de estrés o tension en la corteza terrestre.
%el parametro a representa el nivel general de actividad sismica en una
%region determinada, representa el numero de terremotos por unidad de
%tiempo, independiente de su magnitud, es decir, es una medida de la
%energía sismica total liberada en una region determinada durate un periodo
%de tiempo determinado.
%en el contexto de la evaluacion del peligro sismico, el parametro a se
%utiliza para estimar el peligro sismico total en una determinada region ,
%un valor más alto de a indicaria un mayor nivel de actividad sismica y,
%por lo tanto un mayor potencial de dañar los terremotos. 
%en el contexto de las estadisticas de terremoto, el parametro a esta
%relacionado con el numero total de terremotos que ocurren en una region
%determinada en un periodo de tiempo determinado, independiente de su
%magnitud. A menudo se ultiza en conjunto con el parametro b para estimar
%la distribucion de la magnitud de la frecuencia de los terremotos en una
%region determinada.
%% ejercicio 3.1
maule= readmatrix("maule.csv");
illapel= readmatrix('illapel.csv');

%% ejercicio 3.1 maule
magnitud_maule= maule(:,5);
maxx= max(magnitud_maule);

M=[0:0.1:maxx];

n=[];
cont=0;
for i=1:89
    m=find(magnitud_maule>=M(i));
    largo=length(m);
    cont=cont+1
    n(cont)=largo;
end

N=log10(n);

%grafico G-R
% plot(M,N,'LineWidth',2,'Color',[0 0.4470 0.7410])
% xlabel('Magnitudes')
% ylabel('log(N)')
% title('Terremoto de Maule 2010')

%polyfit polyval
pf=polyfit(M(41:71),N(41:71),1);
pv=polyval(pf,M(41:71));


%graficar
figure
plot(M,N,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M(41:71),pv,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Terremoto de Maule 2010')
%% ejercicio 3.1 illapel
magnitud_illapel= illapel(:,5);
maxxi= max(magnitud_illapel);

M_i=[0:0.1:maxxi];

n_i=[];
cont=0
for i=1:84
    mi=find(magnitud_illapel>=M_i(i));
    largo_i=length(mi);
    cont=cont+1
    n_i(cont)=largo_i;
end

N_i=log10(n_i);

%grafico G-R
% plot(M_i,N_i,'LineWidth',2,'color',[0 0.4470 0.7410])
% xlabel('Magnitudes')
% ylabel('log(N)')
% title('Terremoto de Illapel 2015')

% %polyfit polyval
pf_i=polyfit(M_i(41:71),N_i(41:71),1);
pv_i=polyval(pf_i,M_i(41:71));


%graficar
figure
plot(M_i,N_i,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_i(41:71),pv_i,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Terremoto de Illapel 2015')

figure
subplot(1,2,1)
plot(M,N,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M(41:71),pv,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Terremoto de Maule 2010')
subplot(1,2,2)
plot(M_i,N_i,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_i(41:71),pv_i,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Terremoto de Illapel 2015')


%% ejercicio 3.2
maule2= readtable('maule.csv');
illapel2= readtable('illapel.csv');
%ley de omori
% n(t) = K / c + t
% n(t) = cantidad de sismos
% K = Amplitud
% c = Constante Compensación 
% t = Nro. de sismos diarios

%% ejercicio 3.2 maule
fechaa=maule2.time;
% Convierte las fechas de celda a datetime especificando el formato de entrada y la zona horaria
fechaa= datetime(fechaa, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSX', 'TimeZone', 'UTC');
fecha= datetime(fechaa,'Format','yyyy-MM-dd');

fecha=flipud(fecha);
fecha1=datevec(fecha);

fechas=fecha(1):days(1):fecha(end);

for i=1:length(fechas)-1
    posicion= find(fecha>fechas(i) & fecha<fechas(i+1));
    cantidad(i)= length(posicion); 
end

cantidad(1,180)=0;

% figure()
% plot(fechas,cantidad,'LineWidth',2)
% axis tight
% xlabel('fechas')
% ylabel('Cantidad de sismos')
% title('Ley de omori')


%definimos variables
 k=max(cantidad);
 c=0.1;

 % calculamos usando ley de omori
 for j=1:180
    n(j)= k/ (c + j);
 end

figure()
plot(fechas,cantidad,'LineWidth',1.5)
hold on
plot([1:180],n,'LineWidth',1.5)
axis tight
xlabel('fechas')
ylabel('Cantidad de sismos')
title('Ley de omori Maule')

%% ejercicio 3.2 illapel
fechaa_i=illapel2.time;
% Convierte las fechas de celda a datetime especificando el formato de entrada y la zona horaria
fechaa_i= datetime(fechaa_i, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSSX', 'TimeZone', 'UTC');
fecha_i= datetime(fechaa_i,'Format','yyyy-MM-dd');

fecha_i=flipud(fecha_i);
fecha1_i=datevec(fecha_i);

fechas_i=fecha_i(1):days(1):fecha_i(end);

for i=1:length(fechas_i)-1
    posicion_i= find(fecha_i>fechas_i(i) & fecha_i<fechas_i(i+1));
    cantidad_i(i)= length(posicion_i); 
end

cantidad_i(1,182)=0;

% figure()
% plot(fechas_i,cantidad_i,'LineWidth',2)
% axis tight
% xlabel('fechas')
% ylabel('Cantidad de sismos')
% title('Ley de omori')


% ajuste
 % n(t) = K / c + t
 k_i=max(cantidad_i);
 c=0.1;

 for j_i=1:182
    n_i(j_i)= k_i/ (c + j_i);
 end

figure()
plot(fechas_i,cantidad_i,'LineWidth',1.5)
hold on
plot([1:182],n_i,'LineWidth',1.5)
axis tight
xlabel('fechas')
ylabel('Cantidad de sismos')
title('Ley de omori Illapel')

figure
subplot(1,2,1)
plot(fechas,cantidad,'LineWidth',1.5)
hold on
plot(1:180,n,'LineWidth',1.5)
axis tight
xlabel('fechas')
ylabel('Cantidad de sismos')
title('Ley de omori Maule')
subplot(1,2,2)
plot(fechas_i,cantidad_i,'LineWidth',1.5)
hold on
plot(1:182,n_i,'LineWidth',1.5)
axis tight
xlabel('fechas')
ylabel('Cantidad de sismos')
title('Ley de omori Illapel')
%% ejercicio 3.4
maule_pre= readmatrix("Maule_PRE_Terremoto.csv");
illapel_pre= readmatrix('Illapel_PRE_Terremoto.csv');

%% ejercicio 3.4 maule
magnitud_maulepre= maule_pre(:,5);
maxx_pre= max(magnitud_maulepre);

M_pre=[0:0.1:maxx_pre];

n_pre=[];
cont_pre=0;
for i=1:67
    m_pre=find(magnitud_maulepre>=M_pre(i));
    largo_pre=length(m_pre);
    cont_pre=cont_pre+1
    n_pre(cont_pre)=largo_pre;
end

N_pre=log10(n_pre);

%grafico G-R
% plot(M_pre,N_pre,'LineWidth',2,'Color',[0 0.4470 0.7410])
% xlabel('Magnitudes')
% ylabel('log(N)')
% title('Terremoto de Maule 2010')

%polyfit polyval
pf_pre=polyfit(M_pre(29:65),N_pre(29:65),1);
pv_pre=polyval(pf_pre,M_pre(29:65));


%graficar
figure
plot(M_pre,N_pre,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_pre(29:65),pv_pre,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Maule antes del terremoto')
%% ejercicio 3.4 illapel
magnitud_illapelpre= illapel_pre(:,5);
maxxi_pre= max(magnitud_illapelpre);

M_ipre=[0:0.1:maxxi_pre];

n_ipre=[];
cont=0;
for i=1:67
    mi_pre=find(magnitud_illapelpre>=M_ipre(i));
    largo_ipre=length(mi_pre);
    cont=cont+1
    n_ipre(cont)=largo_ipre;
end

N_ipre=log10(n_ipre);

%grafico G-R
% figure
% plot(M_ipre,N_ipre,'LineWidth',2,'color',[0 0.4470 0.7410])
% xlabel('Magnitudes')
% ylabel('log(N)')
% title('Terremoto de Illapel 2015')

% %polyfit polyval
pf_ipre=polyfit(M_ipre(33:65),N_ipre(33:65),1);
pv_ipre=polyval(pf_ipre,M_ipre(33:65));


%graficar
figure
plot(M_ipre,N_ipre,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_ipre(33:65),pv_ipre,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Illapel antes del terremoto')

figure
subplot(1,2,1)
plot(M_pre,N_pre,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_pre(29:65),pv_pre,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Maule antes del terremoto')
subplot(1,2,2)
plot(M_ipre,N_ipre,'LineWidth',2,'Color',[0 0.4470 0.7410])
hold on 
plot(M_ipre(33:65),pv_ipre,'LineWidth',2,'Color','m')
xlabel('Magnitudes')
ylabel('log(N)')
title('Illapel antes del terremoto')
%% ejercicio 2.2
A=1;
w=pi;
k=2*pi;
%polteamos con respecto a posicion
x=linspace(0,4,100);
t=0
%ec de onda
u=A*cos(w*t-k.*x);
figure
plot(x,u,'LineWidth',1.5)
xlabel('Posición')
ylabel('Desplazamiento')
title('Desplazamiento en función de la posición')

%ploteamos con respecto al tiempo
x1=0;
t1=0:0.1:4;
%ec de onda
u1=A*cos(w*t1-k.*x1);
figure
plot(t1,u1,'LineWidth',1.5,'color',[0 0.4470 0.7410] )
xlabel('Tiempo')
ylabel('Desplazamiento')
title('Desplazamiento en función del tiempo')

figure
subplot(1,2,1)
plot(x,u,'LineWidth',1.5)
xlabel('Posición')
ylabel('Desplazamiento')
title('Desplazamiento en función de la posición')
subplot(1,2,2)
plot(t1,u1,'LineWidth',1.5,'color',[0 0.4470 0.7410] )
xlabel('Tiempo')
ylabel('Desplazamiento')
title('Desplazamiento en función del tiempo')
