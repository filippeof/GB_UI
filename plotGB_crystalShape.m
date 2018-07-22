function plotGB_crystalShape(ax,ori,v,oM)
% ax= axis to plot
% ori = orientation('Euler', [0,45,0]*degree, cs);% crystal orientation
% v=[1,0,0]; %vector normal to gb plane
if isa(v,'vector3d') || isa(v,'Miller'); v=v.xyz; end
color_shape = oM.orientation2color(ori);

wrlFname='olivine_KS.wrl';
[vert,fac]=getPoly(wrlFname);
crystalT = hgtransform('Parent',ax); %Transformation matrix for the crystal and lines
gbT = hgtransform('Parent',ax); %Transformation matrix for the gb surface

gbT.Matrix =eye(4);
rotCorrection =eye(4);

p=patch('Vertices',vert,'Faces',fac,'FaceColor',color_shape,'faceAlpha',0.1,'Parent',crystalT);%; color_g2
xL=get(ax,'xLim'); yL=get(ax,'yLim'); zL=get(ax,'zLim');

Sxyz = makehgtform('scale',1/max([xL,yL,zL])); %scale to axis
rotCorrection(1:3,1:3) =matrix(rotation('map',yvector,zvector,xvector,yvector)); % correction so everything is in the same reference(x//a,y//b,z//c)
gbT.Matrix(1:3,1:3) =matrix(ori); % rotation matrix
gbT.Matrix=gbT.Matrix*Sxyz;% rotation +scale matrix
crystalT.Matrix=gbT.Matrix*rotCorrection; % scale+ rotation matrix + correction for crystal
% alpha(p, 0.3)% set patches transparency to 0.3

hold on    
    l_b= line([1.1*xL(1) 1.1*xL(2)],[0 0],[0 0],'Color','red','LineStyle','--','LineWidth',1.5,'Parent',crystalT);%b
    t_b= text([1.15*xL(1) 1.15*xL(2)],[0 0],[0 0],'b','Color','red','Parent',crystalT);

    hold on
    l_c= line([0 0], [1.1*yL(1) 1.1*yL(2)], [0 0], 'Color', 'red', 'LineStyle','--','LineWidth',1.5,'Parent',crystalT);%c
    t_c= text([0 0], [1.15*yL(1) 1.15*yL(2)], [0 0], 'c', 'Color', 'red','Parent',crystalT);

    hold on
    l3= line([0 0],[0 0],[1.1*zL(1) 1.1*zL(2)],'Color','red','LineStyle','--','LineWidth',1.5,'Parent',crystalT);%a
    t3= text([0 0],[0 0],[1.15*zL(1) 1.15*zL(2)],'a','Color','red','Parent',crystalT);
    hold off
    
x1=0;y1=0;z1=0; % center coordinates
w = null(v); % Find two orthonormal vectors which are orthogonal to v
P=[-1,1;-1,1]; % x Square limits
Q=[-1,-1;1,1]; % y square limits 
X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = y1+w(2,1)*P+w(2,2)*Q; % Using the two vectors in w
Z = z1+w(3,1)*P+w(3,2)*Q;
   hold on 
   gb_plane=surf (X,Y,Z,'FaceColor','k','FaceAlpha',0.4,'Parent',gbT);
 
% axis equal; axis tight; axis vis3d; axis off%
% ax.XTick=[]; ax.YTick=[]; ax.ZTick=[];
% xlabel(ax,'X');ylabel(ax,'Y');zlabel(ax,'Z')
% view(ax,3)

%%