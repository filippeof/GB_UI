function [m1,m2] = calcGBnormal(ori_g1,ori_g2,ang_gb_xy,ang_gb_xz)
    % ori =orientation (Mtex function) in Euler angles
    % angles in rad
    A=rotate(xvector,rotation('axis',zvector,'angle',(ang_gb_xy))); % vector disted alpha
    B=rotate(xvector,rotation('axis',yvector,'angle',(ang_gb_xz)));% vector disted beta
    N = cross(A, B);
    m1=round(ori_g1\N);% m in crystal coordinates
    m2=round(ori_g2\N); 
end