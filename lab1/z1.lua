function printf(tab)
  print (printf1(tab))
end

function printf1(tab)
  local str = '{'
  i=0
  for k, v in pairs(tab) do
    if i>1 then
      str=str..", "
    else
      i=2
    end
    
    if type (tab[k]) == 'table' then
      str = str..printf1(tab[k])
    else
      str = str..tostring(v)
    end
  end
  return str..'}'
end

function printfk(tab)
  print (printfk1(tab))
end

function printfk1(tab)
  local str = '{'
  i=0
  for k, v in pairs(tab) do
    if i>1 then
      str=str..", "
    else
      i=2
    end
    
    if type (tab[k]) == 'table' then
      str = str..printfk1(tab[k])
    else
      str = str..tostring(k)..": "..tostring(v)
    end
  end
  return str..'}'
end
--[[
printf({1,2,3,4,5})
printf ( {'ala', 'ma', 127, 'kotów'} ) --> {ala , ma , 127, kotów}
printf ( {'to są', {}, {2, 'tablice'}, 'zagnieżdżone?', {true}} ) --> {to są, {}, {2, tablice}, zagnieżdżone?, {true}}
--]]