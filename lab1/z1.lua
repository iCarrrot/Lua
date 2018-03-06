function printf(tab)
  print (printf1(tab))
end

function printf1(tab)
  local str = '{'
  for i=1,#tab do
    if i>1 then
      str=str..", "
    end
    
    if type (tab[i]) == 'table' then
      str = str..printf1(tab[i])
    else
      str = str..tostring(tab[i])
    end
  end
  return str..'}'
end
---[[
printf({1,2,3,4,5})
printf ( {'ala', 'ma', 127, 'kotów'} ) --> {ala , ma , 127, kotów}
printf ( {'to są', {}, {2, 'tablice'}, 'zagnieżdżone?', {true}} ) --> {to są, {}, {2, tablice}, zagnieżdżone?, {true}}
--]]