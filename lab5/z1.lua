require("lab1.z1")


function chain(...)
  tab = {...}
  return function(state)
    if #state == 1 and #state[1] == 0 then
      return nil
    end
    while next(state[1]) == nil do
      table.remove(state,1)
    end
    a = table.remove(state[1],1)
    return a
  end, tab
end

for x in chain({},{},{},{'a', 'b', 'c'}, {40, 50}, {}, {6, 7}) do
  print(x)
end

print(chain({'a', 'b', 'c'}, {40, 50}, {}, {6, 7}))
print(chain({1,2,3,5,6,7}, {2,5,5,4,7}))
