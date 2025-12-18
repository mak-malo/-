F = textread('C:\Users\Zlata\Desktop\Курсач 11сем\данные.txt');
t= 30000;
XT= 1941620;
XX=zeros(9,t);
XW1 = zeros(t,1);
XW2 = zeros(t,1);
GG = zeros(t,1);
s=0;
e = 2;
%for e=2:1:8
    for q=1:1:(t)
     XW1(q)= F(q,e);
    end
    for q=1:1:(t)
      XW2(q)= F(q,3);
    end

    g = gausswin(2500); % <-- this value determines the width of the smoothing window
    g = g/sum(g);
    GG = conv(XW2, g, 'same');

    plot(XW2);
    hold on
    plot(GG);
    hold off

    for q=1:1:(t)
      XW2(q)= XW2(q)-GG(q);
    end
    TF = islocalmax(XW2);
    for q=1:1:(t)
      if  TF(q)==1 
          s= s+1;
      end
    end
    N =  s/(t*0.005);
   
 
    %plot(XW2);
x = 1:t;
TF = islocalmin(XW2);

degree = 15;  % степень полинома (подберите под данные)
p = polyfit(x(TF), XW2(TF), degree);  % находим коэффициенты полинома


% Вычисляем Y на плотной сетке
x_smooth = linspace(min(x(TF)), max(x(TF)), t);
y_smooth = polyval(p, x_smooth);

plot(x(TF),XW2(TF), 'o', x_smooth, y_smooth, '-');

 for q=1:1:(t)
      GG(q)= y_smooth(q);
 end

 for q=1:1:(t)
      XW2(q)=XW2(q) - GG(q);
 end

 plot(XW2)


 