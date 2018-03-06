require("lab1.z1")

local function map(tab, func)
  local mapped = {}
  for i=1,#tab do
    mapped[i] = func(tab[i])
  end
  return mapped
end

local function add1 (x)
  return x+1
end

t = {1,2,3,4,5,6}
printf(map(t,add1))