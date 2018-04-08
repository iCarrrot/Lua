local Vector = {}

local mt = {__metatable = 'Vector'}

function Vector:new(tab)
  local o = {}
  for k, v in ipairs(tab) do
    o[k] = v
  end
  o.dim = #tab
  setmetatable(o, mt)
  return o
end


--operacje arytmetyczne----------------------------------------------
function mt.__unm(v)
  local new = {}
  for i = 1, v.dim do
    new[i] = -v[i]
  end
  return Vector(new)
end

function mt.__add(v1, v2)
  local new = {}
  if v1.dim ~= v2.dim then error("Must be equal!", 2) end
  for i = 1, v1.dim do
    new[i] = v1[i] + v2[i]
  end
  return Vector(new)
end

function mt.__sub(v1, v2)
  return v1+ (-v2)
end


function mt.__mul(v1,v2)
  if getmetatable(v1) ~= 'Vector' then v1, v2 = v2, v1 end
  if getmetatable(v2) =='Vector' then
    if v1.dim ~= v2.dim then error("Must be equal!", 2) end
    local new = 0
    for i = 1, v1.dim do
      new = new + v1[i]*v2[i]
    end
    return new
  elseif type(v2) == "number" then
    new = {}
    for i = 1, v1.dim do
      new[i] = v2*v1[i]
    end
    return Vector(new)
  else
    error("Bad args, bro", 2)
  end
end
  
function mt.__div(v, num)
  if type(num) == "number" then
    new = {}
    for i = 1, v1.dim do
      new[i] = v1[i] / v2
    end
    return Vector(new)
  else
    error("Bad args, bro", 2)
  end
end

function mt.__len(v)
  local norm = 0
  for i = 1, v.dim do
    norm = norm + v[i]^2
  end
  return math.sqrt(norm)
end

--operacje boolowskie------------------------------------------------

function mt.__eq(v1, v2)
  if v1.dim ~= v2.dim then return false end
  for i=1,v1.dim do
    if v1[i] ~= v2[i] then return false end
  end
  return true
end


--stringi------------------------------------------------------------
function mt.__tostring(v)
  local new = {}
  for i = 1, v.dim do
    new[i] = v[i]
  end
  return "["..table.concat(new,", ")..']'
end

function mt.__concat(a1, a2)
  return tostring(a1)..tostring(a2)
end

--inne---------------------------------------------------------------
function mt.__ipairs(v)
  local last = 0
  local key = {}
  for i = 1, v.dim do
    key[i]=0
  end
  key = Vector(key)
  return function()
    last = last+1
    if last > key.dim then return nil end
    if last > 1 then
      key[last] = 1
      key[last-1] = 0
    else
      key[1] = 1
    end
    return key, v[last]
  end
end


function mt.__newindex(v) end

setmetatable(Vector, {__call = Vector.new, __metatable = "Can't touch this!"})
return Vector
