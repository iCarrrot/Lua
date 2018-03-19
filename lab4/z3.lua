require("lab1.z1")



local path = 'K:\\hidden-name\\Teaching\\2016_Lua\\[Lab]\\Lecture 04.pdf'

function unpath(path, iftest)
  local sep = package.config:sub(1,1)
  if iftest then
    sep ='\\' 
  end
  
  local pattern_file = '%s*([^\\]+)%.([%w]+)%s*$'
  local pattern_path = '[^'..sep..'+'..sep..'%s*]*'
  local words = {}
  local file, ext = string.match(path, pattern_file) 
  path = string.gsub(path,pattern_file,'')

  for i in string.gmatch(path, pattern_path) do
    if #i>0 then
      words[#words+1] = i
    end
  end
  words[#words+1] = {file,ext}
--printf(words)
  return words
end

printf(unpath(path, true))
