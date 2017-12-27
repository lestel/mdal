function varargout = princomp(varargin)
%PRINCOMP Principal Components Analysis (PCA). 
%   Using PRINCOMP is discouraged. Use PCA instead. Calls to PRINCOMP are
%   routed to PCA. Please see the documentation of PCA for help. 
%
%   [coeff, score, latent, tsquare] = princomp(x,econFlag)
% 
%   See also: PCA

%   Copyright 1993-2010 The MathWorks, Inc.


fEconomy = false;

if nargin > 1
    if isequal (varargin{2},0)
        fEconomy = false;
    end
    
    if strcmp(varargin{2},'econ')
        fEconomy = true;
    end
end

if nargout ==1
    varargout{1} = pca(varargin{1},'Algorithm','eig','Economy',fEconomy);
    return;
else
    [varargout{1:nargout}]=pca(varargin{1},'Algorithm','svd','Economy',fEconomy);
end
