function writeParams(fileName, m, pw)

if nargin < 3
  pw = 20;
end
formatString = "p.%-" + string(pw) + "s = %-2.4g;\n";

parNames = string(get(m, "pNames"));
[~, funcName] = fileparts(fileName);

fid = fopen(fileName, "w");

fprintf(fid, "%s\n\n", "function p = " + funcName);

for p = parNames(:)'
  fprintf(fid, formatString, p, m.(p));
end

fprintf(fid, "\n%s", "end");

fclose(fid);

end