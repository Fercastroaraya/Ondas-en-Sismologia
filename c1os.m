%certamen 1 ondas en sismologia
%% 1.2 diagrama de wadati
%evento chileno
tp_chile= [11 16 19 19 19.5 20 26];
ts_chile= [18 26 33 32 32 33 43];
tstp_chile = [7 10 14 13 13.5 13 17];

%ts-tp= tp(vp/vs -1)
%calculamos pendiente
polyfit_chile=polyfit(tp_chile,tstp_chile,1);
polyval_chile= polyval(polyfit_chile,tp_chile);

figure
plot(tp_chile,tstp_chile,'o','LineWidth',2,'Color',[0.3010 0.7450 0.9330])
hold on
plot(tp_chile,polyval_chile,'-','LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
xlabel('tp [s]')
ylabel('ts-tp [s]')
title('Diagrama de Wadati evento Chileno')

%evento taiwan
tp_taiwan= [110 170 180 210 245];
ts_taiwan= [210 323 375 370 445]; 
tstp_taiwan = [100 153 195 160 200];

%ts-tp= tp(vp/vs -1)
%calculamos pendiente
polyfit_taiwan=polyfit(tp_taiwan,tstp_taiwan,1);
polyval_taiwan= polyval(polyfit_taiwan,tp_taiwan);

figure
plot(tp_taiwan,tstp_taiwan,'o','LineWidth',2)
hold on
plot(tp_taiwan,polyval_taiwan,'-','LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
xlabel('tp [s]')
ylabel('ts-tp [s]')
title('Diagrama de Wadati evento Taiwan')


figure
subplot(1,2,1)
plot(tp_chile,tstp_chile,'o','LineWidth',2,'Color',[0.3010 0.7450 0.9330])
hold on
plot(tp_chile,polyval_chile,'-','LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
xlabel('tp [s]')
ylabel('ts-tp [s]')
title('Diagrama de Wadati evento Chileno')
subplot(1,2,2)
plot(tp_taiwan,tstp_taiwan,'o','LineWidth',2)
hold on
plot(tp_taiwan,polyval_taiwan,'-','LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
xlabel('tp [s]')
ylabel('ts-tp [s]')
title('Diagrama de Wadati evento Taiwan')

%% 1.3 razon vp/vs
%vp/vs= m +1
m_chile= polyfit_chile(1,1);
razon_chile= m_chile +1;
m_taiwan= polyfit_taiwan(1,1);
razon_taiwan= m_taiwan +1;

%% 1.4 determinar valores de vp y vs
%chile
latepi_chile= -28.91;
longepi_chile= -71.44;

latesta_chile= [-28.463 -28.205 -28.836 -29.879 -29.904 -29.919 -30.259];
longesta_chile= [-71.225 -71.074 -70.274 -71.271 -71.238 -71.238 -71.490];


for i=1:length(latesta_chile)
      lat= [latepi_chile latesta_chile(i)];
      long= [longepi_chile longesta_chile(i)];
      dist(i)= gsw_distance(long,lat);
end

%calculamos vp y vs sabiendo que ts= d/vs tp= d/vp
for j=1:length(tp_chile)
    vs(j)=dist(j)/ts_chile(j);
    vp(j)=dist(j)/tp_chile(j);
end

%taiwan
latepi_taiwan= 23.819;
longepi_taiwan= 121.56;

latesta_taiwan= [22.28 19.03 30.28 37.48 40.02];
longesta_taiwan= [114.14 109.84 109.49 126.62 116.17];


for i=1:length(latesta_taiwan)
      lat= [latepi_taiwan latesta_taiwan(i)];
      long= [longepi_taiwan longesta_taiwan(i)];
      distt(i)= gsw_distance(long,lat);
end

%calculamos vp y vs sabiendo que ts= d/vs tp= d/vp
for j=1:length(tp_taiwan)
    vst(j)=distt(j)/ts_taiwan(j);
    vpt(j)=distt(j)/tp_taiwan(j);
end

%% 3 determinar coeficiente de poisson 
%con la expresión encontrada en la pregunta 2, reemplazamos ocn los valores
%obtenidos en 1 para determinar un valor para el coeficion de Poisson

v_chile= ((razon_chile.^2) - 2)/ (2*((razon_chile.^2) -1));
v_taiwan= ((razon_taiwan.^2) - 2)/ (2*((razon_taiwan.^2) -1));
