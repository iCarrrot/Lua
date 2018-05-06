local function rng() 
    return math.random(3) 
end

math.randomseed( os.time() )

AI = function(mysymbol, board)
    while true do
        local x, y = rng(), rng()
        if board[x][y] == ' ' then 
            return x, y 
        end
    end
end
-- print (AI('X', {{'X', 'O', 'X'}, {'O', 'X', 'O'}, {'O', ' ', 'X '}}))