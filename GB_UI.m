function GB_UI
    f = figure('Visible','off','Units','normalized','pos',[0 0 1 1],'NumberTitle', 'off', 'Name', 'Grain boundary Plane');
    f_pos=getpixelposition(gcf);
    tabgp = uitabgroup(f,'Units','normalized','Position',[0 0.45 1 0.55]);
    tab1 = uitab(tabgp,'Title','Grain Boundary');
    tab2 = uitab(tabgp,'Title','Stereo projections');
    sf=[f_pos(3) f_pos(4) f_pos(3) f_pos(4)]; %scaling factor for your screen
    c = uicontextmenu;
    tab1.UIContextMenu = c;
    m1 = uimenu(c ,'Label','Plot IPF Colorcoding','Callback',@plotOM);

    % set axes -crystal shape left
    ax_crystal_left = axes('Parent', tab1,'Units','normalized','Position', [0.05 0.075 0.25 0.75],'Color','none');
    ax_crystal_left.XTick=[]; ax_crystal_left.YTick=[]; ax_crystal_left.ZTick=[];
    xlabel(ax_crystal_left,'X');ylabel(ax_crystal_left,'Y');zlabel(ax_crystal_left,'Z')
    title(ax_crystal_left,'Left grain','FontSize',15);
    ax_crystal_left.View=[-37.5000 30.0000];
     
    % set axes -GB
    ax_gb = axes('Parent', tab1, 'Units','normalized','Position', [0.4 0.075 0.2 0.75],'Color','none');
    ax_gb.XTick=[]; ax_gb.YTick=[]; ax_gb.ZTick=[];
    xlabel(ax_gb,'X');ylabel(ax_gb,'Y');zlabel(ax_gb,'Z')
    ax_gb.XDir='reverse';
    title(ax_gb,'Grain Boundary Plane Calculation','FontSize',15);
    ax_gb.Title.Units='normalized'; ax_gb.Title.Position=ax_gb.Title.Position+[0 0.1 0];
    ax_gb.View=[165 -45];
    
     % set axes -crystal shape right
     ax_crystal_right = axes('Parent', tab1, 'Units','normalized','Position', [0.7 0.075 0.25 0.75],'Color','none');
    ax_crystal_right.XTick=[]; ax_crystal_right.YTick=[]; ax_crystal_right.ZTick=[];
    xlabel(ax_crystal_right,'X');ylabel(ax_crystal_right,'Y');zlabel(ax_crystal_right,'Z')
    title(ax_crystal_right,'Right grain','FontSize',15);
    ax_crystal_right.View=[-37.5000 30.0000];
    
%% UI controls
% Radio buttons
    radBtnGroup = uibuttongroup('Parent',f,'Title','Auto Update','Units','pixels','Position', [10 f_pos(4)-80 80 80],'SelectionChangedFcn',@bselection);
    r1 = uicontrol(radBtnGroup,'Style', 'radiobutton', 'String','On','Position',[5 40 60 25]);
    r2 = uicontrol(radBtnGroup,'Style', 'radiobutton', 'String','Off','Position',[5 10 60 25]);

% Plot stereo Push button
    update_btn = uicontrol('Style', 'pushButton',...
        'Position', sf.*[0.4297 0.2136 0.1172 0.0568], 'Units','normalized',...
        'Parent',f,'Callback', @updateGB,'String', 'Update plots','Visible','off'); 
    
%% grain 1
% slider phi1
    phi1_1_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',90,...
        'Position', sf.*[0.0781 0.2130 0.1172 0.0568], 'Units','pixels',...
        'Parent',f,'Callback', @updateGB); 
        a1=annotation(f,'textbox','String','\phi_1', 'FontSize',20,'Units','pix','Position', sf.*[0.1305 0.3054 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a2=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.0625 0.2557 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a3=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.1953 0.2557 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
   
% slider PHI
    PHI_1_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',135,...
        'Position', sf.*[0.0781 0.1136 0.1172 0.0568], 'Units','pixels',...
        'Parent',f,'Callback', @updateGB); 
        a4=annotation(f,'textbox','String','\Phi', 'FontSize',20,'Units','pix','Position', sf.*[0.1305 0.1989 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a5=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.0625 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a6=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.1953 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');

% slider phi2
    phi2_1_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',90,...
        'Position',sf.*[0.0781 0.0142 0.1172 0.0568],...
        'Parent',f,'Callback', @updateGB); 
        a7=annotation(f,'textbox','String','\phi_2', 'FontSize',20,'Units','pix','Position', sf.*[0.1305 0.1065 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a8=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.0625 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a9=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.1953 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
%% grain 2
   % slider phi1
    phi1_2_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',90,...
        'Position', sf.*[0.7812 0.2130 0.1172 0.0568], 'Units','normalized',...
        'Parent',f,'Callback', @updateGB); 
        a10=annotation(f,'textbox','String','\phi_1', 'FontSize',20,'Units','pix','Position', sf.*[0.8336 0.3054 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a11=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.7656 0.2557 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a12=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.8984 0.2557 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
   
% slider PHI
    PHI_2_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',90,...
        'Position', sf.*[0.7812 0.1136 0.1172 0.0568], 'Units','normalized',...
        'Parent',f,'Callback', @updateGB); 
        a13=annotation(f,'textbox','String','\Phi', 'FontSize',20,'Units','pix','Position', sf.*[0.8336 0.1989 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a14=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.7656 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a15=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.8984 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');

% slider phi2
    phi2_2_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',85,...
        'Position',sf.*[0.7812 0.0142 0.1172 0.0568],...
        'Parent',f,'Callback', @updateGB); 
        a16=annotation(f,'textbox','String','\phi_2', 'FontSize',20,'Units','pix','Position', sf.*[0.8336 0.1065 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a17=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.7656 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a18=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.8984 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');

% alpha/beta

        % slider alpha
    alpha_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',45,...
        'Position', sf.*[0.4297 0.1136 0.1172 0.0568], 'Units','normalized',...
        'Parent',f,'Callback', @updateGB); 
        a19=annotation(f,'textbox','String','\alpha', 'FontSize',20,'Units','pix','Position', sf.*[0.4820 0.1989 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a20=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.4141 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a21=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.5469 0.1562 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');

        % slider beta
    beta_sld = uicontrol('Style', 'slider','SliderStep',[1/181,10/181],...
        'Min',0,'Max',180,'Value',135,...
        'Position',sf.*[0.4297 0.0142 0.1172 0.0568],...
        'Parent',f,'Callback', @updateGB); 
        a22=annotation(f,'textbox','String','\beta', 'FontSize',20,'Units','pix','Position', sf.*[0.4820 0.0994 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a23=annotation(f,'textbox','String','0', 'FontSize',15,'Units','pix','Position', sf.*[0.4141 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        a24=annotation(f,'textbox','String','180', 'FontSize',15,'Units','pix','Position', sf.*[0.5469 0.0568 0.0938 0.0213],'Interpreter','Tex','EdgeColor','none');
        
        % update strings Euler Angles
        str_g1=sprintf('g_1 = (%.0f,%.0f,%.0f)\\circ, g_2 = (%.0f,%.0f,%.0f)\\circ',phi1_1_sld.Value, PHI_1_sld.Value, phi2_1_sld.Value,...
        phi1_2_sld.Value, PHI_2_sld.Value, phi2_2_sld.Value);
        a25=annotation(f,'textbox','String',str_g1, 'FontSize',15,'Units','pix','Position', sf.*[0.34 0.42 0.3 0.0213],'Interpreter','Tex','EdgeColor','none','HorizontalAlignment','center');
        
        % update strings alpha/beta angles
        str_g2=sprintf('\\alpha = %.0f\\circ, \\beta= %.0f\\circ',alpha_sld.Value,beta_sld.Value);
        a26=annotation(f,'textbox','String',str_g2, 'FontSize',15,'Units','pix','Position', sf.*[0.34 0.37 0.3 0.0213],'Interpreter','Tex','EdgeColor','none','HorizontalAlignment','center');
        
        %Set colorcoding
        cs=crystalSymmetry('mmm');
        oM = ipdfHSVOrientationMapping(cs);
        oM.inversePoleFigureDirection = zvector;% 001 IPF colorcoding

        ang_gb_xy = alpha_sld.Value*degree;
        ang_gb_xz = beta_sld.Value*degree;
        ori_g1 = orientation('Euler', [phi1_1_sld.Value, PHI_1_sld.Value, phi2_1_sld.Value]* degree, cs);
        ori_g2 = orientation('Euler', [phi1_2_sld.Value, PHI_2_sld.Value, phi2_2_sld.Value]* degree, cs);
        
        [m1,m2] = calcGBnormal(ori_g1,ori_g2,ang_gb_xy,ang_gb_xz);
        str_hkl=sprintf('hkl_{g1} = (%.0f,%.0f,%.0f), hkl_{g2} = (%.0f,%.0f,%.0f)',m1.hkl,m2.hkl);
        a27=annotation(f,'textbox','String',str_hkl, 'FontSize',15,'Units','pix','Position', sf.*[0.34 0.32 0.3 0.0213],'Interpreter','Tex','EdgeColor','none','HorizontalAlignment','center');
        
        plotGB_sim(ax_gb, ang_gb_xy, ang_gb_xz, ori_g1, ori_g2,oM)
        
        plotGB_stereo (tab2,ang_gb_xy, ang_gb_xz, ori_g1, ori_g2)
        
        plotGB_crystalShape(ax_crystal_left,ori_g1,m1,oM)
        plotGB_crystalShape(ax_crystal_right,ori_g2,m2,oM)
        
        % Make figure visIble, resize to fit screen, if needed
        all_annotations=[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27];
        all_controls=[update_btn,radBtnGroup,r1,r2, phi1_1_sld,PHI_1_sld,phi2_1_sld,phi1_2_sld,PHI_2_sld,phi2_2_sld,alpha_sld,beta_sld];
        all_axis=[ax_gb, ax_crystal_left, ax_crystal_right];
        set([all_annotations,all_controls,all_axis], 'Units', 'normalized'); % adjust ui to screen
        f.Visible = 'on';  
    function bselection(~,event)
        if strcmp(event.NewValue.String,'Off')
            update_btn.Visible='on';
        else
            update_btn.Visible='off';
        end
    end

    function plotOM(~,~)
        om_f = figure('Visible','off','Units','normalized','pos',[0.75 0 0.2 0.2],'NumberTitle', 'off', 'Name', 'IPF colorcoding');
        ax_om = axes('Parent', om_f,'Units','normalized','Position', [0.05 0.05 0.70 0.90],'Color','none');
        plot(oM,'parent',ax_om)
        om_f.Visible='on';
    end

    function updateGB(source,~)
        %Update values
        ang_gb_xy = alpha_sld.Value*degree; % alpha in rad
        ang_gb_xz = beta_sld.Value*degree; % beta in rad
        ori_g1 = orientation('Euler', [phi1_1_sld.Value, PHI_1_sld.Value, phi2_1_sld.Value]* degree, cs);
        ori_g2 = orientation('Euler', [phi1_2_sld.Value, PHI_2_sld.Value, phi2_2_sld.Value]* degree, cs);
        [m1, m2] = calcGBnormal(ori_g1,ori_g2,ang_gb_xy,ang_gb_xz);

        %Update strings
        str_g1=sprintf('g_1 = (%.0f,%.0f,%.0f)\\circ, g_2 = (%.0f,%.0f,%.0f)\\circ',phi1_1_sld.Value, PHI_1_sld.Value, phi2_1_sld.Value,...
        phi1_2_sld.Value, PHI_2_sld.Value, phi2_2_sld.Value);
        a25.String=str_g1;
        str_g2=sprintf('\\alpha = %.0f\\circ, \\beta= %.0f\\circ', alpha_sld.Value,beta_sld.Value);
        a26.String=str_g2;
        str_hkl=sprintf('hkl_{g1} = (%.0f,%.0f,%.0f), hkl_{g2} = (%.0f,%.0f,%.0f)',m1.hkl,m2.hkl);
        a27.String=str_hkl;

        if r1.Value==1 || strcmp(source.String,'Update plots')
            %Update axis GB
            cla(ax_gb)
            plotGB_sim(ax_gb, ang_gb_xy, ang_gb_xz, ori_g1, ori_g2,oM)
            axis equal; axis tight; axis vis3d; axis off%
            ax_gb.XTick=[]; ax_gb.YTick=[]; ax_gb.ZTick=[];
            xlabel(ax_gb,'X');ylabel(ax_gb,'Y');zlabel(ax_gb,'Z')
            view(ax_gb, 165,-45)

            %Update axis left grain
            cla(ax_crystal_left)
            plotGB_crystalShape(ax_crystal_left,ori_g1,m1,oM)
            axis equal; axis tight; axis vis3d; axis off%
%             ax_crystal_left.Children(1).Children
            %Update axis right grain
            cla(ax_crystal_right)
            plotGB_crystalShape(ax_crystal_right,ori_g2,m2,oM)
            axis equal; axis tight; axis vis3d; axis off%

            %Update axes stereoplot
            delete(allchild(tab2))
            plotGB_stereo (tab2,ang_gb_xy, ang_gb_xz, ori_g1, ori_g2)
        end
    end
end