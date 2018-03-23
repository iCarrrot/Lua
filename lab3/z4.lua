str = 'test string'

string.strip = function(text, w)
  if w == nil then
    w=' '
  end
  local newText = ''
  local n = text:len()
  while true do
    --if n<1 then 
      ---return "ERROR" 
    --end
    local c = text:sub(n,n)
    if string.find(w,c) == nil then
      return text:sub(1,n)
    end
    n=n-1
  end
end

print(string.strip(str, 'test stritng'))

