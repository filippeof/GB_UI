function[vert,facetVert]= getPoly(wrlFname,varargin)
% extract faces and vertex from wrl file
% options: 'plot' : plot the resulting file
%              'showid' : show id of each plane 
%              'showAxes' : show crystal axes
wrlTxt= regexp(fileread(wrlFname), '\n', 'split');

%
for i=1:length(wrlTxt)
   if ~isempty(strfind(wrlTxt{i},'point ['))
       vertBeginId=i+1;
       break% only IndexedFaceSet, stop before reading IndexedLineSet
   end
end 
for i=vertBeginId:length(wrlTxt)
   if ~isempty(strfind(wrlTxt{i},']}'))
       vertEndId= i-1;
       break% only IndexedFaceSet, stop before reading IndexedLineSet
   end
end
%
for i=1:length(wrlTxt)
   if ~isempty(strfind(wrlTxt{i},'coordIndex ['))
       facetVertBeginId=i+1;
       break% only IndexedFaceSet, stop before reading IndexedLineSet
   end
end 
for i=facetVertBeginId:length(wrlTxt)
   if ~isempty(strfind(wrlTxt{i},']'))
       facetVertEndId= i-1;
       break% only IndexedFaceSet, stop before reading IndexedLineSet 
   end
end
%
% read vertices
 vertList= wrlTxt(vertBeginId: vertEndId);
 for i=1:length(vertList)
 vert{i} = str2double(strsplit(strtrim(vertList{i}),' '));
 end
 vert=vertcat(vert{:});
% read index of vertex for each polygon
  facetVertList= wrlTxt(facetVertBeginId: facetVertEndId);
  for i=1:length(facetVertList)
 facetVert{i} = str2double(strsplit(strtrim(facetVertList{i}),' '));
  end
  
% correct vertex index (start with 1 instead of 0 and remove -1 at the end)
  for i=1:length(facetVert)
 facetVert{i} = (facetVert{i}(1:end-1)+1);
  end
lgt = cellfun('length',facetVert);
facetVert = cellfun(@(v,n)[v,nan(1,max(lgt)-n)],facetVert,num2cell(lgt),'UniformOutput',false);
facetVert = vertcat(facetVert{:});

  
 % handling options
 if nargin >1
     if validatestring('plot',varargin)
        p=patch('Vertices',vert,'Faces',fac,'FaceVertexCData',[0 0 0],'FaceColor','flat','faceAlpha',0.1,'Parent',crystalT);%; color_g2
     end
         axis('equal'); axis('tight'); xlabel('x'); ylabel('y'); zlabel('z');
        %plot axes
        if validatestring('showAxes',varargin)
            xL=get(gca,'xLim');
            yL=get(gca,'yLim');
            zL=get(gca,'zLim');
            hold on
            line([1.1*xL(1) 1.1*xL(2)],[0 0],[0 0],'Color','red','LineStyle','--','LineWidth',1.5);%b
            text([1.15*xL(1) 1.15*xL(2)],[0 0],[0 0],'b','Color','red');

            hold on
            line([0 0],[1.1*yL(1) 1.1*yL(2)],[0 0],'Color','red','LineStyle','--','LineWidth',1.5);%c
            text([0 0],[1.15*yL(1) 1.15*yL(2)],[0 0],'c','Color','red');

            hold on
            line([0 0],[0 0],[1.1*zL(1) 1.1*zL(2)],'Color','red','LineStyle','--','LineWidth',1.5);%a
            text([0 0],[0 0],[1.15*zL(1) 1.15*zL(2)],'a','Color','red');
        end
            
     end
end