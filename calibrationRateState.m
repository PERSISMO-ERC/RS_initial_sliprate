clear
clf
N = 1001;
ab = linspace(0.2,0.8,N);

b = 0.01;
f0 = 0.6;

sratio = 1;
s22 = -100e6;
s12 = 55e6;
V0 = 1e-12;

a = ab*b;
s11 = s22*sratio;
psi = 90-0.5*atan2d(2*s12,(s11-s22));

theta = linspace(-180,180,N/2);
n1 = -sind(theta);
n2 = cosd(theta);
s1 = cosd(theta);
s2 = sind(theta);

tau = s11*n1.*s1 + s22*n2.*s2 + s12*(n1.*s2 + n2.*s1);
sigma = s11*n1.*n1 + s22*n2.*n2 + s12*(n1.*n2 + n2.*n1);

fini = abs(tau./sigma);

for i=1:length(a)
    V(i,:) = V0* exp((fini-f0)./(a(i)-b));
end

vmin = 1e-15*V0;
vmax = 1e-3;

var = V;
var(var<=vmin) = NaN;
var(var>=vmax) = NaN;

pcolor(ab,theta,var')
shading flat
set(gca,'ColorScale','log')
caxis([vmin vmax])
h1 = colorbar;
set(gca,'YTick',[min(theta):10:max(theta)])
set(gca,'XTick',[min(ab):0.05:max(ab)])
set(gca,'FontSize',22)
grid on
hold on

range = logspace(log10(vmin),log10(vmax),10);
[c,h] = contour(ab,theta,log10(var'),log10(range));
h.Color = 'k';

str = ['$$\Psi \approx ' num2str(psi,'%4.0f') '^o ~;~ \sigma_{11}/\sigma_{22} = ' num2str(sratio,'%4.1f') '$$'];
title(str,'Interpreter','latex')

xlabel('a/b','FontSize',28)
ylabel('\theta','FontSize',28)
h1.Label.String = 'V_i';
h1.Label.Rotation = 0;
h1.Label.FontSize = 28;