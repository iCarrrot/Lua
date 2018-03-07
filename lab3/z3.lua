str = 'Księżyc:\nNów’'

utf8.sub = function(text, i, j)
  local newText = ''
  local n = 1
  for _i, c in  utf8.codes(text) do
    if n>= i and n<=j then
      newText = newText..utf8.char(c)
    elseif n>j then
      return newText
    end
    n=n+1
  end
  return newText
end

print(utf8.sub(str,5,10))