function [gc] = getfirst(plane_v1,plane_v2, num_plane, sys)

plane = ort(plane_v1,plane_v2);

alfa = 0 : pi/num_plane : pi-pi/num_plane;

%начальное задание векторов на плоскости plane
L_0 = plane*[cos(alfa), sin(alfa)];

lsys =  sys.lsys;
T    =  sys.T;
X0   =  sys.X0;

%            Opt.save_all = 0; %Opt.approximation = 2;
 
rs = reach(lsys,X0,L_0,[0 T]);
[L_T t] = get_direction(rs);


