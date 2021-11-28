function [nr, nc] = calcSubplotSize(n)

nc = ceil(sqrt(n));
if nc * (nc - 1) >= n
  nr = nc - 1;
else
  nr = nc;
end

end