str = 'Księżyc:\nNów'

utf8.normalize = function(text)
  local newText = ''
  for i, c in  utf8.codes(text) do
    if(c<128 and c>=0) then
      newText = newText..utf8.char(c)
    end
  end
  return newText
end

print(utf8.normalize(str))