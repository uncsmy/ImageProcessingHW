x = -5:0.1:5;
y1 = abs(x);
y2 = 0.2*log((exp(5*x)+exp(-5*x))/2);
y3 = 0.1*log((exp(10*x)+exp(-10*x))/2);
y4 = 0.05*log((exp(20*x)+exp(-20*x))/2);

plot(x,y1,x,y2,x,y3,x,y4)
legend('y = abs(x)','r=0.2','r=0.1','r=0.05')
