str = 'KsiężycQWERTYUIµń”„ćźż'

utf8.reverse = function(text)
  local newText = ''
  for i, c in  utf8.codes(text) do
    newText = utf8.char(c)..newText
  end
  return newText
end

print(utf8.reverse(str))