t = {10, print , x=12, k='hi', 42}
function test(...)
  if type(...) == 'table' then
    t = ...
  else 
    t = {...}
  end
  local newTab={}
  for k, v in  ipairs(t) do  
    --print (k, v) 
    newTab[k]=v
  end
  local i=0
  for k, v in  pairs(t) do  
    i = i+1
    print (k, v) 
  end
  local state = true
  if i > #newTab then
    state = false
  end

  return state, newTab
end

print (test(t))
