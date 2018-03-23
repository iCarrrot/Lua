require("lab1.z1")

function zip(...)
  tab = {...}
  return function(state)
    ret = {}
    for k, tab in pairs(state) do
      if #tab == 0 then
        return nil
      end
      ret[#ret+1] = table.remove(state[k],1)
      
    end
    return table.unpack(ret)
  end, tab
end




for x, y in zip({'a', 'b', 'c', 'd'}, {40, 50, 60}) do
  print (x, y)
end