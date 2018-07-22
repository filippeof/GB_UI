function plotGB_sim(ax,ang_gb_xy, ang_gb_xz, ori_g1, ori_g2,oM)
% ang_gb_xy = alpha
% ang_gb_xz = beta
% ori =  crystal orientation in euler angles
% EXAMPLE GRAIN BOUNDARY
% define gb angles
% ang_gb_xy=45*degree;
% ang_gb_xz=135*degree;
% % define grain orientations
% ori_g1 = orientation('Euler', 10*degree, 10*degree, 10*degree, cs);
% ori_g2 = orientation('Euler', 25*degree, 45*degree, 10*degree, cs);
%define color by IPF
color_g1 = oM.orientation2color(ori_g1);
color_g2 = oM.orientation2color(ori_g2);

%XZ
if ang_gb_xz>=0 && ang_gb_xz<=45*degree
    x_XZ=1;
    z_XZ=tan(ang_gb_xz); 
elseif ang_gb_xz>45*degree && ang_gb_xz<=135*degree
    z_XZ=1;
    x_XZ=0.5+z_XZ/(2*(tan(ang_gb_xz))); 
elseif ang_gb_xz>135*degree && ang_gb_xz<=180*degree
    x_XZ=0;
    z_XZ=tan(180*degree-ang_gb_xz); 
end
y_XZ=1;

% XY
if ang_gb_xy>=0 && ang_gb_xy<=45*degree
    x_XY=0;
    y_XY=1-tan(ang_gb_xy); 
elseif ang_gb_xy>45*degree && ang_gb_xy<=135*degree
    y_XY=0;
    x_XY=0.5-1/(2*(tan(ang_gb_xy))); 
elseif ang_gb_xy>135*degree && ang_gb_xy<=180*degree
    x_XY=1;
    y_XY=1-tan(180*degree-ang_gb_xy); 
end
z_XY=0;

vert = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 1 1; 1 1 1; 0.5 1 0; x_XZ y_XZ z_XZ; x_XY y_XY z_XY;];
if x_XZ==1
    fac1_xz = [7 8 6 5 4];
    fac2_xz = [3 8 7];
elseif x_XZ==0
    fac1_xz = [7 8 4];
    fac2_xz = [7 8 5 6 3];
else
    fac1_xz = [7 8 5 4];
    fac2_xz = [3 6 8 7];
end

if x_XY==1
    fac1_xy = [7 9 2 1 4];
    fac2_xy = [9 3 7];
elseif x_XY==0
    fac1_xy = [7 9 4];
    fac2_xy = [7 9 1 2 3];
else
    fac1_xy = [7 9 1 4];
    fac2_xy = [9 2 3 7];
end

fac1_gb=[9 7 8];

p1=patch(ax,'Vertices',vert,'Faces',fac2_xy,'FaceVertexCData',color_g2,'FaceColor','flat');%; color_g2
hold on
p2=patch(ax,'Vertices',vert,'Faces',fac2_xz,'FaceVertexCData',color_g2,'FaceColor','flat');%; color_g2
hold on
p3=patch(ax,'Vertices',vert,'Faces', fac1_xy,'FaceVertexCData',color_g1,'FaceColor','flat');%; color_g1
hold on
p4=patch(ax,'Vertices',vert,'Faces',fac1_xz,'FaceVertexCData',color_g1,'FaceColor','flat');%; color_g1
hold on
p5=patch(ax,'Vertices',vert,'Faces',fac1_gb,'FaceVertexCData',[0 0 0],'FaceColor','flat');%; color_g1
alpha([p1,p2,p3,p4],0.8)
alpha(p5,0.7)

hold on 
line(ax,[0,1],[1,1],[0,0],'Color','k','Linewidth',2)
hold off
% view(ax, 165,-45)
% axis equal; axis tight; axis vis3d; axis off%
% xlabel(ax,'x');ylabel(ax,'y');zlabel(ax,'z')
set(ax, 'XDir','reverse')
