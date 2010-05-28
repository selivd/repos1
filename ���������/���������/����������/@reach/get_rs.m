function RS = get_rs(prs,tt,center_values,varargin)
%  RS = get_rs(prs,tt,center_values,ea_val,ia_val, dir_values)

    global ellOptions;

  if ~isstruct(ellOptions)
    evalin('base', 'ellipsoids_init;');
  end

  ea_val=[];
  ia_val=[];
  l_values=[];
  
  optargin = size(varargin,2);
  if(optargin>0)
      ea_val=varargin{1};
  end;
  if(optargin>1)
      ia_val=varargin{2};
  end;
  if(optargin>2)
      l_values=varargin{3};
  end;
  
  
  
  RS.system             = [];
  RS.t0                 = [];
  RS.X0                 = [];
  RS.initial_directions = [];
  RS.time_values        = [];
  RS.center_values      = [];
  RS.l_values           = [];
  RS.ea_values          = [];
  RS.ia_values          = [];
  RS.mu_values          = [];
  RS.minmax             = [];
  RS.projection_basis   = [];
  RS.calc_data          = [];
  RS                    = class(RS, 'reach');
  
  
  RS.system             = prs.system;
  RS.t0                 = prs.t0;
  RS.X0                 = prs.X0;
  RS.initial_directions = prs.initial_directions;
  RS.l_values           = prs.l_values;
  RS.ea_values          = prs.ea_values;
  RS.ia_values          = prs.ia_values;
  %RS.mu_values          = prs.mu_values;
  %RS.minmax             = prs.minmax;
  RS.projection_basis   = prs.projection_basis;
  %RS.calc_data          = prs.calc_data;
  
  RS.time_values        = tt;
  RS.center_values      = center_values;
  if(~isempty(ea_val))
      RS.ia_values      = ia_val;
  end;
  
  if(~isempty(ia_val)) 
      RS.ea_values      = ea_val;
  end;
  
  if(~isempty(l_values))
      RS.l_values = l_values;
  end;
  
  return;
  
  