function h = text3(v,string,varargin)
% plot three dimensional arrows
%
% Syntax
%   text3(v,string)
%
% Input
%
% See also
% savefigure vector3d/scatter3 vector3d/plot3 vector3d/arrow3

% where to plot
if check_option(varargin,'parent')
  ax = get_option(varargin,'parent');
else
  ax = gca;
end

v = 1.2.*v.normalize;

h = optiondraw(text(v.x,v.y,v.z,string,'FontSize',15,'parent',ax),...
  'horizontalAlignment','center','verticalAlignment','middle',varargin{:});

% set axis to 3d
axis(ax,'equal','vis3d','off');

% st box limits
set(ax,'XDir','rev','YDir','rev',...
'XLim',[-1.2,1.2],'YLim',[-1.2,1.2],'ZLim',[-1.2,1.2]);

if nargout == 0, clear h;end
