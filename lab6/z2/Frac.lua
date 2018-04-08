local Frac = {}

local mt = {__metatable = 'Frac'}

--pomocnicze---------------------------------------------------------
local function gcd(a, b)
    while b > 0 do
        a, b = b, a % b
    end
    return a
end

local function normalize(fr)
  local gc = gcd(fr.num, fr.den)
  fr.num, fr.den = math.floor(fr.num//gc), math.floor(fr.den//gc)
end

--operacje arytmetyczne----------------------------------------------
function mt.__unm(fr)
  return Frac(-fr.num, fr.den)
end

function mt.__add(fr1, fr2)
  --print("add ", fr1.num, fr1.den, fr2.num , fr2.den)
    if type(fr1) == 'number' then fr1 = Frac.toFrac(fr1) end
    if type(fr2) == 'number' then fr2 = Frac.toFrac(fr2) end
    return Frac(fr1.num * fr2.den + fr2.num * fr1.den, fr1.den * fr2.den)
end

function mt.__sub(fr1, fr2)
  return fr1+ (-fr2)
end


function mt.__mul(fr1,fr2)
  if type(fr1) == 'number' then fr1 = Frac.toFrac(fr1) end
  if type(fr2) == 'number' then fr2 = Frac.toFrac(fr2) end
  return Frac(fr1.num*fr2.num, fr1.den*fr2.den)
end
  
function mt.__div(fr1,fr2)
  if type(fr1) == 'number' then fr1 = Frac.toFrac(fr1) end
  if type(fr2) == 'number' then fr2 = Frac.toFrac(fr2) end
  return fr1 * Frac(fr2.den, fr2.num)
end

function mt.__pow(fr, p)
  if type(p)~= "number" or math.floor(p) ~= p then error("Can't do this!", 2) end
  return Frac(fr.num^p, fr.den^p)
end

--operacje boolowskie------------------------------------------------

function mt.__eq(fr1, fr2)
  return fr1.num == fr2.num and fr1.den == fr2.den
end

function mt.__lt(fr1, fr2)
  return fr1.num*fr2.den < fr1.den * fr2.num
end

function mt.__le(fr1, fr2)
  return fr1 < fr2 or fr1 == fr2
end

--reszta-------------------------------------------------------------
function mt.__tostring(fr)
  --print(fr.num, fr.den)
  if fr.num == 0 then return "0" end
  if fr.num < 0 then return '-'..tostring(-fr) end
  local w = fr.num // fr.den
  if w == 0 then return fr.num..'/'..fr.den end
  if fr.num%fr.den == 0 then
    return ''..w
  else
    return w.." and "..fr.num%fr.den..'/'..fr.den
  end
end


function mt.__concat(a1, a2)
  return tostring(a1)..tostring(a2)
end

function Frac:new(num, den)
    if den == 0 then error("It can't be 0 my friend!", 2) end
    if num == 0 then den = 1 end
    if den < 0 then num, den = -num, -den end
    local o = {num = num, den = den}
    normalize(o)
    setmetatable(o, mt)
    return o
end

function Frac.toFrac(num)
  if type(num)~= 'number' then error("Invalid argument",2) end
  local den = 1
  while math.floor(num) ~= num do 
    num, den = num*10, den *10
  end
  return Frac(num, den)
end

function Frac.tofloat(fr)
  return fr.num/fr.den
end


setmetatable(Frac, {__call = Frac.new, __metatable = "Can't touch this!"})
return Frac
