function plotGB_stereo(tab,ang_gb_xy, ang_gb_xz, ori_g1, ori_g2)

ax_1 = axes('Parent',tab,'Units','normalized','Position', [0.01 0.05 0.25 0.75],'Color','none');
ax_2 = axes('Parent',tab,'Units','normalized','Position', [0.26 0.05 0.25 0.75],'Color','none');
ax_3 = axes('Parent',tab,'Units','normalized','Position', [0.51 0.05 0.25 0.75],'Color','none');
ax_4 = axes('Parent',tab,'Units','normalized','Position', [0.76 0.05 0.25 0.75],'Color','none');

A=rotate(xvector,rotation('axis',zvector,'angle',(ang_gb_xy)));%
B=rotate(xvector,rotation('axis',yvector,'angle',(ang_gb_xz)));%
N = cross(A, B);

% GB Plane normal in specimen coordinates
plot(A,'antipodal','label','A','grid','Parent',ax_1,'markerSize',3)
hold on
plot(B,'antipodal','label','B','Parent',ax_1,'markerSize',3)
hold on
plot(N,'antipodal','label','N','Parent',ax_1,'markerSize',3,'markerFaceColor',[0.9290 0.6940 0.1250])
hold on
plot(N,'LineStyle','--','circle','antipodal','linewidth',1.5,'Parent',ax_1)
hold on
annotate([vector3d.X,vector3d.Y,vector3d.Z],'label',{'X','Y','Z'},'backgroundcolor','none','Parent',ax_1,'markerSize',5)
title(ax_1,{'GB normal (N)','(Sample reference)'}')
%
cs=ori_g1.CS;
h = Miller({1,0,0},{0,1,0},{0,0,1},cs);
h1= ori_g1*h; % h in sample coordinates
h2= ori_g2*h;

% Crystal orientarion of grain 1 (left) in specimen coordinates
plot(h1,'markerFaceColor',[0.5765 0.2314 0.2549],'markerSize',3, 'label',{'(100)','(010)','(001)'}, 'fontSize',16,'Color',[ 0.5765 0.2314 0.2549],'antipodal','grid','Parent',ax_2)
hold on
plot(N,'antipodal','label','N','markerSize',3,'markerFaceColor',[0.9290 0.6940 0.1250],'Parent',ax_2)
hold on
annotate([vector3d.X,vector3d.Y,vector3d.Z],'label',{'X','Y','Z'},'backgroundcolor','none','Parent',ax_2,'markerSize',5)
hold off
title(ax_2,{'Left grain orientation and GB normal (N)','(Sample reference)'})

% Crystal orientation of grain 2 (right) in specimen coordinates
plot(h2,'markerFaceColor',[ 0.2365 0.5714 0.2549],'markerSize',3, 'label',{'(100)','(010)','(001)'}, 'fontSize',16,'Color',[ 0.2365 0.5714 0.2549],'antipodal','grid','Parent',ax_3)
hold on
plot(N,'antipodal','label','N','markerSize',3,'markerFaceColor',[0.9290 0.6940 0.1250],'Parent',ax_3)
hold on
annotate([vector3d.X,vector3d.Y,vector3d.Z],'label',{'X','Y','Z'},'backgroundcolor','none','Parent',ax_3,'markerSize',5)
hold off
title(ax_3,{'Right grain orientation and GB normal (N)','(Sample reference)'})

% Grain boundary plane normal in crystal coordinates
m1=round(ori_g1\N);% m in crystal coordinates
m2=round(ori_g2\N); 
h = Miller({1,0,0},{0,1,0},{0,0,1},cs);
plot(h,'markerFaceColor',[0 0 0],'markerSize',3, 'labeled','all', 'fontSize',16,'Color',[ 0 0 0],'antipodal','grid','Parent',ax_4)
hold on
plot(m1,'markerFaceColor',[ 0.5765 0.2314 0.2549],'markerSize',3, 'labeled','all', 'fontSize',16,'Color',[ 0.5765 0.2314 0.2549],'antipodal','Parent',ax_4)
hold on
plot(m2,'markerFaceColor',[ 0.2365 0.5714 0.2549],'markerSize',3, 'labeled','all', 'fontSize',16,'Color',[ 0.2365 0.5714  0.2549],'antipodal','Parent',ax_4)
hold off
title(ax_4,{'GB plane normal', '(Crystal reference)'})