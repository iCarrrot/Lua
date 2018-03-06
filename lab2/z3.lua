require("lab1.z1")


function moveinto(tab1,i1,j1,tab2,i2)
  if i2 == nil then
    tab2, i2 = tab1, tab2
  end
  local padding = j1-i1+1
  new_tab = {}
  for k, v in pairs(tab2) do
    if type(k) ~= "number" or k < i2 or k<1 then
      new_tab[k] = v
    end
    if type(k) == "number" and k>=i2 then
      new_tab[k+padding]=v
    end
    
  end
  for k1, v1 in pairs(tab1) do
    print(k1,v1,i1,j1)
    if k1 >= i1 and k1 <= j1 then
      new_tab[i2+k1-2]=v1
    end
    
  end
  for k,v in pairs(tab2) do
    tab2[k] = nil
  end
  for k, v in pairs(new_tab) do
  
  --tab2 = new_tab
  --print(tab1,i1,j1,tab2,i2)
    tab2[k] = v
  end
end
tab2 = {1, nil , 3, 7, nil , 8}
moveinto ({3, 4, nil , 6, 7}, 2, 4 ,tab2, 4)
printf(tab2)
printfk(tab2)
--tab2 --> {1, nil , 3, 4, nil , 6, 7, nil , 8}
