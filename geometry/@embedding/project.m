function [ori, Tori] = project(obj,ori)
% project an embedding back onto the manifold of orientations.
%
% Syntax
%   [ori, Tori] = project(e)
%
% Input
%  e - @embedding
%
% Output
%  ori - @orientation
%  Tori - projected @embedding
%

% get the embedding of the identity
Tid = embedding.id(obj.CS);

% ensure obj is symmetric
obj = obj.sym;

% special case for triclinic symmetry
if obj.CS.Laue.id ==2
  
  %weighted sum in Horn
  for i = 1:length(obj.u)
    r(i,:) = obj.u{i}(:);
  end
  
  ori = orientation(fit(obj.l,r,obj.CS),obj.CS);
  
  if nargout == 2, Tori = ori * Tid; end
  return
  
end

% initial guess
if nargin == 1, ori = orientation.id(obj.CS); end

% basis of the tangential space
t = spinTensor([xvector,yvector,zvector]);

% perform steepest descent iteration to maximize dot(ori * Tid, obj)
maxIter = 100;
for i = 1:maxIter
  
  % compute the gradient in ori
  Tori = rotate_outer(Tid,ori);
  for k = 1:length(obj.u)
    Tori.u{k} = obj.rank(k) * EinsteinSum(t,[1,-1],Tori.u{k},[-1 2:obj.rank(k)]);
  end
  
  g = vector3d(dot(Tori,obj).');
  
  % stop if gradient is sufficently small
  if all(norm(g)<1e-10), break; end
  
  % update ori
  ori = exp(ori,g,'left');
  
end
end