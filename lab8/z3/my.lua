local function rng()
    return math.random(3)
end

math.randomseed(os.time())
AI = function(mysymbol, board)
    mysymbol = "" .. mysymbol
    enemy = mysymbol == "X" and "O" or "X"
    -- print(mysymbol, enemy)
    x, y = checkLines(mysymbol, board)
    if x and y then
        return x, y
    end

    x, y = checkLines(enemy, board)
    if x and y then
        return x, y
    end

    if board[2][2] == " " then
        return 2, 2
    end

    if board[1][3] == " " then
        return 1, 3
    end
    if board[3][1] == " " then
        return 3, 1
    end
    if board[1][1] == " " then
        return 1, 1
    end
    if board[3][3] == " " then
        return 3, 3
    end

    while true do
        local x, y = rng(), rng()
        if board[x][y] == " " then
            return x, y
        end
    end
end

function checkLines(s, board)
    local oxx = " " .. s .. s
    local xox = s .. " " .. s
    local xxo = s .. s .. " "
    local lines = {
        {board[1][1] .. board[1][2] .. board[1][3], {{1, 1}, {1, 2}, {1, 3}}},
        {board[2][1] .. board[2][2] .. board[2][3], {{2, 1}, {2, 2}, {2, 3}}},
        {board[3][1] .. board[3][2] .. board[3][3], {{3, 1}, {3, 2}, {3, 3}}},
        {board[1][1] .. board[2][1] .. board[3][1], {{1, 1}, {2, 1}, {3, 1}}},
        {board[1][2] .. board[2][2] .. board[3][2], {{1, 2}, {2, 2}, {3, 2}}},
        {board[1][3] .. board[2][3] .. board[3][3], {{1, 3}, {2, 3}, {3, 3}}},
        {board[1][1] .. board[2][2] .. board[3][3], {{1, 1}, {2, 2}, {3, 3}}},
        {board[1][3] .. board[2][2] .. board[3][1], {{1, 3}, {2, 2}, {3, 1}}}
    }
    for i = 1, 8 do
        -- print(lines[i][1], oxx, xox, xxo)
        if lines[i][1] == oxx then
            return table.unpack(lines[i][2][1])
        end
        if lines[i][1] == xox then
            return table.unpack(lines[i][2][2])
        end
        if lines[i][1] == xxo then
            return table.unpack(lines[i][2][3])
        end
    end
    return nil, nil
end

-- print (AI('X', {{'X', 'O', 'X'}, {'O', 'X', 'O'}, {'O', ' ', 'X '}}))
