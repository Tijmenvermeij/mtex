function display(s)
% standard output

% check whether crystal or specimen symmetry
if ~s.isCS
  
  disp(' ');
  disp([inputname(1) ' = ' s.lattice ' specimen ' doclink('symmetry_index','symmetry') ' ' docmethods(inputname(1))]);
  disp(' ');
  
  return
end


disp(' ');
disp([inputname(1) ' = crystal ' doclink('symmetry_index','symmetry') ' ' docmethods(inputname(1))]);

disp(' ');

props = {}; propV = {};

% add mineral name if given
if ~isempty(s.mineral)
  props{end+1} = 'mineral'; 
  propV{end+1} = s.mineral;
end

if ~isempty(s.color)
  props{end+1} = 'color'; 
  propV{end+1} = s.color;
end


% add symmetry
props{end+1} = 'symmetry'; 
propV{end+1} = [symmetry.pointGroups(s.id).Inter];

% add axis length
props{end+1} = 'a, b, c';
propV{end+1} = option2str(vec2cell(norm(s.axes)));

% add axis angle
if s.id < 6
  props{end+1} = 'alpha, beta, gamma';
  propV{end+1} = [num2str(s.alpha) '°, ' num2str(s.beta) '°, ' num2str(s.gamma) '°'];
end

% add reference frame
if any(strcmp(s.lattice,{'triclinic','monoclinic','trigonal','hexagonal'}))
  props{end+1} = 'reference frame'; 
  propV{end+1} = option2str(s.alignment);    
end

% display all properties
cprintf(propV(:),'-L','  ','-ic','L','-la','L','-Lr',props,'-d',': ');

disp(' ');



