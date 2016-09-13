t = 0:5000;
a = 200*sin(2*pi*0.0003*t');
Pul  = a .* sin(2*pi*0.005*t');

r_fig = 3;  c_fig = 2;
figure(1)
subplot(n_fig , c_fig, 1);
plot(t,Pul,'b',  [0 5000],[0 0],'k' );

[avt_temp_data, cycle_temp_data] ...
    = Rhythm.rhythm1_temp_cycle_data(200, Pul, -200, 7500, 0, 0);
subplot(n_fig, c_fig, 3 );
plot(t' , avt_temp_data(:,1));

subplot(n_fig, c_fig, 5 );
plot(t' , avt_temp_data(:,2));



zcTrend = 25* sin(2*pi*0.0002*t');

subplot(n_fig , c_fig, 2);
plot(t,Pul,'b',  t,zcTrend,'k' );

[avt_temp_data, cycle_temp_data] ...
    = Rhythm.rhythm1_temp_cycle_data(200, Pul-zcTrend, -200, 7500, 0, 0);
subplot(n_fig, c_fig,4 );
plot(t' , avt_temp_data(:,1));

subplot(n_fig, c_fig, 6 );
plot(t' , avt_temp_data(:,2));


figure(2)
plot(t,Pul-zcTrend,'b',  [0 5000],[0 0],'k' );
